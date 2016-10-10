//
//  ELMeViewController.m
//  EasyLife
//
//  Created by Sekorm on 16/10/8.
//  Copyright © 2016年 EL. All rights reserved.
//

#import "ELMeViewController.h"
#import "ELJokerController.h"
@interface ELMeViewController ()

@end

@implementation ELMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"个人中心";
    
    UIButton * btn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"星座运势" forState:UIControlStateNormal];
    [btn setTitleColor:kCommonGrayTextColor forState:UIControlStateNormal];
    [btn sizeToFit];
    [self.view addSubview:btn];
    btn.center = self.view.center;
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnClick{
    
    ELJokerController * jokerVC = [[ELJokerController alloc]init];
    jokerVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:jokerVC animated:YES];
}

@end
