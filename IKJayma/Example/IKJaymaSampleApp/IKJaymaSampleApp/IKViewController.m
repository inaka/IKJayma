//
//  IKViewController.m
//  IKJaymaSampleApp
//
//  Created by Gera on 6/24/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import "IKViewController.h"
#import "IKDocument.h"

@interface IKViewController ()

@end

@implementation IKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDictionary * fakeDictionary = @{@"firstName": @"andres",
                                      @"midName": @"andres",
                                      @"lastName": @"andres",
                                      @"email": @"andres",
                                      @"introduction": @"andres",
                                      @"isActive": @true,
                                      @"hasPoints": @true,
                                      @"points": @20,
                                      @"gamesPlayed": @4.2};
    IKDocument * document = [[IKDocument alloc]initWithDictionary:fakeDictionary];
    
    NSDictionary * dict = [document dictionaryRepresentation];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
