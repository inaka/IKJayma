//
//  IKJayma - IJAbstractBackendTests.m
//  Copyright 2014 Inaka Labs S.A. All rights reserved.
//
//  Created by: Gera
//

// Class under test
#import "IJSampleBackend.h"

// Collaborators

// Test support
#import <XCTest/XCTest.h>

// Matchers/mocking support
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
//#import <OCMock/OCMock.h>

@interface IJAbstractBackendTests : XCTestCase
@end

@implementation IJAbstractBackendTests
{
  IJSampleBackend * sut;
}
- (void)setUp
{
  [super setUp];
  sut = [[IJSampleBackend alloc]init];
}

- (void)test_queueRequestShouldQueueTheCorrespondingOperation
{
  NSURLRequest * request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"www.google.com.ar"]];

  [sut queueRequest:request success:nil failure:nil];
  IJFakeHTTPRequestOperation * lastOperation = (IJFakeHTTPRequestOperation *)[sut lastOperation];
  expect(lastOperation.request).to.equal(request);
}
@end