//
//  QSHybridHandle.h
//  C2-iOS-Utils
//
//  Created by 彭思 on 2022/9/30.
//

#import <Foundation/Foundation.h>
#import "QSHybridModel.h"
#import "QSHybridViewController.h"

typedef void(^QSResponseCallback)(id responseData, QSReturnType type);

NS_ASSUME_NONNULL_BEGIN

@interface QSHybridHandle : NSObject
+ (void)handleWithModule:(NSString *)module method:(NSString *)method value:(QSHybridModel *)value controller:(QSHybridViewController *)controller responseCallback:(QSResponseCallback)responseCallback;

@end

NS_ASSUME_NONNULL_END
