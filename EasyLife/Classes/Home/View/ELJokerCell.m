//
//  ELJokerCell.m
//  EasyLife
//
//  Created by Sekorm on 16/10/9.
//  Copyright © 2016年 EL. All rights reserved.
//

#import "ELJokerCell.h"
#import "UIView+Layer.h"
#import "UIImageView+YYWebImage.h"
#import "ELJokerModel.h"


@interface ELJokerCell ()
@property (nonatomic,strong) UIView * bgView;
@property (nonatomic,strong) UIImageView * image_view;
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UILabel * timeLabel;
@end

@implementation ELJokerCell

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
    self.image_view.contentMode = UIViewContentModeTop;
    self.image_view.clipsToBounds = YES;
    
    self.titleLabel = [[UILabel alloc]init];
    [self.bgView addSubview:self.titleLabel];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.font = kFont(18);
    self.titleLabel.textColor = kTextColor;
    
    self.timeLabel = [[UILabel alloc]init];
    [self.bgView addSubview:self.timeLabel];
    self.timeLabel.font = kFont(12);
    self.timeLabel.textColor = kDetailTextColor;

}

- (void)setJokerModel:(ELJokerModel *)jokerModel{
    
    _jokerModel = jokerModel;
    
    NSString * imageUrl = [jokerModel.url stringByReplacingOccurrencesOfString:@"\\" withString:@""];
//    [self.image_view  yy_setImageWithURL:[NSURL URLWithString:imageUrl] placeholder:[UIImage imageNamed:@"refreshjoke_loading_0"]];
    [self.image_view yy_setImageWithURL:[NSURL URLWithString:imageUrl] placeholder:[UIImage imageNamed:@"refreshjoke_loading_0"] options:YYWebImageOptionShowNetworkActivity completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        self.image_view.image = image;
    }];
    
    self.titleLabel.text = jokerModel.content;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.titleLabel.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:kLineSpace];//调整行间距
    [paragraphStyle setLineBreakMode:NSLineBreakByCharWrapping];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.titleLabel.text length])];
    self.titleLabel.attributedText = attributedString;
  
    self.timeLabel.text = jokerModel.updatetime;
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
    self.timeLabel.frame = CGRectMake(self.bgView.width - kInsetMargin - self.timeLabel.width,
                                      self.titleLabel.bottom + 0.5 * kInsetMargin,
                                      self.timeLabel.width,
                                      self.timeLabel.height);

    if (_jokerModel.url.length > 0) {
        self.image_view.hidden = NO;
        self.image_view.frame = CGRectMake(kInsetMargin,
                                           self.timeLabel.bottom + 0.5 * kInsetMargin,
                                           self.bgView.width - 2 * kInsetMargin,
                                           self.bgView.height - self.timeLabel.bottom - 2 * kInsetMargin);
    }else{
        self.image_view.hidden = YES;
    }
}

@end
