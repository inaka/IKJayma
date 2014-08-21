//
//  IKAbstractAuthenticatedRepositoryTests.m
//  IKJayma
//
//  Created by Tom Ryan on 8/21/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import <XCTest/XCTest.h>

// Matchers/mocking support
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
//#import <OCMock/OCMock.h>
#import "IJFakeAFNetworkingBackend.h"
#import "IJSampleDocument.h"
#import "IJSampleAuthenticatedRepository.h"
#import "IKAbstractAuthenticatedRepository.h"

@interface IKAbstractAuthenticatedRepositoryTests : XCTestCase
@property (nonatomic, strong) IJSampleAuthenticatedRepository * sut;
@property (nonatomic, strong) IJFakeAFNetworkingBackend * fakeBackend;
@property (nonatomic, strong) IJSampleDocument * sampleDocument;
@property (nonatomic, strong) IJSampleDocument *  sampleDocumentWithId;
@end

@implementation IKAbstractAuthenticatedRepositoryTests

- (void)setUp {
    [super setUp];
	
	self.sampleDocument =  [[IJSampleDocument alloc] initWithDictionary:@{@"name":@"andres"}];
    NSString * documentRandomId = [NSString stringWithFormat:@"%d",arc4random()%100];
    self.sampleDocumentWithId = [[IJSampleDocument alloc] initWithDictionary:@{@"name":@"andres" , @"id":documentRandomId}];
    
    self.fakeBackend = [[IJFakeAFNetworkingBackend alloc]init];
    self.sut = [[IJSampleAuthenticatedRepository alloc] initWithBackend:self.fakeBackend];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testUnauthenticatedDocumentCreation {
	self.sut.useAuthentication = NO;
	[self.sut createDocument:self.sampleDocument success:nil failure:nil];
    NSURLRequest * lastRequest = [self.fakeBackend lastOperation].request;
	
	NSDictionary *expectedDictionary = [NSJSONSerialization JSONObjectWithData:lastRequest.HTTPBody options:NSJSONReadingMutableLeaves error:NULL];
	NSDictionary *obtainedDictionary = [self.sampleDocument dictionaryRepresentation];
	
	expect(obtainedDictionary).to.equal(expectedDictionary);
	
	NSDictionary *headers = [lastRequest allHTTPHeaderFields];
	expect([headers allKeys]).notTo.contain(@"Authorization");
}

- (void)testAuthenticatedDocumentCreation {
	self.sut.useAuthentication = YES;
	self.sut.authenticationString = @"This is a test auth string";
	[self.sut createDocument:self.sampleDocument success:nil failure:nil];
    NSURLRequest * lastRequest = [self.fakeBackend lastOperation].request;
    
	NSDictionary *expectedDictionary = [NSJSONSerialization JSONObjectWithData:lastRequest.HTTPBody options:NSJSONReadingMutableLeaves error:NULL];
	NSDictionary *obtainedDictionary = [self.sampleDocument dictionaryRepresentation];
	
	expect(obtainedDictionary).to.equal(expectedDictionary);
	
	NSDictionary *headers = [lastRequest allHTTPHeaderFields];
	expect([headers allKeys]).contain(@"Authorization");
}

@end
