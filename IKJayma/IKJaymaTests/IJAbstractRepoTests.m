//
//  IKJayma - IJAbstractRepoTests.m
//  Copyright 2014 Inaka Labs S.A. All rights reserved.
//
//  Created by: Gera
//

    // Class under test
#import "IJAbstractRepo.h"
#import "IJSampleRepo.h"

    // Collaborators

    // Test support
#import <XCTest/XCTest.h>

    // Matchers/mocking support
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
//#import <OCMock/OCMock.h>
#import "IJFakeAFNetworkingBackend.h"
#import "IJSampleDocument.h"

@interface IJAbstractRepoTests : XCTestCase
@end

@implementation IJAbstractRepoTests
{
    IJSampleRepo * sut;
    IJFakeAFNetworkingBackend * fakeBackend;
    IJSampleDocument * sampleDocument;
    // test fixture ivars go here
}
- (void) setUp
{
    [super setUp];
    sampleDocument =  [[IJSampleDocument alloc] initWithDictionary:@{@"name":@"andres"}];
    fakeBackend = [[IJFakeAFNetworkingBackend alloc]init];
    sut = [[IJSampleRepo alloc] initWithBackend:fakeBackend];
}
- (void)test_initWithBackendShouldReturnAbstractRepo
{
    expect(sut).to.beKindOf([IJAbstractRepo class]);
}

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
    expect(lastRequest.URL.absoluteString).to.equal(@"sample.com/samples");
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
    expect([lastRequest.allHTTPHeaderFields objectForKey:@"content-type"]).to.equal(@"application/json");
}

-(void)test_createDocumentShouldCallSuccessWithObjectWithId
{
    __block IJAbstractDocument * documentFromServer = nil;
    
    [sut createDocument:sampleDocument success:^(IJAbstractDocument *document) {
        documentFromServer = document;
    } failure:nil];
    IJFakeHTTPRequestOperation * operation = [fakeBackend lastOperation];
    operation.successBlock (operation,@{});
    
    expect(documentFromServer).to.beKindOf([IJSampleDocument class]);
    expect([documentFromServer dictionaryRepresentation]).to.equal(@{});
}

-(void)test_createDocumentShouldCallErrorWithError
{
    __block NSError * errorFromServer = nil;
    
    [sut createDocument:sampleDocument success:nil failure:^(NSError *error) {
        errorFromServer = error;
    }];
    IJFakeHTTPRequestOperation * operation = [fakeBackend lastOperation];
    operation.failureBlock (operation, [self someError]);
    
    expect(errorFromServer).to.beKindOf([NSError class]);
}
-(NSError *)someError
{
    return [NSError errorWithDomain:@"" code:0 userInfo:@{}];
}
@end