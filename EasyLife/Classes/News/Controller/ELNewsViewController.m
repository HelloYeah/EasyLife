//
//  ELNewsViewController.m
//  EasyLife
//
//  Created by Sekorm on 16/10/8.
//  Copyright © 2016年 EL. All rights reserved.
//

#import "ELNewsViewController.h"

#import "ELWeiXinNewsListController.h"
#import "ELTodayHotNewsController.h"


@interface ELNewsViewController ()
@property (nonatomic,strong) ELWeiXinNewsListController * weiXinNewsListVC;
@property (nonatomic,strong) ELTodayHotNewsController * todayHotNewsVC;
@end

@implementation ELNewsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    UISegmentedControl * segmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"今日资讯",@"微信精选"]];
    segmentedControl.frame = CGRectMake(0, 0, kScreenWidth * 0.35, kNavigationBarHeight * 0.8);
    segmentedControl.tintColor = kCommonTintColor;
    segmentedControl.selectedSegmentIndex = 0;
    self.navigationItem.titleView = segmentedControl;
    [segmentedControl addTarget:self action:@selector(changeSelectedIndex:) forControlEvents:UIControlEventValueChanged];
    [self changeSelectedIndex:segmentedControl];
    
}

- (void)changeSelectedIndex:(UISegmentedControl *)segmentedControl{
    
    if(segmentedControl.selectedSegmentIndex == 0){
        self.weiXinNewsListVC.view.hidden = YES;
        self.todayHotNewsVC.view.hidden = NO;
        
    }else{
        self.weiXinNewsListVC.view.hidden = NO;
        self.todayHotNewsVC.view.hidden = YES;
    }
}

- (ELWeiXinNewsListController *)weiXinNewsListVC{
    
    if (_weiXinNewsListVC == nil) {
        _weiXinNewsListVC = [[ELWeiXinNewsListController alloc]init];
        [self addChildViewController:_weiXinNewsListVC];
        [self.view addSubview:_weiXinNewsListVC.view];
    }
    return _weiXinNewsListVC;
}

- (ELTodayHotNewsController *)todayHotNewsVC{
    
    if (_todayHotNewsVC == nil) {
        _todayHotNewsVC = [[ELTodayHotNewsController alloc]init];
        [self addChildViewController:_todayHotNewsVC];
        [self.view addSubview:_todayHotNewsVC.view];
    }
    return _todayHotNewsVC;
}

@end

