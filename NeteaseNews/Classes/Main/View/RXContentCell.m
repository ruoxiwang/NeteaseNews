//
//  RXContentCell.m
//  NeteaseNews
//
//  Created by 王若曦 on 16/3/28.
//  Copyright © 2016年 wrx. All rights reserved.
//

#import "RXContentCell.h"

@interface RXContentCell ()

@property (nonatomic,strong) RXNewsController *newsController;

@end

@implementation RXContentCell

- (void)awakeFromNib{

    UIStoryboard *newsStoryboard = [UIStoryboard storyboardWithName:@"News" bundle:nil];
    
    self.newsController = newsStoryboard.instantiateInitialViewController;
    
    [self.contentView addSubview:self.newsController.tableView];
    
    self.newsController.tableView.frame = self.contentView.bounds;
}

- (void)setChannel:(RXChannel *)channel{
    
    _channel = channel;
    
    self.newsController.tidURLString = channel.tidURLString;
    
}

- (void)setIndex:(NSInteger)index {
    
    _index = index;
    
    self.newsController.index = index;
}



@end
