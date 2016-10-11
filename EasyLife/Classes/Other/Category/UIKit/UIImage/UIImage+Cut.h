//
//  UIImage+Cut.h
//  MeiJiaLove
//
//  Created by Wu.weibin on 13-5-17.
//  Copyright (c) 2013年 Wu.weibin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface UIImage (Cut)

- (UIImage *)clipImageWithScaleWithsize:(CGSize)asize; 

- (UIImage *)compressImage;

- (NSData *)compressImageData;

@end
