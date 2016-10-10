//
//  ELCommonConstant.h
//  EasyLife
//
//  Created by LiangYe on 16/9/7.
//  Copyright © 2016年 LiangYe. All rights reserved.
// 普通公共常量

#import <Foundation/Foundation.h>

@interface ELCommonConstant : NSObject

/** 当前纬度*/
UIKIT_EXTERN NSString *const kELUserCurrentLatitude;
/** 当前经度*/
UIKIT_EXTERN NSString *const kELUserCurrentLongitude;
/** 是否登陆*/
UIKIT_EXTERN NSString *const kELHasLoginFlag;
/** 网络请求成功*/
UIKIT_EXTERN NSString *const kELRequestSuccessNotification;
@end
