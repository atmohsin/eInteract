//
//  StudentLoginViewController.m
//  eInteract
//
//  Created by Mohsin Khan on 23/08/13.
//  Copyright (c) 2013 Codefrux Training. All rights reserved.
//

#import "StudentLoginViewController.h"

@interface StudentLoginViewController ()

@end

@implementation StudentLoginViewController

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
    [self.navigationItem setHidesBackButton:YES animated:YES];
    self.userName.text = self.user.fullName;
    
    UIBarButtonItem *signOutButton = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:self action:@selector(signOut:)];
    self.navigationItem.rightBarButtonItem = signOutButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)signOut:(id)sender{
    
    NSArray *viewControllers = [[self navigationController] viewControllers];
    for( int i=0;i<[viewControllers count];i++){
        id obj=[viewControllers objectAtIndex:i];
        if([obj isKindOfClass:[ViewController class]]){
            [[self navigationController] popToViewController:obj animated:YES];
            return;
        }
    }
}

-(IBAction)viewProfileBtn:(id)sender {
    StudentViewProfileViewController *studentProfileViewController = [[StudentViewProfileViewController alloc]initWithNibName:@"StudentViewProfileViewController" bundle:nil];
    studentProfileViewController.user = self.user;
    [self.navigationController pushViewController:studentProfileViewController animated:YES];
}

-(IBAction)assessTest:(id)sender{
    AssesTestViewController *assessTestControll = [[AssesTestViewController alloc]initWithNibName:@"AssesTestViewController" bundle:nil];
    assessTestControll.user = self.user;
    [self.navigationController pushViewController:assessTestControll animated:YES];
}


@end
