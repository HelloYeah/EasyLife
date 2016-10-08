//
//  UILabel+Addition.m
//  NeiHan
//
//  Created by Charles on 16/4/26.
//  Copyright © 2016年 Com.Charles. All rights reserved.
//

#import "UILabel+Addition.h"

@implementation UILabel (Addition)

- (instancetype)initWithFont:(UIFont *)font
                   textColor:(UIColor *)textColor
               textAlignment:(NSTextAlignment)textAlignment {
    if (self = [super init]) {
        self.font = font;
        self.textAlignment = textAlignment ? textAlignment : NSTextAlignmentLeft;
        self.textColor = textColor;
    }
    return self;
}

+ (instancetype)labelWithFont:(UIFont *)font
                    textColor:(UIColor *)textColor
                textAlignment:(NSTextAlignment)textAlignment {
    return [[UILabel alloc] initWithFont:font textColor:textColor textAlignment:textAlignment];
}
@end
