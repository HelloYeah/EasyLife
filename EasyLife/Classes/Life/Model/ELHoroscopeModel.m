//
//  ELHoroscopeModel.m
//  EasyLife
//
//  Created by Sekorm on 16/10/11.
//  Copyright © 2016年 EL. All rights reserved.
//

#import "ELHoroscopeModel.h"
@implementation ELHoroscopeModel

- (void)setWeekth:(NSString *)weekth{
    _weekth = weekth;
    self.horoscopeLeavel = ELHoroscopeWeekLeavel;
}

- (void)setMonth:(NSString *)month{
    _month = month;
    self.horoscopeLeavel = ELHoroscopeMonthLeavel;
}

- (void)setYear:(NSString *)year{
    _year = year;
    self.horoscopeLeavel = ELHoroscopeYearLeavel;
}

@end
