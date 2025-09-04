//
//  RewardADProvider.swift
//  Pods
//
//  Created by minusapple on 2025/9/3.
//

import Foundation
import BUAdSDK

public 
class TxRewardADProvider: NSObject, BUMNativeExpressRewardedVideoAdDelegate {
    
    private var rewardedAd: BUNativeExpressRewardedVideoAd?
    private var rewardedId: String?
    public var rewardCompleted:((_ type: TxAdSupportResposeType, _ transId: String, _ placementId: String)->Void)?
    
    public func showReward(adId: String) {
        if !adId.isEmpty {
            rewardedId = adId
            let slot: BUAdSlot = BUAdSlot.init()
            slot.id = adId
            slot.mediation.mutedIfCan = true
            let model = BURewardedVideoModel()
            model.rewardAmount = 1
            rewardedAd = BUNativeExpressRewardedVideoAd(slot: slot, rewardedVideoModel: model)
            rewardedAd?.delegate = self
            rewardedAd?.loadData()
        }
    }
    
    // MARK: - BUMNativeExpressRewardedVideoAdDelegate
    func nativeExpressRewardedVideoAdDidLoad(_ rewardedVideoAd: BUNativeExpressRewardedVideoAd) {
        if let current = UIViewController.ptCurrentVC() {
            rewardedAd?.show(fromRootViewController: current)
        }
    }
    
    func nativeExpressRewardedVideoAd(_ rewardedVideoAd: BUNativeExpressRewardedVideoAd, didFailWithError error: (any Error)?) {
        rewardCompleted?(.loadFail, "", "")
    }
    
    func nativeExpressRewardedVideoAdDidDownLoadVideo(_ rewardedVideoAd: BUNativeExpressRewardedVideoAd) {}
    
    func nativeExpressRewardedVideoAdDidShowFailed(_ rewardedVideoAd: BUNativeExpressRewardedVideoAd, error: any Error) {
        rewardCompleted?(.loadFail, "", "")
    }
    
    func nativeExpressRewardedVideoAdDidVisible(_ rewardedVideoAd: BUNativeExpressRewardedVideoAd) {}
    
    func nativeExpressRewardedVideoAdDidClose(_ rewardedVideoAd: BUNativeExpressRewardedVideoAd) {
        rewardCompleted?(.didClose, "", "")
    }
    
    func nativeExpressRewardedVideoAdDidClick(_ rewardedVideoAd: BUNativeExpressRewardedVideoAd) {}
    
    func nativeExpressRewardedVideoAdDidClickSkip(_ rewardedVideoAd: BUNativeExpressRewardedVideoAd) {
        rewardCompleted?(.didClose, "", "")
    }
    
    func nativeExpressRewardedVideoAdDidPlayFinish(_ rewardedVideoAd: BUNativeExpressRewardedVideoAd, didFailWithError error: (any Error)?) {}
    
    func nativeExpressRewardedVideoAdServerRewardDidSucceed(_ rewardedVideoAd: BUNativeExpressRewardedVideoAd, verify: Bool) {
        rewardCompleted?(.success, UUID().uuidString, rewardedId ?? "")
    }
    
}
