//
//  IJAbstractDocument.h
//  IKJayma
//
//  Created by Gera on 6/26/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IJAbstractDocument : NSObject
@property (nonatomic,strong) NSString * documentId;
-(id)initWithDictionary:(NSDictionary *)dictionary;
-(void)refreshWithDictionary:(NSDictionary *)dictionary;
-(NSDictionary *)dictionaryRepresentation;
@end