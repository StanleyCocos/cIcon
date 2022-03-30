import Flutter
import UIKit

@available(iOS 10.3, *)
public class SwiftCiconPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "cicon", binaryMessenger: registrar.messenger())
    let instance = SwiftCiconPlugin()
    UIViewController.initializeMethod()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      
      if "setIcons" == call.method {
          setIcon(name: call.arguments as? String, result: result)
      } else if "restoreIcon" == call.method {
          setIcon(name: nil,  result: result)
      } else if "getIcon" == call.method {
          result(getIcon())
      }
      
  }
    

    public func setIcon(name: String?, result: @escaping FlutterResult){
        guard #available(iOS 10.3, *) else {
            result(false)
            return
        }
        
        if !UIApplication.shared.supportsAlternateIcons {
            result(false)
            return
        }
        
        UIApplication.shared.setAlternateIconName(name){ error in
            print(error)
            result(error == nil)
        }
    }
    
    
    public func getIcon() -> String? {
        return UIApplication.shared.alternateIconName;
    }
}

