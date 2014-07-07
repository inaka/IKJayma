//
//  IKContact.h
//  IKJaymaSample
//
//  Created by Gera on 7/2/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import "IJAbstractDocument.h"

@interface IKContact : IJAbstractDocument
@property (nonatomic,strong)NSString * contactName;
@property (nonatomic,strong)NSString * contactPhone;
@property (nonatomic,strong)NSString * contactEmail;
@end
