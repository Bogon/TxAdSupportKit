//
//  TxAdSupportProvider.swift
//  Pods
//
//  Created by minusapple on 2025/9/6.
//

import UIKit

public final class TxAdSupportProvider: NSObject {
    
    let splashAdProvider: TxSplashADProvider = TxSplashADProvider()
    let fullAdProvider: TxInterstitialFullAdProvider = TxInterstitialFullAdProvider()
    let halfAdProvider: TxInterstitialHalfAdProvider = TxInterstitialHalfAdProvider()
    let bannerProvider: TxBannerProvider = TxBannerProvider()
    let feedFlowAdProvider: TxFeedFlowAdProvider = TxFeedFlowAdProvider()
    let rewardADProvider: TxRewardADProvider = TxRewardADProvider()
    
    // 单例
    public static let shared = TxAdSupportProvider()
    
    // 禁止外部初始化
    private override init() {
        super.init()
    }
    
    // 禁止拷贝
    public override func copy() -> Any {
        return self
    }
    
    public override func mutableCopy() -> Any {
        return self
    }
    
    public func startAdSupport() {
        
        // 初始化 ADSDK
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "TxAdInitliazeRequest"), object: nil, queue: .main) { notification in
            if let userInfo = notification.userInfo, let appId = userInfo["AppId"] as? String {
                TxAdSupportInitProvider.sdk(appid: appId) { isSuccess in
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "TxAdInitliazeReponse"), object: nil, userInfo: [
                        "isSuccess": isSuccess
                    ])
                }
            }
        }
        
        fullAdProvider.interstitialFullCompleted = { type in
            NotificationCenter.default.post(name: Notification.Name(rawValue: "TxAdFullInterstitialResponse"), object: nil, userInfo: [
                "type": type.rawValue
            ])
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "TxAdFullInterstitialRequest"), object: nil, queue: .main) { notification in
            if let userInfo = notification.userInfo, let adId = userInfo["adId"] as? String {
                self.fullAdProvider.showInterstitialFull(adId: adId)
            }
        }
        
        halfAdProvider.interstitialHalfCompleted = { position, type in
            NotificationCenter.default.post(name: Notification.Name(rawValue: "TxAdInterstHalfResponse"), object: nil, userInfo: [
                "type": type.rawValue,
                "position": position
            ])
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "TxAdInterstHalfRequest"), object: nil, queue: .main) { notification in
            if let userInfo = notification.userInfo, let adId = userInfo["adId"] as? String, let position = userInfo["position"] as? Int   {
                self.halfAdProvider.showInterstitialHalf(adId: adId, position: position)
            }
        }
        
        bannerProvider.bannerCompleted = {  type, banner in
            if type == .success,let view: UIView = banner {
                NotificationCenter.default.post(name: Notification.Name(rawValue: "TxAdBannerResponse"), object: nil, userInfo: [
                    "type": type.rawValue,
                    "view": view
                ])
            } else {
                NotificationCenter.default.post(name: Notification.Name(rawValue: "TxAdBannerResponse"), object: nil, userInfo: [
                    "type": type.rawValue,
                    "view": ""
                ])
            }
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "TxAdBannerRequest"), object: nil, queue: .main) { notification in
            if let userInfo = notification.userInfo, let adId = userInfo["adId"] as? String{
                self.bannerProvider.showBanner(adId: adId)
            }
        }
        
        feedFlowAdProvider.feedFlowCompleted = { position, type, adView in
            if type == .success,let view: UIView = adView {
                NotificationCenter.default.post(name: Notification.Name(rawValue: "TxAdFeedFlowResponse"), object: nil, userInfo: [
                    "type": type.rawValue,
                    "view": view,
                    "position": position
                ])
            } else {
                NotificationCenter.default.post(name: Notification.Name(rawValue: "TxAdFeedFlowResponse"), object: nil, userInfo: [
                    "type": type.rawValue,
                    "view": "",
                    "position": position
                ])
            }
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "TxAdFeedFlowRequest"), object: nil, queue: .main) { notification in
            if let userInfo = notification.userInfo, let adId = userInfo["adId"] as? String, let position = userInfo["position"] as? Int {
                self.feedFlowAdProvider.showFeedFlow(adId: adId, position: position)
            }
        }
        
        rewardADProvider.rewardCompleted = { type, transId, placementId in
            if type == .success {
                NotificationCenter.default.post(name: Notification.Name(rawValue: "TxAdRewardResponse"), object: nil, userInfo: [
                    "type": type.rawValue,
                    "transId": transId,
                    "placementId": placementId
                ])
            } else {
                NotificationCenter.default.post(name: Notification.Name(rawValue: "TxAdRewardResponse"), object: nil, userInfo: [
                    "type": type.rawValue,
                    "transId": "",
                    "placementId": ""
                ])
            }
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "TxAdRewardRequest"), object: nil, queue: .main) { notification in
            if let userInfo = notification.userInfo, let adId = userInfo["adId"] as? String {
                self.rewardADProvider.showReward(adId: adId)
            }
        }
        
        
        splashAdProvider.splashResponseBlock = { type in
            NotificationCenter.default.post(name: Notification.Name(rawValue: "TxAdSplashResponse"), object: nil, userInfo: [
                "type": type.rawValue,
            ])
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "TxAdSplashRequest"), object: nil, queue: .main) { notification in
            if let userInfo = notification.userInfo, let adId = userInfo["adId"] as? String {
                self.splashAdProvider.showSplashAd(adId: adId)
            }
        }
    }
    
}
