//
//  QSHybridViewController.m
//  C2-iOS-Utils
//
//  Created by 彭思 on 2022/9/30.
//

#import "QSHybridViewController.h"
#import "NSString+Extension.h"
#import <YYModel/YYModel.h>
#import "QSHybridModel.h"
#import "QSHybridViewController+JSSDK.h"

typedef void(^QSHybridCompletion)(QSReturnType returnType, id returnValue);

@interface QSHybridViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

@end

@implementation QSHybridViewController

- (instancetype)initWithUrl:(NSString *)url {
    if (self = [super init]) {
        self.url = url;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addWebViewObserver];
    [self addScriptMessageHandler];
    [self loadUrl];
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

- (void)addScriptMessageHandler{
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"iOSBridge"];
}

- (void)removeScriptMessageHandler{
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"iOSBridge"];
}

- (void)addWebViewObserver{
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)removeObservers{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self  name:UIApplicationWillTerminateNotification object:nil];
}

- (void)callJS:(NSString *)funcName {
    NSString *message = [NSString parseJSONToJSONString:@{@"funcName":funcName}];
    NSString *js = [NSString stringWithFormat:@"window.webkit.messageHandlers.listener.postMessage(%@)",message];
    [self.webView evaluateJavaScript:js completionHandler:^(id _Nullable result, NSError * _Nullable error) {
    }];
}


#pragma mark -- WKScriptMessageHandler

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    //JS调用OC方法
    //message.boby就是JS里传过来的参数
    NSLog(@"body:%@",message.body);
    QSHybridModel *hybrid = [QSHybridModel yy_modelWithJSON:message.body];
//    [self handleWithHybrid:hybrid completion:^(QSReturnType returnType, id returnValue) {
//        if (returnValue) {
//            [self callJSWithHybrid:hybrid value:hybrid returnType:returnType returnValue:returnValue];
//        }
//    }];
    [self actionWithHybrid:hybrid action:^(id  _Nonnull returnValue, QSReturnType returnFunc) {
        
    }];
}

- (void)handleWithHybrid:(QSHybridModel *)hybrid completion:(QSHybridCompletion)completion {
    if (completion) {
        completion(QSReturnType_OnSuccess, nil);
    }
}

- (void)callJSWithHybrid:(QSHybridModel *)hybrid value:(QSHybridModel *)value returnType:(QSReturnType)returnType returnValue:(id)returnValue {
        
    NSString *funcName;
    switch (returnType) {
        case QSReturnType_OnSuccess:
            funcName = value.onSuccess;
            break;
        case QSReturnType_OnFail:
            funcName = value.onFail;
            break;
        case QSReturnType_OnPageResult:
            funcName = value.onPageResult;
            break;
        case QSReturnType_OnProgress:
            funcName = value.onProgress;
            break;
        default:
            break;
    }
    
    NSString *message = [NSString parseJSONToJSONString:@{@"funcName":funcName?funcName:@"",@"returnValue":returnValue}];
    
    NSString *js = [NSString stringWithFormat:@"window.webkit.messageHandlers.callJS.postMessage(%@)",message];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.webView evaluateJavaScript:js completionHandler:nil];
    });
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    if ([self.navigationController visibleViewController] != self)
    {
        completionHandler();
        return;
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        completionHandler();
            
    }]];
    if ([self.navigationController visibleViewController] == self)    {
        [self presentViewController:alertController animated:YES completion:nil];
    }else
    {
        completionHandler();
    }

}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable result))completionHandler {
    NSLog(@"prompt = %@", prompt);
    completionHandler(@"是是是飒飒飒飒飒飒飒飒飒飒");
//    NSString *message = [NSString parseJSONToJSONString:@{@"funcName":@"aaa",@"returnValue":@"思思点击呢"}];
//
//    NSString *js = [NSString stringWithFormat:@"window.webkit.messageHandlers.iOSBridge.postMessage(%@)",message];
    
    // 原生给H5传值
//    NSString *js = [NSString stringWithFormat:@"aaa('%@')",@"1234567"];
//    [self.webView evaluateJavaScript:js completionHandler:nil];
}

@end
