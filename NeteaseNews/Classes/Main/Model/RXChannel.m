//
//  RXChannel.m
//  NeteaseNews
//
//  Created by 王若曦 on 16/3/28.
//  Copyright © 2016年 wrx. All rights reserved.
//

#import "RXChannel.h"


@implementation RXChannel

- (void)setTid:(NSString *)tid{
    
    _tid = tid;
    //生成对应的url
    if ([_tid isEqualToString:@"T1348647853363"]) {//头条
        _tidURLString = @"article/headline/T1348647853363/0-20.html";
    }else {
        _tidURLString = [NSString stringWithFormat:@"article/list/%@/0-20.html",_tid];
    }
}



+ (instancetype)channelWithDict:(NSDictionary *)dict{
    
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
}

+ (NSArray *)channels{
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"topic_news.json" withExtension:nil];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    
    NSArray *dictArray = dict[@"tList"];
    
    //建立一个模型数组
    NSMutableArray *channels = [NSMutableArray arrayWithCapacity:dictArray.count];
    
    [dictArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        
        RXChannel *channel = [RXChannel channelWithDict:dict];
        
        [channels addObject:channel];
    }];
    
    //排序
    
    /*
     这个方法有返回值
     [channels sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        code
    }]*/
    
   [channels sortUsingComparator:^NSComparisonResult(RXChannel *obj1, RXChannel *obj2) {
       
       return [obj1.tid compare:obj2.tid];
   }];
    
    return channels.copy;
}

@end
