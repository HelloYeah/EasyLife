//
//  ELJokerModel.m
//  EasyLife
//
//  Created by Sekorm on 16/10/9.
//  Copyright © 2016年 EL. All rights reserved.
//

#import "ELJokerModel.h"

@implementation ELJokerModel

- (void)setContent:(NSString *)content{
    
    _content = content;
    
    CGFloat maxWidth = kScreenWidth - 2 * kContentBgLeftAndRightSpace - 2 * kInsetMargin;
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:kLineSpace];
    [paragraphStyle setLineBreakMode:NSLineBreakByCharWrapping];
    CGRect  titleRect = [_content boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX)
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:@{NSFontAttributeName:kFont(18),
                                                         NSParagraphStyleAttributeName:paragraphStyle}
                                               context:nil];
    _rowHeight += titleRect.size.height + kInsetMargin +  2 * kContentBgTopAndBottomSpace;
}

- (void)setUpdatetime:(NSString *)updatetime{
    
    _updatetime = updatetime;
    
    CGRect  timeRect = [_content boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:@{NSFontAttributeName:kFont(15)}
                                               context:nil];
    _rowHeight += timeRect.size.height + kInsetMargin ;
}


- (void)setUrl:(NSString *)url{
    _url = url;
    if (url.length > 0) {
        _rowHeight += kImageViewHeight  + kInsetMargin;
    }
}
@end
