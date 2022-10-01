//
//  QSViewController.m
//  QS-iOS-Utils
//
//  Created by 彭思 on 10/01/2022.
//  Copyright (c) 2022 彭思. All rights reserved.
//

#import "QSViewController.h"
#import <QS-iOS-Utils-umbrella.h>
#import <QSTestUtils/Test.h>
#import <QSTestUtils/TestViewController.h>

//#import <QS_iOS_Utils/QSHybridViewController.h>
//#import "UIImage+Bundle.h"

@interface QSViewController ()

@end

@implementation QSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"ssss-%@", [C2Test testPrint]);
    
    NSLog(@"aaaa-%@", [Test testPrint]);
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 30)];
    [btn setTitle:@"点击" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(didClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIImage *image = [UIImage abBundleImageNamed:@"scan_point"];
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(200, 200, 100, 100)];
    imgView.image = image;
    [self.view addSubview:imgView];
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(100, 300, 100, 30)];
    [btn1 setTitle:@"点击去Test" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor redColor];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(didTestClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
}

- (void)didClick {
//    C2H5MicroAppVC *vc = [[C2H5MicroAppVC alloc]initWithUrl:@"http://localhost:8080/#/"];
//    [self.navigationController pushViewController:vc animated:YES];
    
    QSHybridViewController *vc = [[QSHybridViewController alloc]initWithUrl:@"http://192.168.1.7:8085/test.html"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didTestClick {
    TestViewController *vc = [[TestViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
