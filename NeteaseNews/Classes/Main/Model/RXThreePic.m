//
//  RXThreePic.m
//  NeteaseNews
//
//  Created by 王若曦 on 16/3/29.
//  Copyright © 2016年 wrx. All rights reserved.
//

#import "RXThreePic.h"

@implementation RXThreePic

+ (instancetype)threePicWithDict:(NSDictionary *)dict{
    
    id threePic = [[self alloc] init];
    
    [threePic setValuesForKeysWithDictionary:dict];
    
    return threePic;
}


@end
