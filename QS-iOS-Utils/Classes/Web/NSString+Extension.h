//
//  NSString+Extension.h
//  CommonFramework
//
//  Created by Watson on 2015/9/23.
//  Copyright © 2015年 Watson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extension)

#pragma mark - JSON
/*
 * 字符串解析
 */
+ (NSString *)jsonUtils:(id)stringValue;

/**
 * json字符串转json
 */
+ (id)parseJSONStringToJSON:(NSString *)JSONString;

/**
 * json转json字符串
 */
+ (NSString *)parseJSONToJSONString:(id)JSON;

#pragma mark - 验证
/*
 * 判断字符串是否为空
 */
- (BOOL)isEmpty;

/*
 * 字符串是否为空或者仅为空格验证
 */
+ (BOOL)isEmptyOrBlank:(NSString *)string;

// 手机号码验证
+ (BOOL)validateMobile:(NSString *)mobile;

//固话验证
+ (BOOL)validateAreaTel:(NSString *)areaTel;

// 邮箱验证
+ (BOOL)validateEmail:(NSString *)email;

// 判断是否是身份证号码
+ (BOOL)validateIdCard:(NSString *)idCard;

//判断字符串是否有中文
+ (BOOL)IsChinese:(NSString *)str;

//密码验证
+ (BOOL)validatePassword:(NSString *)password;

//判断是否IP地址
+ (BOOL)isValidatIP:(NSString *)ipAddress;

//判读是否为整数（数字）
+ (BOOL)isPureInt:(NSString*)string;

//判断Url是否合法
+ (BOOL)validateUrl:(NSString *)url;

#pragma mark - 变成星号

// 把手机号第4-7位变成星号
+ (NSString *)phoneNumToAsterisk:(NSString*)phoneNum;

// 把邮箱@前面变成星号
+ (NSString*)emailToAsterisk:(NSString *)email;

// 把身份证号第5-14位变成星号
+ (NSString *)idCardToAsterisk:(NSString *)idCardNum;

#pragma mark - 时间

//返回时间戳
+ (NSString *)timestampChange:(NSDate *)date;

//时间戳转化时间
+ (NSString *)timestampChangeTime:(NSString *)timestamp withFormat:(NSString *)formatStr;
+ (NSString *)timestampChangeTime:(NSString *)timestamp;

//时间转时间戳
+ (NSString *)getTimeStamp:(NSString *)dateTime withFormat:(NSString *)formatStr;
+ (NSString *)getTimeStamp:(NSString *)dateTime;

//计算两个时间相差多少秒
+ (NSInteger)getSecondsWithBeginDate:(NSString*)currentDateString  AndEndDate:(NSString*)tomDateString;

//根据出生日期获取年龄
+ (NSInteger)ageWithDateOfBirth:(NSDate *)date;

//NSDate互转NSString
+ (NSDate *)NSStringToDate:(NSString *)dateString withFormat:(NSString *)formatStr;
+ (NSDate *)NSStringToDate:(NSString *)dateString;
+ (NSString *)NSDateToString:(NSDate *)dateFromString withFormat:(NSString *)formatStr;
+ (NSString *)NSDateToString:(NSDate *)dateFromString;

//当前时间
+ (NSString *)currentDateWithFormat:(NSString *)formatStr;
+ (NSString *)currentDate;

#pragma mark - Emoji

//是否有表情
+ (BOOL)stringContainsEmoji:(NSString *)string;
- (BOOL)isIncludingEmoji;
+ (BOOL)isSpEmoji:(NSString *)emoji;
- (instancetype)removedEmojiString;
- (NSString *)emoji;

#pragma mark - 文本自适应
//根据文本自适应宽高度
- (CGSize)calculateSizeWithAttributes:(NSDictionary *)attributes maxSize:(CGSize)maxSize;
- (CGSize)sizeWithMaxWidth:(CGFloat)width andFont:(UIFont *)font;
- (CGSize)sizeWithMaxHeight:(CGFloat)height andFont:(UIFont *)font;
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

#pragma mark - 其他
/*
 * 适配HTML
 */
- (NSString *)adapterHTML:(NSString *)html;

//重写containsString方法，兼容8.0以下版本
- (BOOL)containsString:(NSString *)aString NS_AVAILABLE(10_10, 8_0);

//获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
+ (NSString *)firstCharactor:(NSString *)aString;

- (NSString *)originName;

- (NSString *)firstStringSeparatedByString:(NSString *)separeted;

// 清除电话号码中的其他符号
+ (NSString *)clearSymbolsWithMobileNumber:(NSString *)mobileNumber;

// 字符串转码
+ (NSString *)transcodingWithString:(NSString *)aString;

// 中文转Unicode
+ (NSString *)convertCNtoUnicode:(NSString *)CN;

// 获取URL参数
+ (NSString *)getParamByName:(NSString *)name URLString:(NSString *)url;

// 补齐字符串
+ (NSString *)makeUpString:(NSString*)string digit:(NSInteger)digit addString:(NSString*)addString;

// 获取文件的MD5值
+ (NSString *)getFileMD5StringFromPath:(NSString *)path;

@end
