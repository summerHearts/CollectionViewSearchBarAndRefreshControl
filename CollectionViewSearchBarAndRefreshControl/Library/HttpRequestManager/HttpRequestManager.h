//
//  HttpRequestManager.h
//  CollectionViewSearchBarAndRefreshControl
//
//  Created by 佐毅 on 16/2/4.
//  Copyright © 2016年 上海乐住信息技术有限公司. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef enum {
    GET,
    POST,
    PUT,
    DELETE,
    HEAD
} requestMethod;


typedef void(^requestSuccessBlock)(id obj);

typedef void(^requestFailBlock)(NSError *error);
#import <AFNetworking/AFNetworking.h>

@interface HttpRequestManager : AFHTTPSessionManager

+ (instancetype)shareManager;

- (void)requestWithMethod:(requestMethod)method
                 WithPath:(NSString *)path
               WithParams:(NSDictionary*)params
         WithSuccessBlock:(requestSuccessBlock)success
          WithFailurBlock:(requestFailBlock)failure;

@end
