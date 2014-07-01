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
    NSAssert(NO, @"This is an abstract method and should be overridden");
    return nil;
}
-(void)refreshWithDictionary:(NSDictionary *)dictionary
{
    NSAssert(NO, @"This is an abstract method and should be overridden");
}
-(NSDictionary *)dictionaryRepresentation
{
    NSAssert(NO, @"This is an abstract method and should be overridden");
    return nil;
}
@end
