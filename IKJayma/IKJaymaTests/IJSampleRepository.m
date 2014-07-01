//
//  IJSampleRepository.m
//  IKJayma
//
//  Created by Gera on 6/27/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import "IJSampleRepository.h"
#import "IJSampleDocument.h"
@implementation IJSampleRepository
- (id)initWithBackend:(IJAFNetworkingBackend *)backend
{
    if (self = [super init])
    {
        self.backend = backend;
        self.serverUrl = @"http://sample.com";
        self.basePath = @"samples";
    }
    return self;
}
-(IJAbstractDocument *)writeDocumentWithResponseObject:(NSDictionary *)responseObject
{
    IJSampleDocument * document = [[IJSampleDocument alloc]initWithDictionary:responseObject];
    return document;
}
@end
