//
//  QSHybridModel.h
//  C2-iOS-Utils
//
//  Created by 彭思 on 2022/9/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, QSReturnType) {
    QSReturnType_OnSuccess,// 成功返回结果
    QSReturnType_OnFail,// 失败返回结果
    QSReturnType_OnPageResult,// 上一页面返回结果
    QSReturnType_OnProgress//下载进度
};

@interface QSHybridModel : NSObject
@property (nonatomic, copy) NSString *module;
@property (nonatomic, copy) NSString *function;
@property (nonatomic, strong) NSDictionary *params;

@property (nonatomic, copy) NSString *onProgress;
@property (nonatomic, copy) NSString *onPageResult;
@property (nonatomic, copy) NSString *onSuccess;
@property (nonatomic, copy) NSString *onFail;
@property (nonatomic, strong) id returnValue;
@end

NS_ASSUME_NONNULL_END
