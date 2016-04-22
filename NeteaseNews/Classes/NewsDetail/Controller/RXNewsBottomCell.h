//
//  RXNewsBottomCell.h
//  NeteaseNews
//
//  Created by 王若曦 on 16/4/20.
//  Copyright © 2016年 wrx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RXNewsBottomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *sectionLabel;

+ (instancetype)shareCell;
+ (instancetype)sectionHeaderCell;
+ (instancetype)moreReplyCell;
+ (instancetype)hotReplyCell;
+ (instancetype)moreNewsCell;
+ (instancetype)closeCell;
+ (instancetype)keywordCell;

@end
