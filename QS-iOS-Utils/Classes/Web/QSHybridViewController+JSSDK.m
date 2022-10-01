//
//  QSHybridViewController+JSSDK.m
//  C2-iOS-Utils
//
//  Created by 彭思 on 2022/9/30.
//

#import "QSHybridViewController+JSSDK.h"
#import "QSHybridHandle.h"
#import "QSHybridModel.h"

@implementation QSHybridViewController (JSSDK)
// JSSDK的Api对应原生处理
- (void)actionWithHybrid:(QSHybridModel *)hybrid action:(QSActionBlock)actionBlock {
    
    NSString *module = hybrid.module;
    NSString *method = hybrid.function;
    
    [QSHybridHandle handleWithModule:module method:method value:hybrid controller:self responseCallback:^(id  _Nonnull responseData, QSReturnType type) {
        if (actionBlock) {
            actionBlock(responseData, type);
        }
    }];
}

@end
