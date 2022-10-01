//
//  UIImage+Bundle.m
//  C2-IOS-Utils_Example
//
//  Created by rilakkuma on 2022/9/30.
//  Copyright © 2022 jabraknight. All rights reserved.
//

#import "UIImage+Bundle.h"
#import "NSBundle+Bundle.h"

@implementation UIImage (Bundle)
+ (UIImage *)abBundleImageNamed:(NSString *)imgName{
    NSBundle *bundle = [NSBundle abBundle];
    UIImage *image = [UIImage imageNamed:imgName inBundle:bundle compatibleWithTraitCollection:nil];
    return image;
}

@end
