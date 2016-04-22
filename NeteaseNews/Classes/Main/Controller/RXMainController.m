//
//  RXMainController.m
//  NeteaseNews
//
//  Created by 王若曦 on 16/3/28.
//  Copyright © 2016年 wrx. All rights reserved.
//

#import "RXMainController.h"
#import "RXChannel.h"
#import "RXContentCell.h"
#import "RXWeatherView.h"
#import "RXNetWorkTool.h"
#import "RXWeather.h"
#import "RXWeatherDetailController.h"
#import "RXWeatherDetail.h"
#import "UIImage+SnapshotScreen.h"
#import "UIImage+ImageEffects.h"

@interface RXMainController () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *labelScrollView;

@property (weak, nonatomic) IBOutlet UICollectionView *contentCollectionView;

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *contentFlowlayout;

//频道数组
@property (nonatomic,strong) NSArray *channels;

//存储label的数组
@property (nonatomic,strong) NSMutableArray *labelArray;

//barBtn不能旋转
//@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightBtn;

//小图片
@property (nonatomic,strong) UIImageView *littleImg;

//天气视图是否展示
@property (nonatomic,assign,getter=isWeatherShow) BOOL weatherShow;

//天气视图
@property (nonatomic,strong) RXWeatherView *weatherView;

@property (nonatomic,strong) UIButton *rightBtn;

//weatherModel
@property (nonatomic,strong) RXWeather *weatherModel;

//detailModel
@property (nonatomic,strong) RXWeatherDetail *detailModel;


@end

@implementation RXMainController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self setupLabelView];
    
    [self setContentFlowlayout];
    
    [self sendWeatherRequest];
    
    [self setRightBtn];
    
    self.contentCollectionView.delegate = self;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    [self scrollViewDidEndScrollingAnimation:self.contentCollectionView];
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    self.rightBtn.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    UIApplication *app = [UIApplication sharedApplication];
    
    app.statusBarStyle = UIStatusBarStyleLightContent;
    
    self.rightBtn.hidden = NO;
}

- (NSMutableArray *)labelArray{
    
    if (_labelArray == nil) {
        _labelArray = [NSMutableArray array];
    }
    
    return _labelArray;
}



#pragma mark - weather请求
- (void)sendWeatherRequest{
    
    //http://c.3g.163.com/nc/weather/5YyX5LqsfOWMl%2BS6rA%3D%3D.html
    
    
    NSString *weatherURLString = @"weather/5YyX5LqsfOWMl%2BS6rA%3D%3D.html";
    
    [[RXNetWorkTool sharedRXNetWorkTool] getWithURLString:weatherURLString finishBlock:^(id obj) {
        
        if ([obj isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *dict = obj;
            
            RXWeather *weatherModel = [RXWeather weatherWithDict:dict];
            
            self.weatherModel = weatherModel;
            
            //或者把模型用参数传过去
            [self addWeatherView];
        }
    }];
}

#pragma mark - 设置天气view弹出时右上角的小图片和weatherView
- (void)addWeatherView{
    
    UIImageView *littleImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"224"]];
    
    littleImg.x = [UIScreen mainScreen].bounds.size.width - 30;
    littleImg.y = 57;
    
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    
    self.littleImg = littleImg;
    
    [window addSubview:littleImg];
    
    self.littleImg.hidden = YES;
    
    //添加weatherView
    RXWeatherView *weatherView = [RXWeatherView weatherView];
    
    weatherView.x = 0;
    weatherView.y = 64;
    weatherView.width = [UIScreen mainScreen].bounds.size.width;
    weatherView.height = [UIScreen mainScreen].bounds.size.height - 64;
    
    //set方法设置显示内容
    weatherView.weatherModel = self.weatherModel;
    
    [window addSubview:weatherView];
    
    self.weatherView = weatherView;
    
    self.weatherView.hidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushWeatherDetailVC) name:@"pushWeatherDetailVC" object:nil];
    
    
}


#pragma mark - 右侧按钮点击事件
- (void)rightBtnDidClick{
    
    if (self.isWeatherShow) {
        
        self.littleImg.hidden = YES;
        
        //[self.rightBtn setImage:[UIImage imageNamed:@"top_navigation_square"]];
        
        [UIView animateWithDuration:0.2 animations:^{
            
            self.rightBtn.transform = CGAffineTransformRotate(self.rightBtn.transform, M_1_PI *5);
            
            self.weatherView.alpha = 0;
            
        } completion:^(BOOL finished) {
            
            [self.rightBtn setImage:[UIImage imageNamed:@"top_navigation_square"] forState:UIControlStateNormal];
           
            self.weatherView.hidden = YES;
        }];
        
    }else{
        
        self.littleImg.hidden = NO;
        
        [self.rightBtn setImage:[UIImage imageNamed:@"223"] forState:UIControlStateNormal];
        
        [UIView animateWithDuration:0.2 animations:^{
            
            self.rightBtn.transform = CGAffineTransformRotate(self.rightBtn.transform, -M_1_PI *6);
            
            self.weatherView.hidden = NO;
            self.weatherView.alpha = 1;
            
        }completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.1 animations:^{
                
                self.rightBtn.transform = CGAffineTransformRotate(self.rightBtn.transform, M_1_PI);
                
            }];
        }];
    }
    
    self.weatherShow = !self.isWeatherShow;
    
    //将背景处理成高斯模糊
    self.weatherView.backgroundImage.image = [[UIImage snapshotScreen:72] applyLightEffect];
    
    //按钮动画
    [self.weatherView.bottomView btnAnimate];
}

- (void)setupLabelView{

    self.channels = [RXChannel channels];
    
    CGFloat labelX = 0;
    CGFloat labelY = 0;
    CGFloat labelW = 80;
    CGFloat labelH = self.labelScrollView.frame.size.height;
    
    for (int i = 0; i < self.channels.count; ++ i) {
        
        labelX = i * labelW;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
        
        label.tag = i;
        label.text = [self.channels[i] tname];
        label.textAlignment = NSTextAlignmentCenter;
        
        label.userInteractionEnabled = YES;
        
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelDidClick:)]];
        
        [self.labelScrollView addSubview:label];
        
        [self.labelArray addObject:label];
    }
    
    self.labelScrollView.contentSize = CGSizeMake(labelW * self.channels.count, 0);
    self.labelScrollView.showsHorizontalScrollIndicator = NO;
}


- (void)labelDidClick:(UITapGestureRecognizer *)tap{
    
    //取出索引
    NSInteger tag = tap.view.tag;
    
    CGPoint offset = self.contentCollectionView.contentOffset;

    offset.x = self.contentCollectionView.bounds.size.width * tag;
    
    [self.contentCollectionView setContentOffset:offset animated:YES];
    
    
}


- (void)setContentFlowlayout{
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat height = [UIScreen mainScreen].bounds.size.height - 64 - self.labelScrollView.bounds.size.height;
    
    self.contentFlowlayout.itemSize = CGSizeMake(width, height);
    self.contentFlowlayout.minimumInteritemSpacing = 0;
    self.contentFlowlayout.minimumLineSpacing = 0;
    
}

#pragma mark - 数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.channels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RXContentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
    
    RXChannel *channel = self.channels[indexPath.item];
    
    cell.channel = channel;
    cell.index = indexPath.item;
    
    return cell;
    
}

#pragma mark - 代理方法
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    UILabel *label = self.labelArray[index];
    CGPoint offset = self.labelScrollView.contentOffset;
    
    offset.x = label.center.x - scrollView.frame.size.width *0.5;
    
    //    RXLog(@"%f",scrollView.frame.size.width);
    //左边越界处理
    if (offset.x < 0) {
        offset.x = 0;
    }
    //右边越界处理
    CGFloat maxOffset = self.labelScrollView.contentSize.width - scrollView.frame.size.width;
    if (offset.x > maxOffset) {
        offset.x = maxOffset;
    }
    
    
    [self.labelScrollView setContentOffset:offset animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat scale = scrollView.contentOffset.x / scrollView.bounds.size.width;
    NSInteger leftIndex = scrollView.contentOffset.x /scrollView.bounds.size.width;
    
    UILabel *leftLabel = self.labelArray[leftIndex];
    
    NSInteger rightIndex = leftIndex + 1;
    
    UILabel *rightLabel = self.labelArray[rightIndex];
    
    //获取变化比例
    CGFloat rightScale = scale - leftIndex;
    CGFloat leftScale = 1 - rightScale;
    
    leftLabel.textColor = [UIColor colorWithRed:leftScale green:0 blue:0 alpha:1];
    rightLabel.textColor = [UIColor colorWithRed:rightScale green:0 blue:0 alpha:1];
    
    //防止数组越界
    if (leftIndex == self.labelScrollView.subviews.count) {
        return;
    }
}


- (void)setRightBtn{
     
#warning 不能设置为barbutton,动画会出问题
     UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
 
     rightBtn.y = 20;
     rightBtn.width = 45;
     rightBtn.height = 45;
     rightBtn.x = [UIScreen mainScreen].bounds.size.width - rightBtn.width;
 
     [rightBtn addTarget:self action:@selector(rightBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
     [rightBtn setImage:[UIImage imageNamed:@"top_navigation_square"] forState:UIControlStateNormal];
 
     UIWindow *window =[UIApplication sharedApplication].windows.firstObject;
 
     [window addSubview:rightBtn];
     self.rightBtn = rightBtn;
 
//     UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
// 
//     [rightBtn setImage:[UIImage imageNamed:@"top_navigation_square"] forState:UIControlStateNormal];
// 
//     [rightBtn sizeToFit];
// 
//     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
//     
//     [rightBtn addTarget:self action:@selector(rightBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
//     
//     self.rightBtn = rightBtn;
 }

#pragma mark - 通知方法
- (void)pushWeatherDetailVC{
    
    RXWeatherDetailController *weatherDetailVC = [[RXWeatherDetailController alloc]init];
    
    UIStoryboard *weatherDetailStoryboard = [UIStoryboard storyboardWithName:@"RXWeatherDetailController" bundle:nil];
    
    weatherDetailVC = weatherDetailStoryboard.instantiateInitialViewController;
    
    weatherDetailVC.weatherModel = self.weatherModel;
    
//    RXLog(@"%@",weatherDetailVC.weatherModel.date);
    
    weatherDetailVC.navigationController.navigationBarHidden = YES;
    [self rightBtnDidClick];
    
    self.rightBtn.hidden = YES;
    
    [self.navigationController pushViewController:weatherDetailVC animated:YES];
    
    
}

@end
