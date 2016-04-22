//
//  RXNewsDetail.m
//  NeteaseNews
//
//  Created by 王若曦 on 16/4/19.
//  Copyright © 2016年 wrx. All rights reserved.
//

#import "RXNewsDetail.h"
#import "RXNewsImage.h"

@implementation RXNewsDetail

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
        
    }
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    
    if ([key isEqual: @"img"]) {
        
        NSArray *img = value;
        
        NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:img.count];
        
        [img enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            RXNewsImage *imageModel = [RXNewsImage imageWithDict:obj];
            
            [tempArray addObject:imageModel];
        }];
        
        self.img = tempArray;
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

}

+ (instancetype)newsDetailWithDict:(NSDictionary *)dict {
    
    return [[self alloc] initWithDictionary:dict];
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"%@,%@",self.title,self.ptime];
}
@end
