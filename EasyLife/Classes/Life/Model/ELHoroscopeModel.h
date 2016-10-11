//
//  ELHoroscopeModel.h
//  EasyLife
//
//  Created by Sekorm on 16/10/11.
//  Copyright © 2016年 EL. All rights reserved.
//

#import "ELBaseModel.h"

typedef enum : NSUInteger {
    ELHoroscopeDayLeavel,
    ELHoroscopeWeekLeavel,
    ELHoroscopeMonthLeavel,
    ELHoroscopeYearLeavel
} ELHoroscopeLeavel;

@interface ELHoroscopeModel : ELBaseModel

@property (nonatomic,assign) ELHoroscopeLeavel  horoscopeLeavel;


#pragma mark - day leavel
@property (nonatomic,copy) NSString * date;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * datetime;
@property (nonatomic,copy) NSString * all;
@property (nonatomic,copy) NSString * color;
@property (nonatomic,copy) NSString * health;
@property (nonatomic,copy) NSString * love;
@property (nonatomic,copy) NSString * money;
@property (nonatomic,copy) NSString * number;
@property (nonatomic,copy) NSString * QFriend;
@property (nonatomic,copy) NSString * summary;
@property (nonatomic,copy) NSString * work;

#pragma mark - week leavel
@property (nonatomic,copy) NSString * job;
@property (nonatomic,copy) NSString * weekth;
#pragma mark - month leavel
@property (nonatomic,copy) NSString * month;
#pragma mark - year leavel
@property (nonatomic,strong) NSDictionary * mima;
@property (nonatomic,copy) NSString * career;
@property (nonatomic,copy) NSString * finance;
@property (nonatomic,copy) NSString * luckyStone;
@property (nonatomic,copy) NSString * year;
@end
