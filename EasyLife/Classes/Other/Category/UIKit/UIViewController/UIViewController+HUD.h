//
//  UIViewController+HUD.h
//  Floral
//
//  Created by Sekorm on 2017/3/24.
//  Copyright © 2017年 YL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (HUD)

@property (nonatomic,strong) MBProgressHUD *hud;

- (void)hideHud:(BOOL)animated;
/**
     显示提示信息(有菊花, 一直显示, 不消失)
     
     - parameter view:    显示在哪个View上
     - parameter hint:    提示信息
     - parameter yOffset: y上的偏移量
 */
- (void)showIndicatorHint:(NSString *)hint yOffset:(CGFloat)yOffset;

/**
 显示提示信息(有菊花, 一直显示, 不消失)
 
 - parameter view:    显示在哪个View上
 - parameter hint:    提示信息

 */
- (void)showIndicatorHint:(NSString *)hint;

- (void)showHint:(NSString *)hint;

/**
     显示纯文字提示信息(显示在keywindow上)
     
     - parameter hint: 提示信息
     - parameter duration: 持续时间(不填的话, 默认两秒)
     - parameter yOffset: y上的偏移量
 */
- (void)showHint:(NSString *)hint duration:(NSTimeInterval)timeInterval yOffset:(CGFloat)yOffset;

/**
     显示纯文字提示信息
     
     - parameter hint: 显示在哪个View上
     - parameter hint: 提示信息
     - parameter duration: 持续时间(不填的话, 默认两秒)
     - parameter yOffset: y上的偏移量
 */
- (void)showHint:(UIView *)view  hint:(NSString *)hint duration:(NSTimeInterval)timeInterval yOffset:(CGFloat)yOffset;
@end
