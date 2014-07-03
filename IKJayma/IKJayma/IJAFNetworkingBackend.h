//
//  IJAFNetworkingBackend.h
//  IKJayma
//
//  Created by Gera on 6/26/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "IJError.h"
@interface IJAFNetworkingBackend : NSObject
@property (strong) NSOperationQueue * operationsQueue;
- (void)queueRequest:(NSURLRequest *)request success:(void (^)(NSOperation *operation, id responseObject))success failure:(void (^)(IJError *error))failure;
@end
