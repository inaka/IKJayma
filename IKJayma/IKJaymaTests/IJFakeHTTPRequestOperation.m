//
//  IJFakeHTTPRequestOperation.m
//  IKJayma
//
//  Created by Gera on 6/26/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import "IJFakeHTTPRequestOperation.h"

@implementation IJFakeHTTPRequestOperation
- (id)initWithRequest:(NSURLRequest *)urlRequest
{
    self = [super initWithRequest:urlRequest];
    if (self)
    {
    }
    return self;
}

- (void)setCompletionBlockWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    [super setCompletionBlockWithSuccess:success failure:failure];
    self.successBlock = success;
    self.failureBlock = failure;
}
@end
