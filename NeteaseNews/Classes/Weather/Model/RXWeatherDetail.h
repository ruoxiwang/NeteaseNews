//
//  RXWeatherDetail.h
//  NeteaseNews
//
//  Created by 王若曦 on 16/3/31.
//  Copyright © 2016年 wrx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RXWeatherDetail : NSObject

/*
 {"wind":"微风",
 "nongli":"农历二月廿二日",
 "date":"30日",
 "climate":"晴",
 "temperature":"22°C/7°C",
 "week":"星期三"},
 */

@property (nonatomic,copy) NSString *wind;

@property (nonatomic,copy) NSString *nongli;

@property (nonatomic,copy) NSString *date;

@property (nonatomic,copy) NSString *climate;

@property (nonatomic,copy) NSString *temperature;

@property (nonatomic,copy) NSString *week;

+ (instancetype)weatherDetailWithDict:(NSDictionary *)dict;

@end
