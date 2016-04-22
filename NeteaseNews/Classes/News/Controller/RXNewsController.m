//
//  RXNewsController.m
//  NeteaseNews
//
//  Created by 王若曦 on 16/3/28.
//  Copyright © 2016年 wrx. All rights reserved.
//

#import "RXNewsController.h"
#import "RXNews.h"
#import "RXNewsCell.h"
#import <MJRefresh.h>
#import "RXNewsDetailController.h"
#import "UIImage+SnapshotScreen.h"
#import "UIImage+ImageEffects.h"

@interface RXNewsController ()

@property (nonatomic,strong) NSMutableArray *innerNewList;

@property (nonatomic,strong) UIActivityIndicatorView *footerIndicatorView;

@property (nonatomic,assign) NSInteger currentIndex;

@property (nonatomic,strong) UIImageView *backgroundImage;

@property (nonatomic,strong) RXNewsCell *cell;


@end

@implementation RXNewsController

- (UIImageView *)backgroundImage {
    
    if (_backgroundImage == nil) {
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        
        _backgroundImage = image;
        
    }
    
    return _backgroundImage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    __weak typeof (self) weakSelf = self;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf loadData];
    }];
    
    [self setPullUpView];
}

- (NSMutableArray *)innerNewList{
    
    if (_innerNewList == nil) {
        
        _innerNewList = [NSMutableArray array];
    }
    
    return _innerNewList;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setTidURLString:(NSString *)tidURLString{
    
    _tidURLString = tidURLString.copy;
    
    __weak typeof (self) weakSelf = self;
    [RXNews newListWith:_tidURLString completeBlock:^(NSArray *newList) {
        
        [weakSelf.innerNewList removeAllObjects];
        
        [weakSelf.innerNewList addObjectsFromArray:newList];
        
        [weakSelf.tableView reloadData];
    }];
}

- (void)setPullUpView{
    
    UIActivityIndicatorView *footerIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    self.footerIndicatorView = footerIndicatorView;
    
    
    self.tableView.tableFooterView = footerIndicatorView;
}



- (void)loadData{
    
     // http://c.m.163.com//nc/article/headline/T1348647853363/0-20.html
    __weak typeof (self) weakSelf = self;
    [RXNews newListWith:self.tidURLString completeBlock:^(NSArray *newList) {
        
        weakSelf.innerNewList = [newList mutableCopy];
        
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView reloadData];
        
    }];

}

- (void)loadMoreData{
    
    self.currentIndex ++;
    
    //0-20.html
    //获取最后的字符串
    NSString *lastPathComponent = [self.tidURLString lastPathComponent];
    
    //获取最后字符串之前的范围
    NSRange range = [self.tidURLString rangeOfString:lastPathComponent];

    //获取之前的字符串
    NSString *previousString = [self.tidURLString substringToIndex:range.location];
    
    NSString *newString = [previousString stringByAppendingString:[NSString stringWithFormat:@"%zd-20.html",self.currentIndex * 10]];
    
    __weak typeof (self) weakSelf = self;
    [RXNews newListWith:newString completeBlock:^(NSArray *newList) {
        
        [weakSelf.innerNewList addObjectsFromArray:newList];
        
        [weakSelf.tableView reloadData];
        
        [weakSelf.footerIndicatorView stopAnimating];
    }];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.innerNewList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = nil;
    
    RXNews *news = self.innerNewList[indexPath.row];
    
    if (news.imgextra.count == 2) {
        
        identifier =  @"ThreePicCell";
        
    }else if (news.imgType){
        
        identifier = @"BigCell";
        
    }else{
        
        identifier = @"BasicCell";
        
    }
    
    RXNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    
    cell.news = news;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RXNews *news = self.innerNewList[indexPath.row];
    if (news.imgextra.count == 2) {
        
        return 120;
        
    }else if (news.imgType){
        
        return 200;
    
    }else{
        
        return 80;
    }

}

#pragma mark tableView Delegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == self.innerNewList.count - 1) {
        
        if (![self.footerIndicatorView isAnimating]) {
            [self.footerIndicatorView startAnimating];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self loadMoreData];
            });
            
        }else{
        
            
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //马上选中又取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"RXNewsDetailController" bundle:nil];
    
    RXNewsDetailController *detailVC = [[RXNewsDetailController alloc] init];
    
    detailVC = storyboard.instantiateInitialViewController;
    
    UIImage *backImage = [[UIImage snapshotScreen:0] applyDarkEffect];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    imageView.image = backImage;
    
    detailVC.backgroundView = imageView;
    
    [detailVC.view addSubview:imageView];
    
    RXNewsCell *cell = (RXNewsCell *)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
    
//    RXLog(@"%@",cell);
    
    //记录cell的位置，dismiss的时候返回该位置
    CGRect cellFrame = cell.frame;
    
    cellFrame = CGRectMake(0, cellFrame.origin.y + 108 - self.tableView.contentOffset.y, cellFrame.size.width, cellFrame.size.height);
    
    detailVC.cellOldFrame = cellFrame;
    
    detailVC.cell = cell;
    
    detailVC.news = self.innerNewList[indexPath.row];
    
    detailVC.index = self.index;
    
//    RXLog(@"%@",detailVC.cell);
    
    detailVC.cell.frame = cellFrame;
    
    [detailVC.view addSubview:cell];
    
    //present只能是根控制器，不然会打印错误
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [window.rootViewController presentViewController:detailVC animated:NO completion:^{
        
        [UIView animateWithDuration:0.25 animations:^{
            
            detailVC.cell.frame = CGRectMake(0, ScreenHeight / 2, cell.width, cell.height);
            
        }completion:^(BOOL finished) {
            
            [detailVC setUI];
            
        }];
    }];
}



@end
