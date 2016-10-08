//
//  NSDictionary+Addition.m
//  NeiHan
//
//  Created by Charles on 16/9/1.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NSDictionary+Addition.h"

@implementation NSDictionary (Addition)
- (void)propertyCode {
    
    // 属性跟字典的key一一对应
    NSMutableString *codes = [NSMutableString string];
    // 遍历字典中所有key取出来
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        // key:属性名
        NSString *code;
        if ([obj isKindOfClass:[NSString class]]) {
            code = [NSString stringWithFormat:@"@property (nonatomic, copy) NSString *%@;",key];
        }else if ([obj isKindOfClass:NSClassFromString(@"__NSCFBoolean")]){
            code = [NSString stringWithFormat:@"@property (nonatomic, assign) BOOL %@;",key];
        }else if ([obj isKindOfClass:[NSNumber class]]){
            code = [NSString stringWithFormat:@"@property (nonatomic, assign) NSInteger %@;",key];
        }else if ([obj isKindOfClass:[NSArray class]]){
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSArray *%@;",key];
            NSLog(@"----%@列表", key);
            for (NSDictionary *dict in obj) {
                if ([dict isKindOfClass:[NSDictionary class]]) {
                    [dict propertyCode];
                }
            }NSLog(@"----%@列表", key);
        }else if ([obj isKindOfClass:[NSDictionary class]]){
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSDictionary *%@;",key];
            [(NSDictionary *)obj propertyCode];
        }
        [codes appendFormat:@"%@\n",code];
        
    }];
    NSLog(@"%@", codes);
}
@end
