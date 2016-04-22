//
//  RXCycleCell.m
//  NeteaseNews
//
//  Created by 王若曦 on 16/3/29.
//  Copyright © 2016年 wrx. All rights reserved.
//

#import "RXCycleCell.h"
#import <UIImageView+WebCache.h>

@interface RXCycleCell ()

@property (weak, nonatomic) IBOutlet UIImageView *cycleImageView;

@property (weak, nonatomic) IBOutlet UILabel *cycleLabel;

@end

@implementation RXCycleCell

- (void)setCycle:(RXCycle *)cycle{
    
    _cycle = cycle;
    
    [self.cycleImageView sd_setImageWithURL:[NSURL URLWithString:cycle.imgsrc]];
    
    self.cycleLabel.text = cycle.title;
    
}

@end

