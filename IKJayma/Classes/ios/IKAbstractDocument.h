//
//  IKAbstractDocument.h
//  IKJaymaSampleApp
//
//  Created by Gera on 6/25/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IKAbstractDocument : NSObject
-(id)initWithDictionary:(NSDictionary *)dictionary;
-(NSDictionary *)dictionaryRepresentation;
@end
