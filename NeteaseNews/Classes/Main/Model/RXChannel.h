//
//  RXChannel.h
//  NeteaseNews
//
//  Created by 王若曦 on 16/3/28.
//  Copyright © 2016年 wrx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RXChannel : NSObject

@property (nonatomic,copy) NSString *tid;

@property (nonatomic,copy) NSString *tname;

@property (nonatomic,copy,readonly) NSString *tidURLString;

+ (NSArray *)channels;

@end
