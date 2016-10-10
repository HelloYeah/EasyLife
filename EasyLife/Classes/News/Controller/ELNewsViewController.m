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
@property (nonatomic,weak) ELWeiXinNewsListController * weiXinNewsListVC;
@property (nonatomic,weak) ELTodayHotNewsController * todayHotNewsVC;
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
       
        ELTodayHotNewsController * todayHotNewsVC = [[ELTodayHotNewsController alloc]init];
        [todayHotNewsVC willMoveToParentViewController:self];
        [self addChildViewController:todayHotNewsVC];
        _todayHotNewsVC = todayHotNewsVC;
        [self.view addSubview:todayHotNewsVC.view];
        
        [_weiXinNewsListVC.view removeFromSuperview];
        [_weiXinNewsListVC willMoveToParentViewController:nil];
        [_weiXinNewsListVC removeFromParentViewController];
        
    }else{

        ELWeiXinNewsListController * weiXinNewsListVC = [[ELWeiXinNewsListController alloc]init];
        [weiXinNewsListVC willMoveToParentViewController:self];
        [self addChildViewController:weiXinNewsListVC];
        _weiXinNewsListVC = weiXinNewsListVC;
        [self.view addSubview:weiXinNewsListVC.view];
        
        [_todayHotNewsVC.view removeFromSuperview];
        [_todayHotNewsVC willMoveToParentViewController:nil];
        [_todayHotNewsVC removeFromParentViewController];
    }
}
@end

