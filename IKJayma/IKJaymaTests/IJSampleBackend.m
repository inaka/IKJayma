//
//  IJSampleBackend.m
//  IKJayma
//
//  Created by Brujo Benavides on 4/7/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import "IJSampleBackend.h"

@implementation IJSampleBackend
-(IJFakeHTTPRequestOperation *)lastOperation
{
  return (IJFakeHTTPRequestOperation *)self.operationsQueue.operations.lastObject;
}
-(NSOperation *)operationWithRequest:(NSURLRequest *)request success:(void (^)(NSOperation *operation, id responseObject))success failure:(void (^)(IJError *error))failure
{
  return [[IJFakeHTTPRequestOperation alloc] initWithRequest:request];
}
@end
