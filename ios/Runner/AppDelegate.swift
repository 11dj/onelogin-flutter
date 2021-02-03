import UIKit
import Flutter
import OLOidc

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    var olOidc : OLOidc?
    
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        guard #available(iOS 11, *) else {
            return olOidc?.currentAuthorizationFlow?.resumeExternalUserAgentFlow(with: url) ?? false
        }
        return false
    }

}
