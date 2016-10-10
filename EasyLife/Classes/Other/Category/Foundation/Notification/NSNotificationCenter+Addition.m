//
//  NSNotificationCenter+Addition.m
//  EasyLife
//
//  Created by LiangYe on 16/3/16.
//  Copyright © 2016年 Com.LiangYe. All rights reserved.
//

#import "NSNotificationCenter+Addition.h"

@implementation NSNotificationCenter (Addition)

+ (void)postNotification:(NSString *)notiname {
    [[NSNotificationCenter defaultCenter] postNotificationName:notiname object:nil];
}

+ (void)postNotification:(NSString *)notiname object:(id)object {
    if (object == nil) {
        [self postNotification:notiname];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:notiname object:object userInfo:nil];
    }
}

+ (void)removeAllObserverForObj:(id)obj {
    [[NSNotificationCenter defaultCenter] removeObserver:obj];
}

+ (void)addObserver:(id)observer action:(SEL)action name:(NSString *)name {
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:action name:name object:nil];
}

@end
