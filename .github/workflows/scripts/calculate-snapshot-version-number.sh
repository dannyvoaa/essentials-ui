# =============================================================================
#
# This script constructs a SNAPSHOT version number and APK file name based on 
# the version number specified in the pubspec file, the branch name being built
# and a unique build number provided by GitHub. It will also validate that the 
# version number defined in pubspec.yaml is in fact a SNAPSHOT version. This
# script is meant to be used for feature branches and the develop branch.
#
# =============================================================================

# -----------------------------------------------------------------------------
# dummy environment variables used for testing, normally provided by github

# export GITHUB_REF='refs/heads/master' 
# export GITHUB_REF='refs/heads/develop' 
#export GITHUB_REF='refs/heads/feature/cicd-pipeline' 
#export GITHUB_RUN_NUMBER=42
#export GITHUB_ENV='version-info.txt'
# -----------------------------------------------------------------------------

cd aae_mobile

# grab our branch name and the version number in pubspec
export BRANCH_NAME=$(echo $GITHUB_REF | grep -o '[^/]*$')
export ESSENTIALS_PUBSEPC_VERSION=$(yq e .version pubspec.yaml )

# verify we have a SNAPSHOT version number when appropriate and a
# release version number when building off of master
if [[ "$GITHUB_REF" != "refs/heads/master" ]]  && 
   [[ "$ESSENTIALS_PUBSEPC_VERSION" != *"-SNAPSHOT" ]]
then
    echo "Vesion number in pubsepc.yaml is $ESSENTIALS_PUBSEPC_VERSION but should be a SNAPSHOT version."
	exit 1
elif [[ "$GITHUB_REF" == "refs/heads/master" ]]  &&
     [[ ! $ESSENTIALS_PUBSEPC_VERSION =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]
then
    echo "Vesion number in pubsepc.yaml is $ESSENTIALS_PUBSEPC_VERSION but should be a proper release version number."
	exit 1	
fi

# construct version number, but omit branch name for develop and master
if [[ "$GITHUB_REF" == "refs/heads/develop" ]] ||
   [[ "$GITHUB_REF" == "refs/heads/master" ]]
then
	export ESSENTIALS_VERSION=$(echo $ESSENTIALS_PUBSEPC_VERSION)
else
	export ESSENTIALS_VERSION=$(echo $ESSENTIALS_PUBSEPC_VERSION'-'$BRANCH_NAME)
fi

# construct the file name
if [[ "$GITHUB_REF" == "refs/heads/master" ]] 
then 
	export ESSENTIALS_FILE_NAME=$(echo 'essentials'-$ESSENTIALS_VERSION)
else
	export ESSENTIALS_FILE_NAME=$(echo 'essentials'-$ESSENTIALS_VERSION+$GITHUB_RUN_NUMBER)
fi

# export the variables for other steps in the job
echo "BRANCH_NAME="$BRANCH_NAME >> $GITHUB_ENV
echo "ESSENTIALS_VERSION="$ESSENTIALS_VERSION >> $GITHUB_ENV
echo "ESSENTIALS_FILE_NAME="$ESSENTIALS_FILE_NAME >> $GITHUB_ENV

echo $ESSENTIALS_FILE_NAME