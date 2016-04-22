//
//  RXWeatherDetail.m
//  NeteaseNews
//
//  Created by 王若曦 on 16/3/31.
//  Copyright © 2016年 wrx. All rights reserved.
//

#import "RXWeatherDetail.h"

@implementation RXWeatherDetail

+ (instancetype)weatherDetailWithDict:(NSDictionary *)dict{
    
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}



@end
