//
//  RXNavController.m
//  NeteaseNews
//
//  Created by 王若曦 on 16/3/28.
//  Copyright © 2016年 wrx. All rights reserved.
//

#import "RXNavController.h"

@interface RXNavController ()

@end

@implementation RXNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

+ (void)initialize{
    
    UINavigationBar *navBar =  [UINavigationBar appearance];
    
    [navBar setBarTintColor:[UIColor colorWithRed:215.0/255.0 green:26.0/255.0 blue:34.0/255.0 alpha:0.8]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
