//
//  IJAbstractBackend.m
//  IKJayma
//
//  Created by Gera on 7/11/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import "IJAbstractBackend.h"

@implementation IJAbstractBackend

- (id) init
{
    if (self = [super init])
    {
        self.operationsQueue = [[NSOperationQueue alloc]init];
    }
    return self;
}

- (NSOperation *)operationWithRequest:(NSURLRequest *)request success:(void (^)(NSOperation *operation, id responseObject))success failure:(void (^)(IJError *error))failure
{
    NSAssert(NO, @"This is an abstract method and should be overridden");
    return nil;
}

- (void)queueRequest:(NSURLRequest *)request success:(void (^)(NSOperation *operation, id responseObject))success failure:(void (^)(IJError *error))failure
{
    NSOperation *operation = [self operationWithRequest:request success:success failure: failure];
    [self.operationsQueue addOperation:operation];
}
@end
