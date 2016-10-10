//
//  NSAttributedString+Size.h
//  
//
//  Created by LiangYe on 16/8/30.
//  Copyright © 2016年 Com.LiangYe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSAttributedString (Size)

/**
 *  根据约束的宽度来求NSAttributedString的高度 
 */
- (CGFloat)heightWithConstrainedWidth:(CGFloat)width ; 

@end
