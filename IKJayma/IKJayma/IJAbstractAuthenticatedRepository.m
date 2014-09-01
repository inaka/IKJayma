//
//  IKAbstractAuthenticatedRepository.m
//  IKJayma
//
//  Created by Tom Ryan on 8/21/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import "IJAbstractAuthenticatedRepository.h"

@implementation IJAbstractAuthenticatedRepository

- (instancetype)initWithBackend:(IJAbstractBackend *)backend {
	self = [super initWithBackend:backend];
	if(self) {
		self.useAuthentication = YES;
	}
	return self;
}

- (void)createDocument:(id<IJDocumentProtocol>)document success:(void (^)(id<IJDocumentProtocol>))success failure:(void (^)(IJError *))failure {
	if(![self checkAuthentication]) {
		NSAssert(NO, @"You must provide an authentication string!");
		return;
	}

	[super createDocument:document success:success failure:failure];
}

- (void)updateDocument:(id<IJDocumentProtocol>)document success:(void (^)(id<IJDocumentProtocol>))success failure:(void (^)(IJError *))failure {
	if(![self checkAuthentication]) {
		NSAssert(NO, @"You must provide an authentication string!");
		return;
	}
	[super updateDocument:document success:success failure:failure];
}

- (void)deleteDocument:(id<IJDocumentProtocol>)document success:(void (^)(BOOL))success failure:(void (^)(IJError *))failure {
	if(![self checkAuthentication]) {
		NSAssert(NO, @"You must provide an authentication string!");
		return;
	}
	[super deleteDocument:document success:success failure:failure];
}

- (void)deleteDocumentWithId:(NSString *)documentId success:(void (^)(BOOL))success failure:(void (^)(IJError *))failure {
	if(![self checkAuthentication]) {
		NSAssert(NO, @"You must provide an authentication string!");
		return;
	}
	[super deleteDocumentWithId:documentId success:success failure:failure];
}

- (void)findDefaultAuthenticatedDocumentWithSuccess:(void (^)(id<IJDocumentProtocol> document) )success failure:(void (^)(IJError *error))failure {
	if(![self checkAuthentication]) {
		NSAssert(NO, @"You must provide an authentication string!");
		return;
	}
	[super findDocumentWithId:@"" success:success failure:failure];
}

- (void)findDocumentWithId:(NSString *)documentId success:(void (^)(id<IJDocumentProtocol>))success failure:(void (^)(IJError *))failure {
	if(![self checkAuthentication]) {
		NSAssert(NO, @"You must provide an authentication string!");
		return;
	}
	[super findDocumentWithId:documentId success:success failure:failure];
}


- (void)findDocumentsWithConditions:(NSDictionary *)searchConditions success:(void (^)(NSArray *))success failure:(void (^)(IJError *))failure {
	if(![self checkAuthentication]) {
		NSAssert(NO, @"You must provide an authentication string!");
		return;
	}
	[super findDocumentsWithConditions:searchConditions success:success failure:failure];
}

- (void)findAllDocumentsWithSuccess:(void (^)(NSArray *))success failure:(void (^)(IJError *))failure {
	if(![self checkAuthentication]) {
		NSAssert(NO, @"You must provide an authentication string!");
		return;
	}
	[super findAllDocumentsWithSuccess:success failure:failure];
}

- (void)refreshDocument:(id<IJDocumentProtocol>)document success:(void (^)(BOOL))success failure:(void (^)(IJError *))failure {
	if(![self checkAuthentication]) {
		NSAssert(NO, @"You must provide an authentication string!");
		return;
	}
	[super refreshDocument:document success:success failure:failure];
}

#pragma mark -


- (BOOL)checkAuthentication {
	if(!self.useAuthentication) {
		return YES;
	}
	return (self.authenticationString || self.authenticationString.length > 0);
}

- (NSMutableURLRequest *)requestWithUrl:(NSURL *)url httpMethod:(NSString *)method {
	NSMutableURLRequest *request = [super requestWithUrl:url httpMethod:method];
	if(self.useAuthentication && (self.authenticationString && self.authenticationString.length > 0)) {
		[request setValue:self.authenticationString forHTTPHeaderField:@"Authorization"];
	}
	
	return request;
}
@end
