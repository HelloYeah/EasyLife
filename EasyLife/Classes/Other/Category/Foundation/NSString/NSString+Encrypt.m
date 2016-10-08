//
//  NSString+Encrypt.m
//
//
//  Created by Charles on 14/9/22.
//  Copyright © 2015年 Com.Charles. All rights reserved.
//

#import "NSString+Encrypt.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Encrypt)

- (NSString *)stringWithMD5 {
    if(self == nil || [self length] == 0)
        return nil;
    const char *value = [self UTF8String];
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    //CC_MD5(value, strlen(value), outputBuffer);
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}

- (NSString *)stringWithSha1 {
    
    if (self == nil || [self length] == 0) {
        return nil;
    }
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}
@end
