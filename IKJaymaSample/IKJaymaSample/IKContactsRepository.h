//
//  IKContactsRepository.h
//  IKJaymaSample
//
//  Created by Gera on 7/2/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import "IJAbstractRepository.h"
#import "Headers.h"
@interface IKContactsRepository : IJAbstractRepository

-(void)createContact:(IKContact *)contact success:(void (^)(IKContact * contact))success failure:(void (^)(NSString * errorMessage))failure;

-(void)updateContact:(IKContact *)contact success:(void (^)(IKContact * contact))success failure:(void (^)(NSString * messageError))failure;

-(void)findAllContactsWithSuccess:(void (^)(NSArray * contacts))success failure:(void (^)(NSString * messageError))failure;

-(void)findContactsWithName:(NSString *)name success:(void (^)(NSArray * contacts))success failure:(void (^)(NSString * messageError))failure;

-(void)deleteContact:(IKContact *)contact success:(void (^)(BOOL success))success failure:(void (^)(NSString *messageError))failure;
@end
