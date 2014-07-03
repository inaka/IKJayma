//
//  IKContactsRepository.m
//  IKJaymaSample
//
//  Created by Gera on 7/2/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import "IKContactsRepository.h"
@implementation IKContactsRepository
-(id)initWithBackend:(IJAFNetworkingBackend *)backend
{
    if ( self = [super init])
    {
        self.backend = backend;
        self.serverUrl = @"http://localhost:9000/api";
        self.basePath = @"contacts";
    }
    return self;
}
-(IJAbstractDocument *)writeDocumentWithResponseObject:(NSDictionary *)responseObject
{
    IKContact * contact = [[IKContact alloc]initWithDictionary:responseObject];
    return contact;
}
-(void)createContact:(IKContact *)contact success:(void (^)(IKContact * contact))success failure:(void (^)(NSString * errorMessage))failure
{
    [self createDocument:contact success:^(IJAbstractDocument *document) {
        if (success)
            success ((IKContact *)document);
    } failure:^(id responseObject, NSError *error) {
        if (failure)
        {
            failure ([self responseErrorMessageFromResponseObject:responseObject andError:error]);
        }
    }];
}

-(void)updateContact:(IKContact *)contact success:(void (^)(IKContact * contact))success failure:(void (^)(NSString * errorMessage))failure
{
    [self updateDocument:contact success:^(IJAbstractDocument *document) {
        if (success)
            success ((IKContact *)document);
    } failure:^(id responseObject, NSError *error) {
        if (failure)
        {
            failure ([self responseErrorMessageFromResponseObject:responseObject andError:error]);
        }
    }];
}

-(void)findAllContactsWithSuccess:(void (^)(NSArray * contacts))success failure:(void (^)(NSString * errorMessage))failure
{
    [self findAllDocumentsWithSuccess:success failure:^(id responseObject, NSError *error) {
        if (failure)
        {
            failure ([self responseErrorMessageFromResponseObject:responseObject andError:error]);
        }
    }];
}

-(NSString *)responseErrorMessageFromResponseObject:(id)responseObject andError:(NSError *)error
{
    if (responseObject[@"error"])
        return responseObject[@"error"];
    else
        return error.localizedDescription;
}
@end
