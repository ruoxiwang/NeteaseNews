//
//  RXNews.m
//  NeteaseNews
//
//  Created by 王若曦 on 16/3/28.
//  Copyright © 2016年 wrx. All rights reserved.
//

#import "RXNews.h"
#import "RXThreePic.h"

@implementation RXNews

+ (instancetype)newsWithDict:(NSDictionary *)dict{
    
    id instance = [[self alloc] init];
    
    [instance setValuesForKeysWithDictionary:dict
     ];
    
    return instance;
}

- (void)setValue:(id)value forKey:(NSString *)key{
    
    if ([key isEqualToString:@"imgextra"]) {
        
        NSArray *dictArray = value;
        
        NSMutableArray *threePics = [NSMutableArray array];
        
        [dictArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            RXThreePic *threePic = [RXThreePic threePicWithDict:obj];
            
            [threePics addObject:threePic];
            
        }];
        
        self.imgextra = threePics.copy;
        
        return;
    }
    
#warning 忘记调用只会设置imgextra的值
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}


+ (void)newListWith:(NSString *)URLString completeBlock:(completeBlock)completeBlock{
    
    [[RXNetWorkTool sharedRXNetWorkTool] getWithURLString:URLString finishBlock:^(id obj) {
       //数据解析
        if ([obj isKindOfClass:[NSDictionary class]]) {
            
            //通过tid取出字典
            NSDictionary *dict = obj;
            
            NSString *key = dict.keyEnumerator.nextObject;
            
            NSArray *dictArray = dict[key];
            
            NSMutableArray *newList = [NSMutableArray arrayWithCapacity:dictArray.count];
            
            [dictArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                RXNews *news = [RXNews newsWithDict:obj];
                
                [newList addObject:news];
            }];
            
            //传数据给视图
            if (completeBlock) {
                completeBlock(newList.copy);
            }
        }
        
    }];
}



@end
