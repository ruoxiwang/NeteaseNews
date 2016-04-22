//
//  RXReplyModel.h
//  NeteaseNews
//
//  Created by 王若曦 on 16/4/21.
//  Copyright © 2016年 wrx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RXReplyModel : NSObject

//用户姓名
@property (nonatomic,copy) NSString *name;
//用户ip
@property (nonatomic,copy) NSString *address;
//用户发言
@property (nonatomic,copy) NSString *say;
//用户点赞
@property (nonatomic,copy) NSString *suppose;
//头像
@property (nonatomic,copy) NSString *icon;
//回复时间
@property (nonatomic,copy) NSString *rtime;

/**
 *  hotReply
 */
//用户头像
@property (nonatomic,copy) NSString *tImage;
//用户地址
@property(nonatomic,copy)NSString *f;
//实际评价
@property(nonatomic,copy)NSString *b;
//用户名称
@property(nonatomic,copy)NSString *n;
//顶帖人数
@property(nonatomic,copy)NSString *v;

+ (instancetype)replyWithDict:(NSDictionary *)dict;

@end
