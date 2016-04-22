//
//  RXNewsDetailController.h
//  NeteaseNews
//
//  Created by 王若曦 on 16/4/17.
//  Copyright © 2016年 wrx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RXNewsCell.h"
#import "RXNews.h"


@interface RXNewsDetailController : UIViewController

@property (nonatomic,strong) RXNewsCell *cell;
@property (nonatomic,strong) UIImageView *backgroundView;
@property (nonatomic,assign) CGRect cellOldFrame;

@property (nonatomic,strong) RXNews *news;
@property (nonatomic,assign) NSInteger index;

- (void)setUI;

@end
