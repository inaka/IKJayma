//
//  IKViewController.m
//  IKJaymaSample
//
//  Created by Gera on 7/2/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import "IKViewController.h"
#import "IKCreateContactViewController.h"
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
    self.contactsArray = [NSMutableArray array];
    self.contactsBackend = [[IJAFNetworkingBackend alloc]init];
    self.contactsRepository = [[IKContactsRepository alloc]initWithBackend:self.contactsBackend];
    [self.contactsRepository findAllDocumentsWithSuccess:^(NSArray *documents) {
        self.contactsArray = [NSMutableArray arrayWithArray:documents];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
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
    IKContactDocument * contact = nil;
    if (self.contactsArray.count > indexPath.row)
        contact = [self.contactsArray objectAtIndex:indexPath.row] ? [self.contactsArray objectAtIndex:indexPath.row] : nil;
    
    cell.textLabel.text = contact ? [NSString stringWithFormat:@"%@ : %@",contact.contactName,contact.contactEmail] : @"Add a new contact";
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = indexPath.row;
    if (indexPath.row == self.contactsArray.count)
    {
        IKCreateContactViewController * controller = [self.storyboard instantiateViewControllerWithIdentifier:@"createContactController"];
        [self.navigationController pushViewController:controller animated:YES];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
