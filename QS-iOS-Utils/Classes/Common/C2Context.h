//
//  C2Context.h
//  C2-iOS-Utils
//
//  Created by 彭思 on 2022/9/28.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, C2BackBtnStyle) {
    C2BackBtnStyle_Default,  // 默认，图标加文字
    C2BackBtnStyle_OnlyIcon, // 仅图标
    C2BackBtnStyle_OnlyText  // 仅文字
};

@interface C2Context : NSObject
+ (instancetype)sharedInstance;
+ (BOOL)isIPhoneXSeries;
+ (UINavigationController *)currentNavi;
/**
 返回按钮样式
 */
@property (nonatomic, assign) C2BackBtnStyle backStyle;


@end

NS_ASSUME_NONNULL_END
