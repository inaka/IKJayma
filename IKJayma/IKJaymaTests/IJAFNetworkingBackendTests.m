 //
//  IKJayma - IJAFNetworkingBackendTests.m
//  Copyright 2014 Inaka Labs S.A. All rights reserved.
//
//  Created by: Gera
//

    // Class under test
#import "IJAFNetworkingBackend.h"
#import "IJFakeAFNetworkingBackend.h"
#import "IJFakeHTTPRequestOperation.h"
    // Collaborators

    // Test support
#import <XCTest/XCTest.h>

    // Matchers/mocking support
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
//#import <OCMock/OCMock.h>

@interface IJAFNetworkingBackendTests : XCTestCase
@end

@implementation IJAFNetworkingBackendTests
{
    IJFakeAFNetworkingBackend * sut;
    // test fixture ivars go here
}
- (void) setUp
{
    [super setUp];
    sut = [[IJFakeAFNetworkingBackend alloc] init];
}
- (void)test_initShouldReturnAFNetworkingBackend
{
    expect(sut).to.beKindOf([IJAFNetworkingBackend class]);
}
- (void)test_queueRequestShouldQueueTheCorrespondingOperation
{
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"www.google.com.ar"]];

    [sut queueRequest:request success:nil failure:nil];
    expect([sut lastOperation].request).to.equal(request);
}
- (void)test_queueRequestShouldCallSuccessBlock
{
    // I need to create a sut that uses a real operation queue (not a fake)
    IJFakeAFNetworkingBackend *freshSut = [[IJFakeAFNetworkingBackend alloc] init];
    __block id sutSuccessResponseObject = nil;
    __block NSOperation * sutSuccessRequestOperation = nil;
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"www.google.com.ar"]];
    
    [freshSut queueRequest:request success:^(NSOperation *operation, id responseObject) {
        sutSuccessResponseObject = responseObject;
        sutSuccessRequestOperation = operation;
    } failure:nil];
    
    NSString * sampleResponse = @"123";
    
    /* We simulate a success block fire */
    IJFakeHTTPRequestOperation *operation = (IJFakeHTTPRequestOperation *)[freshSut lastOperation];
    operation.successBlock(nil, sampleResponse);
    
    expect(sutSuccessResponseObject).will.equal(sampleResponse);
}

- (void)test_queueRequestShouldCallFailureBlock
{
    IJFakeAFNetworkingBackend *freshSut = [[IJFakeAFNetworkingBackend alloc] init];
    __block id sutFailureResponseObject = nil;
    __block NSHTTPURLResponse * sutFailureHTTPURLResponse = nil;
    __block NSError * sutError = nil;
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"www.google.com.ar"]];
    
    [freshSut queueRequest:request success:^(NSOperation *operation, id responseObject) {
        
    } failure:^(IJError *error) {
        sutFailureResponseObject = error.responseObject;
        sutFailureHTTPURLResponse = error.response;
        sutError = error.internalError;
    }];
    
    IJFakeHTTPRequestOperation *operation = (IJFakeHTTPRequestOperation *)[freshSut lastOperation];
    operation.failureBlock(operation, nil);

    expect(sutFailureResponseObject).will.equal(operation.responseObject);
}
@end