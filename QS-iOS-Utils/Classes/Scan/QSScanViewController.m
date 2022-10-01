//
//  QSScanViewController.m
//  C2-iOS-Utils
//
//  Created by 彭思 on 2022/9/30.
//

#import "QSScanViewController.h"
#import <SGQRCode/SGQRCode.h>
#import <SGQRCode/SGScanView.h>
#import "C2Common.h"
#import "UIImage+Bundle.h"

@interface QSScanViewController ()
@property (nonatomic, strong) SGScanCode *scanCode;
@property (nonatomic, strong) SGScanView *scanView;
@property (nonatomic, strong) UIButton *backBtn;

@end

@implementation QSScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.blackColor;
    self.title = @"扫一扫";
    self.scanCode = [SGScanCode scanCode];
    [self setupQRCodeScan];
    [self.view addSubview:self.scanView];
    [self.view addSubview:self.backBtn];
    self.scanView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    self.backBtn.frame = CGRectMake(19, kStatusBarHeight + 14, 24, 24);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.scanView startScanning];
}

- (void)viewWillDisappear:(BOOL)animated {
   [super viewWillDisappear:animated];
   [self.scanView stopScanning];
}

- (void)dealloc {
   [self removeScanningView];
}

- (void)removeScanningView {
    [self.scanView stopScanning];
    [self.scanView removeFromSuperview];
    self.scanView = nil;
}

- (void)backBtnAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setupQRCodeScan {
    BOOL isCameraDeviceRearAvailable = self.scanCode.isCameraDeviceRearAvailable;
    if (isCameraDeviceRearAvailable == NO) {
        return;
    }
    SGAuthorization *authorization = [[SGAuthorization alloc] init];
    authorization.openLog = NO;
    __block BOOL authorizationStatus = YES;
    [authorization AVAuthorizationBlock:^(SGAuthorization * _Nonnull authorization, SGAuthorizationStatus status) {
        if (status == SGAuthorizationStatusFail || status == SGAuthorizationStatusUnknown) {
            authorizationStatus = NO;
            return;
        }
    }];
    if (!authorizationStatus) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    self.scanCode.openLog = YES;
    self.scanCode.brightness = YES;
    
    [self.scanCode scanWithController:self resultBlock:^(SGScanCode *scanCode, NSString *result) {
        if (result) {
            [scanCode stopRunning];
            if (weakSelf.didScanResultBlock) {
                weakSelf.didScanResultBlock(result);
            }
        }
    }];
}

- (SGScanView *)scanView {
    if (!_scanView) {
        _scanView = [[SGScanView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        _scanView.borderColor = [UIColor clearColor];
        _scanView.cornerColor = [UIColor whiteColor];
        _scanView.backgroundAlpha = 0.3;
    }
    return _scanView;
}

- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage abBundleImageNamed:@"back_camera"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

//- (UIImage *)bundleImageWithName:(NSString *)imageName {
//    NSBundle *bundle = [NSBundle mainBundle];
//    NSURL *url = [bundle URLForResource:@"QSUtils" withExtension:@"bundle"];
//    if (url == nil) {
//        return nil;
//    }
//    NSBundle *imageBundle = [NSBundle bundleWithURL:url];
//    NSString *path = [imageBundle pathForResource:imageName ofType:@"png"];
//    return [UIImage imageWithContentsOfFile:path];
//}

@end
