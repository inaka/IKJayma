//
//  IJSampleBackend.h
//  IKJayma
//
//  Created by Brujo Benavides on 4/7/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import "IJAbstractBackend.h"
#import "IJFakeHTTPRequestOperation.h"

@interface IJSampleBackend : IJAbstractBackend
-(IJFakeHTTPRequestOperation *)lastOperation;
-(NSOperation *)operationWithRequest:(NSURLRequest *)request success:(void (^)(NSOperation *operation, id responseObject))success failure:(void (^)(IJError *error))failure;
@end
