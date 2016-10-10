//
//  ELUserInfoManager.h
//  EasyLife
//
//  Created by LiangYe on 16/9/7.
//  Copyright © 2016年 LiangYe. All rights reserved.
//  用户信息管理类

#import <Foundation/Foundation.h>
#import "ELUserInfoModel.h"

@interface ELUserInfoManager : NSObject

+ (instancetype)sharedManager;

/**
 *  登录成功
 */
- (void)didLoginInWithUserInfo:(id)userInfo;

/**
 *  退出
 */
- (void)didLoginOut;

/**
 *  获取用户信息
 */
- (ELUserInfoModel *)currentUserInfo;

/**
 *  更新缓存中的用户信息
 */
- (void)resetUserInfoWithUserInfo:(ELUserInfoModel *)userInfo;

/**
 *  用来记录是否是登陆状态
 */
@property (nonatomic, assign) BOOL isLogin;

@end
