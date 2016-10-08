//
//  ELUserInfoManager.m
//  NeiHan
//
//  Created by Charles on 16/9/7.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "ELUserInfoManager.h"
#import "ELUserInfoModel.h"
#import "ELFileCacheManager.h"

static ELUserInfoManager *_singleton = nil;
@implementation ELUserInfoManager

+ (instancetype)sharedManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singleton = [[ELUserInfoManager alloc] init];
    });
    return _singleton;
}

// 当前用户信息
- (ELUserInfoModel *)currentUserInfo {
    
    id obj = [ELFileCacheManager getObjectByFileName:NSStringFromClass([ELUserInfoModel class])];
    if (obj != nil) {
        return  obj;
    }
    return nil;
}

// 重置用户信息
- (void)resetUserInfoWithUserInfo:(ELUserInfoModel *)userInfo {
    [userInfo archive];
}

// 登陆
- (void)didLoginInWithUserInfo:(id)userInfo {
    
    ELUserInfoModel *userinfo = [ELUserInfoModel modelWithDictionary:userInfo];
    [userinfo archive];
    
    [ELFileCacheManager saveUserData:@YES forKey:kELHasLoginFlag];
}

// 退出登陆
- (void)didLoginOut {
    [ELFileCacheManager removeObjectByFileName:NSStringFromClass([ELUserInfoModel class])];
    
    [ELFileCacheManager saveUserData:@NO forKey:kELHasLoginFlag];
}

// 判断是否是登陆状态
- (BOOL)isLogin {
    return [[NSUserDefaults standardUserDefaults] boolForKey:kELHasLoginFlag];
}

@end
