//
//  RXWeather.h
//  NeteaseNews
//
//  Created by 王若曦 on 16/3/30.
//  Copyright © 2016年 wrx. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^completeBlock)(NSArray *details);

@interface RXWeather : NSObject

//存储weatherDetail模型的数组
@property (nonatomic,strong) NSArray *detailArray;

@property (nonatomic,copy) NSString *date;

@property (nonatomic,strong) NSNumber *nowTemperature;

@property (nonatomic,strong) NSDictionary *pm2d5;

+ (instancetype)weatherWithDict:(NSDictionary *)dict;

@end
