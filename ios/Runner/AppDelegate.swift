import UIKit
import Flutter
import OLOidc

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    var olOidc : OLOidc?
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        guard #available(iOS 11, *) else {
            return olOidc?.currentAuthorizationFlow?.resumeExternalUserAgentFlow(with: url) ?? false
        }
        return false
    }
    
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let oneLoginChannel = FlutterMethodChannel(name: "samples.flutter.dev/onelogin",
                                                  binaryMessenger: controller.binaryMessenger)

    
    oneLoginChannel.setMethodCallHandler({
      [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
      // Note: this method is invoked on the UI thread.
      guard call.method == "getSignIn" else {
        result(FlutterMethodNotImplemented)
        return
      }
      self?.signIn(result: result)
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    func signIn(result: FlutterResult) {
        olOidc?.signIn(presenter: self) { error
                in
                if let error = error {
                        result(FlutterError(code: "Error",
                                            message: "Error: \(error)",
                                            details: nil))
                }
                if let accessToken = self.olOidc?.olAuthState.accessToken {
                    result("Received access token: \(accessToken)")
                }
            }
    }


}
