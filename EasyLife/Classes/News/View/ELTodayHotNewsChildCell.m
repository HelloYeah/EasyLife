//
//  ELTodayHotNewsChildCell.m
//  EasyLife
//
//  Created by Sekorm on 16/10/9.
//  Copyright © 2016年 EL. All rights reserved.
//

#import "ELTodayHotNewsChildCell.h"
#import "UIView+Layer.h"
#import "UIImageView+YYWebImage.h"
#import "ELTodayHotNewsChildModel.h"

#define kContentBgLeftAndRightSpace kLeftMargin * kScreenWidthRatio
#define kContentBgTopAndBottomSpace kLeftMargin * kScreenWidthRatio * 0.5
#define kInsetMargin 10 * kScreenWidthRatio

@interface ELTodayHotNewsChildCell ()
@property (nonatomic,strong) UIView * bgView;
@property (nonatomic,strong) UIImageView * image_view;
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UILabel * timeLabel;
@property (nonatomic,strong) UILabel * souceLabel;
@end

@implementation ELTodayHotNewsChildCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews{
    
    self.bgView = [[UIView alloc]init];
    [self.contentView addSubview:self.bgView];
    self.bgView.backgroundColor = kBgColor;
    [self.bgView setLayerCornerRadius:6 * kScreenWidthRatio borderWidth:kLineHeight borderColor:kBgColor];
    
    self.image_view = [[UIImageView alloc]init];
    [self.bgView addSubview:self.image_view];
    self.image_view.contentMode = UIViewContentModeScaleToFill;
    self.image_view.clipsToBounds = YES;
    
    self.titleLabel = [[UILabel alloc]init];
    [self.bgView addSubview:self.titleLabel];
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.font = kFont(15);
    
    self.timeLabel = [[UILabel alloc]init];
    [self.bgView addSubview:self.timeLabel];
    self.timeLabel.font = kFont(12);
    self.timeLabel.textColor = kDarkGrayColor;
    
    self.souceLabel = [[UILabel alloc]init];
    [self.bgView addSubview:self.souceLabel];
    self.souceLabel.font = kFont(12);
    self.souceLabel.textColor = kDarkGrayColor;
}

- (void)setNewsModel:(ELTodayHotNewsChildModel *)newsModel{
    
    _newsModel = newsModel;
    
    NSString * imageUrl = [newsModel.thumbnail_pic_s stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    [self.image_view  yy_setImageWithURL:[NSURL URLWithString:imageUrl] placeholder:[UIImage imageNamed:@"refreshjoke_loading_0"]];
    
    self.titleLabel.text = newsModel.title;
    self.timeLabel.text = newsModel.date;
    self.souceLabel.text = [NSString stringWithFormat:@"来源:%@",newsModel.author_name];
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.bgView.frame = CGRectMake(kContentBgLeftAndRightSpace,
                                   kContentBgTopAndBottomSpace,
                                   kScreenWidth - 2 * kContentBgLeftAndRightSpace,
                                   self.height - 2 * kContentBgTopAndBottomSpace);
    
    CGSize titleLabelSize = [self.titleLabel sizeThatFits:CGSizeMake(self.bgView.width - 2 * kInsetMargin, CGFLOAT_MAX)];
    self.titleLabel.frame = CGRectMake(kInsetMargin,
                                       kInsetMargin,
                                       self.bgView.width - 2 * kInsetMargin,
                                       titleLabelSize.height);
    
    [self.timeLabel sizeToFit];
    self.timeLabel.frame = CGRectMake(kInsetMargin,
                                      self.titleLabel.bottom + 0.5 * kInsetMargin,
                                      self.timeLabel.width,
                                      self.timeLabel.height);
    [self.souceLabel sizeToFit];
    self.souceLabel.frame = CGRectMake(self.bgView.width - kInsetMargin - self.souceLabel.width,
                                      self.titleLabel.bottom + 0.5 * kInsetMargin,
                                      self.souceLabel.width,
                                      self.souceLabel.height);
    
    self.image_view.frame = CGRectMake(kInsetMargin,
                                       self.timeLabel.bottom + 0.5 * kInsetMargin,
                                       self.bgView.width - 2 * kInsetMargin,
                                       self.bgView.height - self.timeLabel.bottom - 2 * kInsetMargin);
}

@end
