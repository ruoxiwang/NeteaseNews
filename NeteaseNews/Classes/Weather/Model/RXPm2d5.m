//
//  RXPm2d5.m
//  NeteaseNews
//
//  Created by 王若曦 on 16/3/30.
//  Copyright © 2016年 wrx. All rights reserved.
//

#import "RXPm2d5.h"

@implementation RXPm2d5

+ (instancetype)pm2d5WithDict:(NSDictionary *)dict{
    
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}

@end
