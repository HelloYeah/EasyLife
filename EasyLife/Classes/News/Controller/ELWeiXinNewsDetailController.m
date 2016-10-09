//
//  ELWeiXinNewsDetailController.m
//  EasyLife
//
//  Created by Sekorm on 16/10/8.
//  Copyright © 2016年 EL. All rights reserved.
//

#import "ELWeiXinNewsDetailController.h"
#import <WebKit/WebKit.h>

@interface ELWeiXinNewsDetailController ()<WKNavigationDelegate>
@property (nonatomic,strong) WKWebView * webView;
@end

@implementation ELWeiXinNewsDetailController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    [self showLoadingAnimation];
    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0,
                                                              0,
                                                              kScreenWidth,
                                                              kScreenHeight - kNavigationBarHeight - kStatusBarHeight)];
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
    [self loadUrl];
    
}
//请求加载网页
- (void)loadUrl{
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.linkUrl]
                                                  cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                              timeoutInterval:10];
    
    [self.webView loadRequest:request];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    [self hideLoadingAnimation];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    [MBProgressHUD showMessage:error.domain];
}
@end
