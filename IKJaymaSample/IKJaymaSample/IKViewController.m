//
//  IKViewController.m
//  IKJaymaSample
//
//  Created by Gera on 7/2/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import "IKViewController.h"
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
    return self.contactsArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EmptyCell"];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EmptyCell"];
    }
    IKContactDocument * contact = [self.contactsArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ : %@",contact.contactName,contact.contactEmail];
    return cell;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
