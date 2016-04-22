//
//  RXCycle.m
//  NeteaseNews
//
//  Created by 王若曦 on 16/3/29.
//  Copyright © 2016年 wrx. All rights reserved.
//

#import "RXCycle.h"
#import "RXNetWorkTool.h"

@implementation RXCycle

+ (instancetype)cycleWithDict:(NSDictionary *)dict{
    
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}



+ (void)cycleListWithCompleteBlock:(completeBlock)completeBlock{
    
    [[RXNetWorkTool sharedRXNetWorkTool] getWithURLString:@"ad/headline/0-4.html" finishBlock:^(id obj) {
        
        if ([obj isKindOfClass:[NSDictionary class]]) {
           /*
            {"headline_ad":
            [{  "title":"《看客》：鲸鱼表演的血腥内幕",
                "tag":"photoset",
                "subtitle":"",
                "imgsrc":"http://img6.cache.netease.com/3g/2016/3/29/20160329071647bef22.jpg",
                "url":"3R710001|114427"},
            {   "title":"日自卫队驻与那国岛 距钓鱼岛150公里",
                "tag":"photoset",
                "subtitle":"",
                "imgsrc":"http://img1.cache.netease.com/3g/2016/3/29/201603291710238a8fd.jpg",
                "url":"00AO0001|114498"},
            {   "title":"中国游客在韩参加大规模啤酒炸鸡派对",
                "tag":"photoset",
                "subtitle":"",
                "imgsrc":"http://img2.cache.netease.com/3g/2016/3/29/201603291156426bec7.jpg",
                "url":"00AO0001|114481"},
            {   "title":"影像记录：记忆里的绿皮火车",
                "tag":"photoset",
                "subtitle":"",
                "imgsrc":"http://img5.cache.netease.com/3g/2016/3/29/201603291130403bae9.jpg",
                "url":"57KT0001|114473"}]}
            */
            
            NSDictionary *dict = obj;
            
            NSArray *dictArray = dict[@"headline_ad"];
            
            NSMutableArray *cycles = [NSMutableArray arrayWithCapacity:dictArray.count];
            
            [dictArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                RXCycle *cycle = [RXCycle cycleWithDict:obj];
                
                [cycles addObject:cycle];
            }];
            
            if (completeBlock) {
                
                completeBlock(cycles.copy);
            }
        }
        
    }];
    
}

@end
