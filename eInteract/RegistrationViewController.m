//
//  RegistrationViewController.m
//  eInteract
//
//  Created by Mohsin Khan on 22/08/13.
//  Copyright (c) 2013 Codefrux Training. All rights reserved.
//

#import "RegistrationViewController.h"
#import "User.h"
#import "Database.h"

@interface RegistrationViewController ()

@end

@implementation RegistrationViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) textFieldShouldReturn :(UITextField *) textField {
    [textField resignFirstResponder];
    return NO;
}


-(User *)populateUser{
    User *user = [[User alloc]init];
    user.userName = self.emailId.text;
    user.password = self.password.text;
    user.userType = @"S";
    user.fullName = self.fullName.text;
    user.mobileNo = self.mobileNo.text;
    
    return user;
    
}

- (IBAction)cancelBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)submitBtn:(id)sender{
    Database *db = [Database INSTANCE];
    User *user = [self populateUser];
    
    [db createUser:user.userName password:user.password usertype:user.userType fullname:user.fullName mobileno:user.mobileNo];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
