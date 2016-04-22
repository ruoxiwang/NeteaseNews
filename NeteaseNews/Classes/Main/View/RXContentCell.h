//
//  RXContentCell.h
//  NeteaseNews
//
//  Created by 王若曦 on 16/3/28.
//  Copyright © 2016年 wrx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RXNewsController.h"
#import "RXChannel.h"

@interface RXContentCell : UICollectionViewCell

@property (nonatomic,strong) RXChannel *channel;

@property (nonatomic,assign) NSInteger index;

@end
