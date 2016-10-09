//
//  ELCommonAPIConstant.h
//  EasyLife
//
//  Created by Sekorm on 16/10/9.
//  Copyright © 2016年 EL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELCommonAPIConstant : NSObject
#pragma mark - HOME / 首页

UIKIT_EXTERN NSString *const kNHHomeServiceListAPI;

#pragma mark - READ / 阅读类

/** 微信精选*/
UIKIT_EXTERN NSString *const kELWeiXinNewsListAPI;
/** 今日资讯*/
UIKIT_EXTERN NSString *const kELTodayHotNewsListAPI;


#pragma mark - PUBLISH / 发布
/** 内涵用户发布动态可选择的热吧列表*/
UIKIT_EXTERN NSString *const kNHUserPublishSelectDraftListAPI;


#pragma mark - USER / 用户
/** 内涵用户个人信息*/
UIKIT_EXTERN NSString *const kNHUserProfileInfoAPI;

#pragma mark - CHECK / 审核
/** 内涵审核的动态列表*/
UIKIT_EXTERN NSString *const kNHCheckDynamicListAPI;
@end
