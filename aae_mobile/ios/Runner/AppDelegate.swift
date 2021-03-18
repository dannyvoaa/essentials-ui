import UIKit
import Flutter
import Firebase

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    GeneratedPluginRegistrant.register(with: self)
    
    Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
     // AnalyticsParameterItemID: "id",
      AnalyticsParameterItemName: "AAECalscreenName"
     // AnalyticsParameterContentType: "cont"
      ])
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    
  }
    
}
