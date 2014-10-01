//
//  IKAbstractAuthenticatedRepository.h
//  IKJayma
//
//  Created by Tom Ryan on 8/21/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import "IJAbstractRepository.h"

@interface IJAbstractAuthenticatedRepository : IJAbstractRepository
/*! The Authentication String provided in the HTTP Header */
@property (nonatomic, strong) NSString *authenticationString;
/*! Switch on and off to include the authentication string in the HTTP Headers*/
@property (nonatomic) BOOL useAuthentication;

/*! Check the validity of the authentication string if userAuthentication is set to YES*/
- (BOOL)checkAuthentication;
/*! \brief Find the default document endpoint, authenticated.
 *
 */
- (void)findDefaultAuthenticatedDocumentWithSuccess:(void (^)(id<IJDocumentProtocol> document) )success failure:(void (^)(IJError *error))failure;

/*! Convenience method to create an NSMutableURLRequest */
- (NSMutableURLRequest *)requestWithUrl:(NSURL *)url httpMethod:(NSString *)method;
@end
