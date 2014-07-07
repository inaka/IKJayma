//
//  IKSearchContactsViewController.m
//  IKJaymaSample
//
//  Created by Gera on 7/4/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import "IKSearchContactsViewController.h"
#import "IKUpdateContactViewController.h"

@interface IKSearchContactsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textFieldSearch;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation IKSearchContactsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)searchWithName:(NSString *)name
{
    [self.contactsRepository findContactsWithName:name success:^(NSArray *contacts) {
        self.contactsArray = [NSMutableArray arrayWithArray:contacts];
        [self.tableView reloadData];
    } failure:^(NSString *messageError) {
        [[[UIAlertView alloc]initWithTitle:@"ERROR" message:messageError delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil]show] ;    
    }];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.textFieldSearch.delegate = self;
	// Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contactsArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EmptyCell"];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EmptyCell"];
    }
    IKContact * contact = [self.contactsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = contact.contactName;
    self.automaticallyAdjustsScrollViewInsets = YES;
    return cell;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (!self.textFieldSearch.text || [self.textFieldSearch.text isEqualToString:@""])
        return NO;
    
    [self searchWithName:self.textFieldSearch.text];
    [self.textFieldSearch resignFirstResponder];
    return YES;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        IKUpdateContactViewController * controller = [self.storyboard instantiateViewControllerWithIdentifier:@"updateContactController"];
        controller.contactsRepository = self.contactsRepository;
        controller.contactToUpdate = [self.contactsArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:controller animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
