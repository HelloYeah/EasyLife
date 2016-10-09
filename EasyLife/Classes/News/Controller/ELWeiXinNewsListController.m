//
//  ELWeiXinNewsListController.m
//  EasyLife
//
//  Created by Sekorm on 16/10/9.
//  Copyright © 2016年 EL. All rights reserved.
//

#import "ELWeiXinNewsListController.h"
#import "ELBaseRequest.h"
#import "ELWeiXinNewsModel.h"
#import "UIImageView+YYWebImage.h"
#import "ELWeiXinNewsListCell.h"
#import "ELWeiXinNewsDetailController.h"

static const NSString * kWeiXinNewsAppKey = @"8d99c5ce4d8d02ee59ecf1a5e13f77e0";

@interface ELWeiXinNewsListController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,assign) NSInteger  pageIndex;
@property (nonatomic,strong) ELBaseRequest * request;
@property (nonatomic,strong) UITableView * tableView;
@end

@implementation ELWeiXinNewsListController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self showLoadingAnimation];
    self.pageIndex = 1;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self loadData];
    
    
    [ELUtils addLoadMoreForScrollView:self.tableView loadMoreCallBack:^{
        [self loadData];
    }];
    
    [ELUtils addPullRefreshForScrollView:self.tableView pullRefreshCallBack:^{
        [self pullRefresh];
    }];
}


- (ELBaseRequest *)request{
    
    if (_request == nil) {
        ELBaseRequest * request = [ELBaseRequest el_request];
        _request = request;
    }
    _request.el_url = [NSString stringWithFormat:@"%@?pno=%ld&key=%@",kELWeiXinNewsListAPI,self.pageIndex,kWeiXinNewsAppKey];
    return _request;
}

- (void)loadData{
    
    if (!self.request) return ;
    [self.request el_sendRequestWithCompletion:^(NSDictionary * response, BOOL success, NSString *message) {
        
        if (success) {
            
            [self hideLoadingAnimation];
            [ELUtils endLoadMoreForScrollView:self.tableView];
            NSMutableArray * tempArray = response[@"list"];
            [self.dataArray addObjectsFromArray:[ELWeiXinNewsModel modelArrayWithDictArray:tempArray]];
            [self.tableView reloadData];
            self.pageIndex ++;
        }
    }];
}

- (void)pullRefresh{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [ELUtils endRefreshForScrollView:self.tableView];
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * const ID = @"ELWeiXinNewsCell";
    ELWeiXinNewsListCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[ELWeiXinNewsListCell alloc]initWithStyle: UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ELWeiXinNewsModel * model = self.dataArray[indexPath.row];
    cell.newsModel = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100 * kScreenWidthRatio;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ELWeiXinNewsModel * model = self.dataArray[indexPath.row];
    NSString * linkUrl = [model.url stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    ELWeiXinNewsDetailController * weiXinNewsDetailVC = [[ELWeiXinNewsDetailController alloc]init];
    weiXinNewsDetailVC.linkUrl = linkUrl;
    weiXinNewsDetailVC.title = @"微信精选";
    weiXinNewsDetailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:weiXinNewsDetailVC animated:YES];
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
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end

