//
//  AssessResultViewController.m
//  eInteract
//
//  Created by Mohsin Khan on 01/09/13.
//  Copyright (c) 2013 Codefrux Training. All rights reserved.
//

#import "AssessResultViewController.h"

@interface AssessResultViewController ()

@end

@implementation AssessResultViewController

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
    // Do any additional setup after loading the view from its nib.
    self.scoreLbl.text = self.scoreValue;
    self.title = @"Result";
    
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain target:self action:@selector(homeBtn:)];
    self.navigationItem.rightBarButtonItem = homeButton;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)homeBtn:(id)sender{
    StudentLoginViewController *studentController = [[StudentLoginViewController alloc]initWithNibName:@"StudentLoginViewController" bundle:nil];
    studentController.user = self.user;
    [self.navigationController pushViewController:studentController animated:YES];
}

@end
