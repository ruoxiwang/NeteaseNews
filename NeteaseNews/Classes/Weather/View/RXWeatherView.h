//
//  RXWeatherView.h
//  NeteaseNews
//
//  Created by 王若曦 on 16/3/30.
//  Copyright © 2016年 wrx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RXWeather.h"
#import "RXBottomView.h"

@interface RXWeatherView : UIView

@property (nonatomic,strong) RXWeather *weatherModel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet RXBottomView *bottomView;

+ (instancetype)weatherView;

@end
