//
//  ELJokerModel.h
//  EasyLife
//
//  Created by Sekorm on 16/10/9.
//  Copyright © 2016年 EL. All rights reserved.
//

#import "ELBaseModel.h"

#define kContentBgLeftAndRightSpace kLeftMargin * kScreenWidthRatio
#define kContentBgTopAndBottomSpace kLeftMargin * kScreenWidthRatio * 0.5
#define kInsetMargin 10 * kScreenWidthRatio
#define kImageViewHeight 250 * kScreenWidthRatio
#define kLineSpace 6 * kScreenWidthRatio
@interface ELJokerModel : ELBaseModel
@property (nonatomic,copy) NSString * content;
@property (nonatomic,copy) NSString * hashId;
@property (nonatomic,copy) NSString * unixtime;
@property (nonatomic,copy) NSString * updatetime;
@property (nonatomic,copy) NSString * url;
@property (nonatomic,assign) CGFloat  rowHeight;
@end
