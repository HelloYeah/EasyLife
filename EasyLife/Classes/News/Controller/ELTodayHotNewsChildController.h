//
//  ELTodayHotNewsChildController.h
//  EasyLife
//
//  Created by Sekorm on 16/10/9.
//  Copyright © 2016年 EL. All rights reserved.
//

#import "ELBaseViewController.h"

//类型,,top(头条，默认),shehui(社会),guonei(国内),guoji(国际),yule(娱乐),tiyu(体育)junshi(军事),keji(科技),caijing(财经),shishang(时尚)
@interface ELTodayHotNewsChildController : ELBaseViewController
@property (nonatomic,copy) NSString * newsType;
@end
