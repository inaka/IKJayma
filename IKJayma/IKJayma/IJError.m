//
//  IJError.m
//  IKJayma
//
//  Created by Gera on 7/3/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import "IJError.h"

@implementation IJError

-(id)initWithResponse:(NSHTTPURLResponse *)response responseObject:(id)responseObject andError:(NSError *)error {
	self = [[self class] errorWithDomain:error.domain ? error.domain : @"com.inaka.ikjayma.error" code:error.code userInfo:error.userInfo];
	if(self) {
		self.response = response;
		self.responseObject = responseObject;
		self.internalError = error;
		self.responseCode = response.statusCode;
	}
	
    return self;
}

- (NSInteger)code {
	return self.response.statusCode;
}

- (NSString *)debugDescription {
	NSMutableString *returnString = [NSMutableString string];
	[returnString appendFormat:@"Response: %@\n", self.response];
	[returnString appendFormat:@"Response Object: %@\n", self.responseObject];
	[returnString appendFormat:@"Internal Error: %@\n", self.internalError.localizedDescription];
	[returnString appendFormat:@"code: %li", (long)self.code];
	
	return returnString;
}

@end
