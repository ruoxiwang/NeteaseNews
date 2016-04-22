//
//  RXCycle.h
//  NeteaseNews
//
//  Created by 王若曦 on 16/3/29.
//  Copyright © 2016年 wrx. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^completeBlock)(NSArray *newList);
@interface RXCycle : NSObject

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *imgsrc;

+ (void)cycleListWithCompleteBlock:(completeBlock)completeBlock;

@end
