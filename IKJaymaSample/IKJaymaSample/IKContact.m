//
//  IKContactDocument.m
//  IKJaymaSample
//
//  Created by Gera on 7/2/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import "IKContact.h"

@implementation IKContact
-(id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        self.documentId = dictionary[@"id"] ? dictionary[@"id"] : @"";
        [self refreshWithDictionary:dictionary];
    }
    return self;
}
-(NSDictionary *)dictionaryRepresentation
{
    
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if (self.documentId && ![self.documentId isEqualToString:@""])
        [dictionary setObject:self.documentId forKey:@"id"];
    
    if (self.contactName && ![self.contactName isEqualToString:@""])
        [dictionary setObject:self.contactName forKey:@"name"];
    
    if (self.contactPhone && ![self.contactPhone isEqualToString:@""])
        [dictionary setObject:self.contactPhone forKey:@"phone"];
    
    if (self.contactEmail && ![self.contactEmail isEqualToString:@""])
        [dictionary setObject:self.contactEmail forKey:@"email"];
    
    return dictionary;
}
-(void)refreshWithDictionary:(NSDictionary *)dictionary
{
    self.contactName = dictionary[@"name"] ? dictionary[@"name"] : @"";
    self.contactPhone = dictionary[@"phone"] ? dictionary[@"phone"] : @"";
    self.contactEmail = dictionary[@"email"] ? dictionary[@"email"] : @"";
}
@end
