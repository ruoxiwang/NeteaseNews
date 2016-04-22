//
//  UIImage+SnapshotScreen.m
//  NeteaseNews
//
//  Created by 王若曦 on 16/4/17.
//  Copyright © 2016年 wrx. All rights reserved.
//

#import "UIImage+SnapshotScreen.h"

@implementation UIImage (SnapshotScreen)

+ (UIImage *)snapshotScreen:(CGFloat)y {
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    CGSize mainSize = CGSizeMake(window.bounds.size.width, window.bounds.size.height);
    
    UIGraphicsBeginImageContextWithOptions(mainSize, NO, [UIScreen mainScreen].scale);
    
    CGRect mainRect = CGRectMake(0, -y, window.bounds.size.width, window.bounds.size.height + y);
    
    [window drawViewHierarchyInRect:mainRect afterScreenUpdates:NO];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

@end
