//
//  RXNewsImage.h
//  NeteaseNews
//
//  Created by 王若曦 on 16/4/19.
//  Copyright © 2016年 wrx. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 "img": [
 {
 "ref": "<!--IMG#0-->",
 "pixel": "549*365",
 "alt": "NASA早前发布的朝鲜夜晚卫星图",
 "src": "http://img6.cache.netease.com/3g/2015/2/3/20150203160030899db.jpg"
 }
 ],
 */

@interface RXNewsImage : NSObject

//图片所处位置
@property (nonatomic,copy) NSString *ref;

//图片大小
@property (nonatomic,copy) NSString *pixel;

//图片描述
@property (nonatomic,copy) NSString *alt;

//图片链接
@property (nonatomic,copy) NSString *src;

+ (instancetype)imageWithDict:(NSDictionary *)dict;

@end
