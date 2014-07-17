//
//  IJAbstractBackend.h
//  IKJayma
//
//  Created by Gera on 7/11/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IJError.h"
@interface IJAbstractBackend : NSObject
/* The queue that handles the NSOperations */
@property (strong) NSOperationQueue * operationsQueue;
/*! \brief ABSTRACT METHOD. You'll need to write your custom implementation.
 *
 *   This will create and return an NSOperation.
 */
- (NSOperation *)operationWithRequest:(NSURLRequest *)request success:(void (^)(NSOperation *operation, id responseObject))success failure:(void (^)(IJError *error))failure;
/*! \brief ABSTRACT METHOD. You'll need to write your custom implementation.
 *
 *   This will add a request to a queue so you can stop all operations in case you don't need them anymore. In case you need to implement a not-contemplated method in your repositories you'll need to send your request here. Other way you won't never use it.
 */
- (void)queueRequest:(NSURLRequest *)request success:(void (^)(NSOperation *operation, id responseObject))success failure:(void (^)(IJError *error))failure;

@end
