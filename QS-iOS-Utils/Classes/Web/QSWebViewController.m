//
//  WebViewController.m
//  C2-iOS-Utils
//
//  Created by 彭思 on 2022/9/30.
//

#import "QSWebViewController.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

@interface QSWebViewController ()<WKNavigationDelegate>

@end

@implementation QSWebViewController

- (instancetype)initWithUrl:(NSString *)url {
    if (self = [super init]) {
        self.url = url;
    }
    return self;
}

- (void)loadUrl{
    if (!self.url.length) {
        NSLog(@"url is nil");
        return;
    }
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
//    NSString * url = [NSString convertCNtoUnicode:self.url];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addWebViewObserver];
    [self buildUI];
    [self loadUrl];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self configWebViewFrame];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self removeObservers];
}

- (void)dealloc{
    [self prepareForClose];
}

- (void)addWebViewObserver{
    if ([self isLocalUrl:self.url]) return;
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)removeObservers{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self  name:UIApplicationWillTerminateNotification object:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
//    DLog(@"keyPath = %@, change = %@", keyPath, change);
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        if (object == self.webView) {
            [self.progressView setAlpha:1.0f];
            [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
            
            if(self.webView.estimatedProgress >= 1.0f) {
                [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    [self.progressView setAlpha:0.0f];
                } completion:^(BOOL finished) {
                    [self.progressView setProgress:0.0f animated:NO];
                }];
            }
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)prepareForClose{
    @try {
        if ([self isLocalUrl:self.url]) return;
        [self.webView removeObserver:self forKeyPath:@"estimatedProgress" context:NULL];
    } @catch (NSException *exception) {
        
    } @finally {
        [self.webView removeFromSuperview];
    }
}

- (void)configWebViewFrame {
//    CGFloat naviHeight = (self.navigationController && !self.navigationController.isNavigationBarHidden) ?kNavigationBarHeight:0;
//    CGFloat tabbarHeight = (self.tabBarController && self.navigationController.viewControllers.count==1)?kTabBarHeight:0;
//    self.progressView.hidden = [self isLocalUrl:self.url];
    self.webView.frame = CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
}

- (BOOL)isLocalUrl:(NSString *)url {
    return ![url hasPrefix:@"http"];
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {

    NSString *strRequest = [navigationAction.request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"即将跳转到 : %@", strRequest);
    if (self.webView.backForwardList.backList.count) {
        self.closeButtion.hidden = !self.webView.backForwardList.backList.count;
//        [self addLeftBarButtonItemsWithCount:1+!self.closeButtion.hidden];
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"开始加载");
                
    [self.webView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id result, NSError *error) {
        NSString *userAgent = result;
        //修改UserAgent
        NSString *newUserAgent = [userAgent stringByAppendingString:@"C2Mobile/{1.0.0}"];
        NSString *barHeight = [NSString stringWithFormat:@";statusBarHeight:%f",20.0];
        newUserAgent = [newUserAgent stringByAppendingString:barHeight];
        [self.webView setCustomUserAgent:newUserAgent];
    }];
    
}
 
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"内容开始返回");
}
 
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"加载完成");
    // 禁用缩放
    [self.webView evaluateJavaScript:[self disableZoom] completionHandler:nil];
    // 禁用选中效果
    [self.webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none'" completionHandler:nil];
    [self.webView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none'" completionHandler:nil];

}
 
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"加载navi失败 error : %@",error.description);
//    WEAKSELF
//    [self showNetworkErrorWithRetryBlock:^{
//        [wkSelf loadUrl];
//    }];
}

- (void)webView:(WKWebView *)webView didFailLoadWithError:(nonnull NSError *)error {
    NSLog(@"加载失败 error : %@",error.description);
}

#pragma mark - Event

- (void)buildUI{
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [[UIImage alloc]init];
    self.title = @"测试";
    if (@available(iOS 11.0, *)) {
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = UIColor.whiteColor;
    self.webView.backgroundColor = UIColor.greenColor;
    [self.view addSubview:self.webView];
    [self.webView addSubview:self.progressView];
//    [self addLeftBarButtonItemsWithCount:1];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 100);
    [btn setTitle:@"传值" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.redColor forState:UIControlStateNormal];
    [btn addTarget: self action:@selector(tapClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

//- (void)addLeftBarButtonItemsWithCount:(NSInteger)count {
//    self.backButton.frame = CGRectMake(0, 20+(kIs_iPhoneX?20:0), 55, 44);
//    self.closeButtion.frame = CGRectMake(55, 20+(kIs_iPhoneX?20:0), 35, 44);
//    UIBarButtonItem *backBarItem = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];
//    UIBarButtonItem *closeBarItem = [[UIBarButtonItem alloc] initWithCustomView:self.closeButtion];
//    self.navigationItem.leftBarButtonItems = (count==1)?@[backBarItem]:@[backBarItem,closeBarItem];
//}

- (void)tapClick {
    NSString *jsFun = [NSString stringWithFormat:@"aaa('%@')",@"1234567"];
    [self.webView evaluateJavaScript:jsFun completionHandler:^(id _Nullable result, NSError * _Nullable error){
        NSLog(@"evaluateJavaScript:\n result = %@ error = %@",result, error);
    }];
}

- (void)close{
    [self backToLastPage];
}

-(BOOL)canGoBack{
    return [self.webView canGoBack];
}

- (void)goBack{
    [self.webView goBack];
}

- (void)actionPopBack{
    if ([self canGoBack]){
        [self goBack];
    }else{
        [self backToLastPage];
    }
}

- (void)backToLastPage{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Lazy Load

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 1)];
        _progressView.trackTintColor = [UIColor clearColor];
        _progressView.progressTintColor = UIColor.redColor;
    }
    return _progressView;
}

- (WKWebView *)webView {
    if (!_webView) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
        WKUserContentController *userCC = [[WKUserContentController alloc] init];
        config.userContentController = userCC;
        
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 100, kScreenW, kScreenH) configuration:config];
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        if (@available(iOS 13.0,*)) {
            config.defaultWebpagePreferences.preferredContentMode = WKContentModeMobile;
        }
    }
    return _webView;
}

- (UIButton *)closeButtion{
    if (!_closeButtion) {
        _closeButtion = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButtion setTitle:@"关闭" forState:UIControlStateNormal];
        _closeButtion.titleLabel.font = [UIFont systemFontOfSize:17];
        _closeButtion.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_closeButtion setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_closeButtion addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        _closeButtion.exclusiveTouch = YES;
        _closeButtion.hidden = YES;
    }
    return _closeButtion;
}

- (UIButton *)backButton{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        UIImage *btnImage = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000E623", 30, [UIColor blackColor])];
        [_backButton setTitle:@"返回   " forState:UIControlStateNormal];
        _backButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [_backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(actionPopBack) forControlEvents:UIControlEventTouchUpInside];
        _backButton.exclusiveTouch = YES;
    }
    return _backButton;
}

#pragma mark - NSString

- (NSString *)disableZoom {
    return @"var script = document.createElement('meta');"
    "script.name = 'viewport';"
    "script.content=\"width=device-width, user-scalable=no\";"
    "document.getElementsByTagName('head')[0].appendChild(script);";
}

- (NSString *)webViewBridgeScript {
    NSLog(@"注入JS");
    return @"";
}

@end
