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
#import "YYAnimatedImageView.h"
#import "ELJokerModel.h"
#import <WebKit/WebKit.h>
#import "UIImage+Addition.h"

@interface ELJokerCell ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIView * bgView;
@property (nonatomic,strong) YYAnimatedImageView * image_view;
@property (nonatomic,strong) WKWebView * webView;
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UILabel * timeLabel;
@property (nonatomic,strong) UIScrollView  * cover;
@property (nonatomic,strong) UIImage * targetImage;
@property (nonatomic,weak) UIImageView * scaleImageView;
@property (nonatomic,strong) UILabel * bigImageTipLabel;
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
    
    self.image_view = [[YYAnimatedImageView alloc]init];
    [self.bgView addSubview:self.image_view];
    self.image_view.contentMode = UIViewContentModeTop;
    self.image_view.clipsToBounds = YES;
    [self.image_view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bigImageClick)]];
    
    _bigImageTipLabel = [[UILabel alloc]init];
    _bigImageTipLabel.font = kFont(16);
    _bigImageTipLabel.text = @"点击查看原图";
    [_bigImageTipLabel sizeToFit];
    _bigImageTipLabel.height = self.bigImageTipLabel.height + kInsetMargin;
    _bigImageTipLabel.textAlignment = NSTextAlignmentCenter;
    _bigImageTipLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    _bigImageTipLabel.textColor = kWhiteColor;
    [self.bgView addSubview:_bigImageTipLabel];
    
    
    self.webView = [[WKWebView alloc]init];
    self.webView.scrollView.scrollEnabled = NO;
    [self.bgView addSubview:self.webView];

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

- (void)bigImageClick{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.cover];
}

- (void)closeBigImageClick{
    [_cover removeFromSuperview];
    _cover = nil;
}

- (UIScrollView *)cover{
    
    if (_cover == nil) {
        
        _cover = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                                0,
                                                                kScreenWidth,
                                                                kScreenHeight)];
        
        UIImageView * imageView = [[UIImageView alloc]initWithImage:self.targetImage];
        [_cover addSubview:imageView];
        imageView.left = (kScreenWidth - self.targetImage.size.width) * 0.5;
        if (self.targetImage.size.height > kScreenHeight) {
            imageView.top = kStatusBarHeight;
        }else{
            imageView.center = _cover.center;
        }
        _scaleImageView = imageView;
        
        _cover.contentSize = self.targetImage.size;
        _cover.contentInset = UIEdgeInsetsMake(kLeftMargin,
                                               kLeftMargin * 2,
                                               kLeftMargin * 2,
                                               kLeftMargin);
        _cover.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
        [_cover addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeBigImageClick)]];
        
        _cover.delegate = self;
        _cover.minimumZoomScale = 0.2f;
        _cover.maximumZoomScale = 2.0f;
    }
    return _cover;
}

#pragma mark 缩放

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.scaleImageView;
}

//实现图片在缩放过程中居中
- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?(scrollView.bounds.size.width - scrollView.contentSize.width)/2 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?(scrollView.bounds.size.height - scrollView.contentSize.height)/2 : 0.0;
    self.scaleImageView.center = CGPointMake(scrollView.contentSize.width/2 + offsetX,scrollView.contentSize.height/2 + offsetY);
}



- (void)setJokerModel:(ELJokerModel *)jokerModel{
    
    _jokerModel = jokerModel;
    
    self.titleLabel.text = jokerModel.content;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.titleLabel.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:kLineSpace];//调整行间距
    [paragraphStyle setLineBreakMode:NSLineBreakByCharWrapping];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.titleLabel.text length])];
    self.titleLabel.attributedText = attributedString;
  
    self.timeLabel.text = jokerModel.updatetime;
    [self.timeLabel sizeToFit];
    
    NSString * imageUrl = [jokerModel.url stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
    self.bigImageTipLabel.hidden = YES;
    
    if ([[imageUrl substringFromIndex:imageUrl.length - 3] isEqualToString:@"gif"]) {
        
        self.image_view.hidden = YES;
        self.webView.hidden = NO;
        NSURL * url = [NSURL URLWithString:imageUrl];
        NSURLRequest * request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
        
//        [self.image_view yy_setImageWithURL:[NSURL URLWithString:imageUrl] placeholder:[UIImage imageNamed:@"refreshjoke_loading_0"] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//
//        } transform:nil completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
//
//        }];

    }else{
        
        self.webView.hidden = YES;
        self.image_view.hidden = NO;
        [self.image_view yy_setImageWithURL:[NSURL URLWithString:imageUrl]
                                placeholder:[UIImage imageNamed:@"refreshjoke_loading_0"]
                                    options:YYWebImageOptionShowNetworkActivity
                                 completion:^(UIImage * _Nullable image,
                                              NSURL * _Nonnull url,
                                              YYWebImageFromType from,
                                              YYWebImageStage stage,
                                              NSError * _Nullable error) {
            
            CGFloat imageViewW = kScreenWidth - 2 * kContentBgLeftAndRightSpace - 2 * kInsetMargin;
            CGFloat imageViewH = kImageViewHeight;
            CGSize orginSize = image.size;
            CGFloat scale  = MIN(imageViewW / orginSize.width, imageViewH / orginSize.height);
            CGFloat targetWidth = scale > 1 ? scale * image.size.width : imageViewW;
            self.targetImage = scale < 1 ? image : nil;
            self.bigImageTipLabel.hidden = scale > 1;
            self.image_view.userInteractionEnabled = scale < 1;
            self.image_view.image = [image sourceImage:image targetWidth:targetWidth];
            self.image_view.contentMode = UIViewContentModeTop;
        }];
    }

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
    
    
    self.timeLabel.frame = CGRectMake(self.bgView.width - kInsetMargin - self.timeLabel.width,
                                      self.titleLabel.bottom + 0.5 * kInsetMargin,
                                      self.timeLabel.width,
                                      self.timeLabel.height);

    if (self.webView.hidden == NO) {
        self.webView.frame = CGRectMake(kInsetMargin,
                                        self.timeLabel.bottom + 0.5 * kInsetMargin,
                                        self.bgView.width - 2 * kInsetMargin,
                                        self.bgView.height - self.timeLabel.bottom - 2 * kInsetMargin);
        
        return;
    }
    
    if (_jokerModel.url.length > 0) {
 
        self.image_view.frame = CGRectMake(kInsetMargin,
                                           self.timeLabel.bottom + 0.5 * kInsetMargin,
                                           self.bgView.width - 2 * kInsetMargin,
                                           self.bgView.height - self.timeLabel.bottom - 2 * kInsetMargin);
        self.bigImageTipLabel.width = self.image_view.width;
        self.bigImageTipLabel.left = self.image_view.left;
        self.bigImageTipLabel.bottom = self.image_view.bottom;
    }else{
        self.image_view.hidden = YES;
    }
    
}

@end
