//
//  RXWeather.m
//  NeteaseNews
//
//  Created by 王若曦 on 16/3/30.
//  Copyright © 2016年 wrx. All rights reserved.
//

#import "RXWeather.h"
#import "RXNetWorkTool.h"

@implementation RXWeather

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    
    if (self = [super init]) {
        
        self.detailArray = dict[@"北京|北京"];
        self.date = dict[@"dt"];
        self.nowTemperature = dict[@"rt_temperature"];
        
        self.pm2d5 = dict[@"pm2d5"];
        
    }
    return self;
}

+ (instancetype)weatherWithDict:(NSDictionary *)dict{
    
    return [[self alloc]initWithDictionary:dict];
}



@end
