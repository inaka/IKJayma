//
//  IJAbstractRepo.m
//  IKJayma
//
//  Created by Gera on 6/26/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import "IJAbstractRepo.h"
@implementation IJAbstractRepo

-(id)initWithBackend:(IJAFNetworkingBackend *)backend
{
    NSAssert(NO, @"This is an abstract method and should be overridden");
    return nil;
}
-(void)createDocument:(IJAbstractDocument *)document success:(void (^)(IJAbstractDocument *document) )success failure:(void (^)(NSError *error))failure
{
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[self serverUrlWithPath]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:[document dictionaryRepresentation] options:NSJSONWritingPrettyPrinted error:NULL]];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
   
    [self.backend queueRequest:request success:^(NSOperation *operation, id responseObject) {
        if (success)
        {
            success ([self writeDocumentWithResponseObject:responseObject]);
        }
    } failure:^(NSOperation *operation, NSError *error) {
        if (failure)
        {
            failure (error);
        }
    }];
}
-(IJAbstractDocument *)writeDocumentWithResponseObject:(NSDictionary *)responseObject
{
    NSAssert(NO, @"This is an abstract method and should be overridden");
    return nil;
}
-(NSURL *)serverUrlWithPath
{
    NSURL * serverUrlWithPath = [NSURL URLWithString:[NSString stringWithFormat: @"%@/%@",self.serverUrl,self.basePath]];
    return serverUrlWithPath;
}
@end
