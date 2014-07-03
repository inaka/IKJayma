//
//  IKUpdateContactViewController.m
//  IKJaymaSample
//
//  Created by Gera on 7/3/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import "IKUpdateContactViewController.h"

@interface IKUpdateContactViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textFieldName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPhone;

@end

@implementation IKUpdateContactViewController

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
    [super viewDidLoad];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                target:self
                                                                                action:@selector(updateContact:)];
    [[self navigationItem] setRightBarButtonItem:doneButton];
    
    self.textFieldName.text = self.contactToUpdate.contactName;
    self.textFieldPhone.text = self.contactToUpdate.contactPhone;
    self.textFieldEmail.text = self.contactToUpdate.contactEmail;
}
- (IBAction)updateContact:(id)sender
{
    if (!self.textFieldName.text || [self.textFieldName.text isEqualToString:@""])
        return;
    
    self.contactToUpdate.contactName = self.textFieldName.text;
    self.contactToUpdate.contactEmail = self.textFieldEmail.text;
    self.contactToUpdate.contactPhone = self.textFieldPhone.text;
    
    [self.contactsRepository updateDocument:self.contactToUpdate success:^(IJAbstractDocument *document) {
        
    } failure:^(NSError *error) {
    
    }];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
