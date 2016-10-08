//
//  MBProgressHUD+NHAddition.m
//  NeiHan
//
//  Created by Charles on 16/9/11.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "MBProgressHUD+NHAddition.h"

@implementation MBProgressHUD (NHAddition)

#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:0.7];
}

- (void)startAnimation:(UIView *)img {
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotationAnimation.toValue =  @(M_PI * 2.0);
    rotationAnimation.duration = 0.5;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 100000;
    [img.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view {
    [self show:error icon:@"error.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view {
    [self show:success icon:@"success.png" view:view];
}

#pragma mark 显示信息

+ (void)showLoading:(UIView *)view {
    [self showLoading:nil toView:view];
}

+ (void)showLoading:(NSString *)text toView:(UIView *)view {
    
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    if (text.length == 0) {
        text = @"Loading";
    }
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    // Set the label text.
    hud.labelText = text;
    hud.color = [UIColor colorWithRed:0.41f green:0.46f blue:0.50f alpha:0.600f];
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:15];
    
}

+ (void)showMessage:(NSString *)message {
    [self showMessage:message toView:nil];
}
#pragma mark 显示一些信息
+ (void)showMessage:(NSString *)message toView:(UIView *)view {
    
    if (message.length == 0) return;
    
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    hud.mode = MBProgressHUDModeText;
    hud.margin = 10.f;
    // 设置hub颜色
    hud.color = [UIColor colorWithRed:0.41f green:0.46f blue:0.50f alpha:0.600f];
    hud.cornerRadius = 5.0f;
    // 设置边框颜色
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1.3秒之后再消失
    [hud hide:YES afterDelay:2.0f];
}

+ (void)showMessage:(NSString *)message detailMessage:(NSString*)detailMessage toView:(UIView *)view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    hud.detailsLabelText = detailMessage;
    hud.mode = MBProgressHUDModeText;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:1.8];
    
}

+ (void)hideAllHUDsInView:(UIView *)view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
}
@end
