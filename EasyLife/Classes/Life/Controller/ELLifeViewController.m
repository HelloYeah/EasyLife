//
//  ELLifeViewController.m
//  EasyLife
//
//  Created by Sekorm on 16/10/8.
//  Copyright © 2016年 EL. All rights reserved.
//

#import "ELLifeViewController.h"
#import "ELBaseRequest.h"
#import "ELWeiXinNewsModel.h"
#import "YYWebImage.h"
#import "ELWeiXinNewsDetailController.h"

@interface ELLifeViewController ()
@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,assign) NSInteger  pageIndex;
@property (nonatomic,strong) ELBaseRequest * request;

@end

@implementation ELLifeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationController.title = @"微信新闻";
    self.pageIndex = 1;
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
    _request.el_url = [NSString stringWithFormat:@"%@?pno=%ld&key=%@",@"http://v.juhe.cn/weixin/query",self.pageIndex,@"8d99c5ce4d8d02ee59ecf1a5e13f77e0"];
    return _request;
}

- (void)loadData{
    
    if (!self.request) return ;
    [self.request el_sendRequestWithCompletion:^(NSDictionary * response, BOOL success, NSString *message) {
        if (success) {
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

    NSString * const ID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle: UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    ELWeiXinNewsModel * model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.title;
    cell.textLabel.numberOfLines = 0;
    NSString * imageUrl = [model.firstImg stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    cell.imageView.image = [[UIImage alloc]init];
    [[YYWebImageManager sharedManager] requestImageWithURL:[NSURL URLWithString:imageUrl] options:YYWebImageOptionShowNetworkActivity progress:nil transform:nil completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        cell.imageView.image = image;
    }];
                            
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
    [self.navigationController pushViewController:weiXinNewsDetailVC animated:YES];
}

- (NSMutableArray *)dataArray{
    
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
