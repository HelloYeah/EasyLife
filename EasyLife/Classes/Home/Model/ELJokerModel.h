//
//  ELJokerModel.h
//  EasyLife
//
//  Created by Sekorm on 16/10/9.
//  Copyright © 2016年 EL. All rights reserved.
//

#import "ELBaseModel.h"

@interface ELJokerModel : ELBaseModel
//"content":"你们是来搞笑的吗",
//"hashId":"190B25E454C75D24510C603FB08ADD95",
//"unixtime":1474171515,
//"updatetime":"2016-09-18 12:05:15",
//"url":"http://juheimg.oss-cn-hangzhou.aliyuncs.com/joke/201609/18/190B25E454C75D24510C603FB08ADD95.gif"
@property (nonatomic,copy) NSString * content;
@property (nonatomic,copy) NSString * hashId;
@property (nonatomic,copy) NSString * unixtime;
@property (nonatomic,copy) NSString * updatetime;
@property (nonatomic,copy) NSString * url;
@end
