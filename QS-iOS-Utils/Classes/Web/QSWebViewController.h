//
//  WebViewController.h
//  C2-iOS-Utils
//
//  Created by 彭思 on 2022/9/30.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QSWebViewController : UIViewController
@property (nonatomic, copy) NSString *url;//请求地址
@property (nonatomic, strong) WKWebView *webView;//页面加载视图

@property (nonatomic, strong) UIProgressView *progressView;//页面加载进度条，仅网络加载显示

@property (nonatomic, strong) UIButton *backButton;//返回按钮

@property (nonatomic, strong) UIButton *closeButtion;//关闭按钮

- (void)actionPopBack;//返回
- (instancetype)initWithUrl:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
