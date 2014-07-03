//
//  IJAFNetworkingBackend.m
//  IKJayma
//
//  Created by Gera on 6/26/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import "IJAFNetworkingBackend.h"

@implementation IJAFNetworkingBackend

-(id)init
{
    if (self = [super init])
    {
        self.operationsQueue = [[NSOperationQueue alloc]init];
    }
    return self;
}


- (void)queueRequest:(NSURLRequest *)request success:(void (^)(NSOperation *operation, id responseObject))success failure:(void (^)(NSOperation *operation, NSError *error))failure
{
    AFHTTPRequestOperation *operation = [self operationWithRequest:request];
    
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:success failure:failure];

    [self.operationsQueue addOperation:operation];
}
- (AFHTTPRequestOperation *)operationWithRequest:(NSURLRequest *)request
{
    return [[AFHTTPRequestOperation alloc] initWithRequest:request];
}
@end
