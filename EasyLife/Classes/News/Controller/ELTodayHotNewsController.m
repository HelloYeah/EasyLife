//
//  ELTodayHotNewsController.m
//  EasyLife
//
//  Created by Sekorm on 16/10/9.
//  Copyright © 2016年 EL. All rights reserved.
//

#import "ELTodayHotNewsController.h"
#import "HYTabbarView.h"
#import "ELWeiXinNewsListController.h"

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

        ELWeiXinNewsListController * top = [[ELWeiXinNewsListController alloc]init];
        top.title = @"头条";
        [_tabbarView addSubItemWithViewController:top];
        
        ELWeiXinNewsListController * shehui = [[ELWeiXinNewsListController alloc]init];
        shehui.title = @"社会";
        [_tabbarView addSubItemWithViewController:shehui];
        
        ELWeiXinNewsListController * guonei = [[ELWeiXinNewsListController alloc]init];
        guonei.title = @"国内";
        [_tabbarView addSubItemWithViewController:guonei];
        
        ELWeiXinNewsListController * guoji = [[ELWeiXinNewsListController alloc]init];
        guoji.title = @"国际";
        [_tabbarView addSubItemWithViewController:guoji];
        
        ELWeiXinNewsListController * yule = [[ELWeiXinNewsListController alloc]init];
        yule.title = @"娱乐";
        [_tabbarView addSubItemWithViewController:yule];
        
        ELWeiXinNewsListController * tiyu = [[ELWeiXinNewsListController alloc]init];
        tiyu.title = @"体育";
        [_tabbarView addSubItemWithViewController:tiyu];
        
        ELWeiXinNewsListController * junshi = [[ELWeiXinNewsListController alloc]init];
        junshi.title = @"军事";
        [_tabbarView addSubItemWithViewController:junshi];
        
        ELWeiXinNewsListController * keji = [[ELWeiXinNewsListController alloc]init];
        keji.title = @"科技";
        [_tabbarView addSubItemWithViewController:keji];
        
        ELWeiXinNewsListController * caijing = [[ELWeiXinNewsListController alloc]init];
        caijing.title = @"财经";
        [_tabbarView addSubItemWithViewController:caijing];
        
        ELWeiXinNewsListController * shishang = [[ELWeiXinNewsListController alloc]init];
        shishang.title = @"时尚";
        [_tabbarView addSubItemWithViewController:shishang];
    }
    return _tabbarView;
}

@end
