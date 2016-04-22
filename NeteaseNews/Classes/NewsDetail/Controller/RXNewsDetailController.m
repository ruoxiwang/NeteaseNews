//
//  RXNewsDetailController.m
//  NeteaseNews
//
//  Created by 王若曦 on 16/4/17.
//  Copyright © 2016年 wrx. All rights reserved.
//

#import "RXNewsDetailController.h"
#import "RXNewsDetail.h"
#import "RXNewsImage.h"
#import "RXNetWorkTool.h"
#import "RXReplyModel.h"
#import "RXNewsBottomCell.h"

@interface RXNewsDetailController () <UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *navBar;
@property (weak, nonatomic) IBOutlet UITableView *mainView;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *replyBtn;
@property (weak, nonatomic) IBOutlet UIView *sliceView;

@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,strong) NSMutableArray *replyModels;

@property (nonatomic,strong) RXNewsDetail *newsDetail;
@property (nonatomic,strong) RXNewsBottomCell *closeCell;

@end

@implementation RXNewsDetailController

- (UIWebView *)webView {
    
    if (! _webView) {
        
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 700)];
        
        _webView = webView;
    }
    
    return _webView;
}

- (NSMutableArray *)replyModels {
    
    if (_replyModels) {
        
        NSMutableArray *array = [NSMutableArray array];
    
        _replyModels = array;
    }
    
    return _replyModels;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIApplication *app = [UIApplication sharedApplication];
    
    app.statusBarStyle = UIStatusBarStyleDefault;
    
    self.mainView.delegate = self;
    self.mainView.dataSource = self;
    
    self.replyBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
//    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}

- (void)backToNews {
    
    self.backBtn.hidden = YES;
    self.replyBtn.hidden = YES;
    self.sliceView.hidden = YES;
    
    [UIView animateWithDuration:0.4 animations:^{
        
        CGFloat viewY = self.cellOldFrame.origin.y + self.cellOldFrame.size.height;
        
        self.cell.frame = self.cellOldFrame;
        
        self.mainView.frame = CGRectMake(0, viewY, ScreenWidth, 0);
        
        self.navBar.frame = CGRectMake(0, viewY, ScreenWidth, 0);
        
    } completion:^(BOOL finished) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self dismissViewControllerAnimated:NO completion:^{
                
            }];
            
        });
        
    }];
    
}

- (void)setUI {
    
    CGFloat viewY = self.cell.y + self.cell.height;
    
    self.mainView.frame = CGRectMake(0, viewY, ScreenWidth, 0);
    self.navBar.frame = CGRectMake(0, viewY, ScreenWidth, 0);
    
    [self.view bringSubviewToFront:self.mainView];
    [self.view bringSubviewToFront:self.navBar];
    
    //view做动画
    [self viewOpenAnimation];
 
}

- (void)viewOpenAnimation {
    
    [UIView animateWithDuration:0.4 animations:^{
        
        self.cell.frame = CGRectMake(0, -self.cellOldFrame.size.height, ScreenWidth, self.cellOldFrame.size.height);
        self.mainView.frame = CGRectMake(0, 64, ScreenWidth, ScreenHeight);
        self.navBar.frame = CGRectMake(0, 0, ScreenWidth, 64);
        
    }completion:^(BOOL finished) {
        self.sliceView.hidden = NO;
        self.backBtn.hidden = NO;
        self.replyBtn.hidden = NO;
        
        [self loadData];

    }];
}

- (void)loadData {
    
    self.webView.delegate = self;
    
    NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/full.html",self.news.docid];
    
    [[RXNetWorkTool sharedRXNetWorkTool] getWithURLString:url finishBlock:^(id obj) {
        NSDictionary *dict = obj;
        
        RXNewsDetail *newsDetail = [RXNewsDetail newsDetailWithDict:dict[self.news.docid]];
        
        self.newsDetail = newsDetail;
        
        if (self.news.boardid.length < 1) {
            self.news.boardid = self.newsDetail.replyBoard;
        }
        self.news.replyCount = self.newsDetail.replyCount;
        
        [self showInWebView];
        
        [self setReplyCount];
    }];
    
    //提前接收reply数据
    [self loadReplyData];
  
}

- (void)loadReplyData {
    
    NSString *replyUrl = [NSString stringWithFormat:@"http://comment.api.163.com/api/json/post/list/new/hot/%@/%@/0/10/10/2/2",self.news.boardid,self.news.docid];
    
    [[RXNetWorkTool sharedRXNetWorkTool] getWithURLString:replyUrl finishBlock:^(id obj) {
        
        NSDictionary *dict = obj;
        
        NSArray *dataArray = dict[@"hotPosts"];
        
        [dataArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
           
            RXReplyModel *replyModel = [RXReplyModel replyWithDict:dict];
            
            [self.replyModels addObject:replyModel];
        }];
    }];
}

- (void)setReplyCount {
    
    CGFloat replyCount = [self.news.replyCount intValue];
    NSString *replyString = [NSString string];
    
    if (replyCount > 10000) {
        
        replyString = [NSString stringWithFormat:@"%.1f万跟帖",replyCount/10000];
        
    }else {
        
        replyString = [NSString stringWithFormat:@"%.0f跟帖",replyCount];
    }
    
    [self.replyBtn setTitle:replyString forState:UIControlStateNormal];
    [self.replyBtn setTitle:replyString forState:UIControlStateHighlighted];
    
//    RXLog(@"%@",self.replyBtn);
}

#pragma mark - 拼接html
- (void)showInWebView {
    
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<html>"];
    [html appendString:@"<head>"];
    [html appendFormat:@"<link rel=\"stylesheet\" href=\"%@\">",[[NSBundle mainBundle] URLForResource:@"RXDetails.css" withExtension:nil]];
    [html appendString:@"</head>"];
    
    [html appendString:@"<body style=\"background:#f6f6f6\">"];
    [html appendString:[self touchBody]];
    [html appendString:@"</body>"];
    
    [html appendString:@"</html>"];
    
    //加载数据
    [self.webView loadHTMLString:html baseURL:nil];
    
}

- (NSString *)touchBody {
    
    NSMutableString *bodyString = [NSMutableString string];
    
    [bodyString appendFormat:@"<div class=\"title\">%@</div>",self.newsDetail.title];
    [bodyString appendFormat:@"<div class=\"time\">%@</div>",self.newsDetail.ptime];
    
    if (self.newsDetail.body != nil) {
        [bodyString appendString:self.newsDetail.body];
    }
    
    [self.newsDetail.img enumerateObjectsUsingBlock:^(RXNewsImage *imgModel, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSMutableString *imgHtml = [NSMutableString string];
        
        [imgHtml appendString:@"<div class=\"img-parent\">"];
        
        NSArray *pixel = [imgModel.pixel componentsSeparatedByString:@"*"];
        
        CGFloat width = [[pixel firstObject] floatValue];
        CGFloat height = [[pixel lastObject] floatValue];
        
        //判断是否超过最大宽度
        CGFloat maxWidth = ScreenWidth * 0.96;
        
        if (width > maxWidth) {
            height = maxWidth / width * height;
            width = maxWidth;
        }
        
        NSString *onload =  @"this.onclick = function() {"
        "  window.location.href = 'rx:src=' +this.src;"
        "};";
        
        [imgHtml appendFormat:@"<img onload=\"%@\" width=\"%f\" height=\"%f\" src=\"%@\">",onload,width,height,imgModel.src];
        
        //结束
        [imgHtml appendString:@"</div>"];
        //替换标记
        [bodyString replaceOccurrencesOfString:imgModel.ref withString:imgHtml
                                       options:NSCaseInsensitiveSearch range:NSMakeRange(0,bodyString.length)];
    }];
    
    return bodyString;
}

#pragma mark - webView代理
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString *url = request.URL.absoluteString;
    
    NSRange range = [url rangeOfString:@"rx:src="];
    
    if (range.location != NSNotFound) {
        
        NSInteger begin = range.location + range.length;
        NSString *src = [url substringFromIndex:begin];
        [self savePicToAlbum:src];
        
        return NO;
    }
    
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.webView.height = self.webView.scrollView.contentSize.height;
    
    [self.mainView reloadData];
}

- (void)savePicToAlbum:(NSString *)src {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定到保存到相册吗" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        NSURLCache *cache = [NSURLCache sharedURLCache];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:src]];
        NSData *imageData = [cache cachedResponseForRequest:request].data;
        UIImage *image = [UIImage imageWithData:imageData];
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return self.webView;
    }else if(section == 1) {
        
        RXNewsBottomCell *bottomCell = [RXNewsBottomCell sectionHeaderCell];
        bottomCell.sectionLabel.text = @"热门跟帖";
        return bottomCell;
    }else {
        
        RXNewsBottomCell *bottomCell = [RXNewsBottomCell sectionHeaderCell];
        bottomCell.sectionLabel.text = @"推荐新闻";
        return bottomCell;
    }
    
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return self.webView.height;
    }else if (section == 1) {
        return self.replyModels.count > 0 ? 40 : CGFLOAT_MIN;
    }else if (section == 2) {
        return CGFLOAT_MIN;
    }
    
    return CGFLOAT_MIN;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        return 1 + self.replyModels.count;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [[UITableViewCell alloc] init];
}

- (IBAction)backBtnDidClick {
    
    [self backToNews];
}

- (IBAction)replyBtnDidClick {
}


@end
