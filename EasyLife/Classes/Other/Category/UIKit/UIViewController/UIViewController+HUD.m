//
//  UIViewController+HUD.m
//  Floral
//
//  Created by Sekorm on 2017/3/24.
//  Copyright © 2017年 YL. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "UIViewController+HUD.h"
#import <objc/runtime.h>

@implementation UIViewController (HUD)

//定义关联的Key
static const char *key = "MBProgressHUD";
- (MBProgressHUD *)hud{
    
    return objc_getAssociatedObject(self, key);
}

- (void)setHud:(MBProgressHUD *)hud{
    objc_setAssociatedObject(self, key, hud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showIndicatorHint:(NSString *)hint {
    
    [self showIndicatorHint:hint yOffset:0];
}



- (void)showIndicatorHint:(NSString *)hint  yOffset:(CGFloat)yOffset {
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];;
    HUD.label.text = hint;
    if (yOffset) {
        HUD.offset = CGPointMake(0, yOffset);
    }
    [HUD showAnimated:YES];
    HUD.margin = 20.0;
    self.hud = HUD;
}

- (void)showHint:(NSString *)hint {
    [self showHint:hint duration:2.0 yOffset:0];
}


- (void)showHint:(NSString *)hint duration:(NSTimeInterval)timeInterval yOffset:(CGFloat)yOffset {

    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];;
    HUD.mode = MBProgressHUDModeText;
    HUD.label.text = hint;
    if (yOffset) {
        HUD.offset = CGPointMake(0, yOffset);
    }
    HUD.removeFromSuperViewOnHide = YES;
    [HUD showAnimated:YES];
    [HUD hideAnimated:YES afterDelay:timeInterval];

}

- (void)showHint:(UIView *)view  hint:(NSString *)hint duration:(NSTimeInterval)timeInterval yOffset:(CGFloat)yOffset {
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];;
    HUD.mode = MBProgressHUDModeText;
    HUD.label.text = hint;
    if (yOffset) {
        HUD.offset = CGPointMake(0, yOffset);
    }
    HUD.removeFromSuperViewOnHide = YES;
    [HUD showAnimated:YES];
    [HUD hideAnimated:YES afterDelay:timeInterval];
}

- (void)hideHud:(BOOL)animated {
    [self.hud hideAnimated:animated];
}
@end
