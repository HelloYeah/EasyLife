//
//  SKUserInfoHeaderView.m
//  Sinfo
//
//  Created by Sekorm on 16/4/8.
//  Copyright © 2016年 yeliang. All rights reserved.
//

#import "ELUserInfoHeaderView.h"
#import "UIView+Frame.h"

#define SKUserInfoHeaderImageWidth (60 * kScreenWidthRatio)
#define SKUserInfoVipImageWidth (60 * kScreenWidthRatio)
#define SKUserInfoVipImageHeight (25 * kScreenWidthRatio)
#define SKUserInfoNameAndCompanyHeight (25 * kScreenWidthRatio)
static const NSInteger SKUserInfoSpace = 10;
@interface ELUserInfoHeaderView ()

/** 透明边框 */
@property (nonatomic, strong) UIView *HeaderBorderView;

/** 背景视图 */
@property (nonatomic, strong ) UIImageView *bgImgView;

/** vip标志图片 */
@property (nonatomic, strong) UIImageView *vipImgView;

/** 头像 */
@property (nonatomic, strong) UIImageView *headerImgView;
/** 名称 */
@property (nonatomic, strong) UILabel *nameLabel;
/** 公司 */
@property (nonatomic, strong) UILabel *companyLabel;

@end

@implementation ELUserInfoHeaderView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpSubviews];
        [self setUserInfoData];
    }
    return self;
}

#pragma mark  -  初始化设置

- (void)setUpSubviews
{
    self.bgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    self.bgImgView.image = [UIImage imageNamed:@"LOL"];
    self.clipsToBounds = YES;
    
    self.bgImgView.userInteractionEnabled = YES;
    [self addSubview:self.bgImgView];
    self.HeaderBorderView = [[UIView alloc]initWithFrame:CGRectMake((self.width - SKUserInfoHeaderImageWidth)/2 - SKUserInfoSpace / 2,
                                                                    (self.height - SKUserInfoHeaderImageWidth)/2 -SKUserInfoSpace / 2,
                                                                    SKUserInfoHeaderImageWidth + SKUserInfoSpace,
                                                                    SKUserInfoHeaderImageWidth + SKUserInfoSpace)];
    self.HeaderBorderView.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.3];
    self.HeaderBorderView.layer.cornerRadius = SKUserInfoHeaderImageWidth / 2 + SKUserInfoSpace / 2;
    self.HeaderBorderView.layer.masksToBounds = YES;
    [self addSubview:self.HeaderBorderView];
    self.headerImgView = [[UIImageView alloc]initWithFrame:CGRectMake((self.width - SKUserInfoHeaderImageWidth)/2,
                                                                      (self.height - SKUserInfoHeaderImageWidth)/2,
                                                                      SKUserInfoHeaderImageWidth,
                                                                      SKUserInfoHeaderImageWidth)];
    self.headerImgView.layer.cornerRadius = SKUserInfoHeaderImageWidth / 2;
    self.headerImgView.layer.masksToBounds = YES;
    [self addSubview:self.headerImgView];
    self.vipImgView = [[UIImageView alloc]initWithFrame:CGRectMake((self.width - SKUserInfoVipImageWidth)/2,
                                                                   self.headerImgView.top - SKUserInfoVipImageHeight,
                                                                   SKUserInfoVipImageWidth,
                                                                   SKUserInfoVipImageHeight)];
    [self addSubview:self.vipImgView];
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(SKUserInfoSpace,
                                                              self.headerImgView.bottom + SKUserInfoSpace,
                                                              kScreenWidth - 2 * SKUserInfoSpace,
                                                              SKUserInfoNameAndCompanyHeight)];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.font = [UIFont systemFontOfSize:16];
    self.nameLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.nameLabel];
    self.companyLabel = [[UILabel alloc]initWithFrame:CGRectMake(SKUserInfoSpace,
                                                                 self.nameLabel.bottom,
                                                                 kScreenWidth - 2 * SKUserInfoSpace,
                                                                 SKUserInfoNameAndCompanyHeight)];
    self.companyLabel.textAlignment = NSTextAlignmentCenter;
    self.companyLabel.font = [UIFont systemFontOfSize:14];
    self.companyLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.companyLabel];
    
    self.nameLabel.backgroundColor = [UIColor clearColor];
    self.headerImgView.userInteractionEnabled = YES;
    [self.headerImgView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(checkUserInfomation)]];
    
    self.nameLabel.userInteractionEnabled = YES;
    [self.nameLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(checkUserInfomation)]];
    
    self.companyLabel.userInteractionEnabled = YES;
    [self.companyLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(checkUserInfomation)]];
    
}

/**
 *  设置用户信息
 */
- (void)setUserInfoData{

    self.companyLabel.text = @"来自 星星的你";
    self.nameLabel.text = @"昵称: Hello World";
    self.vipImgView.image = [UIImage imageNamed:@"user_vip_crown"];
    self.headerImgView.image = [UIImage imageNamed:@"lion"];
    
}

#pragma mark - 监听事件
- (void)checkUserInfomation{
    if (self.checkUserInfomationBlock) {
        self.checkUserInfomationBlock();
    }
}

- (void)alphaWithHeight:(CGFloat)height orignHeight:(CGFloat)orignHeight{
    
    CGFloat offsetY = height - orignHeight;
    CGFloat alpha = (height - 64) / (orignHeight - 64);
    CGFloat scale = MAX(alpha, 1);
    self.frame = CGRectMake(0, 0, kScreenWidth, height);
    self.bgImgView.width =  kScreenWidth * scale;
    self.bgImgView.height = MAX(height * scale, orignHeight);
    self.bgImgView.center = CGPointMake(self.width * 0.5, self.height * 0.5);
    
    self.headerImgView.top = (orignHeight - SKUserInfoHeaderImageWidth)/2 + offsetY;
    self.HeaderBorderView.top = (orignHeight - SKUserInfoHeaderImageWidth)/2 - SKUserInfoSpace / 2 + offsetY;
    self.vipImgView.top = self.headerImgView.top - SKUserInfoVipImageHeight;
    self.nameLabel.top = self.headerImgView.bottom + SKUserInfoSpace;
    self.companyLabel.top = self.nameLabel.bottom;

    
    
    self.HeaderBorderView.alpha = alpha;
    self.headerImgView.alpha = alpha;
    self.nameLabel.alpha = alpha;
    self.companyLabel.alpha = alpha;
    self.vipImgView.alpha = alpha;
}

@end
