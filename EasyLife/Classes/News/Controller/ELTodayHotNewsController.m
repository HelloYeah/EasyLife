//
//  ELTodayHotNewsController.m
//  EasyLife
//
//  Created by Sekorm on 16/10/9.
//  Copyright © 2016年 EL. All rights reserved.
//

#import "ELTodayHotNewsController.h"
#import "HYTabbarView.h"
#import "ELTodayHotNewsChildController.h"

@interface ELTodayHotNewsController ()
@property (nonatomic,strong) HYTabbarView * tabbarView;
@end

@implementation ELTodayHotNewsController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    [self.view addSubview:self.tabbarView];
}

- (HYTabbarView *)tabbarView{
    
    if (_tabbarView == nil) {
        _tabbarView = [[HYTabbarView alloc]initWithFrame:CGRectMake(0,
                                                                    0,
                                                                    kScreenWidth,
                                                                    kScreenHeight - kStatusBarHeight - kNavigationBarHeight - kTabBarHeight)];
//类型,,top(头条，默认),shehui(社会),guonei(国内),guoji(国际),yule(娱乐),tiyu(体育)junshi(军事),keji(科技),caijing(财经),shishang(时尚)
        ELTodayHotNewsChildController * top = [[ELTodayHotNewsChildController alloc]init];
        top.title = @"头条";
        top.newsType = @"top";
        [_tabbarView addSubItemWithViewController:top];
        
        ELTodayHotNewsChildController * shehui = [[ELTodayHotNewsChildController alloc]init];
        shehui.title = @"社会";
        shehui.newsType = @"shehui";
        [_tabbarView addSubItemWithViewController:shehui];
        
        ELTodayHotNewsChildController * guonei = [[ELTodayHotNewsChildController alloc]init];
        guonei.title = @"国内";
        guonei.newsType = @"guonei";
        [_tabbarView addSubItemWithViewController:guonei];
        
        ELTodayHotNewsChildController * guoji = [[ELTodayHotNewsChildController alloc]init];
        guoji.title = @"国际";
        guoji.newsType = @"guoji";
        [_tabbarView addSubItemWithViewController:guoji];
        
        ELTodayHotNewsChildController * yule = [[ELTodayHotNewsChildController alloc]init];
        yule.title = @"娱乐";
        yule.newsType = @"yule";
        [_tabbarView addSubItemWithViewController:yule];
        
        ELTodayHotNewsChildController * tiyu = [[ELTodayHotNewsChildController alloc]init];
        tiyu.title = @"体育";
        tiyu.newsType = @"tiyu";
        [_tabbarView addSubItemWithViewController:tiyu];
        
        ELTodayHotNewsChildController * junshi = [[ELTodayHotNewsChildController alloc]init];
        junshi.title = @"军事";
        junshi.newsType = @"junshi";
        [_tabbarView addSubItemWithViewController:junshi];
        
        ELTodayHotNewsChildController * keji = [[ELTodayHotNewsChildController alloc]init];
        keji.title = @"科技";
        keji.newsType = @"keji";
        [_tabbarView addSubItemWithViewController:keji];
        
        ELTodayHotNewsChildController * caijing = [[ELTodayHotNewsChildController alloc]init];
        caijing.title = @"财经";
        caijing.newsType = @"caijing";
        [_tabbarView addSubItemWithViewController:caijing];
        
        ELTodayHotNewsChildController * shishang = [[ELTodayHotNewsChildController alloc]init];
        shishang.title = @"时尚";
        shishang.newsType = @"shishang";
        [_tabbarView addSubItemWithViewController:shishang];
    }
    return _tabbarView;
}

@end
