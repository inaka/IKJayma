//
//  IKContactsRepository.m
//  IKJaymaSample
//
//  Created by Gera on 7/2/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import "IKContactsRepository.h"
#import "IKContactDocument.h"
@implementation IKContactsRepository
-(id)initWithBackend:(IJAFNetworkingBackend *)backend
{
    if ( self = [super init])
    {
        self.backend = backend;
        self.serverUrl = @"http://192.168.1.111:9000/api";
        self.basePath = @"contacts";
    }
    return self;
}
-(IJAbstractDocument *)writeDocumentWithResponseObject:(NSDictionary *)responseObject
{
    IKContactDocument * contact = [[IKContactDocument alloc]initWithDictionary:responseObject];
    return contact;
}

@end
