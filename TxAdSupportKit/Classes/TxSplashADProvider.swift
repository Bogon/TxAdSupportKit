//
//  TxSplashADProvider.swift
//  Pods
//
//  Created by minusapple on 2025/9/8.
//

import UIKit
import BUAdSDK

class TxSplashADProvider: NSObject, BUMSplashAdDelegate, BUSplashCardDelegate {
    
    private var splashAd: BUSplashAd?
    var splashResponseBlock: ((TxAdSupportResposeType) -> Void)?
    
    public func showSplashAd(adId: String) {
        if !adId.isEmpty {
            let adSize = UIScreen.main.bounds.size
            let splashAd = BUSplashAd(slotID: adId, adSize: adSize)
            splashAd.supportCardView = true
            splashAd.delegate = self
            splashAd.cardDelegate = self
            splashAd.tolerateTimeout = 3
            self.splashAd = splashAd
            splashAd.loadData()
        }
    }
    
    public func splashAdLoadSuccess(_ splashAd: BUSplashAd) {
        if let vc = UIViewController.ptCurrentVC() {
            splashAd.showSplashView(inRootViewController: vc)
        }
    }
    
    public func splashAdLoadFail(_ splashAd: BUSplashAd, error: BUAdError?) {
        splashResponseBlock?(.loadFail)
    }
    
    public func splashAdRenderFail(_ splashAd: BUSplashAd, error: BUAdError?) {}
    public func splashAdRenderSuccess(_ splashAd: BUSplashAd) {}
    public func splashAdWillShow(_ splashAd: BUSplashAd) {}
    public func splashAdDidShow(_ splashAd: BUSplashAd) {}
    public func splashAdDidClick(_ splashAd: BUSplashAd) {}
    
    public func splashAdDidClose(_ splashAd: BUSplashAd, closeType: BUSplashAdCloseType) {
        splashResponseBlock?(.didClose)
    }
    
    public func splashCardReady(toShow splashAd: BUSplashAd) {
        if let vc = UIViewController.ptCurrentVC() {
            splashAd.showCardView(inRootViewController: vc)
        }
    }
    
    public func splashCardViewDidClick(_ splashAd: BUSplashAd) {}
    
    public func splashCardViewDidClose(_ splashAd: BUSplashAd) {
        splashResponseBlock?(.didClose)
    }
    
    public func splashAdViewControllerDidClose(_ splashAd: BUSplashAd) {}
    public func splashDidCloseOtherController(_ splashAd: BUSplashAd, interactionType: BUInteractionType) {}
    public func splashVideoAdDidPlayFinish(_ splashAd: BUSplashAd, didFailWithError error: Error?) {}
}
