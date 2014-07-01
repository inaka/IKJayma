//
//  IJFakeAFNetworkingBackend.h
//  IKJayma
//
//  Created by Gera on 6/26/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import "IJAFNetworkingBackend.h"
#import "IJFakeHTTPRequestOperation.h"
#import <AFNetworking/AFNetworking.h>

@interface IJFakeAFNetworkingBackend : IJAFNetworkingBackend
-(IJFakeHTTPRequestOperation *)lastOperation;
@end
