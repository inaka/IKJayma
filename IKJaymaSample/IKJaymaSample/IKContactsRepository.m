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
    [self createDocument:contact success:^(id<IJDocumentProtocol>document) {
        if (success)
        {
            success ((IKContact *)document);
        }
    } failure:^(IJError *error) {
        if (failure)
        {
            failure([self errorMessageFromError:error]);
        }
    }];
}

-(void)updateContact:(IKContact *)contact success:(void (^)(IKContact * contact))success failure:(void (^)(NSString * messageError))failure
{
    [self updateDocument:contact success:^(id<IJDocumentProtocol>document) {
        if (success)
        {
            success ((IKContact *)document);
        }
    } failure:^(IJError *error) {
        if (failure)
        {
            failure([self errorMessageFromError:error]);
        }
    }];
}

-(void)findAllContactsWithSuccess:(void (^)(NSArray * contacts))success failure:(void (^)(NSString * messageError))failure
{
    [self findAllDocumentsWithSuccess:success failure:^(IJError *error) {
        if (failure)
        {
            failure([self errorMessageFromError:error]);
        }
    }];
}

-(void)findContactsWithName:(NSString *)name success:(void (^)(NSArray * contacts))success failure:(void (^)(NSString * messageError))failure
{
    [self findDocumentsWithConditions:@{@"name":name} success:success failure:^(IJError *error){
        if (failure)
        {
            failure([self errorMessageFromError:error]);
        }
    }];
}
-(void)deleteContact:(IKContact *)contact success:(void (^)(BOOL success))success failure:(void (^)(NSString *messageError))failure
{
    [self deleteDocument:contact success:success failure:^(IJError *error) {
        if (failure)
        {
            failure([self errorMessageFromError:error]);
        }
        
    } ];
}

-(NSString *)errorMessageFromError:(IJError *)error
{
    if (error.responseObject[@"error"])
        return error.responseObject[@"error"];
    else
    {
        switch (error.response.statusCode) {
            case 409:
                return @"Contact name is already taken!";
            default:
                return error.internalError.localizedDescription;
        }
    }
}
@end
