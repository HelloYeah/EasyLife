//
//  ELWeiXinNewsListCell.m
//  EasyLife
//
//  Created by Sekorm on 16/10/8.
//  Copyright © 2016年 EL. All rights reserved.
//

#import "ELWeiXinNewsListCell.h"
#import "UIView+Layer.h"
#import "UIImageView+YYWebImage.h"
#import "ELWeiXinNewsModel.h"

#define kContentBgLeftAndRightSpace kLeftMargin * kScreenWidthRatio
#define kContentBgTopAndBottomSpace kLeftMargin * kScreenWidthRatio * 0.5
#define kInsetMargin 10 * kScreenWidthRatio

@interface ELWeiXinNewsListCell ()
@property (nonatomic,strong) UIView * bgView;
@property (nonatomic,strong) UIImageView * image_view;
@property (nonatomic,strong) UILabel * titleLabel;
@end

@implementation ELWeiXinNewsListCell

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
    self.titleLabel.font = kFont(14);
}

- (void)setNewsModel:(ELWeiXinNewsModel *)newsModel{
    
    _newsModel = newsModel;
    
    NSString * imageUrl = [newsModel.firstImg stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    [self.image_view  yy_setImageWithURL:[NSURL URLWithString:imageUrl] placeholder:[UIImage imageNamed:@"refreshjoke_loading_0"]];

    self.titleLabel.text = newsModel.title;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.bgView.frame = CGRectMake(kContentBgLeftAndRightSpace,
                                   kContentBgTopAndBottomSpace,
                                   kScreenWidth - 2 * kContentBgLeftAndRightSpace,
                                   self.height - 2 * kContentBgTopAndBottomSpace);
    
    self.titleLabel.frame = CGRectMake(kInsetMargin,
                                       kInsetMargin,
                                       self.bgView.width * 0.65,
                                       self.bgView.height - 2 * kInsetMargin);
    
    self.image_view.frame = CGRectMake(self.titleLabel.right + kInsetMargin,
                                       kInsetMargin,
                                       self.bgView.width - self.titleLabel.width - 3 * kInsetMargin,
                                       self.bgView.height - 2 * kInsetMargin);
}

@end
