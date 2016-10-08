//
//  MBProgressHUD+NHAddition.h
//  NeiHan
//
//  Created by Charles on 16/9/11.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (NHAddition)

+ (void)showError:(NSString *)error
           toView:(UIView *)view;

+ (void)showSuccess:(NSString *)success
             toView:(UIView *)view;
/**
 *  尽量都使用这个
 */
+ (void)showLoading:(UIView *)view;
+ (void)showLoading:(NSString *)text
             toView:(UIView *)view;

/**
 *  尽量都使用这个
 */
+ (void)showMessage:(NSString *)message;
+ (void)showMessage:(NSString *)message
             toView:(UIView *)view;

+ (void)showMessage:(NSString *)message
      detailMessage:(NSString*)detailMessage
             toView:(UIView *)view;

+ (void)hideAllHUDsInView:(UIView *)view;
@end
