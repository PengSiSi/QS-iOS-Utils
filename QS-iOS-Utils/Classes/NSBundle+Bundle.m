//
//  NSBundle+Bundle.m
//  C2-IOS-Utils_Example
//
//  Created by rilakkuma on 2022/9/30.
//  Copyright © 2022 jabraknight. All rights reserved.
//

#import "NSBundle+Bundle.h"

@implementation NSBundle (Bundle)
+ (NSBundle *)abBundle{
    Class cls = NSClassFromString(@"QSUtils");
    NSBundle *bundle = [NSBundle bundleForClass:cls];
    
    NSURL *url = [bundle URLForResource:@"QSUtils" withExtension:@"bundle"];
    bundle = [NSBundle bundleWithURL:url];
    return bundle;
}


@end
