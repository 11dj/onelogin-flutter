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
        
}
    
    override func viewDidLoad() {
      super.viewDidLoad()

      let olOidcConfig = try? OLOidcConfig(dict: [
        "issuer": "https://openid-connect.onelogin.com/oidc",
        "clientId": "ba08dd00-484a-0139-b563-06351d701be3184317",
        "redirectUri": "https://com.oneloginAuth.oidc://callback",
        "scopes": "openid profile"
      ])

      olOidc = try? OLOidc(configuration: olOidcConfig)
      AppDelegate.shared.olOidc = olOidc

    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
//        let oneLoginChannel = FlutterMethodChannel(name: "samples.flutter.dev/onelogin",
//                                                  binaryMessenger: controller.binaryMessenger)
    
    let oneLoginChannel = FlutterMethodChannel.init(name: "samples.flutter.dev/onelogin", binaryMessenger: controller as! FlutterBinaryMessenger)
    
    oneLoginChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: FlutterResult) -> Void in
        if call.method == "initOneLogin" {
//            self?.signIn(result: result)
            let olOidc = OLOidc(configuration: myConfiguration, useSecureStorage: false)
        } else if call.method == "getSignIn" {
            self?.signIn(controller: controller, result: result)
          } else {
          result(FlutterMethodNotImplemented)
          return
        }
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    func signIn(controller: UIViewController, result: FlutterResult) {
        olOidc?.signIn(presenter: controller) { error
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
