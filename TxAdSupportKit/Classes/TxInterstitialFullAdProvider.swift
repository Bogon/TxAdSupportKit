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
    
    func nativeExpressFullscreenVideoAdDidLoad(_ fullscreenVideoAd: BUNativeExpressFullscreenVideoAd) {
        if let current: UIViewController = UIViewController.ptCurrentVC() {
            interstitialFullAd?.show(fromRootViewController: current)
        }
    }
    
    func nativeExpressFullscreenVideoAd(_ fullscreenVideoAd: BUNativeExpressFullscreenVideoAd, didFailWithError error: (any Error)?) {
        interstitialFullCompleted?(.loadFail)
    }
    
    func nativeExpressFullscreenVideoAdViewRenderSuccess(_ rewardedVideoAd: BUNativeExpressFullscreenVideoAd) {
        
    }
    
    func nativeExpressFullscreenVideoAdViewRenderFail(_ rewardedVideoAd: BUNativeExpressFullscreenVideoAd, error: (any Error)?) {
        
    }
    
    func nativeExpressFullscreenVideoAdDidDownLoadVideo(_ fullscreenVideoAd: BUNativeExpressFullscreenVideoAd) {
        
    }
    
    func nativeExpressFullscreenVideoAdWillVisible(_ fullscreenVideoAd: BUNativeExpressFullscreenVideoAd) {
        
    }
    
    func nativeExpressFullscreenVideoAdDidVisible(_ fullscreenVideoAd: BUNativeExpressFullscreenVideoAd) {
        
    }
    
    func nativeExpressFullscreenVideoAdDidClick(_ fullscreenVideoAd: BUNativeExpressFullscreenVideoAd) {
        
    }
    
    func nativeExpressFullscreenVideoAdDidClickSkip(_ fullscreenVideoAd: BUNativeExpressFullscreenVideoAd) {
        interstitialFullCompleted?(.didClose)
    }
    
    func nativeExpressFullscreenVideoAdWillClose(_ fullscreenVideoAd: BUNativeExpressFullscreenVideoAd) {
        
    }
    
    func nativeExpressFullscreenVideoAdDidClose(_ fullscreenVideoAd: BUNativeExpressFullscreenVideoAd) {
        interstitialFullCompleted?(.didClose)
    }
    
    func nativeExpressFullscreenVideoAdDidPlayFinish(_ fullscreenVideoAd: BUNativeExpressFullscreenVideoAd, didFailWithError error: (any Error)?) {
        
    }
    
    func nativeExpressFullscreenVideoAdCallback(_ fullscreenVideoAd: BUNativeExpressFullscreenVideoAd, with nativeExpressVideoAdType: BUNativeExpressFullScreenAdType) {
        
    }
    
    func nativeExpressFullscreenVideoAdDidCloseOtherController(_ fullscreenVideoAd: BUNativeExpressFullscreenVideoAd, interactionType: BUInteractionType) {
        
    }
}

