//
//  C2Common.h
//  C2-iOS-Core
//
//  Created by watson on 2020/11/3.
//

#ifndef C2Common_h
#define C2Common_h

#import "NSString+Extension.h"
#import "C2Context.h"
#import "YYModel.h"

///==============================
/// @name Network
///==============================

///==============================
/// @name Frame
///==============================

//是否iPhoneX YES:iPhoneX屏幕 NO:传统屏幕
#define kIs_iPhoneX [C2Context isIPhoneXSeries]

#define kADAPTAION(value) (((value)*[UIScreen mainScreen].bounds.size.width)/750.0)

/** 返回跟以iphone6设计图测量大小等比缩放的值*/
#define kADaptionWidth(value) ((value) *((kScreenW)/375.f))
#define kADaptionHeight(value) ((value) *((kScreenH)/667.f))

//子类布局的时候 使用
#define kNavigationBarHeight (kIs_iPhoneX ? 88.f : 64.f)
#define kStatusBarHeight (kIs_iPhoneX ? 44.f : 20.f)
#define kTabBarHeight (kIs_iPhoneX ? 83.f : 49.f)
#define kBottomHeight (kIs_iPhoneX ? 34.f : 0.f)

#define kWidthOfPixs(pix) (kScreenW / 750.0 * (pix))
#define kHeightOfPixs(pix) (kScreenH / 1333.0 * (pix))

//屏幕
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

///==============================
/// @name Lazy init
///==============================

#define Lazy(name, className) -(className *)name{\
if (!_##name) {\
_##name = [[className alloc]init];\
}\
return _##name;\
}

///==============================
/// @name Image
///==============================
#define ImageName(X)    (UIImage*)([UIImage imageNamed:X])

///==============================
/// @name WeakSelf
///==============================
#define WEAKSELF      typeof(self) __weak wkSelf = self;
#define StrongWeakSelf   typeof(wkSelf) __strong stSelf=wkSelf;

///==============================
/// @name Color
///==============================
#define kColor(r, g, b) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1.0]
#define kAColor(r, g, b, a) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:(a)]

#define kColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0  blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define kColorFromRGBA(rgbValue,a) [UIColor  colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0  green:((float)((rgbValue & 0xFF00) >> 8))/255.0  blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

#define TEXT_BLACK_COLOR kColorFromRGB(0x0B121A)
#define TEXT_GARY_COLOR kColorFromRGB(0x28435D)
#define TEXT_LIGHTGRAY_COLOR kColorFromRGB(0x93A0AD)
#define BACKGROUND_GRAY_COLOR kColorFromRGB(0xF5F6F7)
#define BACKGROUND_BLACK_COLOR kColorFromRGBA(0x000000, 0.5)
#define CELL_LINE_COLOR kColorFromRGB(0xE5E5E5)

#define BLACK_COLOR kColorFromRGB(0x212020)
#define BLUE_COLOR kColorFromRGB(0x0085FF)
#define RED_COLOR kColorFromRGB(0xFF4F2B)
#define ORANGR_COLOR kColorFromRGB(0xFF8A3A)
#define GREEN_COLOR kColorFromRGB(0x00CB00)
#define PURPLE_COLOR kColorFromRGB(0x676CFF)

///==============================
/// @name Debug Log
///==============================

#if DEBUG
#define DLog( s, ... ) printf("class: <%p %s:(%d) > method: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(s), ##__VA_ARGS__] UTF8String] );

//    #define     DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog( s, ... ) printf("class: <%p %s:(%d) > method: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(s), ##__VA_ARGS__] UTF8String] );

//    #define DLog( s, ... )
//    #define DLog(fmt, ...) BUGLY_LOG_MACRO(BuglyLogLevelVerbose, fmt, ##__VA_ARGS__)
#endif

///==============================
/// @name Notification
///==============================

#define POST_NOTIFICATION(X)  [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:X object:nil]];
#define POST_NOTIFICATIONWithObject(notice,obj)  [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:notice object:obj]];

#endif /* C2Common_h */
