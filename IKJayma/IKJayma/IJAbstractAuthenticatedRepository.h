//
//  IKAbstractAuthenticatedRepository.h
//  IKJayma
//
//  Created by Tom Ryan on 8/21/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import "IJAbstractRepository.h"

@interface IJAbstractAuthenticatedRepository : IJAbstractRepository
@property (nonatomic, strong) NSString *authenticationString;
@property (nonatomic) BOOL useAuthentication;

- (BOOL)checkAuthentication;

- (void)findDefaultAuthenticatedDocumentWithSuccess:(void (^)(id<IJDocumentProtocol> document) )success failure:(void (^)(IJError *error))failure;

- (NSMutableURLRequest *)requestWithUrl:(NSURL *)url httpMethod:(NSString *)method;
@end
