//
//  QSScanViewController.h
//  C2-iOS-Utils
//
//  Created by 彭思 on 2022/9/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QSScanViewController : UIViewController
@property (nonatomic,copy) void (^didScanResultBlock)(NSString *result); // 扫描结果回调

@end

NS_ASSUME_NONNULL_END
