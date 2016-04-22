//
//  RXNewsImage.m
//  NeteaseNews
//
//  Created by 王若曦 on 16/4/19.
//  Copyright © 2016年 wrx. All rights reserved.
//

#import "RXNewsImage.h"

@implementation RXNewsImage

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
        
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

+ (instancetype)imageWithDict:(NSDictionary *)dict {
    
    return [[self alloc] initWithDictionary:dict];
    
}

@end
