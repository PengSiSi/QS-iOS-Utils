//
//  QSHybridHandle.m
//  C2-iOS-Utils
//
//  Created by 彭思 on 2022/9/30.
//

#import "QSHybridHandle.h"
#import "QSHybridModel.h"
#import "QSHybridViewController.h"
#import "QSScanViewController.h"
#import "C2Common.h"

@implementation QSHybridHandle
+ (void)handleWithModule:(NSString *)module method:(NSString *)method value:(QSHybridModel *)value controller:(QSHybridViewController *)controller responseCallback:(QSResponseCallback)responseCallback {
    if ([method isEqualToString:@"scan"]) {
        // 扫一扫
        QSScanViewController *scan = [[QSScanViewController alloc]init];
        scan.modalPresentationStyle = UIModalPresentationFullScreen;
        scan.didScanResultBlock = ^(NSString * _Nonnull result) {
            // 扫码字符串
            if (responseCallback) {
                responseCallback(result, QSReturnType_OnSuccess);
            }
        };
        [[C2Context currentNavi] presentViewController:scan animated:YES completion:nil];
    }
}
    
@end
