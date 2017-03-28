//
//  ELLifeViewController.m
//  EasyLife
//
//  Created by Sekorm on 16/10/8.
//  Copyright © 2016年 EL. All rights reserved.
//
//  http://live.ximalaya.com/live-web/v4/homepage?device=iPhone FM接口

#import "ELLifeViewController.h"
#import "ELJokerController.h"
#import "ELHoroscopeView.h"
#import "ELHoroscopeModel.h"
#import "ELBaseRequest.h"
#import "NSString+URL.h"

static const NSString * kJHoroscopeAppKey = @"f0b6f98f5224c5d4f31adc7a07dec884";
@interface ELLifeViewController ()
@property (nonatomic,strong) ELHoroscopeView * horoscopeView;
@property (nonatomic,strong) ELBaseRequest * request;
@end

@implementation ELLifeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"生活";
    
    UIButton * btn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"星座运势" forState:UIControlStateNormal];
    [btn setTitleColor:kCommonGrayTextColor forState:UIControlStateNormal];
    [btn sizeToFit];
    [self.view addSubview:btn];
    btn.center = self.view.center;
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.request = [ELBaseRequest el_request];
    NSString * urlStr = [NSString stringWithFormat:@"%@?consName=%@&type=%@&key=%@",kELHoroscopeAPI,[@"天秤座" urlEncodedString],@"today",kJHoroscopeAppKey];
    
    self.request.el_url = urlStr;
    NSLog(@"%@",self.request.el_url);
    [self.request el_sendRequestWithCompletion:^(id response, BOOL success, NSString *message) {
        NSLog(@"%@",response);
    }];
}

- (void)btnClick{
    
    ELJokerController * jokerVC = [[ELJokerController alloc]init];
    jokerVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:jokerVC animated:YES];
}

@end
