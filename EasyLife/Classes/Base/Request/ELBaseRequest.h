//
//  ELBaseRequest.h
//  EasyLife
//
//  Created by LiangYe on 16/8/30.
//  Copyright © 2016年 LiangYe. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ELBaseRequestReponseDelegate <NSObject>
@required
/** 如果不用block返回数据的话，这个方法必须实现*/
- (void)requestSuccessReponse:(BOOL)success response:(id)response message:(NSString *)message;
@end

typedef void(^ELAPIDicCompletion)(id response, BOOL success, NSString *message);
@interface ELBaseRequest : NSObject

@property (nonatomic, weak) id <ELBaseRequestReponseDelegate> el_delegate;
/** 链接*/
@property (nonatomic, copy) NSString *el_url;
/** 默认GET*/
@property (nonatomic, assign) BOOL el_isPost;
/** 图片数组*/
@property (nonatomic, strong) NSArray <UIImage *>*el_imageArray;

/** 构造方法*/
+ (instancetype)el_request;
+ (instancetype)el_requestWithUrl:(NSString *)el_url;
+ (instancetype)el_requestWithUrl:(NSString *)el_url isPost:(BOOL)el_isPost;
+ (instancetype)el_requestWithUrl:(NSString *)el_url isPost:(BOOL)el_isPost delegate:(id <ELBaseRequestReponseDelegate>)el_delegate;

/** 开始请求，如果设置了代理，不需要block回调*/
- (void)el_sendRequest;
/** 开始请求，没有设置代理，或者设置了代理，需要block回调，block回调优先级高于代理*/
- (void)el_sendRequestWithCompletion:(ELAPIDicCompletion)completion;

@end
