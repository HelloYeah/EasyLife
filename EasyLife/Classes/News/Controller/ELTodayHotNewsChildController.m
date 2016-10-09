//
//  ELTodayHotNewsChildController.m
//  EasyLife
//
//  Created by Sekorm on 16/10/9.
//  Copyright © 2016年 EL. All rights reserved.
//

#import "ELTodayHotNewsChildController.h"
#import "ELBaseRequest.h"
#import "UIImageView+YYWebImage.h"
#import "ELTodayHotNewsChildCell.h"
#import "ELTodayHotNewsChildModel.h"
#import "ELWeiXinNewsDetailController.h"

static const NSString * kWeiXinNewsAppKey = @"160f6a145f32d7c5410a2437923e01ea";

@interface ELTodayHotNewsChildController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,strong) ELBaseRequest * request;
@property (nonatomic,strong) UITableView * tableView;
@end

@implementation ELTodayHotNewsChildController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self loadData];
    
    
//    [ELUtils addLoadMoreForScrollView:self.tableView loadMoreCallBack:^{
//        [self loadData];
//    }];
//    
    [ELUtils addPullRefreshForScrollView:self.tableView pullRefreshCallBack:^{
        [self pullRefresh];
    }];
}


- (ELBaseRequest *)request{
    
    if (_request == nil) {
        ELBaseRequest * request = [ELBaseRequest el_request];
        _request = request;
    }
    _request.el_url = [NSString stringWithFormat:@"%@?type=%@&key=%@",kELTodayHotNewsListAPI,self.newsType,kWeiXinNewsAppKey];
    return _request;
}

- (void)loadData{
    
    if (!self.request) return ;
    [self.request el_sendRequestWithCompletion:^(NSDictionary * response, BOOL success, NSString *message) {
        
        if (success) {
            [ELUtils endRefreshForScrollView:self.tableView];
            NSMutableArray * tempArray = response[@"data"];
            self.dataArray  = [ELTodayHotNewsChildModel modelArrayWithDictArray:tempArray];
            [self.tableView reloadData];
        }
    }];
}

- (void)pullRefresh{
    
    [self loadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * const ID = @"ELTodayHotNewsChildCell";
    ELTodayHotNewsChildCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[ELTodayHotNewsChildCell alloc]initWithStyle: UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ELTodayHotNewsChildModel * model = self.dataArray[indexPath.row];
    cell.newsModel = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 300 * kScreenWidthRatio;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ELTodayHotNewsChildModel * model = self.dataArray[indexPath.row];
    NSString * linkUrl = [model.url stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    ELWeiXinNewsDetailController * weiXinNewsDetailVC = [[ELWeiXinNewsDetailController alloc]init];
    weiXinNewsDetailVC.linkUrl = linkUrl;
    weiXinNewsDetailVC.hidesBottomBarWhenPushed = YES;
    weiXinNewsDetailVC.title = @"今日资讯";
    UITabBarController * tabBarController = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController * nav = tabBarController.childViewControllers[1];
//    [self presentVc:weiXinNewsDetailVC];
    [nav pushViewController:weiXinNewsDetailVC animated:YES];
}

- (NSMutableArray *)dataArray{
    
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (UITableView *)tableView{
    
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,
                                                                  0,
                                                                  kScreenWidth,
                                                                  kScreenHeight - kNavigationBarHeight - kStatusBarHeight)
                                                 style:UITableViewStylePlain];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, kNavigationBarHeight * 2 + kStatusBarHeight, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
