//
//  RegistrationViewController.h
//  eInteract
//
//  Created by Mohsin Khan on 22/08/13.
//  Copyright (c) 2013 Codefrux Training. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface RegistrationViewController : UIViewController{
    
}

@property (nonatomic,retain) IBOutlet UITextField *password;
@property (nonatomic,retain) IBOutlet UITextField *confirmPassword;
@property (nonatomic,retain) IBOutlet UITextField *emailId;
@property (nonatomic,retain) IBOutlet UITextField *mobileNo;
@property (nonatomic,retain) IBOutlet UITextField *fullName;

-(IBAction)submitBtn:(id)sender;
-(User *)populateUser;
- (IBAction)cancelBtn:(id)sender;

@end
