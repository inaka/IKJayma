//
//  IJError.m
//  IKJayma
//
//  Created by Gera on 7/3/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import "IJError.h"

@implementation IJError
-(id)initWithResponse:(NSHTTPURLResponse *)response responseObject:(id)responseObject andError:(NSError *)error
{
    if (self = [super init])
    {
        self.response = response;
        self.responseObject = responseObject;
        self.internalError = error;
    }
    return self;
}
@end
