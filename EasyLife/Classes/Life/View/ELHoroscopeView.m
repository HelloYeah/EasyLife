//
//  ELHoroscopeView.m
//  EasyLife
//
//  Created by Sekorm on 16/10/11.
//  Copyright © 2016年 EL. All rights reserved.
//

#import "ELHoroscopeView.h"
#import "ELHoroscopeModel.h"

@interface ELHoroscopeView ()

@property (nonatomic,strong) UIView * bgView;
@property (nonatomic,strong) UILabel * dateLabel;
@property (nonatomic,strong) UILabel * nameLabel;
@property (nonatomic,strong) UILabel * allLabel;
@property (nonatomic,strong) UILabel * colorLabel;
@property (nonatomic,strong) UILabel * healthLabel;
@property (nonatomic,strong) UILabel * loveLabel;
@property (nonatomic,strong) UILabel * moneyLabel;
@property (nonatomic,strong) UILabel * numberLabel;
@property (nonatomic,strong) UILabel * QFriendLabel;
@property (nonatomic,strong) UILabel * summaryLabel;
@property (nonatomic,strong) UILabel * workLabel;
@property (nonatomic,strong) UILabel * jobLabel;
@property (nonatomic,strong) UILabel * mimaLabel;
@property (nonatomic,strong) UILabel * careerLabel;
@property (nonatomic,strong) UILabel * financeLabel;
@property (nonatomic,strong) UILabel * luckyStoneLabel;
@end

@implementation ELHoroscopeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews{
    
    self.bgView = [[UIView  alloc]init];
    [self addSubview:self.bgView];
    
    self.dateLabel = [[UILabel alloc]init];
    [self.bgView addSubview:self.dateLabel];
    
    self.nameLabel = [[UILabel alloc]init];
    [self.bgView addSubview:self.nameLabel];
    
    self.allLabel = [[UILabel alloc]init];
    [self.bgView addSubview:self.allLabel];
    
    self.colorLabel = [[UILabel alloc]init];
    [self.bgView addSubview:self.colorLabel];
    
    self.healthLabel = [[UILabel alloc]init];
    [self.bgView addSubview:self.healthLabel];
    
    self.loveLabel = [[UILabel alloc]init];
    [self.bgView addSubview:self.loveLabel];
    
    self.moneyLabel = [[UILabel alloc]init];
    [self.bgView addSubview:self.moneyLabel];
    
    self.numberLabel = [[UILabel alloc]init];
    [self.bgView addSubview:self.numberLabel];
    
    self.QFriendLabel = [[UILabel alloc]init];
    [self.bgView addSubview:self.QFriendLabel];
    
    self.summaryLabel = [[UILabel alloc]init];
    [self.bgView addSubview:self.summaryLabel];
    
    self.workLabel = [[UILabel alloc]init];
    [self.bgView addSubview:self.workLabel];
    
    self.jobLabel = [[UILabel alloc]init];
    [self.bgView addSubview:self.jobLabel];
    
    self.mimaLabel = [[UILabel alloc]init];
    [self.bgView addSubview:self.mimaLabel];
    
    self.careerLabel = [[UILabel alloc]init];
    [self.bgView addSubview:self.careerLabel];
    
    self.financeLabel = [[UILabel alloc]init];
    [self.bgView addSubview:self.financeLabel];
    
    self.luckyStoneLabel = [[UILabel alloc]init];
    [self.bgView addSubview:self.luckyStoneLabel];
}

- (void)setHoroscopeModel:(ELHoroscopeModel *)horoscopeModel{
    
    _horoscopeModel = horoscopeModel;
    
}

@end
