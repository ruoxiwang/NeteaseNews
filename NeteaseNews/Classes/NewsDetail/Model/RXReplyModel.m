//
//  RXReplyModel.m
//  NeteaseNews
//
//  Created by 王若曦 on 16/4/21.
//  Copyright © 2016年 wrx. All rights reserved.
//

#import "RXReplyModel.h"

@implementation RXReplyModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        
        self.name = dict[@"n"];
        if (self.name == nil) {
            self.name = @"机智的网友";
        }
        self.address = dict[@"f"];
        self.say = dict[@"b"];
        self.suppose = dict[@"v"];
        self.icon = dict[@"timg"];
        self.rtime = dict[@"t"];
        
    }
    
    return self;
}

+ (instancetype)replyWithDict:(NSDictionary *)dict {
    
    return [[self alloc] initWithDict:dict];
}

@end
