//
//  RXBottomView.m
//  NeteaseNews
//
//  Created by 王若曦 on 16/4/1.
//  Copyright © 2016年 wrx. All rights reserved.
//

#import "RXBottomView.h"


@interface RXBottomView ()

@property (nonatomic,weak) UIButton *searchBtn;
@property (nonatomic,weak) UIButton *headBtn;
@property (nonatomic,weak) UIButton *downloadBtn;
@property (nonatomic,weak) UIButton *nigthBtn;
@property (nonatomic,weak) UIButton *saoBtn;
@property (nonatomic,weak) UIButton *friendBtn;

@end

//这里用了九宫格算法，其实使用collectionView开发效率更高
@implementation RXBottomView

- (void)bottomView{
    
    self.searchBtn =  [self addBtnWithName:@"搜索" icon:@"204" color:[UIColor orangeColor] index:0];
    self.headBtn = [self addBtnWithName:@"上头条" icon:@"202" color:[UIColor colorWithRed:255.0/255.0 green:25/255.0 blue:25/255.0 alpha:1] index:1];
    self.downloadBtn = [self addBtnWithName:@"离线" icon:@"203" color:[UIColor colorWithRed:217/255.0 green:44/255.0 blue:89/255.0 alpha:1] index:2];
    self.nigthBtn = [self addBtnWithName:@"夜间" icon:@"205" color:[UIColor colorWithRed:60/255.0 green:153/255.0 blue:208/255.0 alpha:1] index:3];
    self.saoBtn = [self addBtnWithName:@"扫一扫" icon:@"204" color:[UIColor colorWithRed:88/255.0 green:110/255.0 blue:183/255.0 alpha:1] index:4];
    self.friendBtn = [self addBtnWithName:@"邀请好友" icon:@"201" color:[UIColor colorWithRed:97/255.0 green:198/255.0 blue:88/255.0 alpha:1] index:5];
    
    
}

- (UIButton *)addBtnWithName:(NSString *)name icon:(NSString *)icon color:(UIColor *)color index:(NSInteger)index{

    CGFloat margin = 20;
    CGFloat width = (self.width - margin * 4) / 3;
    CGFloat height = width;
    
    NSInteger row = index/3;
    NSInteger col = index%3;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.x = margin + col * (width + margin);
    btn.y = margin + row * (height + margin * 2);
    btn.width = width;
    btn.height = height;

    btn.layer.cornerRadius = width/2;
    btn.layer.masksToBounds = YES;
    
    [btn setBackgroundColor:color];
    [btn setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    
    [self addSubview:btn];
    
    UILabel *label = [[UILabel alloc] init];
    label.x = btn.x;
    label.y = CGRectGetMaxY(btn.frame) + 10;
    label.width = width;
    label.height = margin;
    
    label.textAlignment = NSTextAlignmentCenter;
    [label setTextColor:[UIColor blackColor]];
    label.text = name;
    
    [self addSubview:label];

    return btn;
}

- (void)btnAnimate {
    
    [self addBtnAnimateWithBtn:self.searchBtn];
    [self addBtnAnimateWithBtn:self.headBtn];
    [self addBtnAnimateWithBtn:self.downloadBtn];
    [self addBtnAnimateWithBtn:self.nigthBtn];
    [self addBtnAnimateWithBtn:self.saoBtn];
    [self addBtnAnimateWithBtn:self.friendBtn];
}

- (void)addBtnAnimateWithBtn:(UIButton *)btn {
    
    [UIView animateWithDuration:0.2 animations:^{
        
        btn.transform = CGAffineTransformMakeScale(1.3, 1.3);
        
    }completion:^(BOOL finished) {
       
        [UIView animateWithDuration:0.2 animations:^{
            
            btn.transform = CGAffineTransformMakeScale(0.9, 0.9);
            
        } completion:^(BOOL finished) {
            
            btn.transform = CGAffineTransformMakeScale(1.0, 1.0);
            
        }];
    }];
}

@end
