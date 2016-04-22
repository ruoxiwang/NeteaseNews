//
//  RXNetWorkTool.m
//  NeteaseNews
//
//  Created by 王若曦 on 16/3/28.
//  Copyright © 2016年 wrx. All rights reserved.
//

#import "RXNetWorkTool.h"

@implementation RXNetWorkTool

static RXNetWorkTool *_instance;

+ (instancetype)sharedRXNetWorkTool{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _instance = [[self alloc] initWithBaseURL:[NSURL URLWithString:@"http://c.m.163.com/nc/"]];
        
        _instance.responseSerializer.acceptableContentTypes = [_instance.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
    });
    
    return _instance;
}

- (void)getWithURLString:(NSString *)URLString finishBlock:(finishBlock)finishBlock{
    
    [self GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (finishBlock) {
            //返回数据
            finishBlock(responseObject);
        }
        
//        RXLog(@"%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        RXLog(@"%@",error);
    }];
}

@end
