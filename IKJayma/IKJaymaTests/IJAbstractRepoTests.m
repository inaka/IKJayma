//
//  IKJayma - IJAbstractRepoTests.m
//  Copyright 2014 Inaka Labs S.A. All rights reserved.
//
//  Created by: Gera
//

    // Class under test
#import "IJAbstractRepo.h"

    // Collaborators

    // Test support
#import <XCTest/XCTest.h>

    // Matchers/mocking support
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
//#import <OCMock/OCMock.h>

@interface IJAbstractRepoTests : XCTestCase
@end

@implementation IJAbstractRepoTests
{
    // test fixture ivars go here
}

- (void)test_initShouldReturnAbstractRepo
{
    expect([[IJAbstractRepo alloc] init]).to.beKindOf([IJAbstractRepo class]);
}

@end