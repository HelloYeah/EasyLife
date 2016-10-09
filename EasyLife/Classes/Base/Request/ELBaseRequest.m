//
//  ELBaseRequest.m
//  NeiHan
//
//  Created by Charles on 16/8/30.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "ELBaseRequest.h"
#import "ELRequestManager.h"
#import "MJExtension.h"
#import "NSString+Addition.h"
#import "NSDictionary+Addition.h"
#import "AFNetworkReachabilityManager.h"
#import "NSNotificationCenter+Addition.h"
//#import "NSString+Addition.h"

@implementation ELBaseRequest

#pragma mark - 构造
+ (instancetype)el_request {
    return [[self alloc] init];
}

+ (instancetype)el_requestWithUrl:(NSString *)el_url {
    return [self el_requestWithUrl:el_url isPost:NO];
}

+ (instancetype)el_requestWithUrl:(NSString *)el_url isPost:(BOOL)el_isPost {
    return [self el_requestWithUrl:el_url isPost:el_isPost delegate:nil];
}

+ (instancetype)el_requestWithUrl:(NSString *)el_url isPost:(BOOL)el_isPost delegate:(id <ELBaseRequestReponseDelegate>)el_delegate {
    ELBaseRequest *request = [self el_request];
    request.el_url = el_url;
    request.el_isPost = el_isPost;
    request.el_delegate = el_delegate;
    return request;
}

#pragma mark - 发送请求
- (void)el_sendRequest {
    [self el_sendRequestWithCompletion:nil];
}

- (void)el_sendRequestWithCompletion:(ELAPIDicCompletion)completion {
    
    // 链接
    NSString *urlStr = self.el_url;
    if (urlStr.length == 0) return ;
    
    // 参数
    NSDictionary *params = [self params];
    
    // 普通POST请求
    if (self.el_isPost) {
        if (self.el_imageArray.count == 0) {
            // 开始请求
            [ELRequestManager POST:[urlStr noWhiteSpaceString] parameters:params responseSeializerType:ELResponseSeializerTypeJSON success:^(id responseObject) {
                
                // 处理数据
                [self handleResponse:responseObject completion:completion];
            } failure:^(NSError *error) {
                // 数据请求失败，暂时不做处理
            }];
        }
        
    } else { // 普通GET请求
        // 开始请求
        [ELRequestManager GET:[urlStr noWhiteSpaceString] parameters:params responseSeializerType:ELResponseSeializerTypeJSON success:^(id responseObject) {
            
            // 处理数据
            [self handleResponse:responseObject completion:completion];
        } failure:^(NSError *error) {
            // 数据请求失败，暂时不做处理
        }];
    }
    
    // 上传图片
    if (self.el_imageArray.count) {
        [ELRequestManager POST:[urlStr noWhiteSpaceString] parameters:params responseSeializerType:ELResponseSeializerTypeJSON constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            NSInteger imgCount = 0;
            for (UIImage *image in self.el_imageArray) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss:SSS";
                NSString *fileName = [NSString stringWithFormat:@"%@%@.png",[formatter stringFromDate:[NSDate date]],@(imgCount)];
//                [NSString stringWithFormat:@"uploadFile%@",@(imgCount)]
                [formData appendPartWithFileData:UIImagePNGRepresentation(image) name:@"file" fileName:fileName mimeType:@"image/png"];
                imgCount++;
            }
        } success:^(id responseObject) {
            // 处理数据
            [self handleResponse:responseObject completion:completion];
        } failure:^(NSError *error) {
            // 数据请求失败，暂时不做处理
        }];
    }
}

- (void)handleResponse:(id)responseObject completion:(ELAPIDicCompletion)completion {
    // 接口约定，如果message为retry即重试
    if ([responseObject[@"message"] isEqualToString:@"retry"]) {
        [self el_sendRequestWithCompletion:completion];
        return  ;
    }
    
    // 数据请求成功回调
    BOOL success = [responseObject[@"reason"] isEqualToString:@"success"] ||[responseObject[@"reason"] isEqualToString:@"成功的返回"];
    if (completion) {
        completion(responseObject[@"result"], success, @"");
    } else if (self.el_delegate) {
        if ([self.el_delegate respondsToSelector:@selector(requestSuccessReponse:response:message:)]) {
            [self.el_delegate requestSuccessReponse:success response:responseObject[@"result"] message:@""];
        }
    }
    // 请求成功，发布通知
    [NSNotificationCenter postNotification:kELRequestSuccessNotification];
}

// 设置链接
- (void)setel_url:(NSString *)el_url {
    if (el_url.length == 0 || [el_url isKindOfClass:[NSNull class]]) {
        return ;
    }
    _el_url = el_url;
}

- (NSDictionary *)params {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"tag"] = @"joke";
    params[@"iid"] = @"5316804410";
    params[@"os_version"] = @"9.3.4";
    params[@"os_api"] = @"18";
    
    params[@"app_name"] = @"joke_essay";
    params[@"channel"] = @"App Store";
    params[@"device_platform"] = @"iphone";
    params[@"idfa"] = @"832E262C-31D7-488A-8856-69600FAABE36";
    params[@"live_sdk_version"] = @"120";
    
    params[@"vid"] = @"4A4CBB9E-ADC3-426B-B562-9FC8173FDA52";
    params[@"openudid"] = @"cbb1d9e8770b26c39fac806b79bf263a50da6666";
    params[@"device_type"] = @"iPhone 6 Plus";
    params[@"version_code"] = @"5.5.0";
    params[@"ac"] = @"WIFI";
    params[@"screen_width"] = @"1242";
    params[@"device_id"] = @"10752255605";
    params[@"aid"] = @"7";
    params[@"count"] = @"50";
    params[@"max_time"] = [NSString stringWithFormat:@"%.2f", [[NSDate date] timeIntervalSince1970]];
    
    [params addEntriesFromDictionary:self.mj_keyValues];
    
    if ([params.allKeys containsObject:@"el_delegate"]) {
        [params removeObjectForKey:@"el_delegate"];
    }
    if ([params.allKeys containsObject:@"el_isPost"]) {
        [params removeObjectForKey:@"el_isPost"];
    }
    if ([params.allKeys containsObject:@"el_url"]) {
        [params removeObjectForKey:@"el_url"];
    }
    if (self.el_imageArray.count == 0) {
        if ([params.allKeys containsObject:@"el_imageArray"]) {
            [params removeObjectForKey:@"el_imageArray"];
        }
    }
    return params;
}

@end