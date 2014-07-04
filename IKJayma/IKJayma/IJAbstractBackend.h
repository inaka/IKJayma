//
//  IJAbstractBackend.h
//  IKJayma
//
//  Created by Brujo Benavides on 4/7/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IJError.h"
@interface IJAbstractBackend : NSObject
@property (strong) NSOperationQueue * operationsQueue;
- (NSOperation *)operationWithRequest:(NSURLRequest *)request success:(void (^)(NSOperation *operation, id responseObject))success failure:(void (^)(IJError *error))failure;
- (void)queueRequest:(NSURLRequest *)request success:(void (^)(NSOperation *operation, id responseObject))success failure:(void (^)(IJError *error))failure;
@end
