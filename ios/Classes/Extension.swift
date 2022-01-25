//
//  extension.swift
//  cicon
//
//  Created by ljc on 2022/1/25.
//

import UIKit


extension UIViewController {
  public class func initializeMethod() {
    if self != UIViewController.self {
      return
    }
        // Method Swizzling
    DispatchQueue.once(token: "ChangeIcon") {
      let orignal = class_getInstanceMethod(self, #selector(UIViewController.present(_:animated:completion:)))
      let swizzling = class_getInstanceMethod(self, #selector(UIViewController.jt_present(_:animated:completion:)))
 
      if let old = orignal, let new = swizzling {
        method_exchangeImplementations(old, new)
      }
    }
  }
 
  @objc private func jt_present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
    // 在这里判断是否是更换icon时的弹出框
    if viewControllerToPresent is UIAlertController {
 
      let alertTitle = (viewControllerToPresent as! UIAlertController).title
      let alertMessage = (viewControllerToPresent as! UIAlertController).message
 
      // 更换icon时的弹出框，这两个string都为nil。
      if alertTitle == nil && alertMessage == nil {
        return
      }
    }
         
        // 因为方法已经交换，这个地方的调用就相当于调用原先系统的 present
    self.jt_present(viewControllerToPresent, animated: flag, completion: completion)
  }
}


extension DispatchQueue {
  private static var _onceTracker = [String]()
  public class func once(token: String, block: () -> ()) {
    objc_sync_enter(self)
    defer {
      objc_sync_exit(self)
    }
    if _onceTracker.contains(token) {
      return
    }
    _onceTracker.append(token)
    block()
  }
}

