//
//  IKContactDocument.m
//  IKJaymaSample
//
//  Created by Gera on 7/2/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import "IKContact.h"

@implementation IKContact

-(id)initWithDictionary:(NSDictionary *)dictionary {
	self = [super init];
	
    if (self) {
		if(dictionary[@"id"]) self.documentId = dictionary[@"id"];
        [self refreshWithDictionary:dictionary];
    }
    return self;
}

-(NSDictionary *)dictionaryRepresentation {
    
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.documentId && self.documentId.length > 0) dictionary[@"id"] = self.documentId;
	if(self.contactName && self.contactName.length > 0) dictionary[@"name"] = self.contactName;
	if(self.contactEmail && self.contactEmail.length > 0) dictionary[@"email"] = self.contactEmail;
	if(self.contactPhone && self.contactPhone.length > 0) dictionary[@"phone"] = self.contactPhone;
    
    return dictionary;
}

-(void)refreshWithDictionary:(NSDictionary *)dictionary {
	if(dictionary[@"name"]) self.contactName = dictionary[@"name"];
	if(dictionary[@"email"]) self.contactEmail = dictionary[@"email"];
	if(dictionary[@"phone"]) self.contactPhone = dictionary[@"phone"];
}
@end
