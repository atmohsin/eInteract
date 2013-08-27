//
//  LoginViewController.m
//  eInteract
//
//  Created by Mohsin Khan on 22/08/13.
//  Copyright (c) 2013 Codefrux Training. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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


-(IBAction)signInBtn:(id)sender{
    NSString *userType = self.userType.text;
    NSString *userId = self.userId.text;
    NSString *userPassword = self.password.text;
    
    BOOL isValidate = YES;
    
    if([userId isEqualToString:@""]){
        self.userIdMessage.text = MSG_REQ;
        isValidate = NO;
    }
    if([userPassword isEqualToString:@""]){
        self.passwordMessage.text = MSG_REQ;
        isValidate = NO;
    }
    
    if (!isValidate) {
        return;
    }
    
    Database *db = [Database INSTANCE];
    User *user = [db getUser:userId];
    if (user == NULL) {
        [U showErrorMessage:USER_DOES_NOT_EXIT];
        return;
    }
    else{
        if(![userPassword isEqualToString:user.password]){
            [U showErrorMessage:USER_PASS_NOT_MATCH];
            return;
        }
    }
    
    if ([userType isEqualToString:@"s"]){
            StudentLoginViewController *studentLoginController = [[StudentLoginViewController alloc]initWithNibName:@"StudentLoginViewController" bundle:nil];
        [studentLoginController setUser:user];
            [self.navigationController pushViewController:studentLoginController animated:YES];
    }
    else {
        TeacherLoginViewController *teacherLoginController = [[TeacherLoginViewController alloc]initWithNibName:@"TeacherLoginViewController" bundle:nil];
        [self.navigationController pushViewController:teacherLoginController animated:YES];
    }
}

-(BOOL) textFieldShouldReturn :(UITextField *) textField {
    [textField resignFirstResponder];
    return NO;
}


@end
