//
//  AFHTTPSessionManager+manager.m
//  AFNetworking
//
//  Created by 李响 on 2018/10/31.
//

#import "AFHTTPSessionManager+manager.h"

@implementation AFHTTPSessionManager (manager)

+ (instancetype)ws_manager {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFJSONResponseSerializer *josnSerializer = [AFJSONResponseSerializer serializer];
    josnSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    manager.responseSerializer = josnSerializer;
    
    return manager;
    
}

@end
