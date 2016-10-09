//
//  ELHomeViewController.m
//  EasyLife
//
//  Created by Sekorm on 16/10/8.
//  Copyright © 2016年 EL. All rights reserved.
//

#import "ELHomeViewController.h"

@interface ELHomeViewController ()

@end

@implementation ELHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"首页";
    
    UIButton * btn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"开心一笑" forState:UIControlStateNormal];
    [btn setTitleColor:kCommonGrayTextColor forState:UIControlStateNormal];
    [btn sizeToFit];
    [self.view addSubview:btn];
    btn.center = self.view.center;
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnClick{
    
    [self.navigationController pushViewController:[[UIViewController alloc]init] animated:YES];
}



@end
