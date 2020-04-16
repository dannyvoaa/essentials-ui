# American Essentials (Web Admin)

## Introduction 
The American Essentials (Web Admin) portal, also known as AEWA, is the Flutter-based administrative console for the American Essentials mobile app.

This is baslined on CA submitted code



## Preparing to buld on a new computer

### Switch to the Flutter beta channel
```
flutter channel beta
```

### Reset the build
```
flutter clean
flutter pub get
```

## Build and Run 

### Build for Local Testing
Build and run AEWA in Visual Studio Code as your normally would, targeting _iPad Pro (12.9-inch) (3rd generation)_.

While AEWA will build and run on any iOS device, including _iPhone SE_, the large screen size of _iPad Pro (12.9-inch) (3rd generation)_ more closely resemebles that of a browser and is the device that I reccomend that you use.

### Build for Web Deployment
1) Navigate to the project's directory in Terminal
2) Enable Flutter Web (if it hasn't already been enabled)
   * `flutter config --enable-web`
3) Buld the site for web deployment
   * `flutter build web`
4) Copy the built files (located in $ProjectDir/build/web) to your chosen web server
5) Navigate to the newly deployed website in the browser of your choice
   * Make sure to disable CORS in your browser, otherwise AEWA won't be able to communicate with IBM App ID and IBM Cloudant
   * This is a known issue that should be resolved in the future once AEWA is moved over to AA's API's where AA will have full control over the API's [SAME-ORIGIN](https://developer.mozilla.org/en-US/docs/Web/Security/Same-origin_policy) policy
