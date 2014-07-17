//
//  IJAbstractRepository.m
//  IKJayma
//
//  Created by Gera on 6/26/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import "IJAbstractRepository.h"
@implementation IJAbstractRepository

-(id)initWithBackend:(IJAbstractBackend *)backend
{
    NSAssert(NO, @"This is an abstract method and should be overridden");
    return nil;
}
-(void)createDocument:(IJAbstractDocument *)document success:(void (^)(IJAbstractDocument *document) )success failure:(void (^)(IJError *error))failure
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
    } failure:failure];
}
-(void)updateDocument:(IJAbstractDocument *)document success:(void (^)(IJAbstractDocument *document) )success failure:(void (^)(IJError *error))failure
{
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[self serverUrlWithPathAndDocumentID:document.documentId]];
    [request setHTTPMethod:@"PUT"];
    [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:[document dictionaryRepresentation] options:NSJSONWritingPrettyPrinted error:NULL]];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [self.backend queueRequest:request success:^(NSOperation *operation, id responseObject) {
        if (success)
        {
            success (document);
        }
    } failure:failure];
}
-(void)deleteDocument:(IJAbstractDocument *)document success:(void (^)(BOOL successful) )success failure:(void (^)(IJError *error))failure
{
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[self serverUrlWithPathAndDocumentID:document.documentId]];
    [request setHTTPMethod:@"DELETE"];
    [self.backend queueRequest:request success:^(NSOperation *operation, id responseObject) {
        if (success)
        {
            success (YES);
        }
    } failure:failure];
}
-(void)deleteDocumentWithId:(NSString *)documentId success:(void (^)(BOOL successful) )success failure:(void (^)(IJError *error))failure
{
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[self serverUrlWithPathAndDocumentID:documentId]];
    [request setHTTPMethod:@"DELETE"];
    [self.backend queueRequest:request success:^(NSOperation *operation, id responseObject) {
        if (success)
        {
            success (YES);
        }
    } failure:failure];
}

-(void)findDocumentWithId:(NSString *)documentId success:(void (^)(IJAbstractDocument *document) )success failure:(void (^)(IJError *error))failure
{
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[self serverUrlWithPathAndDocumentID:documentId]];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [self.backend queueRequest:request success:^(NSOperation *operation, id responseObject) {
        if (success)
        {
            success ([self writeDocumentWithResponseObject:responseObject]);
        }
    } failure:failure];
}

-(void)findDocumentsWithConditions:(NSDictionary *)searchConditions success:(void (^)(NSArray *documents) )success failure:(void (^)(IJError *error))failure
{
    NSString * queryString = @"";
    if (searchConditions)
    {
        queryString = [self queryStringFromDictionary:searchConditions];
    }
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[self serverUrlWithPathAndQueryString:queryString]];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];


    
    [self.backend queueRequest:request success:^(NSOperation *operation, id responseObject) {
        if (success)
        {
            NSMutableArray * documentsArray = [NSMutableArray array];
            for (id documentDictionary in responseObject)
            {
                
               [documentsArray addObject:[self writeDocumentWithResponseObject:documentDictionary]];
            }
            success (documentsArray);
        }
    } failure:failure];
}
-(void)findAllDocumentsWithSuccess:(void (^)(NSArray *documents) )success failure:(void (^)(IJError *error))failure
{
    [self findDocumentsWithConditions:nil success:success failure:failure];
}
-(void)refreshDocument:(IJAbstractDocument *)document success:(void (^) (BOOL success))success failure:(void (^)(IJError *error))failure
{
    [self findDocumentWithId:document.documentId success:^(IJAbstractDocument *documentFromServer) {
        [document refreshWithDictionary:[documentFromServer dictionaryRepresentation] ];
        if (success)
        {
            success (YES);
        }
    } failure:failure];
}
#pragma mark Auxiliar Methods
-(NSString *)queryStringFromDictionary:(NSDictionary *)dictionary
{
    NSMutableArray * parametersArray = [NSMutableArray array];
    for (NSString * param in [dictionary allKeys])
    {
        NSString * queryParam = [NSString stringWithFormat:@"%@=%@",param ,dictionary[param]];
        [parametersArray addObject:[queryParam stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    }
    return [parametersArray componentsJoinedByString:@"&"];
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
-(NSURL *)serverUrlWithPathAndDocumentID:(NSString *)documentId
{
    NSURL * serverUrlWithPathAndDocumentID = [NSURL URLWithString:[NSString stringWithFormat: @"%@/%@/%@",self.serverUrl,self.basePath,documentId]];
    return serverUrlWithPathAndDocumentID;
}
-(NSURL *)serverUrlWithPathAndQueryString:(NSString *)queryString
{
    NSURL * serverUrlWithPathAndQueryString = [NSURL URLWithString:[NSString stringWithFormat: @"%@/%@?%@",self.serverUrl,self.basePath,queryString]];
    return serverUrlWithPathAndQueryString;
}
@end
