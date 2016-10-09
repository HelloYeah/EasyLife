//
//  ELTodayHotNewsChildModel.h
//  EasyLife
//
//  Created by Sekorm on 16/10/9.
//  Copyright © 2016年 EL. All rights reserved.
//

#import "ELBaseModel.h"
//"title":"为你写好了“草莓鼻”攻略大全 忍心不看吗",
//"date":"2016-10-09 10:47",
//"category":"时尚",
//"author_name":"北方网",
//"thumbnail_pic_s":"http:\/\/03.imgmini.eastday.com\/mobile\/20161009\/20161009104712_f61510609082120d51641dc79abe7d16_1_mwpm_03200403.jpeg",
//"url":"http:\/\/mini.eastday.com\/mobile\/161009104712902.html?qid=juheshuju",
//"thumbnail_pic_s03":"http:\/\/03.imgmini.eastday.com\/mobile\/20161009\/20161009104712_f61510609082120d51641dc79abe7d16_1_mwpl_05500201.jpeg"
@interface ELTodayHotNewsChildModel : ELBaseModel
@property (nonatomic,copy) NSString * title;
@property (nonatomic,copy) NSString * date;
@property (nonatomic,copy) NSString * category;
@property (nonatomic,copy) NSString * author_name;
@property (nonatomic,copy) NSString * thumbnail_pic_s;
@property (nonatomic,copy) NSString * url;
@property (nonatomic,copy) NSString * thumbnail_pic_s03;
@end
