//
//  AdSupportInitProvider.swift
//  Pods
//
//  Created by minusapple on 2025/9/3.
//

import Foundation
import BUAdSDK

public enum TxAdSupportResposeType: Int {
    case loadFail = 0
    case didClose
    case success
}

public class TxAdSupportInitProvider: NSObject {
    public static func sdk(bundleId: String = "", appid: String, _ completed: @escaping (Bool) -> Void) {
        if !bundleId.isEmpty {
            Bundle.main.custom_setBundleIdentifier(bundleId)
        }
        if !appid.isEmpty {
            let config: BUAdSDKConfiguration = BUAdSDKConfiguration.configuration()
            config.appID = appid
            #if DEBUG
            config.debugLog = true
            #endif
            config.useMediation = true
            BUAdSDKManager.start(asyncCompletionHandler: { success, error in
                if success {
                    completed(success)
                } else {
                    completed(false)
                }
            })
        }
    }
}

extension UIViewController {

    class func ptCurrentNav() -> UINavigationController? {
        return ptCurrentVC()?.navigationController
    }
    

    class func ptCurrentVC() -> UIViewController? {
        var window: UIWindow?
        
        if #available(iOS 13.0, *) {
            outer: for scene in UIApplication.shared.connectedScenes {
                if let windowScene = scene as? UIWindowScene {
                    for windowTemp in windowScene.windows {
                        if windowTemp.isKeyWindow {
                            window = windowTemp
                            // 跳两层
                            break outer
                        }
                    }
                }
            }
        } else {
            if let delegateWindow = UIApplication.shared.delegate?.window, let windowV = delegateWindow {
                window = windowV
            }
        }
        
        var topViewController = window?.rootViewController
        
        while true {
            if let topVC = topViewController?.presentedViewController {
                topViewController = topVC
            } else if let topNavi = topViewController as? UINavigationController, let topVC = topNavi.topViewController {
                topViewController = topVC
            } else if let topTab = topViewController as? UITabBarController {
                topViewController = topTab.selectedViewController
            } else {
                break
            }
        }
        
        return topViewController
    }
    
    class func ptWindow() -> UIWindow? {
        var window: UIWindow?
        if #available(iOS 13.0, *) {
            outer: for scene in UIApplication.shared.connectedScenes {
                if let windowScene = scene as? UIWindowScene {
                    for windowTemp in windowScene.windows {
                        if windowTemp.isKeyWindow {
                            window = windowTemp
                            // 跳两层
                            break outer
                        }
                    }
                }
            }
        } else {
            if let delegateWindow = UIApplication.shared.delegate?.window, let windowV = delegateWindow {
                window = windowV
            }
        }
        
        return window
    }
}

