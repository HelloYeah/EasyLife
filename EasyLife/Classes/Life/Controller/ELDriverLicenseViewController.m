//
//  ELDriverLicenseViewController.m
//  EasyLife
//
//  Created by Sekorm on 2017/2/27.
//  Copyright © 2017年 EL. All rights reserved.
//

#import "ELDriverLicenseViewController.h"
#import "ELBaseRequest.h"

@interface ELDriverLicenseViewController ()
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic,strong) ELBaseRequest * request;
@end

@implementation ELDriverLicenseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *appcode = kAliBabaAppKey;
    NSString *host = @"http://jisujiakao.market.alicloudapi.com";
    NSString *path = @"/driverexam/query";
    NSString *method = @"GET";
    NSString *querys = @"?pagenum=1&pagesize=10&sort=normal&subject=1&type=C1";
    NSString *url = [NSString stringWithFormat:@"%@%@%@",  host,  path , querys];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: url]  cachePolicy:1  timeoutInterval:  5];
    request.HTTPMethod  =  method;
    [request addValue:  [NSString  stringWithFormat:@"APPCODE %@" ,  appcode]  forHTTPHeaderField:  @"Authorization"];
    NSURLSession *requestSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [requestSession dataTaskWithRequest:request
                                                   completionHandler:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                       NSLog(@"Response object: %@" , response);
                                                       NSString *bodyString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
                                                       
                                                       //打印应答中的body
                                                       NSLog(@"Response body: %@" , bodyString);
                                                   }];
    
    [task resume];
}



- (void)loadData{
    
  
    WeakSelf(weakSelf)
    [self.request el_sendRequestWithCompletion:^(NSDictionary * response, BOOL success, NSString *message) {
        
        if (success) {
            
            [weakSelf hideLoadingAnimation];
            [ELUtils endLoadMoreForScrollView:self.tableView];
            
            NSMutableArray * tempArray = response[@"data"];
        
            [weakSelf.tableView reloadData];
        }
    }];
}

- (ELBaseRequest *)request{
    
    if (_request == nil) {
        _request = [ELBaseRequest el_request];
    }
    
    _request.el_url = [NSString stringWithFormat:@"%@?pagenum=%ld&pagesize=20&sort=%@&subject=%@&type=%@&key=%@",@"http://jisujiakao.market.alicloudapi.com/driverexam/query",self.pageIndex,@"normal",@"1",@"A1",kAliBabaAppKey];
    NSMutableURLRequest *tempRequest = [_request mutableCopy];
    [tempRequest addValue:  [NSString  stringWithFormat:@"APPCODE %@" ,  kAliBabaAppKey]  forHTTPHeaderField:  @"Authorization"];
    
    return tempRequest;
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
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
