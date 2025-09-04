import UIKit
import BUAdSDK

public class TxBannerProvider: NSObject, BUMNativeExpressBannerViewDelegate {
    
    var bannerAd: BUNativeExpressBannerView?
    public var bannerCompleted:((_ type: TxAdSupportResposeType, _ view: UIView?)->Void)?
    
    public func showBanner(adId: String) {
        if !adId.isEmpty, let current: UIViewController = UIViewController.ptCurrentVC() {
            let slot: BUAdSlot = BUAdSlot.init()
            slot.id = adId
            slot.mediation.mutedIfCan = true
            
            bannerAd = BUNativeExpressBannerView.init(slot: slot, rootViewController: current, adSize: CGSize(width: UIScreen.main.bounds.width, height: 80))
            bannerAd?.delegate = self
            bannerAd?.loadAdData()
        }
    }
    
    // MARK: - BUMNativeExpressBannerViewDelegate
    public func nativeExpressBannerAdViewDidLoad(_ bannerAdView: BUNativeExpressBannerView) {
        bannerCompleted?(.success, bannerAdView)
    }
    
    public func nativeExpressBannerAdView(_ bannerAdView: BUNativeExpressBannerView, didLoadFailWithError error: (any Error)?) {
        bannerCompleted?(.loadFail, nil)
    }
    
    public func nativeExpressBannerAdViewDidBecomeVisible(_ bannerAdView: BUNativeExpressBannerView) {
        
    }
    
    public func nativeExpressBannerAdViewDidClick(_ bannerAdView: BUNativeExpressBannerView) {
        
    }
    
    public func nativeExpressBannerAdView(_ bannerAdView: BUNativeExpressBannerView, dislikeWithReason filterwords: [BUDislikeWords]?) {
        bannerCompleted?(.didClose, nil)
    }
    
    public func nativeExpressBannerAdViewDidCloseOtherController(_ bannerAdView: BUNativeExpressBannerView, interactionType: BUInteractionType) {
        bannerCompleted?(.didClose, nil)
    }
    
    public func nativeExpressBannerAdViewDidRemoved(_ bannerAdView: BUNativeExpressBannerView) {
        bannerCompleted?(.didClose, nil)
    }
    
    public func nativeExpressBannerAdNeedLayoutUI(_ bannerAd: BUNativeExpressBannerView, canvasView: BUMCanvasView) {
        
    }
    
}
