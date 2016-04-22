//
//  RXWeatherView.m
//  NeteaseNews
//
//  Created by 王若曦 on 16/3/30.
//  Copyright © 2016年 wrx. All rights reserved.
//

#import "RXWeatherView.h"
#import "RXWeatherDetail.h"
#import "RXPm2d5.h"
#import "RXBottomView.h"
#import "RXWeatherDetailController.h"

@interface RXWeatherView ()

@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (weak, nonatomic) IBOutlet UILabel *nowTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *pm2d5Label;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImg;
@property (weak, nonatomic) IBOutlet UILabel *climateLabel;
@property (weak, nonatomic) IBOutlet UILabel *locLabel;




- (IBAction)pushBtnDidClick:(id)sender;

@end

@implementation RXWeatherView

+ (instancetype)weatherView{
    
    return [[NSBundle mainBundle] loadNibNamed:@"RXWeatherView" owner:nil options:nil].firstObject;
}

#pragma mark - 添加底部按钮
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
#warning 这里用collectionView开发效率更高
    [self.bottomView bottomView];
}

- (void)setWeatherModel:(RXWeather *)weatherModel{
    
    _weatherModel = weatherModel;
    
    /*
     {"北京|北京":[
     {"wind":"3-4级","nongli":"农历二月廿三日","date":"31日","climate":"晴","temperature":"23°C/13°C","week":"星期四"},
     {"wind":"3-4级","nongli":"农历二月廿四日","date":"1日","climate":"多云","temperature":"22°C/10°C","week":"星期五"},
     {"wind":"3-4级","nongli":"农历二月廿五日","date":"2日","climate":"多云","temperature":"20°C/8°C","week":"星期六"},
     {"wind":"微风","nongli":"农历二月廿六日","date":"3日","climate":"多云","temperature":"17°C/7°C","week":"星期日"}],
     "dt":"2016-03-31",
     "rt_temperature":23,
     "pm2d5":
     {"nbg1":"http://img1.cache.netease.com/m/newsapp/weather/TianQi370/QingTian.jpg","nbg2":"http://img1.cache.netease.com/m/newsapp/weather/TianQi1008/QingTian.jpg","aqi":"288","pm2_5":"237"}}
     */
    
    self.nowTempLabel.text = [NSString stringWithFormat:@"%@",weatherModel.nowTemperature];
    
//    self.nowTempLabel.text = @"-22";
    
    //处理今天的数据
    NSDictionary *todayDict = weatherModel.detailArray[0];
    
    RXWeatherDetail *weatherDetail = [RXWeatherDetail weatherDetailWithDict:todayDict];
    
    self.tempLabel.text = weatherDetail.temperature;
    
    self.dateLabel.text = [NSString stringWithFormat:@"%@ %@",weatherModel.date,weatherDetail.week];
    
    [self weatherImgSetImg:weatherDetail];
    
    self.climateLabel.text = [NSString stringWithFormat:@"%@ %@",weatherDetail.wind,weatherDetail.climate];
    
    self.locLabel.text = @"北京";
    
    //pm2d5模型
    RXPm2d5 *pm2d5 = [RXPm2d5 pm2d5WithDict:weatherModel.pm2d5];
    
    NSInteger pm2d5Value = pm2d5.pm2_5.integerValue;
    
    NSString *desc = [NSString string];
    if (pm2d5Value < 50) {
        desc = @"优";
    }else if (pm2d5Value < 100){
        
        desc = @"良";
    }else{
        
        desc = @"差";
    }
    
    self.pm2d5Label.text = [NSString stringWithFormat:@"PM2.5 %tu %@",pm2d5Value,desc];
    
}

- (void)weatherImgSetImg:(RXWeatherDetail *)weatherDetail{
    
    if ([weatherDetail.climate isEqualToString:@"雷阵雨"]) {
        self.weatherImg.image = [UIImage imageNamed:@"thunder_mini"];
    }else if ([weatherDetail.climate isEqualToString:@"晴"]){
        self.weatherImg.image = [UIImage imageNamed:@"sun_mini"];
    }else if ([weatherDetail.climate isEqualToString:@"多云"]){
        self.weatherImg.image = [UIImage imageNamed:@"sun_and_cloud_mini"];
    }else if ([weatherDetail.climate isEqualToString:@"阴"]){
        self.weatherImg.image = [UIImage imageNamed:@"nosun_mini"];
    }else if ([weatherDetail.climate hasSuffix:@"雨"]){
        self.weatherImg.image = [UIImage imageNamed:@"rain_mini"];
    }else if ([weatherDetail.climate hasSuffix:@"雪"]){
        self.weatherImg.image = [UIImage imageNamed:@"snow_heavyx_mini"];
    }else{
        self.weatherImg.image = [UIImage imageNamed:@"sand_float_mini"];
    }
}

- (IBAction)pushBtnDidClick:(id)sender {
    //不是控制器不能进行push操作，用通知或者代理监听
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushWeatherDetailVC" object:nil];
}
@end
