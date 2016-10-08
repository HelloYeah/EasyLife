//
//  ELCustomNoNetworkEmptyView.h
//  EasyLife
//
//  Created by Sekorm on 16/10/8.
//  Copyright © 2016年 EL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELCustomNoNetworkEmptyView : UIView
/** 没有网络，重试*/
@property (nonatomic, copy) void(^customNoNetworkEmptyViewDidClickRetryHandle)(ELCustomNoNetworkEmptyView *view);
@end
