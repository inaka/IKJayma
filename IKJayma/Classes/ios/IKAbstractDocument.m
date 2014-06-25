//
//  IKAbstractDocument.m
//  IKJaymaSampleApp
//
//  Created by Gera on 6/25/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//
#import <objc/runtime.h>
#import "IKAbstractDocument.h"

@implementation IKAbstractDocument
-(id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        for (NSString * propertyName in [dictionary allKeys])
        {
//            if ([self valueForKey:propertyName])
//            {
                [self setValue:dictionary [propertyName]  forKey:propertyName];
//            }
        }
    }
    return self;
}
-(NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
  
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for(i = 0; i < outCount; i++)
    {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        if(propName)
        {
            NSString *propertyName = [NSString stringWithCString:propName
                                                        encoding:[NSString defaultCStringEncoding]];
            NSString *propertyValue = [self valueForKey:propertyName];
            
            NSString * propertyType = [NSString stringWithUTF8String:property_copyAttributeValue(property , "T")];
            
            
            if (propertyValue)
            {
                if ([propertyType isEqualToString:@"c"])
                {
                    propertyValue = [propertyValue boolValue] ? @"true" : @"false";
                }else if (![propertyType isEqualToString:@"@\"NSString\""])
                {
                    propertyValue = [(id)propertyValue stringValue];
                }
                    
                [dictionary setValue:propertyValue forKey:propertyName];
            }
        }
    }
    free(properties);

    return dictionary;
}
@end
