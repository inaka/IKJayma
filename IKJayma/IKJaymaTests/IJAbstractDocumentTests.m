//
//  IKJayma - IJAbstractDocumentTests.m
//  Copyright 2014 Inaka Labs S.A. All rights reserved.
//
//  Created by: Gera
//

// Class under test
#import "IJSampleDocument.h"

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
    IJSampleDocument * sut;
    NSDictionary * dictionary;
}
- (void) setUp
{
    [super setUp];
    dictionary = @{@"id":@"1" , @"name":@"sample"};
    sut = [[IJSampleDocument alloc] initWithDictionary:dictionary];
}

- (void)test_initWithDictionaryShouldWork
{
    expect(sut).to.beKindOf([IJAbstractDocument class]);
}
- (void)test_dictionaryRepresentationShouldReturnProperDictionary
{
    expect([sut dictionaryRepresentation]).to.equal(dictionary);
}
- (void)test_idShouldBe1
{
    expect(sut.documentId).to.equal(@"1");
}
- (void)test_idShouldBeDictionaryId
{
    NSString * dictionaryId = [NSString stringWithFormat:@"%d",arc4random()%100];
    NSDictionary * freshDictionary = @{@"id":dictionaryId};
    IJSampleDocument * freshSut = [[IJSampleDocument alloc] initWithDictionary:freshDictionary];
    
    expect(freshSut.documentId).to.equal(dictionaryId);
}
@end