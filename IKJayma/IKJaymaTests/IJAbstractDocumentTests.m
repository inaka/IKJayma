//
//  IKJayma - IJAbstractDocumentTests.m
//  Copyright 2014 Inaka Labs S.A. All rights reserved.
//
//  Created by: Gera
//

// Class under test
#import "IJAbstractDocument.h"

// Collaborators

// Test support
#import <XCTest/XCTest.h>

// Matchers/mocking support
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
//#import <OCMock/OCMock.h>

@interface IJAbstractDocumentTests : XCTestCase
@end

@implementation IJAbstractDocumentTests
{
    // test fixture ivars go here
}

- (void)test_initWithDictionaryShouldWork
{
    expect([[IJAbstractDocument alloc]initWithDictionary:@{}]).to.beKindOf([IJAbstractDocument class]);
}
- (void)test_dictionaryRepresentationShouldReturnEmptyDictionary
{
    IJAbstractDocument * document = [[IJAbstractDocument alloc]initWithDictionary:@{}];
    expect([document dictionaryRepresentation]).to.equal(@{});
}
- (void)test_idShouldBeEmpty
{
    IJAbstractDocument * document = [[IJAbstractDocument alloc]initWithDictionary:@{}];
    expect(document.documentId).to.equal(@"");
}
@end