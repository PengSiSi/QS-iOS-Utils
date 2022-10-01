//
//  QSHybridViewController+JSSDK.h
//  C2-iOS-Utils
//
//  Created by 彭思 on 2022/9/30.
//

//#import <C2_iOS_Utils/C2_iOS_Utils.h>
#import "QSHybridModel.h"
#import "QSHybridViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^QSActionBlock)(id returnValue, QSReturnType returnFunc);

@interface QSHybridViewController (JSSDK)

/**
 JSSDK的Api对应原生处理
 
 @param hybrid 传递过来的JSSDK的Api对应 model
 @param actionBlock 原生处理完成后执行的操作
 */
- (void)actionWithHybrid:(QSHybridModel *)hybrid action:(QSActionBlock)actionBlock;


@end

NS_ASSUME_NONNULL_END
