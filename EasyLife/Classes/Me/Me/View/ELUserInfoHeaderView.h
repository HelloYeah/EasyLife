//
//  SKUserInfoHeaderView.h
//  Sinfo
//
//  Created by Sekorm on 16/4/8.
//  Copyright © 2016年 yeliang. All rights reserved.
//


#import <UIKit/UIKit.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH_RATIO (SCREEN_WIDTH / 320)
#define kHeaderViewHeight 210 * SCREEN_WIDTH_RATIO
@interface ELUserInfoHeaderView : UIView

@property (nonatomic,assign) BOOL updateUserInfo;

@property (nonatomic,copy) void(^checkUserInfomationBlock)();

- (void)alphaWithHeight:(CGFloat)height orignHeight:(CGFloat)orignHeight;

@end
