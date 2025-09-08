//
//  InterstitialHalfAdProvider.swift
//  Pods
//
//  Created by minusapple on 2025/9/3.
//

import UIKit
import BUAdSDK

public
class TxInterstitialHalfAdProvider: NSObject, BUNativeExpressFullscreenVideoAdDelegate {
    
    var positionType: Int = 0
    var interstitialHalfAd: BUNativeExpressFullscreenVideoAd?
    public var interstitialHalfCompleted:((_ position: Int, _ type: TxAdSupportResposeType)->Void)?
    
    public func showInterstitialHalf(adId: String, position: Int = 0) {
        if !adId.isEmpty {
            positionType = position
            let slot: BUAdSlot = BUAdSlot.init()
            slot.id = adId
            slot.mediation.mutedIfCan = true
            interstitialHalfAd = BUNativeExpressFullscreenVideoAd(slot: slot)
            interstitialHalfAd?.delegate = self
            interstitialHalfAd?.loadData()
        }
    }
    
    public func nativeExpressFullscreenVideoAdDidLoad(_ fullscreenVideoAd: BUNativeExpressFullscreenVideoAd) {
        if let current: UIViewController = UIViewController.ptCurrentVC() {
            interstitialHalfAd?.show(fromRootViewController: current)
        }
    }
    
    public func nativeExpressFullscreenVideoAd(_ fullscreenVideoAd: BUNativeExpressFullscreenVideoAd, didFailWithError error: (any Error)?) {
        interstitialHalfCompleted?(positionType, .loadFail)
    }
    
    public func nativeExpressFullscreenVideoAdViewRenderSuccess(_ rewardedVideoAd: BUNativeExpressFullscreenVideoAd) {
        
    }
    
    public func nativeExpressFullscreenVideoAdViewRenderFail(_ rewardedVideoAd: BUNativeExpressFullscreenVideoAd, error: (any Error)?) {
        
    }
    
    public func nativeExpressFullscreenVideoAdDidDownLoadVideo(_ fullscreenVideoAd: BUNativeExpressFullscreenVideoAd) {
        
    }
    
    public func nativeExpressFullscreenVideoAdWillVisible(_ fullscreenVideoAd: BUNativeExpressFullscreenVideoAd) {
        
    }
    
    public func nativeExpressFullscreenVideoAdDidVisible(_ fullscreenVideoAd: BUNativeExpressFullscreenVideoAd) {
        
    }
    
    public func nativeExpressFullscreenVideoAdDidClick(_ fullscreenVideoAd: BUNativeExpressFullscreenVideoAd) {
        
    }
    
    public func nativeExpressFullscreenVideoAdDidClickSkip(_ fullscreenVideoAd: BUNativeExpressFullscreenVideoAd) {
        interstitialHalfCompleted?(positionType, .didClose)
    }
    
    public func nativeExpressFullscreenVideoAdWillClose(_ fullscreenVideoAd: BUNativeExpressFullscreenVideoAd) {
        
    }
    
    public func nativeExpressFullscreenVideoAdDidClose(_ fullscreenVideoAd: BUNativeExpressFullscreenVideoAd) {
        interstitialHalfCompleted?(positionType,.didClose)
    }
    
    public func nativeExpressFullscreenVideoAdDidPlayFinish(_ fullscreenVideoAd: BUNativeExpressFullscreenVideoAd, didFailWithError error: (any Error)?) {
        
    }
    
    public func nativeExpressFullscreenVideoAdCallback(_ fullscreenVideoAd: BUNativeExpressFullscreenVideoAd, with nativeExpressVideoAdType: BUNativeExpressFullScreenAdType) {
        
    }
    
    public func nativeExpressFullscreenVideoAdDidCloseOtherController(_ fullscreenVideoAd: BUNativeExpressFullscreenVideoAd, interactionType: BUInteractionType) {
        
    }
}
