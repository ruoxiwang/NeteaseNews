//
//  RXThreePic.h
//  NeteaseNews
//
//  Created by 王若曦 on 16/3/29.
//  Copyright © 2016年 wrx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RXThreePic : NSObject

@property (nonatomic,copy) NSString *imgsrc;

+ (instancetype)threePicWithDict:(NSDictionary *)dict;

@end
