//
//  RXNetWorkTool.h
//  NeteaseNews
//
//  Created by 王若曦 on 16/3/28.
//  Copyright © 2016年 wrx. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef void(^finishBlock)(id obj);
@interface RXNetWorkTool : AFHTTPSessionManager

+ (instancetype)sharedRXNetWorkTool;

- (void)getWithURLString:(NSString *)URLString finishBlock:(finishBlock)finishBlock;

@end
