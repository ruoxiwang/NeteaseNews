//
//  RXNewsCell.m
//  NeteaseNews
//
//  Created by 王若曦 on 16/3/28.
//  Copyright © 2016年 wrx. All rights reserved.
//

#import "RXNewsCell.h"
#import "RXNews.h"
#import <UIImageView+WebCache.h>
#import "RXThreePic.h"

@interface RXNewsCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *replyCountLabel;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *otherImageView;


@end

@implementation RXNewsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setNews:(RXNews *)news{
    
    _news = news;
    
    self.titleLabel.text = news.title;
    
    self.subTitleLabel.text = news.digest;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:news.imgsrc]];
    
    CGFloat count = news.replyCount.intValue;
    
    if (count > 10000) {
        
        self.replyCountLabel.text = [NSString stringWithFormat:@"%.1f万跟帖",count/10000];

    }else{
        
        self.replyCountLabel.text = [NSString stringWithFormat:@"%@跟帖",news.replyCount];
    }
    
    //设置三张图的数据
    if (news.imgextra.count == 2) {
        
        NSArray *threePicArray = news.imgextra;
        
        for (int i = 0; i < 2; ++ i) {
            
            RXThreePic *threePic = threePicArray[i];
            
            NSString *urlString = threePic.imgsrc;
            
            [self.otherImageView[i] sd_setImageWithURL:[NSURL URLWithString:urlString]];
            
        }

    }

    //设置大图数据同上边一致
    
}

- (NSString *)description {

    return [NSString stringWithFormat:@"%@,%@",self.titleLabel,self.iconImageView];
}

@end
