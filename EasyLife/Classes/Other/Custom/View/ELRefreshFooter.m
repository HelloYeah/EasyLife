//
//  ELRefreshFooter.m
//  EasyLife
//
//  Created by LiangYe on 16/9/8.
//  Copyright © 2016年 LiangYe. All rights reserved.
//

#import "ELRefreshFooter.h"

@implementation ELRefreshFooter
//
//- (void)willMoveToSuperview:(UIView *)newSuperview {
//    [super willMoveToSuperview:newSuperview];
//    
//    if (newSuperview) {
//        // 监听scrollView数据的变化
//        if ([self.scrollView isKindOfClass:[UITableView class]] || [self.scrollView isKindOfClass:[UICollectionView class]]) {
//            [self.scrollView setMj_reloadDataBlock:^(NSInteger totalDataCount) {
//                if (self.isAutomaticallyHidden) {
//                    self.hidden = (totalDataCount < 10);
//                }
//            }];
//        }
//    }
//}
////
////#pragma mark - 实现父类的方法
////// 来实现 上拉自动加载
////- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
////    [super scrollViewContentOffsetDidChange:change];
////    
////    // 如果正在刷新，直接返回
////    if (self.state == MJRefreshStateRefreshing || self.state == MJRefreshStateNoMoreData) return;
////    
////    _scrollViewOriginalInset = self.scrollView.contentInset;
////    
////    // 当前的contentOffset
////    CGFloat currentOffsetY = self.scrollView.mj_offsetY;
////    // 尾部控件刚好出现的offsetY
////    CGFloat happenOffsetY = [self happenOffsetY];
////    // 如果是向下滚动到看不见尾部控件，直接返回
////    if (currentOffsetY <= happenOffsetY) return;
////    
////    CGFloat pullingPercent = (currentOffsetY - happenOffsetY) / self.mj_h;
////    if (self.scrollView.isDragging) {
////        self.pullingPercent = pullingPercent;
////#pragma mark - 下面注释掉得是MJ原来的代码
////        // 普通 和 即将刷新 的临界点
////        //        CGFloat normal2pullingOffsetY = happenOffsetY + self.mj_h;
////        [self beginRefreshing];
////        //        if (self.state == MJRefreshStateIdle && currentOffsetY > normal2pullingOffsetY) {
////        //            // 转为即将刷新状态
////        //            self.state = MJRefreshStatePulling;
////        //        } else if (self.state == MJRefreshStatePulling && currentOffsetY <= normal2pullingOffsetY) {
////        //            // 转为普通状态
////        //            self.state = MJRefreshStateIdle;
////        //        }
////    } else if (self.state == MJRefreshStatePulling) {// 即将刷新 && 手松开
////        // 开始刷新
////        [self beginRefreshing];
////    } else if (pullingPercent < 1) {
////        self.pullingPercent = pullingPercent;
////    }
////}
////
////#pragma mark 刚好看到上拉刷新控件时的contentOffset.y
////- (CGFloat)happenOffsetY {
////    CGFloat deltaH = [self heightForContentBreakView];
////    if (deltaH > 0) {
////        return deltaH - self.scrollViewOriginalInset.top;
////    } else {
////        return - self.scrollViewOriginalInset.top;
////    }
////}
//// 
////#pragma mark 获得scrollView的内容 超出 view 的高度
////- (CGFloat)heightForContentBreakView {
////    CGFloat h = self.scrollView.frame.size.height - self.scrollViewOriginalInset.bottom - self.scrollViewOriginalInset.top;
////    return self.scrollView.contentSize.height - h;
////}
//
//- (NSInteger)totalDataCountInScrollView {
//    NSInteger totalCount = 0;
//    if ([self.scrollView isKindOfClass:[UITableView class]]) {
//        UITableView *tableView = (UITableView *)self.scrollView;
//        
//        for (NSInteger section = 0; section<tableView.numberOfSections; section++) {
//            totalCount += [tableView numberOfRowsInSection:section];
//        }
//    } else if ([self.scrollView isKindOfClass:[UICollectionView class]]) {
//        UICollectionView *collectionView = (UICollectionView *)self.scrollView;
//        
//        for (NSInteger section = 0; section<collectionView.numberOfSections; section++) {
//            totalCount += [collectionView numberOfItemsInSection:section];
//        }
//    }
//    return totalCount;
//}
@end
