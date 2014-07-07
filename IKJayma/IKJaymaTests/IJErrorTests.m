//
//  IKJayma - IJErrorTests.m
//  Copyright 2014 Inaka Labs S.A. All rights reserved.
//
//  Created by: Gera
//

    // Class under test
#import "IJError.h"

    // Collaborators

    // Test support
#import <XCTest/XCTest.h>

    // Matchers/mocking support
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
//#import <OCMock/OCMock.h>

@interface IJErrorTests : XCTestCase
@end
@implementation IJErrorTests
{
    // test fixture ivars go here
    IJError * sut;
    NSHTTPURLResponse * response;
    NSError * error;
    id responseObject;
}
-(void)setUp
{
    [super setUp];
    response = [[NSHTTPURLResponse alloc]initWithURL:[NSURL URLWithString:@"www.google.com.ar"] statusCode:arc4random()%400+100 HTTPVersion:@"1.1" headerFields:@{}];
    error = [NSError errorWithDomain:@"menosfruta" code:arc4random()%100 userInfo:@{}];
    responseObject = @(arc4random()%10);
    sut = [[IJError alloc]initWithResponse:response responseObject:responseObject andError:error];
}
-(void)test_IJErrorReturnsCorrectResponse
{
    expect(sut.response).to.equal(response);
}
-(void)test_IJErrorReturnsCorrectResponseObject
{
    expect(sut.responseObject).to.equal(responseObject);
}
-(void)test_IJErrorReturnsCorrectInternalError
{
    expect(sut.internalError).to.equal(error);
}

@end