//
//  IJSampleAuthenticatedRepository.m
//  IKJayma
//
//  Created by Tom Ryan on 8/21/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import "IJSampleAuthenticatedRepository.h"
#import "IJSampleDocument.h"

@implementation IJSampleAuthenticatedRepository

- (id)initWithBackend:(IJAbstractBackend *)backend {
	self = [super init];
    if (self) {
        self.backend = backend;
        self.serverUrl = @"http://sample.com";
        self.basePath = @"samples";
    }
    return self;
}
-(id<IJDocumentProtocol>)writeDocumentWithResponseObject:(NSDictionary *)responseObject {
    IJSampleDocument * document = [[IJSampleDocument alloc]initWithDictionary:responseObject];
    return document;
}

@end
