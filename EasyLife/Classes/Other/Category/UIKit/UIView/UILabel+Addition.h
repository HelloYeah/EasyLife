//
//  UILabel+Addition.h
//  EasyLife
//
//  Created by LiangYe on 16/4/26.
//  Copyright © 2016年 Com.LiangYe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Addition)

- (instancetype)initWithFont:(UIFont *)font
                   textColor:(UIColor *)textColor
                textAlignment:(NSTextAlignment)textAlignment;

+ (instancetype)labelWithFont:(UIFont *)font
               textColor:(UIColor *)textColor
           textAlignment:(NSTextAlignment)textAlignment;

@end
