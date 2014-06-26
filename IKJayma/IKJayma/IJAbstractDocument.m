//
//  IJAbstractDocument.m
//  IKJayma
//
//  Created by Gera on 6/26/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import "IJAbstractDocument.h"

@implementation IJAbstractDocument
-(id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    self.documentId = @"";
    return self;
}
-(NSDictionary *)dictionaryRepresentation
{
    return @{};
}
@end
