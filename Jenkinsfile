@Library('SharedLibrary@ios_signing') _
pipeline {
    agent {
        label 'AnkaFlutterDart'
    }
    parameters {
        choice(
            name: 'Runner_Scheme',
            choices: ['Runner-Test', 'Runner-Stage', 'Runner'],
            description: 'Type of AmericanEssentials scheme you want to build.'
        )
        string(description: 'Version for the ipa to be uploaded', defaultValue: '0.0.1', name: 'version')
        string(description: 'Release tag version (Only for master branch builds)', defaultValue: '1.0', name: 'releasetag')
    }
    environment {
        INTEGRATION_BRANCH = "master"
        BUILD_VERSION =  "5.00.${env.BUILD_NUMBER}"
        BUILD_NUMBER = "${env.BUILD_NUMBER}"
        BRANCH_NAME = "${env.GIT_BRANCH}"
        MASTER_BUILD_VERSION = "5.0.0"
        KEYCHAIN_NAME = "temp.keychain"
        KEYCHAIN_PASS = "secret"
        NOTIFYUSERS = "nagaraj.hiremath@aa.com"
        APPCENTER_TOKEN = credentials('appcenter_access_token')
        SLACK_CHANNEL = 'jetnet-developers'
 features/fastlane-cd-fix
        // SLACK_TOKEN = credentials('AAESlackToken')
        //GIT_TOKEN = credentials('aae-github-zid')
=======
        // SLACK_TOKEN = credentials('CCISlackToken')
        //GIT_TOKEN = credentials('cci-github-zid')
 development
        BUILD_DETAILS = "BUILD DETAILS: ${env.JOB_NAME} #${env.BUILD_NUMBER} - ${BUILD_URL} "
        JOB_CAUSES = edtUtil.getCauses()
        APPCENTER_PROJECTS = ''
    }
    options {
        disableConcurrentBuilds()
    }
    stages {
        stage('Sync Signing Assets') {
            steps {
                sh("mkdir -p ~/Library/MobileDevice/Provisioning\\ Profiles")
                sh("cp ~/Documents/provisionProfiles/American_Essentials.mobileprovision ~/Library/MobileDevice/Provisioning\\ Profiles/")
                syncSigningAssets( KEYCHAIN_NAME, KEYCHAIN_PASS)
            }
        }
        stage ('Setup Dependencies') {
            steps {
                callFastLane('ios setup_ios_dependencies')
            }
        }
        

	stage ('Generate ipa') {
            steps {
                callFastLane("ios create_development_ipa Runner_Scheme:${params.Runner_Scheme}")
            }
        }
        stage ('Distribution Re-sign') {
            steps {
                script {
                    iosSign(
                        PROVISIONING_PROFILE_CRED: 'mobileCCI_Distribution',
                        IPA_PATH: "MobileCCI/build/MobileCCI.ipa"
                    )
                }
            }
        }
        stage ('Upload to App Center') {
            steps {
                callFastLane("upload_to_appcenter app_name:${retrieveAppcenterAppName()} appcenter_token:${APPCENTER_TOKEN}")
            }
        }
        stage('Master branch steps') {
            when {
                branch INTEGRATION_BRANCH
            }
            steps {
                callFastLane("set_github_release_from_master tag_version:${params.releasetag} git_token:${GIT_TOKEN}")
            }
        }
    }
    post {
        always {
            callFastLane("delete_temp_keychain key_name:${env.KEYCHAIN_NAME}")
            sh "rm ~/Library/MobileDevice/Provisioning\\ Profiles/mobileCCI*"
            emailext attachLog: true, attachmentsPattern: 'MobileCCI/fastlane/test_output/report*',
            body: "${currentBuild.currentResult}: Job ${env.JOB_NAME} build ${env.BUILD_NUMBER}\n More info at: ${env.BUILD_URL}",
            to: this.NOTIFYUSERS,
            subject: "${env.JOB_NAME} - Build # ${env.BUILD_NUMBER} - ${currentBuild.result}"
            deleteDir()
        }
       success {
            script {
                notifyMe {
                    mode="slack"
                    subj="JENKINS JOB REPORT FOR MobileCCI Native iOS Builds - BUILD SUCCESSFUL"
                    slackChannel=this.SLACK_CHANNEL
                    statusColor="Green"
                    Message="BUILD SUCCESSFUL: "+ this.BUILD_DETAILS + this.JOB_CAUSES
                    token=this.SLACK_TOKEN
                }
            }
        }
        failure {
            script {
                notifyMe {
                    mode="slack"
                    subj="JENKINS JOB REPORT FOR MobileCCI Native iOS Builds - BUILD Failure"
                    slackChannel=this.SLACK_CHANNEL
                    statusColor="red"
                    Message="BUILD Failed: "+ this.BUILD_DETAILS + this.JOB_CAUSES
                    token=this.SLACK_TOKEN
                }
            }
        }
    }
}
def getBranchName(String branch_name) {
    return branch_name.replace("origin/", "");
}
def callFastLane(String fastlane_command) {
    dir("MobileCCI") {
        withEnv(["PATH=$PATH:/usr/local/bin", "LC_ALL=en_US.UTF-8", "LANG=en_US.UTF-8"]) {
            sh "fastlane ${fastlane_command}"
        }
    }
}
def syncSigningAssets(String key_name, String key_pass) {
    dir("MobileCCI") {
        withEnv(["PATH=$PATH:/usr/local/bin", "keychain_name=temp.keychain", "keychain_password=secret",
            "LC_ALL=en_US.UTF-8", "LANG=en_US.UTF-8"]) {
            withCredentials([file(credentialsId: 'MurphyDeveloper_Cert', variable: 'Certificate_p12')]) {
                withCredentials([string(credentialsId: 'Murphy_cert_password', variable: 'Certificate_p12_passphrase')]) {
                    sh "fastlane create_temp_keychain key_name:${key_name} key_password:${key_pass}"
                    sh "fastlane sync_signing_assets_jenkins cert_path:${Certificate_p12} cert_pass:${Certificate_p12_passphrase} key_name:${key_name} key_password:${key_pass}"
                    sh "security default-keychain -s ${key_name}"
                    sh "security unlock-keychain -p ${key_pass} ${key_name}"
                }
            }
        }
    }
}
