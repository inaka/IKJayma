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

-(void)createDocument:(id<IJDocumentProtocol>)document success:(void (^)(id<IJDocumentProtocol> document) )success failure:(void (^)(IJError *error))failure
{
	NSMutableURLRequest *request = [self requestWithUrl:[self serverUrlWithPath] httpMethod:@"POST"];

    [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:[document dictionaryRepresentation] options:NSJSONWritingPrettyPrinted error:NULL]];
   
    [self.backend queueRequest:request success:^(NSOperation *operation, id responseObject) {
        if (success)
        {
            success ([self writeDocumentWithResponseObject:responseObject]);
        }
    } failure:failure];
}

-(void)updateDocument:(id<IJDocumentProtocol>)document success:(void (^)(id<IJDocumentProtocol> document) )success failure:(void (^)(IJError *error))failure
{
	NSMutableURLRequest *request = [self requestWithUrl:[self serverUrlWithPathAndDocumentID:document.documentId] httpMethod:@"PUT"];

    [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:[document dictionaryRepresentation] options:NSJSONWritingPrettyPrinted error:NULL]];
    
    [self.backend queueRequest:request success:^(NSOperation *operation, id responseObject) {
        if (success)
        {
            success (document);
        }
    } failure:failure];
}

-(void)deleteDocument:(id<IJDocumentProtocol>)document success:(void (^)(BOOL successful) )success failure:(void (^)(IJError *error))failure
{
	NSMutableURLRequest *request = [self requestWithUrl:[self serverUrlWithPathAndDocumentID:document.documentId] httpMethod:@"DELETE"];
	
    [self.backend queueRequest:request success:^(NSOperation *operation, id responseObject) {
        if (success)
        {
            success (YES);
        }
    } failure:failure];
}

-(void)deleteDocumentWithId:(NSString *)documentId success:(void (^)(BOOL successful) )success failure:(void (^)(IJError *error))failure
{
	NSMutableURLRequest *request = [self requestWithUrl:[self serverUrlWithPathAndDocumentID:documentId] httpMethod:@"DELETE"];
    [self.backend queueRequest:request success:^(NSOperation *operation, id responseObject) {
        if (success)
        {
            success (YES);
        }
    } failure:failure];
}

-(void)findDocumentWithId:(NSString *)documentId success:(void (^)(id<IJDocumentProtocol>document))success failure:(void (^)(IJError *error))failure
{
    NSMutableURLRequest * request = [self requestWithUrl:[self serverUrlWithPathAndDocumentID:documentId] httpMethod:@"GET"];
    
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
    NSMutableURLRequest * request = [self requestWithUrl:[self serverUrlWithPathAndQueryString:queryString] httpMethod:@"GET"];
    
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

-(void)refreshDocument:(id<IJDocumentProtocol>)document success:(void (^) (BOOL success))success failure:(void (^)(IJError *error))failure
{
    [self findDocumentWithId:document.documentId success:^(id<IJDocumentProtocol>documentFromServer) {
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

-(id<IJDocumentProtocol>)writeDocumentWithResponseObject:(NSDictionary *)responseObject
{
    NSAssert(NO, @"This is an abstract method and should be overridden");
    return nil;
}

- (NSMutableURLRequest *)requestWithUrl:(NSURL *)url httpMethod:(NSString *)method {
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
	request.HTTPMethod = method;
	[request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	
	return request;
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

-(NSURL *)serverUrlWithPathAndQueryString:(NSString *)queryString {
    NSURL * serverUrlWithPathAndQueryString = [NSURL URLWithString:[NSString stringWithFormat: @"%@/%@?%@",self.serverUrl,self.basePath,queryString]];
    return serverUrlWithPathAndQueryString;
}

@end
