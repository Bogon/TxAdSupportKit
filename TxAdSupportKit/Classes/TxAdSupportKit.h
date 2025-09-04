//
//  TxAdSupportKit.h
//  Pods
//
//  Created by minusapple on 2025/9/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (CustomBundleID)
@property (nonatomic, copy, readonly) NSString *originalBundleID;
@property (nonatomic, copy, nullable) NSString *customBundleID;
- (void)custom_setBundleIdentifier:(NSString *_Nullable)bundleID;
@end

NS_ASSUME_NONNULL_END
