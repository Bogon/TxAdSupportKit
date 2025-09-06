//
//  AdSupportInitProvider.swift
//  Pods
//
//  Created by minusapple on 2025/9/3.
//

import Foundation
import BUAdSDK
import ObjectiveC.runtime

public enum TxAdSupportResposeType: Int {
    case loadFail = 0
    case didClose
    case success
}

public class TxAdSupportInitProvider: NSObject {
    public static func sdk(bundleId: String = "", appid: String, _ completed: @escaping (Bool) -> Void) {
        if !bundleId.isEmpty {
            Bundle.enableCustomBundleID(bundleId)
        }
        print(Bundle.main.bundleIdentifier ?? "nil") 
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


extension Bundle {
    // 用 UInt8 来做唯一 key，避免 String 带来的 UnsafeRawPointer 警告
    private struct AssociatedKeys {
        static var customBundleID: UInt8 = 0
    }

    // MARK: - 动态存储的 customBundleID
    private var customBundleID: String? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.customBundleID) as? String
        }
        set {
            objc_setAssociatedObject(self,
                                     &AssociatedKeys.customBundleID,
                                     newValue,
                                     .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }

    // MARK: - 启用自定义 BundleID
    static func enableCustomBundleID(_ newID: String) {
        // 执行一次 swizzling
        _ = swizzleMethods
        Bundle.main.customBundleID = newID
    }

    // MARK: - 还原
    private static func resetCustomBundleID() {
        Bundle.main.customBundleID = nil
    }

    // MARK: - Swizzling
    private static let swizzleMethods: Void = {
        let cls = Bundle.self

        func swizzle(_ original: Selector, _ swizzled: Selector) {
            if let m1 = class_getInstanceMethod(cls, original),
               let m2 = class_getInstanceMethod(cls, swizzled) {
                method_exchangeImplementations(m1, m2)
            }
        }

        swizzle(#selector(getter: bundleIdentifier),
                #selector(swizzled_bundleIdentifier))
        swizzle(#selector(object(forInfoDictionaryKey:)),
                #selector(swizzled_object(forInfoDictionaryKey:)))
        swizzle(#selector(getter: infoDictionary),
                #selector(swizzled_infoDictionary))
    }()

    // MARK: - Hook 方法
    @objc private func swizzled_bundleIdentifier() -> String? {
        return customBundleID ?? swizzled_bundleIdentifier()
    }

    @objc private func swizzled_object(forInfoDictionaryKey key: String) -> Any? {
        if key == "CFBundleIdentifier", let id = customBundleID {
            return id
        }
        return swizzled_object(forInfoDictionaryKey: key)
    }

    @objc private func swizzled_infoDictionary() -> [String: Any]? {
        var dict = swizzled_infoDictionary() ?? [:]
        if let id = customBundleID {
            dict["CFBundleIdentifier"] = id
        }
        return dict
    }
}
