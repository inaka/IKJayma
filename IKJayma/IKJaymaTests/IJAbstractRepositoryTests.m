//
//  IKJayma - IJAbstractRepoTests.m
//  Copyright 2014 Inaka Labs S.A. All rights reserved.
//
//  Created by: Gera
//

// Class under test
#import "IJAbstractRepository.h"
#import "IJSampleRepository.h"
#import "IJError.h"

// Collaborators

// Test support
#import <XCTest/XCTest.h>

// Matchers/mocking support
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
//#import <OCMock/OCMock.h>
#import "IJFakeAFNetworkingBackend.h"
#import "IJSampleDocument.h"

@interface IJAbstractRepositoryTests : XCTestCase
@end

@implementation IJAbstractRepositoryTests
{
    IJSampleRepository * sut;
    IJFakeAFNetworkingBackend * fakeBackend;
    IJSampleDocument * sampleDocument;
    IJSampleDocument *  sampleDocumentWithId;
    // test fixture ivars go here
}
- (void) setUp
{
    [super setUp];
    sampleDocument =  [[IJSampleDocument alloc] initWithDictionary:@{@"name":@"andres"}];
    NSString * documentRandomId = [NSString stringWithFormat:@"%d",arc4random()%100];
    sampleDocumentWithId = [[IJSampleDocument alloc] initWithDictionary:@{@"name":@"andres" , @"id":documentRandomId}];
    
    fakeBackend = [[IJFakeAFNetworkingBackend alloc]init];
    sut = [[IJSampleRepository alloc] initWithBackend:fakeBackend];
}
- (void)test_initWithBackendShouldReturnAbstractRepo
{
    expect(sut).to.beKindOf([IJAbstractRepository class]);
}

#pragma mark Create Document Tests
-(void)test_createDocumentShouldSendPostRequest
{
    [sut createDocument:sampleDocument success:nil failure:nil];
    NSURLRequest * lastRequest = [fakeBackend lastOperation].request;
    expect(lastRequest.HTTPMethod).to.equal(@"POST");
}

-(void)test_createDocumentShouldPointToCorrectURL
{
    [sut createDocument:sampleDocument success:nil failure:nil];
    NSURLRequest * lastRequest = [fakeBackend lastOperation].request;
    expect(lastRequest.URL.absoluteString).to.equal(@"http://sample.com/samples");
}

-(void)test_createDocumentShouldHaveTheCorrectBody
{
    [sut createDocument:sampleDocument success:nil failure:nil];
    NSURLRequest * lastRequest = [fakeBackend lastOperation].request;
    expect([NSJSONSerialization JSONObjectWithData:lastRequest.HTTPBody options:NSJSONReadingMutableLeaves error:NULL ]).to.equal([sampleDocument dictionaryRepresentation]);
}
-(void)test_createDocumentShouldHaveTheCorrectMIMEType
{
    [sut createDocument:sampleDocument success:nil failure:nil];
    NSURLRequest * lastRequest = [fakeBackend lastOperation].request;
    expect([lastRequest.allHTTPHeaderFields objectForKey:@"Accept"]).to.equal(@"application/json");
}

-(void)test_createDocumentShouldCallSuccessWithObjectWithId
{
    __block IJAbstractDocument * documentFromServer = nil;
    
    [sut createDocument:sampleDocument success:^(id<IJDocumentProtocol>document) {
        documentFromServer = document;
    } failure:nil];
    IJFakeHTTPRequestOperation * operation = [fakeBackend lastOperation];
    operation.successBlock (operation,@{});
    
    expect(documentFromServer).to.beKindOf([IJSampleDocument class]);
    expect([documentFromServer dictionaryRepresentation]).to.equal(@{});
}

-(void)test_createDocumentShouldCallFailureWithError
{
    __block IJError * errorFromServer = nil;
    
    [sut createDocument:sampleDocument success:nil failure:^(IJError *error) {
        errorFromServer = error;
    }];
    IJFakeHTTPRequestOperation * operation = [fakeBackend lastOperation];
    operation.failureBlock (operation, [self someError]);
    
    expect(errorFromServer).to.beKindOf([IJError class]);
}

#pragma mark Update Document Tests

-(void)test_updateDocumentShouldSendPUTRequest
{
    [sut updateDocument:sampleDocument success:nil failure:nil];
    NSURLRequest * lastRequest = [fakeBackend lastOperation].request;
    expect(lastRequest.HTTPMethod).to.equal(@"PUT");
}

-(void)test_updateDocumentShouldPointToCorrectURL
{
    [sut updateDocument:sampleDocumentWithId success:nil failure:nil];
    NSURLRequest * lastRequest = [fakeBackend lastOperation].request;
    expect(lastRequest.URL.absoluteString).to.equal([NSString stringWithFormat:@"http://sample.com/samples/%@",sampleDocumentWithId.documentId]);
}

-(void)test_updateDocumentShouldHaveTheCorrectBody
{
    [sut updateDocument:sampleDocumentWithId success:nil failure:nil];
    NSURLRequest * lastRequest = [fakeBackend lastOperation].request;
    expect([NSJSONSerialization JSONObjectWithData:lastRequest.HTTPBody options:NSJSONReadingMutableLeaves error:NULL ]).to.equal([sampleDocumentWithId dictionaryRepresentation]);
}

-(void)test_updateDocumentShouldHaveTheCorrectMIMEType
{
    [sut updateDocument:sampleDocumentWithId success:nil failure:nil];
    NSURLRequest * lastRequest = [fakeBackend lastOperation].request;
    expect([lastRequest.allHTTPHeaderFields objectForKey:@"Accept"]).to.equal(@"application/json");
}

-(void)test_updateDocumentShouldCallSuccessWithObjectWithId
{
    __block IJAbstractDocument * documentFromServer = nil;
    
    [sut updateDocument:sampleDocumentWithId success:^(id<IJDocumentProtocol>document) {
        documentFromServer = document;
    } failure:nil];
    IJFakeHTTPRequestOperation * operation = [fakeBackend lastOperation];
    operation.successBlock (operation,[sampleDocumentWithId dictionaryRepresentation]);
    
    expect(documentFromServer).to.beKindOf([IJSampleDocument class]);
    expect([documentFromServer dictionaryRepresentation]).to.equal([sampleDocumentWithId dictionaryRepresentation]);
}
-(void)test_updateDocumentShouldCallFailureWithError
{
    __block IJError * errorFromServer = nil;
    __block id responseObjectFromServer = nil;
    
    [sut updateDocument:sampleDocument success:nil failure:^(IJError *error) {
        errorFromServer = error;
        responseObjectFromServer = error.responseObject;
    }];
    IJFakeHTTPRequestOperation * operation = [fakeBackend lastOperation];
    operation.failureBlock (operation, [self someError]);
    
    expect(errorFromServer).to.beKindOf([IJError class]);
    expect(responseObjectFromServer).to.equal(operation.responseObject);
}

#pragma mark Delete With Object Tests

-(void)test_deleteDocumentShouldSendDeleteRequest
{
    [sut deleteDocument:sampleDocumentWithId success:nil failure:nil];
    NSURLRequest * lastRequest = [fakeBackend lastOperation].request;
    expect(lastRequest.HTTPMethod).to.equal(@"DELETE");
}
-(void)test_deleteDocumentShouldPointToCorrectURL
{
    [sut deleteDocument:sampleDocumentWithId success:nil failure:nil];
    NSURLRequest * lastRequest = [fakeBackend lastOperation].request;
    expect(lastRequest.URL.absoluteString).to.equal([NSString stringWithFormat:@"http://sample.com/samples/%@",sampleDocumentWithId.documentId]);
}
-(void)test_deleteShouldReturnEmptyHTTPBody
{
    [sut deleteDocument:sampleDocumentWithId success:nil failure:nil];
    NSURLRequest * lastRequest = [fakeBackend lastOperation].request;
    expect(lastRequest.HTTPBody).to.equal(nil);
}

-(void)test_deleteShouldReturnContentType
{
    [sut deleteDocument:sampleDocumentWithId success:nil failure:nil];
    NSURLRequest * lastRequest = [fakeBackend lastOperation].request;
    expect([lastRequest.allHTTPHeaderFields objectForKey:@"content-type"]).to.equal(@"application/json");
}

-(void)test_deleteDocumentShouldCallSuccessWithObject
{
    __block BOOL successfulFromServer;
    
    [sut deleteDocument:sampleDocumentWithId success:^(BOOL successful) {
        successfulFromServer = successful;
    } failure:nil];
    IJFakeHTTPRequestOperation * operation = [fakeBackend lastOperation];
    operation.successBlock (operation,@YES);
    
    expect(successfulFromServer).to.equal(@YES);
}
-(void)test_deleteDocumentShouldCallFailureWithObject
{
    __block IJError * errorFromServer;
    
    [sut deleteDocument:sampleDocumentWithId success:nil failure:^(IJError *error) {
        errorFromServer = error;
    }];
    IJFakeHTTPRequestOperation * operation = [fakeBackend lastOperation];
    operation.failureBlock (operation,[self someError]);
    
    expect(errorFromServer).to.beKindOf([IJError class]);
}
#pragma mark Delete With Id Tests
-(void)test_deleteDocumentWithIdShouldSendDeleteRequest
{
    [sut deleteDocumentWithId:sampleDocumentWithId.documentId success:nil failure:nil];
    NSURLRequest * lastRequest = [fakeBackend lastOperation].request;
    expect(lastRequest.HTTPMethod).to.equal(@"DELETE");
}
-(void)test_deleteDocumentWithIdShouldPointToCorrectURL
{
    [sut deleteDocumentWithId:sampleDocumentWithId.documentId success:nil failure:nil];
    NSURLRequest * lastRequest = [fakeBackend lastOperation].request;
    expect(lastRequest.URL.absoluteString).to.equal([NSString stringWithFormat:@"http://sample.com/samples/%@",sampleDocumentWithId.documentId]);
}
-(void)test_deleteDocumentWithIdShouldReturnEmptyHTTPBody
{
    [sut deleteDocumentWithId:sampleDocumentWithId.documentId success:nil failure:nil];
    NSURLRequest * lastRequest = [fakeBackend lastOperation].request;
    expect(lastRequest.HTTPBody).to.equal(nil);
}

-(void)test_deleteDocumentWithIdShouldReturnContentType
{
    [sut deleteDocumentWithId:sampleDocumentWithId.documentId success:nil failure:nil];
    NSURLRequest * lastRequest = [fakeBackend lastOperation].request;
    expect([lastRequest.allHTTPHeaderFields objectForKey:@"content-type"]).to.equal(@"application/json");
}

-(void)test_deleteDocumentWithIdShouldCallSuccessWithObjectWithId
{
    __block BOOL successfulFromServer;
    
    [sut deleteDocumentWithId:sampleDocumentWithId.documentId success:^(BOOL successful) {
        successfulFromServer = successful;
    } failure:nil];
    IJFakeHTTPRequestOperation * operation = [fakeBackend lastOperation];
    operation.successBlock (operation,@YES);
    
    expect(successfulFromServer).to.equal(@YES);
}
-(void)test_deleteDocumentWithIdShouldCallFailureWithObjectWithId
{
    __block IJError * errorFromServer;
    
    [sut deleteDocumentWithId:sampleDocumentWithId.documentId success:nil failure:^(IJError *error) {
        errorFromServer = error;
    }];
    IJFakeHTTPRequestOperation * operation = [fakeBackend lastOperation];
    operation.failureBlock (operation,[self someError]);
    
    expect(errorFromServer).to.beKindOf([IJError class]);
}
#pragma mark Find with Id from server tests

-(void)test_findDocumentWithIdShouldSendGetRequest
{
    [sut findDocumentWithId:sampleDocumentWithId.documentId success:nil failure:nil];
    NSURLRequest * lastRequest = [fakeBackend lastOperation].request;
    expect(lastRequest.HTTPMethod).to.equal(@"GET");
}
-(void)test_findDocumentWithIdShouldPointToCorrectURL
{
    [sut findDocumentWithId:sampleDocumentWithId.documentId success:nil failure:nil];
    NSURLRequest * lastRequest = [fakeBackend lastOperation].request;
    expect(lastRequest.URL.absoluteString).to.equal([NSString stringWithFormat:@"http://sample.com/samples/%@",sampleDocumentWithId.documentId]);
}
-(void)test_findDocumentWithIdShouldReturnEmptyHTTPBody
{
    [sut findDocumentWithId:sampleDocumentWithId.documentId success:nil failure:nil];
    NSURLRequest * lastRequest = [fakeBackend lastOperation].request;
    expect(lastRequest.HTTPBody).to.equal(nil);
}
-(void)test_findDocumentWithIdShouldReturnJsonAcceptHeader
{
    [sut findDocumentWithId:sampleDocumentWithId.documentId success:nil failure:nil];
    NSURLRequest * lastRequest = [fakeBackend lastOperation].request;
    expect([lastRequest.allHTTPHeaderFields objectForKey:@"accept"]).to.equal(@"application/json");
}
-(void)test_findDocumentWithIdShouldCallSuccessWithObjectWithId
{
    __block IJAbstractDocument * documentFromServer = nil;
    
    [sut findDocumentWithId:sampleDocumentWithId.documentId success:^(id<IJDocumentProtocol>document) {
        documentFromServer = document;
    } failure:nil];
    IJFakeHTTPRequestOperation * operation = [fakeBackend lastOperation];
    operation.successBlock (operation,[sampleDocumentWithId dictionaryRepresentation]);
    
    expect(documentFromServer).to.beKindOf([IJSampleDocument class]);
    expect([documentFromServer dictionaryRepresentation]).to.equal([sampleDocumentWithId dictionaryRepresentation]);
}
-(void)test_findDocumentWithIdShouldCallFailureWithError
{
    __block IJError * errorFromServer = nil;
    __block id responseObjectFromServer = nil;
    
    [sut findDocumentWithId:sampleDocumentWithId.documentId success:nil failure:^(IJError *error) {
        errorFromServer = error;
        responseObjectFromServer = error.responseObject;
    }];
    IJFakeHTTPRequestOperation * operation = [fakeBackend lastOperation];
    operation.failureBlock (operation, [self someError]);
    
    expect(errorFromServer).to.beKindOf([IJError class]);
    expect(responseObjectFromServer).to.equal(operation.responseObject);
    
}

#pragma mark Find Documents with condition tests
-(void)test_findDocumentsWithConditionsShouldSendGetRequest
{
    NSDictionary * conditions = @{@"type":@"electric"};
    [sut findDocumentsWithConditions:conditions success:nil failure:nil];
    
    NSURLRequest * lastRequest = [fakeBackend lastOperation].request;
    expect(lastRequest.HTTPMethod).to.equal(@"GET");
}
-(void)test_findDocumentsWithConditionsShouldPointToCorrectURL
{
    NSDictionary * conditions = @{@"type":@"electric"};
    [sut findDocumentsWithConditions:conditions success:nil failure:nil];
    
    NSURLRequest * lastRequest = [fakeBackend lastOperation].request;
    expect(lastRequest.URL.host).to.equal(@"sample.com");
    expect(lastRequest.URL.path).to.equal(@"/samples");
}
-(void)test_findDocumentsWithConditionsShouldReturnCorrectQueryString
{
    NSDictionary * conditions = @{@"type":@"electric" ,@"location":@"new york"};
    [sut findDocumentsWithConditions:conditions success:nil failure:nil];
    
    NSURLRequest * lastRequest = [fakeBackend lastOperation].request;
    expect(lastRequest.URL.query).to.equal(@"type=electric&location=new%20york");
}
-(void)test_findDocumentsWithConditionsShouldReturnJsonAcceptHeader
{
    NSDictionary * conditions = @{@"type":@"electric"};
    [sut findDocumentsWithConditions:conditions success:nil failure:nil];
    
    NSURLRequest * lastRequest = [fakeBackend lastOperation].request;
    expect([lastRequest.allHTTPHeaderFields objectForKey:@"accept"]).to.equal(@"application/json");
}
-(void)test_findDocumentsWithConditionsShouldCallSuccessWithArrayWithObjects
{
    __block  NSArray * documentsInArray = @[[sampleDocument dictionaryRepresentation],[sampleDocumentWithId dictionaryRepresentation]];
    __block NSArray * documentsFromServer = nil;
    
    NSDictionary * conditions = @{@"type":@"electric"};
    [sut findDocumentsWithConditions:conditions success:^(NSArray *documents){
        documentsFromServer = documents;
    }failure:nil];
    
    IJFakeHTTPRequestOperation * operation = [fakeBackend lastOperation];
    operation.successBlock (operation,documentsInArray);
    
    IJSampleDocument * firstDocumentFromServer = [documentsFromServer objectAtIndex:0];
    expect(documentsFromServer).to.beKindOf([NSArray class]);
    expect(firstDocumentFromServer).to.beKindOf([IJSampleDocument class]);
    expect([firstDocumentFromServer dictionaryRepresentation]).to.equal([documentsInArray objectAtIndex:0]);
}
-(void)test_findDocumentsWithConditionsShouldCallSuccessWithEmptyArray
{
    __block  NSArray * documentsInArray = @[];
    __block NSArray * documentsFromServer = nil;
    
    NSDictionary * conditions = @{@"type":@"electric"};
    [sut findDocumentsWithConditions:conditions success:^(NSArray *documents){
        documentsFromServer = documents;
    }failure:nil];
    
    IJFakeHTTPRequestOperation * operation = [fakeBackend lastOperation];
    operation.successBlock (operation,documentsInArray);
    
    expect(documentsFromServer).to.beKindOf([NSArray class]);
    expect(documentsFromServer).to.equal(documentsInArray);
}
-(void)test_findDocumentsWithConditionsShouldCallFailureWithError
{
    __block IJError * errorFromServer = nil;
    __block id responseObjectFromServer = nil;
    
    [sut findDocumentWithId:sampleDocumentWithId.documentId success:nil failure:^(IJError *error) {
        errorFromServer = error;
        responseObjectFromServer = error.responseObject;
    }];
    IJFakeHTTPRequestOperation * operation = [fakeBackend lastOperation];
    operation.failureBlock (operation, [self someError]);
    
    expect(errorFromServer).to.beKindOf([IJError class]);
    expect(responseObjectFromServer).to.equal(operation.responseObject);
}

#pragma mark Find all documents tests
-(void)test_findAllDocumentsShouldSendGetRequest
{
    [sut findAllDocumentsWithSuccess:nil failure:nil];
    
    NSURLRequest * lastRequest = [fakeBackend lastOperation].request;
    expect(lastRequest.HTTPMethod).to.equal(@"GET");
}
-(void)test_findAllDocumentsShouldPointToCorrectURL
{
    [sut findAllDocumentsWithSuccess:nil failure:nil];
    
    NSURLRequest * lastRequest = [fakeBackend lastOperation].request;
    expect(lastRequest.URL.host).to.equal(@"sample.com");
    expect(lastRequest.URL.path).to.equal(@"/samples");
}
-(void)test_findAllDocumentsShouldReturnEmptyQueryString
{
    [sut findAllDocumentsWithSuccess:nil failure:nil];
    
    NSURLRequest * lastRequest = [fakeBackend lastOperation].request;
    expect(lastRequest.URL.query).to.equal(@"");
}
-(void)test_findAllDocumentsShouldReturnJsonAcceptHeader
{
    [sut findAllDocumentsWithSuccess:nil failure:nil];
    
    NSURLRequest * lastRequest = [fakeBackend lastOperation].request;
    expect([lastRequest.allHTTPHeaderFields objectForKey:@"accept"]).to.equal(@"application/json");
}
-(void)test_findAllDocumentsShouldCallSuccessWithArrayWithObjects
{
    __block  NSArray * documentsInArray = @[[sampleDocument dictionaryRepresentation],[sampleDocumentWithId dictionaryRepresentation]];
    __block NSArray * documentsFromServer = nil;
    
    [sut findAllDocumentsWithSuccess:^(NSArray *documents){
        documentsFromServer = documents;
    }failure:nil];
    
    IJFakeHTTPRequestOperation * operation = [fakeBackend lastOperation];
    operation.successBlock (operation,documentsInArray);
    
    IJSampleDocument * firstDocumentFromServer = [documentsFromServer objectAtIndex:0];
    expect(documentsFromServer).to.beKindOf([NSArray class]);
    expect(firstDocumentFromServer).to.beKindOf([IJSampleDocument class]);
    expect([firstDocumentFromServer dictionaryRepresentation]).to.equal([documentsInArray objectAtIndex:0]);
}
-(void)test_findAllDocumentsShouldCallSuccessWithEmptyArray
{
    __block  NSArray * documentsInArray = @[];
    __block NSArray * documentsFromServer = nil;
    
    [sut findAllDocumentsWithSuccess:^(NSArray *documents){
        documentsFromServer = documents;
    }failure:nil];
    
    IJFakeHTTPRequestOperation * operation = [fakeBackend lastOperation];
    operation.successBlock (operation,documentsInArray);
    
    expect(documentsFromServer).to.beKindOf([NSArray class]);
    expect(documentsFromServer).to.equal(documentsInArray);
}
-(void)test_findAllDocumentsShouldCallFailureWithError
{
    __block IJError * errorFromServer = nil;
    __block id responseObjectFromServer = nil;
    
    [sut findDocumentWithId:sampleDocumentWithId.documentId success:nil failure:^(IJError *error) {
        errorFromServer = error;
        responseObjectFromServer = error.responseObject;
    }];
    IJFakeHTTPRequestOperation * operation = [fakeBackend lastOperation];
    operation.failureBlock (operation, [self someError]);
    
    expect(errorFromServer).to.beKindOf([IJError class]);
    expect(responseObjectFromServer).to.equal(operation.responseObject);
}


#pragma mark Refresh document tests
-(void)test_refreshDocumentShouldSendGetRequest
{
    [sut refreshDocument:sampleDocumentWithId success:nil failure:nil];
    NSURLRequest * lastRequest = [fakeBackend lastOperation].request;
    expect(lastRequest.HTTPMethod).to.equal(@"GET");
}
-(void)test_refreshDocumentShouldPointToCorrectURL
{
    [sut refreshDocument:sampleDocumentWithId success:nil failure:nil];
    NSURLRequest * lastRequest = [fakeBackend lastOperation].request;
    expect(lastRequest.URL.absoluteString).to.equal([NSString stringWithFormat:@"http://sample.com/samples/%@",sampleDocumentWithId.documentId]);
}
-(void)test_refreshDocumentShouldReturnEmptyHTTPBody
{
    [sut refreshDocument:sampleDocumentWithId success:nil failure:nil];
    NSURLRequest * lastRequest = [fakeBackend lastOperation].request;
    expect(lastRequest.HTTPBody).to.equal(nil);
}
-(void)test_refreshDocumentShouldReturnJsonAcceptHeader
{
    [sut refreshDocument:sampleDocumentWithId success:nil failure:nil];
    NSURLRequest * lastRequest = [fakeBackend lastOperation].request;
    expect([lastRequest.allHTTPHeaderFields objectForKey:@"accept"]).to.equal(@"application/json");
}
-(void)test_refreshDocumentShouldCallSuccessWithSuccessAndFreshDocument
{
    __block IJSampleDocument * documentFromServer = [[IJSampleDocument alloc]initWithDictionary:@{@"id":@"1"}];
    __block BOOL successFromServer = NO;
    
    [sut refreshDocument:documentFromServer success:^(BOOL success) {
        successFromServer = success;
    } failure:nil];
    IJFakeHTTPRequestOperation * operation = [fakeBackend lastOperation];
    operation.successBlock (operation,[sampleDocumentWithId dictionaryRepresentation]);
    
    expect(documentFromServer).to.beKindOf([IJSampleDocument class]);
    expect(successFromServer).to.equal(@YES);
    expect([documentFromServer dictionaryRepresentation]).to.equal([sampleDocumentWithId dictionaryRepresentation]);
}
-(void)test_refreshDocumentShouldCallFailureWithError
{
    __block IJError * errorFromServer = nil;
    __block id responseObjectFromServer = nil;
    
    [sut refreshDocument:sampleDocument success:nil failure:^(IJError *error) {
        errorFromServer = error;
        responseObjectFromServer = error.responseObject;
    }];
    IJFakeHTTPRequestOperation * operation = [fakeBackend lastOperation];
    operation.failureBlock (operation, [self someError]);
    
    expect(errorFromServer).to.beKindOf([IJError class]);
    expect(responseObjectFromServer).to.equal(operation.responseObject);
}

- (void)test_error404ReturnsErrorStatusCode404 {
	__block IJError * errorFromServer = nil;
	
    [sut createDocument:sampleDocument success:nil failure:^(IJError *error) {
        errorFromServer = (IJError *)[self errorWithStatusCode:404];
    }];
    IJFakeHTTPRequestOperation * operation = [fakeBackend lastOperation];
	
    operation.failureBlock (operation, errorFromServer);
    
    expect(errorFromServer).to.beKindOf([IJError class]);
	expect(errorFromServer.code).to.equal(404);
}

#pragma mark - Helpers

-(NSError *)someError {
    NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc]initWithURL:[NSURL URLWithString:@"www.google.com.ar"] statusCode:arc4random()%400+100 HTTPVersion:@"1.1" headerFields:@{}];
    NSError *error = [NSError errorWithDomain:@"menosfruta" code:arc4random()%100 userInfo:@{}];
    id responseObject = @(arc4random()%10);
    return [[IJError alloc] initWithResponse:response responseObject:responseObject andError:error];
}

- (NSError *)errorWithStatusCode:(NSInteger)statusCode {
	NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc]initWithURL:[NSURL URLWithString:@"www.google.com.ar"] statusCode:statusCode HTTPVersion:@"1.1" headerFields:@{}];
    NSError *error = [NSError errorWithDomain:@"menosfruta" code:arc4random()%100 userInfo:@{}];
    id responseObject = @(arc4random()%10);
    return [[IJError alloc] initWithResponse:response responseObject:responseObject andError:error];
}

@end