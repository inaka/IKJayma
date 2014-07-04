//
//  IKSearchContactsViewController.h
//  IKJaymaSample
//
//  Created by Gera on 7/4/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Headers.h"
@interface IKSearchContactsViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property(nonatomic,weak)IKContactsRepository * contactsRepository;
@property(nonatomic,strong)NSMutableArray *contactsArray;
@end
