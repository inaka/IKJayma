//
//  IJFakeAFNetworkingBackend.m
//  IKJayma
//
//  Created by Gera on 6/26/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import "IJFakeAFNetworkingBackend.h"

@implementation IJFakeAFNetworkingBackend
-(AFHTTPRequestOperation *)lastOperation
{
    return self.operationsQueue.operations.lastObject;
}
- (AFHTTPRequestOperation *)operationWithRequest:(NSURLRequest *)request
{
    return [[IJFakeHTTPRequestOperation alloc] initWithRequest:request];
}
@end
