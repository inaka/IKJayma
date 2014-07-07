//
//  IJError.h
//  IKJayma
//
//  Created by Gera on 7/3/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IJError : NSError
/*! The NSHTTPURLResponse from the server.*/
@property (nonatomic,strong)NSHTTPURLResponse *response;
/*! The response object created by AFNetworking.*/
@property (nonatomic,strong)id responseObject;
/*! The NSError retrieved by AFNetworking.*/
@property (nonatomic,strong)NSError *internalError;
/*! Assign the basic properties for an IJError */
-(id)initWithResponse:(NSHTTPURLResponse *)response responseObject:(id)responseObject andError:(NSError *)error;
@end
