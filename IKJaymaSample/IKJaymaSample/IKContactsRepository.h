//
//  IKContactsRepository.h
//  IKJaymaSample
//
//  Created by Gera on 7/2/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import "IJAbstractRepository.h"
#import "IKContact.h"
@interface IKContactsRepository : IJAbstractRepository

-(void)createContact:(IKContact *)contact success:(void (^)(IKContact * contact))success failure:(void (^)(NSString * errorMessage))failure;

-(void)updateContact:(IKContact *)contact success:(void (^)(IKContact * contact))success failure:(void (^)(NSString * errorMessage))failure;

-(void)findAllContactsWithSuccess:(void (^)(NSArray * contacts))success failure:(void (^)(NSString * errorMessage))failure;

@end
