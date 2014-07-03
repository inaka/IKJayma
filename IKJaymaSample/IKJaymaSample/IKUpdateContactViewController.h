//
//  IKUpdateContactViewController.h
//  IKJaymaSample
//
//  Created by Gera on 7/3/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Headers.h"
@interface IKUpdateContactViewController : UIViewController
@property (nonatomic,weak)IKContactsRepository * contactsRepository;
@property (nonatomic,weak)IKContact *contactToUpdate;
@end
