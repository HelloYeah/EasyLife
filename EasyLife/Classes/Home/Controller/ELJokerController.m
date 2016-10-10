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
#import "UIView+Layer.h"
#import "ELJokerCell.h"

#define kHeaderViewHeight 50 * kScreenWidthRatio
static const NSString * kJokerAppKey = @"d8d621f7c735a1be9c79a725daf5bde2";
@interface ELJokerController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,strong) NSMutableArray * picDataArray;
@property (nonatomic,strong) NSMutableArray * textDataArray;
@property (nonatomic,assign) NSInteger  picPageIndex;
@property (nonatomic,assign) NSInteger  textPageIndex;
@property (nonatomic,strong) ELBaseRequest * picRequest;
@property (nonatomic,strong) ELBaseRequest * textRequest;
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) UIView * headerView;
@property (nonatomic,assign) BOOL isPic;
@property (nonatomic,weak) UIButton * selectedBtn;
@end

@implementation ELJokerController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    UISegmentedControl * segmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"趣图",@"段子"]];
    segmentedControl.frame = CGRectMake(0, 0, kScreenWidth * 0.35, kNavigationBarHeight * 0.8);
    segmentedControl.tintColor = kCommonTintColor;
    segmentedControl.selectedSegmentIndex = 0;
    self.navigationItem.titleView = segmentedControl;
    [segmentedControl addTarget:self action:@selector(changeSelectedIndex:) forControlEvents:UIControlEventValueChanged];
    [self changeSelectedIndex:segmentedControl];

    [self showLoadingAnimation];
    self.picPageIndex = 1;
    self.textPageIndex = 1;
    [self loadData];
    
    [ELUtils addLoadMoreForScrollView:self.tableView loadMoreCallBack:^{
        [self loadData];
    }];
    
    [ELUtils addPullRefreshForScrollView:self.tableView pullRefreshCallBack:^{
        [self pullRefresh];
    }];
}
- (void)changeSelectedIndex:(UISegmentedControl *)segmentedControl{
    
    if(segmentedControl.selectedSegmentIndex == 0){
        self.isPic = YES;
    }else{
        self.isPic = NO;
        if(self.textDataArray.count == 0){
            [self loadData];
        }
    }
    [self.tableView reloadData];
}


- (ELBaseRequest *)picRequest{
    
    if (_picRequest == nil) {
        ELBaseRequest * request = [ELBaseRequest el_request];
        _picRequest = request;
    }

    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    _picRequest.el_url = [NSString stringWithFormat:@"%@?sort=desc&page=%ld&pagesize=20&time=%@&key=%@",kELJokerPicListAPI,self.picPageIndex,timeSp,kJokerAppKey];
    return _picRequest;
}

- (ELBaseRequest *)textRequest{
    
    if (_textRequest == nil) {
        ELBaseRequest * request = [ELBaseRequest el_request];
        _textRequest = request;
    }

    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    _textRequest.el_url = [NSString stringWithFormat:@"%@?sort=desc&page=%ld&pagesize=20&time=%@&key=%@",kELJokerTextListAPI,self.textPageIndex,timeSp,kJokerAppKey];
    return _textRequest;
}

- (void)loadData{
    
    ELBaseRequest * request = _isPic ? self.picRequest : self.textRequest;
    
    if (request == nil) return ;
    [request el_sendRequestWithCompletion:^(NSDictionary * response, BOOL success, NSString *message) {
        
        if (success) {
            
            [self hideLoadingAnimation];
            [ELUtils endLoadMoreForScrollView:self.tableView];
            NSMutableArray * tempArray = response[@"data"];
            if (_isPic) {
                [self.picDataArray addObjectsFromArray:[ELJokerModel modelArrayWithDictArray:tempArray]];
                self.picPageIndex ++;
            }else{
                [self.textDataArray addObjectsFromArray:[ELJokerModel modelArrayWithDictArray:tempArray]];
                self.textPageIndex ++;
            }
            [self.tableView reloadData];
            
        }
    }];
}

- (void)pullRefresh{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [ELUtils endRefreshForScrollView:self.tableView];
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    self.dataArray = _isPic ? self.picDataArray : self.textDataArray;
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
    
    ELJokerModel * model = self.dataArray[indexPath.row];
    return model.rowHeight;
}

- (void)changeType:(UIButton *)btn{
    
    _isPic = [btn.currentTitle isEqualToString:@"趣图"];
    btn.selected = YES;
    _selectedBtn.selected = NO;
    _selectedBtn = btn;
    if (!_isPic && self.textDataArray.count == 0) {
        [self loadData];
    }
    [self.tableView reloadData];
}

- (NSMutableArray *)dataArray{
    
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)picDataArray{
    if (_picDataArray == nil) {
        _picDataArray = [NSMutableArray array];
    }
    return _picDataArray;
}

- (NSMutableArray *)textDataArray{
    if (_textDataArray == nil) {
        _textDataArray = [NSMutableArray array];
    }
    return _textDataArray;
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

