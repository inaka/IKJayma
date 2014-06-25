//
//  IKDocument.h
//  IKJaymaSampleApp
//
//  Created by Gera on 6/25/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import "IKAbstractDocument.h"

@interface IKDocument : IKAbstractDocument
@property (nonatomic,retain) NSString * firstName;
@property (nonatomic,retain) NSString * midName;
@property (nonatomic,retain) NSString * lastName;
@property (nonatomic,retain) NSString * email;
@property (nonatomic,retain) NSString * introduction;
@property (nonatomic) BOOL isActive;
@property (nonatomic) BOOL hasPoints;
@property (nonatomic) int points;
@property (nonatomic) int gamesPlayed;
@end
