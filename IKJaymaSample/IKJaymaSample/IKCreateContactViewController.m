//
//  IKCreateContactViewController.m
//  IKJaymaSample
//
//  Created by Gera on 7/3/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import "IKCreateContactViewController.h"

@interface IKCreateContactViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textFieldName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPhone;

@end

@implementation IKCreateContactViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
- (IBAction)createContact:(id)sender
{
    if (!self.textFieldName.text || [self.textFieldName.text isEqualToString:@""])
        return;
    NSDictionary * contactDictionary = @{@"name" : self.textFieldName.text
                                         ,@"email" : self.textFieldEmail.text
                                         ,@"phone" : self.textFieldPhone.text};
    IKContactDocument * contact = [[IKContactDocument alloc] initWithDictionary:contactDictionary];
    [self.contactsRepository createDocument:contact success:^(IJAbstractDocument *document) {
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
