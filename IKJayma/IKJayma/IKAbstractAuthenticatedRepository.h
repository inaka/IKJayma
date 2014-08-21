//
//  IKAbstractAuthenticatedRepository.h
//  IKJayma
//
//  Created by Tom Ryan on 8/21/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import "IJAbstractRepository.h"

@interface IKAbstractAuthenticatedRepository : IJAbstractRepository
@property (nonatomic, strong) NSString *authenticationString;
@property (nonatomic) BOOL useAuthentication;
@end
