//
//  HttpRequestManager.m
//  CollectionViewSearchBarAndRefreshControl
//
//  Created by 佐毅 on 16/2/4.
//  Copyright © 2016年 上海乐住信息技术有限公司. All rights reserved.
//



#import "HttpRequestManager.h"
static NSString *const baseUrl = @"https:imike.com";
static HttpRequestManager *manager = nil;

@implementation HttpRequestManager

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
    });
    return manager;
}


-(instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        self.requestSerializer.timeoutInterval = 10.0f;
        self.requestSerializer = [AFJSONRequestSerializer serializer];
//        self.responseSerializer = [AFHTTPResponseSerializer serializer]; //根据约定协议
        self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [self.requestSerializer setValue:url.absoluteString forHTTPHeaderField:@"Referer"];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
        self.securityPolicy.allowInvalidCertificates = YES;
    }
    return self;
}

- (void)requestWithMethod:(requestMethod)method
                 WithPath:(NSString *)path
               WithParams:(NSDictionary*)params
         WithSuccessBlock:(requestSuccessBlock)success
          WithFailurBlock:(requestFailBlock)failure
{
    switch (method) {
            
        case POST:{
            
            [self POST:path parameters:params progress:nil success:^(NSURLSessionTask *task, NSDictionary * responseObject) {
                success(responseObject);
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                failure(error);
            }];
            break;
        }
        case GET:{
            [self GET:path parameters:params progress:nil success:^(NSURLSessionTask *task, NSDictionary * responseObject) {
                
                success(responseObject);
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                failure(error);
            }];
            break;
        }
      
        case PUT:{
            
            [self POST:path parameters:params progress:nil success:^(NSURLSessionTask *task, NSDictionary * responseObject) {
                success(responseObject);
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Error: %@", error);
                
                failure(error);
            }];
            break;
        }
        default:
            break;
    }
}

@end
