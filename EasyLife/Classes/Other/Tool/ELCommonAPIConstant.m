//
//  ELCommonAPIConstant.m
//  EasyLife
//
//  Created by Sekorm on 16/10/9.
//  Copyright © 2016年 EL. All rights reserved.
//

#import "ELCommonAPIConstant.h"

@implementation ELCommonAPIConstant

#pragma mark - READ / 阅读类
/** 微信精选*/
NSString *const kELWeiXinNewsListAPI = @"http://v.juhe.cn/weixin/query";
/** 今日资讯*/
NSString *const kELTodayHotNewsListAPI = @"http://v.juhe.cn/toutiao/index";
/** 趣图 */
NSString *const kELJokerPicListAPI = @"http://japi.juhe.cn/joke/img/list.from";
/** 段子 */
NSString *const kELJokerTextListAPI = @"http://japi.juhe.cn/joke/content/list.from";
/** 星座运势 */
NSString *const kELHoroscopeAPI = @"http://web.juhe.cn:8080/constellation/getAll";

@end
