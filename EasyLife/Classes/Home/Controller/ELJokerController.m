//
//  ELJokerController.m
//  EasyLife
//
//  Created by Sekorm on 16/10/9.
//  Copyright © 2016年 EL. All rights reserved.
//

#import "ELJokerController.h"
#import "ELBaseRequest.h"
#import "ELJokerModel.h"
#import "UIImageView+YYWebImage.h"
#import "ELJokerCell.h"


static const NSString * kJokerAppKey = @"d8d621f7c735a1be9c79a725daf5bde2";

@interface ELJokerController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,assign) NSInteger  pageIndex;
@property (nonatomic,strong) ELBaseRequest * request;
@property (nonatomic,strong) UITableView * tableView;
@end

@implementation ELJokerController

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
    _request.el_url = [NSString stringWithFormat:@"%@?page=%ld&pagesize=20&key=%@",kELJokerListAPI,self.pageIndex,kJokerAppKey];
    return _request;
}

- (void)loadData{
    
    if (!self.request) return ;
    [self.request el_sendRequestWithCompletion:^(NSDictionary * response, BOOL success, NSString *message) {
        
        if (success) {
            
            [self hideLoadingAnimation];
            [ELUtils endLoadMoreForScrollView:self.tableView];
            NSMutableArray * tempArray = response[@"data"];
            [self.dataArray addObjectsFromArray:[ELJokerModel modelArrayWithDictArray:tempArray]];
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
    ELJokerCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[ELJokerCell alloc]initWithStyle: UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ELJokerModel * model = self.dataArray[indexPath.row];
    cell.jokerModel = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 300 * kScreenWidthRatio;
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

