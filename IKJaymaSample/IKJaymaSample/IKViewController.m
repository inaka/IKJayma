//
//  IKViewController.m
//  IKJaymaSample
//
//  Created by Gera on 7/2/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import "IKViewController.h"
#import "IKCreateContactViewController.h"
#import "IKUpdateContactViewController.h"
#import "IKSearchContactsViewController.h"
#import "Headers.h"
@interface IKViewController ()
@property (nonatomic,strong) IJAFNetworkingBackend *contactsBackend;
@property (nonatomic,strong) IKContactsRepository *contactsRepository;
@property (nonatomic,strong) NSMutableArray * contactsArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation IKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"CONTACTS";
    self.contactsArray = [NSMutableArray array];
    self.contactsBackend = [[IJAFNetworkingBackend alloc]init];
    self.contactsRepository = [[IKContactsRepository alloc]initWithBackend:self.contactsBackend];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                                                                target:self
                                                                                action:@selector(searchContacts:)];
    [[self navigationItem] setRightBarButtonItem:doneButton];
}
-(IBAction)searchContacts:(id)sender
{
    
    IKSearchContactsViewController * controller = [self.storyboard instantiateViewControllerWithIdentifier:@"searchContactsController"];
    controller.contactsRepository = self.contactsRepository;
    [self.navigationController pushViewController:controller animated:YES];
}
-(void)getContactsFromServer
{
    [self.contactsRepository findAllContactsWithSuccess:^(NSArray *contacts) {
        self.contactsArray = [NSMutableArray arrayWithArray:contacts];
        [self.tableView reloadData];
    } failure:^(NSString * errorMessage) {
        [[[UIAlertView alloc]initWithTitle:@"ERROR" message:errorMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil]show] ;
    }];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self getContactsFromServer];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contactsArray.count + 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EmptyCell"];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EmptyCell"];
    }
    IKContact * contact = nil;
    if (self.contactsArray.count > indexPath.row)
        contact = [self.contactsArray objectAtIndex:indexPath.row] ? [self.contactsArray objectAtIndex:indexPath.row] : nil;
    
    cell.textLabel.text = contact ? contact.contactName : @"Add a new contact";
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.contactsArray.count)
    {
        IKCreateContactViewController * controller = [self.storyboard instantiateViewControllerWithIdentifier:@"createContactController"];
        controller.contactsRepository = self.contactsRepository;
        [self.navigationController pushViewController:controller animated:YES];
    }else
    {
        IKUpdateContactViewController * controller = [self.storyboard instantiateViewControllerWithIdentifier:@"updateContactController"];
        controller.contactsRepository = self.contactsRepository;        
        controller.contactToUpdate = [self.contactsArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:controller animated:YES];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
