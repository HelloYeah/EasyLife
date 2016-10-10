//
//  NSString+Addition.m
//  EasyLife
//
//  Created by LiangYe on 16/9/1.
//  Copyright © 2016年 LiangYe. All rights reserved.
//

#import "NSString+Addition.h"

@implementation NSString (Addition)
 

- (NSString *)convertTimesTampWithDateFormat:(NSString *)dateFormat {
    //    @"yyyy-MM-dd HH:mm"
    if (dateFormat.length == 0) {
        return @"";
    }
    NSTimeInterval timeInterval = [self doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSString *timeStr = [ELUtils datestrFromDate:date withDateFormat:dateFormat];
    return timeStr;
}

- (NSString *)contractionsImageViewUrl {
    CGFloat width = kScreenWidth - 2 * kLeftMargin;
    CGFloat height = width * 9 / 16.0f;
    NSString *string = [NSString stringWithFormat:@"?imageView2/2/w/%.0f/h/%.0f/q/85/jpg", width,height];
    NSString *newstring = [self stringByAppendingString:string];
    return newstring;
}

- (NSString *)noWhiteSpaceString {
    NSString *newString = self;
//    newString = [newString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    newString = [newString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    newString = [newString stringByReplacingOccurrencesOfString:@"\n" withString:@""]; 
    newString = [newString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符使用
    newString = [newString stringByReplacingOccurrencesOfString:@" " withString:@""];
//    可以去掉空格，注意此时生成的strUrl是autorelease属性的，所以不必对strUrl进行release操作！
//    newString = [newString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return newString;
}

- (CGSize)sizeWithText:(UIFont *)font maxW:(CGFloat)maxW{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = font;
    CGSize maxsize = CGSizeMake(maxW, MAXFLOAT);
    return  [self boundingRectWithSize:maxsize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
}

//- (NSString *)convertTimesTampWithDateFormat:(NSString *)dateFormat {
////    @"yyyy-MM-dd HH:mm"
//    if ([SRFUtil isBlankString:dateFormat]) return nil;
//    NSTimeInterval timeInterval = [self doubleValue];
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
//    NSString *timeStr = [SRFUtil datestrFromDate:date withDateFormat:dateFormat];
//    return timeStr;
//}

- (CGSize)sizeWithText:(UIFont *)font{
    
    return [self sizeWithText:font maxW:MAXFLOAT];
}

- (NSInteger)fileSize
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    // 判断是否为文件
    BOOL dir = NO;
    BOOL exists = [mgr fileExistsAtPath:self isDirectory:&dir];
    // 文件\文件夹不存在
    if (exists == NO) return 0;
    
    if (dir) { // self是一个文件夹
        // 遍历caches里面的所有内容 --- 直接和间接内容
        NSArray *subpaths = [mgr subpathsAtPath:self];
        NSInteger totalByteSize = 0;
        for (NSString *subpath in subpaths) {
            // 获得全路径
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            // 判断是否为文件
            BOOL dir = NO;
            [mgr fileExistsAtPath:fullSubpath isDirectory:&dir];
            if (dir == NO) { // 文件
                totalByteSize += [[mgr attributesOfItemAtPath:fullSubpath error:nil][NSFileSize] integerValue];
            }
        }
        return totalByteSize;
    } else { // self是一个文件
        return [[mgr attributesOfItemAtPath:self error:nil][NSFileSize] integerValue];
    }
}


- (BOOL)isPhoneNumber {
    // 1.全部是数字
    // 2.11位
    // 3.以13\15\18\17开头
    return [self match:@"^1[3578]\\d{9}$"];
    // JavaScript的正则表达式:\^1[3578]\\d{9}$\
    
}

/**
 *  邮箱地址是否合法
 */
-(BOOL)isEmailWithString:(NSString *)str{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:str];
}

- (BOOL)match:(NSString *)pattern { //创建正则表达式
    // 1.创建正则表达式
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    // 2.测试字符串
    NSArray *results = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
    return results.count > 0;
}

// 判断国际手机号
- (BOOL)isGloabelNumberWithString:(NSString *)str {
    NSString *emailRegex = @"^\\d{6,12}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:str];
    
}


// 判断手机号
- (BOOL)isValidateMobile:(NSString *)mobileNum {
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[0235-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else {
        return NO;
    }
}
/**
 返回处理过的字符串，只保留小数点后两位，结尾0省略
 */
- (instancetype)dealedPriceString{
    
    NSString * curren = self;
    //    //如果有0.00就替换
    //    self.current_price.text = [curren stringByReplacingOccurrencesOfString:@"0.00" withString:@""];
    
    //截取字符串只显示0.92两位数值，结尾如果是0也给去掉
    //1，找到.的位置
    NSUInteger location =  [curren rangeOfString:@"."].location;
    if (location != NSNotFound) { //.找到了
        NSUInteger leng = curren.length - location - 1;
        if (leng > 2) {//说明字符串大于2就截取，截取到字符串.后面的位置
            curren = [curren substringToIndex:location + 3];
            if ([curren hasSuffix:@"0"]) { //后面如果以0结尾
                
                curren = [curren substringToIndex:curren.length -1];
                
            }
            
            
        }
        
    }
    
    
    
    return  curren;
}

/**
 * 判断中文和英文字符串的长度
 */
- (int)convertToInt:(NSString*)strtemp{
    
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return (strlength+1)/2;
    
}
@end
