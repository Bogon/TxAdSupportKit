//
//  InterstitialFullAdProvider.swift
//  Pods
//
//  Created by minusapple on 2025/9/3.
//

import UIKit
import BUAdSDK

public
class TxInterstitialFullAdProvider: NSObject, BUNativeExpressFullscreenVideoAdDelegate {
    
    var interstitialFullAd: BUNativeExpressFullscreenVideoAd?
    public var interstitialFullCompleted:((_ type: TxAdSupportResposeType)->Void)?
    
    public func showInterstitialFull(adId: String) {
        if !adId.isEmpty {
            let slot: BUAdSlot = BUAdSlot.init()
            slot.id = adId
            slot.mediation.mutedIfCan = true
            
            interstitialFullAd = BUNativeExpressFullscreenVideoAd(slot: slot)
            interstitialFullAd?.delegate = self
            interstitialFullAd?.loadData()
        }
    }
    
    public func nativeExpressFullscreenVideoAdDidLoad(_ fullscreenVideoAd: BUNativeExpressFullscreenVideoAd) {
        if let current: UIViewController = UIViewController.ptCurrentVC() {
            interstitialFullAd?.show(fromRootViewController: current)
        }
    }
    
    public func nativeExpressFullscreenVideoAd(_ fullscreenVideoAd: BUNativeExpressFullscreenVideoAd, didFailWithError error: (any Error)?) {
        interstitialFullCompleted?(.loadFail)
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
        interstitialFullCompleted?(.didClose)
    }
    
    public func nativeExpressFullscreenVideoAdWillClose(_ fullscreenVideoAd: BUNativeExpressFullscreenVideoAd) {
        
    }
    
    public func nativeExpressFullscreenVideoAdDidClose(_ fullscreenVideoAd: BUNativeExpressFullscreenVideoAd) {
        interstitialFullCompleted?(.didClose)
    }
    
    public func nativeExpressFullscreenVideoAdDidPlayFinish(_ fullscreenVideoAd: BUNativeExpressFullscreenVideoAd, didFailWithError error: (any Error)?) {
        
    }
    
    public func nativeExpressFullscreenVideoAdCallback(_ fullscreenVideoAd: BUNativeExpressFullscreenVideoAd, with nativeExpressVideoAdType: BUNativeExpressFullScreenAdType) {
        
    }
    
    public func nativeExpressFullscreenVideoAdDidCloseOtherController(_ fullscreenVideoAd: BUNativeExpressFullscreenVideoAd, interactionType: BUInteractionType) {
        
    }
}

