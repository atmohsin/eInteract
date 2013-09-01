//
//  ViewController.m
//  eInteract
//
//  Created by Codefrux Training on 8/22/13.
//  Copyright (c) 2013 Codefrux Training. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"
#import "RegistrationViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
UIColor *color = [UIColor colorWithRed:226/255.0f green:4/255.0f blue:6/255.0f alpha:1.0f];
    self.navigationController.navigationBar.tintColor = color;
    self.title = @"eInteract";

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)loginBtn:(id)sender{
    LoginViewController *loginController = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    //[self presentViewController:loginController animated:YES completion:nil];
    [self.navigationController pushViewController:loginController animated:YES];
}

-(IBAction)registerBtn:(id)sender{
    RegistrationViewController *regController = [[RegistrationViewController alloc]initWithNibName:@"RegistrationViewController" bundle:nil];
    [self presentViewController:regController animated:YES completion:nil];
}

@end
