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
    self.title = @"Creating contact...";
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                target:self
                                                                                action:@selector(createContact:)];
    [[self navigationItem] setRightBarButtonItem:doneButton];
	// Do any additional setup after loading the view.
}
- (IBAction)createContact:(id)sender
{
    if (!self.textFieldName.text || [self.textFieldName.text isEqualToString:@""])
        return;
    NSDictionary * contactDictionary = @{@"name" : self.textFieldName.text
                                         ,@"email" : self.textFieldEmail.text
                                         ,@"phone" : self.textFieldPhone.text};
    IKContact * contact = [[IKContact alloc] initWithDictionary:contactDictionary];
//    [self.contactsRepository createContact:contact success:^(IKContact *contact) {
//        [self.navigationController popViewControllerAnimated:YES];
//    } failure:^(NSString *errorMessage) {
//                [[[UIAlertView alloc]initWithTitle:@"ERROR" message:errorMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil]show];
//    } ];
	
	[self.contactsRepository createDocument:contact success:^(id<IJDocumentProtocol>document) {
		[self.navigationController popViewControllerAnimated:YES];
	} failure:^(IJError *error) {
		[[[UIAlertView alloc]initWithTitle:@"ERROR"
								   message:error.localizedDescription
								  delegate:nil
						 cancelButtonTitle:@"OK"
						 otherButtonTitles: nil] show];
	}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
