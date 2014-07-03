//
//  IJError.h
//  IKJayma
//
//  Created by Gera on 7/3/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IJError : NSError
@property (nonatomic,strong)NSHTTPURLResponse *response;
@property (nonatomic,strong)id responseObject;
@property (nonatomic,strong)NSError *internalError;
-(id)initWithResponse:(NSHTTPURLResponse *)response responseObject:(id)responseObject andError:(NSError *)error;
@end
