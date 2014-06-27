//
//  IJSampleDocument.m
//  IKJayma
//
//  Created by Gera on 6/27/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import "IJSampleDocument.h"

@interface IJSampleDocument()
{

}
@property (nonatomic,retain)NSDictionary * dictionary;
@end
@implementation IJSampleDocument
-(id)initWithDictionary:(NSDictionary *)dictionary
{
    if ( self = [super init])
    {
        self.dictionary = dictionary;
        self.documentId = dictionary[@"id"];
    }
    return self;
}
-(NSDictionary *)dictionaryRepresentation
{
    return self.dictionary;
}
@end
    