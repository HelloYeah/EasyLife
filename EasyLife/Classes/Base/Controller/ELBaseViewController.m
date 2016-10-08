//
//  ELBaseViewController.m
//  EasyLife
//
//  Created by Sekorm on 16/10/8.
//  Copyright © 2016年 EL. All rights reserved.
//

#import "ELBaseViewController.h"
#import "ELCustomNoNetworkEmptyView.h"
#import "NSNotificationCenter+Addition.h"
#import "ELCustomLoadingAnimationView.h"
//#import "NHLocationManager.h"
#import "AFNetworkReachabilityManager.h"
#import "UIView+Tap.h"
#import "YYWebImageManager.h"
#import "YYDiskCache.h"
#import "YYMemoryCache.h"

@interface ELBaseViewController ()

@property (nonatomic, weak) ELCustomNoNetworkEmptyView *noNetworkEmptyView;
@property (nonatomic, weak) ELCustomLoadingAnimationView *animationView;
@end

@implementation ELBaseViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIView setAnimationsEnabled:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    //
    //    // 在自定义leftBarButtonItem后添加下面代码就可以完美解决返回手势无效的情况
    //    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
    //        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    //    }
    NSArray *gestureArray = self.navigationController.view.gestureRecognizers;
    //当是侧滑手势的时候设置scrollview需要此手势失效才生效即可
    for (UIGestureRecognizer *gesture in gestureArray) {
        if ([gesture isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
            
            for (UIView *sub in self.view.subviews) {
                if ([sub isKindOfClass:[UIScrollView class]]) {
                    UIScrollView *sc = (UIScrollView *)sub;
                    [sc.panGestureRecognizer requireGestureRecognizerToFail:gesture];
                }
            }
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [UIView setAnimationsEnabled:YES];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.view.backgroundColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.94f alpha:1.00f];
    
//    [NSNotificationCenter addObserver:self action:@selector(requestSuccessNotification) name:kNHRequestSuccessNotification];
}

- (void)requestSuccessNotification {
    [self hideLoadingAnimation];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)pop {
    if (self.navigationController == nil) return ;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)popToRootVc {
    if (self.navigationController == nil) return ;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)popToVc:(UIViewController *)vc {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    if (self.navigationController == nil) return ;
    [self.navigationController popToViewController:vc animated:YES];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dismissWithCompletion:(void(^)())completion {
    [self dismissViewControllerAnimated:YES completion:completion];
}

- (void)presentVc:(UIViewController *)vc {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    [self presentVc:vc completion:nil];
}

- (void)presentVc:(UIViewController *)vc completion:(void (^)(void))completion {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    [self presentViewController:vc animated:YES completion:completion];
}

- (void)pushVc:(UIViewController *)vc {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    if (self.navigationController == nil) return ;
    if (vc.hidesBottomBarWhenPushed == NO) {
        vc.hidesBottomBarWhenPushed = YES;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)removeChildVc:(UIViewController *)childVc {
    if ([childVc isKindOfClass:[UIViewController class]] == NO) {
        return ;
    }
    [childVc.view removeFromSuperview];
    [childVc willMoveToParentViewController:nil];
    [childVc removeFromParentViewController];
}

- (void)addChildVc:(UIViewController *)childVc {
    if ([childVc isKindOfClass:[UIViewController class]] == NO) {
        return ;
    }
    [childVc willMoveToParentViewController:self];
    [self addChildViewController:childVc];
    [self.view addSubview:childVc.view];
    childVc.view.frame = self.view.bounds;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (ELCustomNoNetworkEmptyView *)noNetworkEmptyView {
    if (!_noNetworkEmptyView) {
        ELCustomNoNetworkEmptyView *empty = [[ELCustomNoNetworkEmptyView alloc] init];
        [self.view addSubview:empty];
        _noNetworkEmptyView = empty;
        
        WeakSelf(weakSelf);
        [empty mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.view);
        }];
        empty.customNoNetworkEmptyViewDidClickRetryHandle = ^(ELCustomNoNetworkEmptyView *emptyView) {
            [weakSelf loadData];
            
        };
    }
    return _noNetworkEmptyView;
}

- (void)showLoadingAnimation {
    ELCustomLoadingAnimationView *animation = [[ELCustomLoadingAnimationView alloc] init];
    [animation showInView:self.view];
    _animationView = animation;
    [self.view bringSubviewToFront:animation];
}

- (void)hideLoadingAnimation {
    [_animationView dismiss];
    _animationView = nil;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.view bringSubviewToFront:self.animationView];
}

- (void)loadData {
    //    [self showLoadingAnimation];
    //
    //    // 网络不可用
    //    if ([AFNetworkReachabilityManager sharedManager].reachable == NO) {
    //
    //        [self hideLoadingAnimation];
    ////        self.noNetworkEmptyView.hidden = NO;
    //
    //    } else { // 网络可用
    //
    //
    //        [self.noNetworkEmptyView removeFromSuperview];
    //        _noNetworkEmptyView = nil;
    //
    //    }
}

- (BOOL)isNetworkReachable {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    [[[YYWebImageManager sharedManager] cache].diskCache removeAllObjects];
    [[[YYWebImageManager sharedManager] cache].memoryCache removeAllObjects];
}

@end
