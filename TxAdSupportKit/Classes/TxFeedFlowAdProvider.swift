//
//  FeedFlowAdProvider.swift
//  Pods
//
//  Created by minusapple on 2025/9/3.
//

import UIKit
import BUAdSDK

public
class TxFeedFlowAdProvider: NSObject, BUNativeExpressAdViewDelegate, BUCustomEventProtocol {

    var feedFlowAd: BUNativeExpressAdManager?
    public var feedFlowCompleted:((_ type: TxAdSupportResposeType, _ view: UIView?)->Void)?
    
    public func showFeedFlow(adId: String) {
        if !adId.isEmpty {
            let slot: BUAdSlot = BUAdSlot.init()
            slot.id = adId
            slot.adType = .feed
            slot.supportRenderControl = true
            slot.imgSize = BUSize.init(by: .feed228_150)
            slot.mediation.mutedIfCan = true
            slot.position = .feed
            
            feedFlowAd = BUNativeExpressAdManager(slot: slot, adSize: CGSize(width:UIScreen.main.bounds.width, height: 0))
            feedFlowAd?.delegate = self
            feedFlowAd?.loadAdData(withCount: 1)
        }
    }
    
    public func nativeExpressAdSuccess(toLoad nativeExpressAdManager: BUNativeExpressAdManager, views: [BUNativeExpressAdView]) {
        if !views.isEmpty {
            views.forEach { expressView in
                if let current: UIViewController = UIViewController.ptCurrentVC()  {
                    expressView.rootViewController = current
                    expressView.render()
                }
            }
        }
    }
    
    public func nativeExpressAdFail(toLoad nativeExpressAdManager: BUNativeExpressAdManager, error: (any Error)?) {
        feedFlowCompleted?(.loadFail, nil)
    }
    
    public func nativeExpressAdViewRenderSuccess(_ nativeExpressAdView: BUNativeExpressAdView) {
        feedFlowCompleted?(.success, nativeExpressAdView)
    }
    
    public func nativeExpressAdView(_ nativeExpressAdView: BUNativeExpressAdView, stateDidChanged playerState: BUPlayerPlayState) {
        
    }
    
    public func nativeExpressAdViewRenderFail(_ nativeExpressAdView: BUNativeExpressAdView, error: (any Error)?) {
        feedFlowCompleted?(.loadFail, nil)
    }
    
    public func nativeExpressAdViewWillShow(_ nativeExpressAdView: BUNativeExpressAdView) {
        
    }
    
    public func nativeExpressAdViewDidClick(_ nativeExpressAdView: BUNativeExpressAdView) {
        
    }
    
    public func nativeExpressAdViewPlayerDidPlayFinish(_ nativeExpressAdView: BUNativeExpressAdView, error: (any Error)?) {
        
    }
    
    public func nativeExpressAdView(_ nativeExpressAdView: BUNativeExpressAdView, dislikeWithReason filterWords: [BUDislikeWords]) {
        feedFlowCompleted?(.didClose, nil)
    }
    
    public func nativeExpressAdViewDidRemoved(_ nativeExpressAdView: BUNativeExpressAdView) {
        feedFlowCompleted?(.didClose, nil)
    }
    
    public func nativeExpressAdViewDidCloseOtherController(_ nativeExpressAdView: BUNativeExpressAdView, interactionType: BUInteractionType) {
        
    }
    
}
