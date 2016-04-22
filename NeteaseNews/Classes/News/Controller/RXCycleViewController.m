//
//  RXCycleViewController.m
//  NeteaseNews
//
//  Created by 王若曦 on 16/3/29.
//  Copyright © 2016年 wrx. All rights reserved.
//

#import "RXCycleViewController.h"
#import "RXCycle.h"
#import "RXCycleCell.h"

@interface RXCycleViewController () <UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *cycleFlowLayout;

@property (nonatomic,strong) NSArray *cycles;

@end

@implementation RXCycleViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.cycleFlowLayout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 250);
    self.cycleFlowLayout.minimumInteritemSpacing = 0;
    self.cycleFlowLayout.minimumLineSpacing = 0;
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    [self loadData];
    
    

}

- (void)loadData{
    
    __weak typeof (self) weakSelf = self;
    [RXCycle cycleListWithCompleteBlock:^(NSArray *newList) {
        
        weakSelf.cycles = newList;
        
        [weakSelf.collectionView reloadData];
        
        //让其通过无动画的方式,滚到最中间那组去
        NSIndexPath *centerIndexPath = [NSIndexPath indexPathForItem:0 inSection:3/2];
        [weakSelf.collectionView scrollToItemAtIndexPath:centerIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    }];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 3;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

//    RXLog(@"%ld",self.cycles.count);
    
    return self.cycles.count;
    
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RXCycleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CycleCell" forIndexPath:indexPath];
    
    cell.cycle = self.cycles[indexPath.item];
    
    return cell;
}

#pragma mark UIScrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    NSInteger needIndex = index % self.cycles.count;
    
//    RXLog(@"%zd",needIndex);
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:needIndex inSection:3/2];
//    RXLog(@"%@",indexPath);
    
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
}


@end
