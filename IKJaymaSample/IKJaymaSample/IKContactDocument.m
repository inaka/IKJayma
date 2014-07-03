//
//  IKContactDocument.m
//  IKJaymaSample
//
//  Created by Gera on 7/2/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import "IKContactDocument.h"

@implementation IKContactDocument
-(id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        self.contactId = dictionary[@"id"] ? dictionary[@"id"] : @"";
        self.contactName = dictionary[@"name"] ? dictionary[@"name"] : @"";
        self.contactPhone = dictionary[@"phone"] ? dictionary[@"phone"] : @"";
        self.contactEmail = dictionary[@"email"] ? dictionary[@"email"] : @"";
    }
    return self;
}
-(NSDictionary *)dictionaryRepresentation
{
    NSDictionary * dictionary = @{ @"id" : self.contactId
                                   ,@"phone" : self.contactPhone
                                   ,@"name" : self.contactName
                                   ,@"email" : self.contactEmail};
    
    return dictionary;
}
-(void)refreshWithDictionary:(NSDictionary *)dictionary
{
    self.contactId = dictionary[@"id"] ? dictionary[@"id"] : self.contactId;
    self.contactName = dictionary[@"name"] ? dictionary[@"name"] : self.contactName;
    self.contactPhone = dictionary[@"phone"] ? dictionary[@"phone"] : self.contactPhone;
    self.contactEmail = dictionary[@"email"] ? dictionary[@"email"] : self.contactEmail;
}
@end
