//
//  RXPm2d5.h
//  NeteaseNews
//
//  Created by 王若曦 on 16/3/30.
//  Copyright © 2016年 wrx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RXPm2d5 : NSObject

/*
 "nbg1":"http://img1.cache.netease.com/m/newsapp/weather/TianQi370/QingTian.jpg",
 "nbg2":"http://img1.cache.netease.com/m/newsapp/weather/TianQi1008/QingTian.jpg",
 "aqi":"40",
 "pm2_5":"15"
 */
@property (nonatomic,copy) NSString *nbg1;
@property (nonatomic,copy) NSString *nbg2;
@property (nonatomic,copy) NSString *aqi;
@property (nonatomic,copy) NSString *pm2_5;

+ (instancetype)pm2d5WithDict:(NSDictionary *)dict;

@end
