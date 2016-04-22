//
//  RXNewsBottomCell.m
//  NeteaseNews
//
//  Created by 王若曦 on 16/4/20.
//  Copyright © 2016年 wrx. All rights reserved.
//

#import "RXNewsBottomCell.h"

@interface RXNewsBottomCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userLocLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyDetailLabel;

@property (weak, nonatomic) IBOutlet UIImageView *newsIcon;
@property (weak, nonatomic) IBOutlet UILabel *newsDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *newsFromLabel;
@property (weak, nonatomic) IBOutlet UILabel *newsTimeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *closeImage;
@property (weak, nonatomic) IBOutlet UILabel *closeLabel;


@end

@implementation RXNewsBottomCell

+ (instancetype)shareCell {
    
    return [[NSBundle mainBundle] loadNibNamed:@"RXNewsBottomCell" owner:nil options:nil][0];
}

+ (instancetype)sectionHeaderCell {
    
    return [[NSBundle mainBundle] loadNibNamed:@"RXNewsBottomCell" owner:nil options:nil][1];
}

+ (instancetype)moreReplyCell {
    
    return [[NSBundle mainBundle] loadNibNamed:@"RXNewsBottomCell" owner:nil options:nil][2];
    
}

+ (instancetype)hotReplyCell {
    
    return [[NSBundle mainBundle] loadNibNamed:@"RXNewsBottomCell" owner:nil options:nil][3];
}
+ (instancetype)moreNewsCell {
    
    return [[NSBundle mainBundle] loadNibNamed:@"RXNewsBottomCell" owner:nil options:nil][4];
}

+ (instancetype)closeCell {
    
    return [[NSBundle mainBundle] loadNibNamed:@"RXNewsBottomCell" owner:nil options:nil][5];
}

+ (instancetype)keywordCell {
    
    return [[NSBundle mainBundle] loadNibNamed:@"RXNewsBottomCell" owner:nil options:nil][6];
}


- (IBAction)moreReplyDidClick {
    
    
}
@end
