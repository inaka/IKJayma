//
//  IJFakeHTTPRequestOperation.h
//  IKJayma
//
//  Created by Gera on 6/26/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import "AFHTTPRequestOperation.h"

@interface IJFakeHTTPRequestOperation : AFHTTPRequestOperation
@property (nonatomic,strong)id responseObject;
@property (copy, nonatomic) void (^successBlock)(AFHTTPRequestOperation *operation, id responseObject);
@property (copy, nonatomic) void (^failureBlock)(AFHTTPRequestOperation *operation, NSError *error);
@end
