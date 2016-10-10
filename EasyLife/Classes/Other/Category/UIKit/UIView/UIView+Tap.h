//
//  UIView+Tap.h
//  EasyLife
//
//  Created by LiangYe on 16/4/2.
//  Copyright © 2016年 Com.LiangYe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Tap)
/**
 *  动态添加手势 
 */
- (void)setTapActionWithBlock:(void (^)(void))block ;
@end
