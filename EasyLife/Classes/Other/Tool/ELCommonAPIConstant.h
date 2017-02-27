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
/** 趣图*/
UIKIT_EXTERN NSString *const kELJokerPicListAPI;
/** 段子*/
UIKIT_EXTERN NSString *const kELJokerTextListAPI;

/** 星座运势*/
UIKIT_EXTERN NSString *const kELHoroscopeAPI;

/** 星座运势*/
UIKIT_EXTERN NSString *const kAliBabaAppKey;
@end
