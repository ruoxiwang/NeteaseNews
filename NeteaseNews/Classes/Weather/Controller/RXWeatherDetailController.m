//
//  RXWeatherDetailController.m
//  NeteaseNews
//
//  Created by 王若曦 on 16/4/1.
//  Copyright © 2016年 wrx. All rights reserved.
//

#import "RXWeatherDetailController.h"
#import "RXWeatherDetail.h"
#import "RXPm2d5.h"
#import <UIImageView+WebCache.h>

@interface RXWeatherDetailController ()

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

- (IBAction)backBtnDidClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImg;
@property (weak, nonatomic) IBOutlet UILabel *nowTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *climateLabel;
@property (weak, nonatomic) IBOutlet UILabel *windLabel;
@property (weak, nonatomic) IBOutlet UILabel *pm2d5Label;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIImageView *backGroundImg;

@property (nonatomic,strong) NSArray *detailArray;

@end

@implementation RXWeatherDetailController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addWeater];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)setWeatherModel:(RXWeather *)weatherModel{
//
//    _weatherModel = weatherModel;
//    
//    
//}

- (void)addWeater{
    
    //取到PM2D5模型
    RXPm2d5 *pm2d5 = [RXPm2d5 pm2d5WithDict:self.weatherModel.pm2d5];
    
    NSDictionary *detailDict = self.weatherModel.detailArray[0];

    
    RXWeatherDetail *todayDetail = [RXWeatherDetail weatherDetailWithDict:detailDict];
    
    [self weatherImgSetImg:todayDetail];
    self.nowTempLabel.text = todayDetail.temperature;
    self.climateLabel.text = todayDetail.climate;
    self.windLabel.text= todayDetail.wind;
    
    self.dateLabel.text = [NSString stringWithFormat:@"%@ %@",self.weatherModel.date,todayDetail.week];
    
//    self.pm2d5Label.text = [NSString stringWithFormat:@"PM2.5 %@",pm2d5.pm2_5];
    
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

    
    NSURL *url = [NSURL URLWithString:pm2d5.nbg2];
    [self.backGroundImg sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"QingTian"]];

}

- (void)weatherImgSetImg:(RXWeatherDetail *)weatherDetail{
    
    if ([weatherDetail.climate isEqualToString:@"雷阵雨"]) {
        self.weatherImg.image = [UIImage imageNamed:@"thunder"];
    }else if ([weatherDetail.climate isEqualToString:@"晴"]){
        self.weatherImg.image = [UIImage imageNamed:@"sun"];
    }else if ([weatherDetail.climate isEqualToString:@"多云"]){
        self.weatherImg.image = [UIImage imageNamed:@"sunandcloud"];
    }else if ([weatherDetail.climate isEqualToString:@"阴"]){
        self.weatherImg.image = [UIImage imageNamed:@"cloud"];
    }else if ([weatherDetail.climate hasSuffix:@"雨"]){
        self.weatherImg.image = [UIImage imageNamed:@"rain"];
    }else if ([weatherDetail.climate hasSuffix:@"雪"]){
        self.weatherImg.image = [UIImage imageNamed:@"snow"];
    }else{
        self.weatherImg.image = [UIImage imageNamed:@"sandfloat"];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}


- (IBAction)backBtnDidClick:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        self.hidesBottomBarWhenPushed=YES;
    }
    return self;
}


@end
