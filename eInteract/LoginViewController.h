//
//  LoginViewController.h
//  eInteract
//
//  Created by Mohsin Khan on 22/08/13.
//  Copyright (c) 2013 Codefrux Training. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "Database.h"
#import "StudentLoginViewController.h"
#import "TeacherLoginViewController.h"
#import "M.h"
#import "U.h"

@interface LoginViewController : UIViewController{
    
}

@property (nonatomic,retain) IBOutlet UITextField *userId;
@property (nonatomic,retain) IBOutlet UITextField *password;
@property (nonatomic,retain) IBOutlet UITextField *userType;
@property (nonatomic,retain) IBOutlet UILabel *message;
@property (nonatomic,retain) IBOutlet UILabel *userIdMessage;
@property (nonatomic,retain) IBOutlet UILabel *passwordMessage;

@property (nonatomic,retain) User *user;

-(IBAction)signInBtn:(id)sender;

@end
