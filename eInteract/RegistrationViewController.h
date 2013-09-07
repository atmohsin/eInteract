//
//  RegistrationViewController.h
//  eInteract
//
//  Created by Mohsin Khan on 22/08/13.
//  Copyright (c) 2013 Codefrux Training. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "UserTypeCell.h"

@interface RegistrationViewController : UIViewController <UITabBarControllerDelegate,UITableViewDataSource> {
    UserTypeCell *cell;
    NSString *userType;
}


@property (strong,nonatomic) NSArray *labelArray;
@property (strong,nonatomic) NSArray *name;
@property (strong,nonatomic) NSArray *icons;

@property (nonatomic,weak) IBOutlet UITextField *password;
@property (nonatomic,weak) IBOutlet UITextField *confirmPassword;
@property (nonatomic,weak) IBOutlet UITextField *emailId;
@property (nonatomic,weak) IBOutlet UITextField *mobileNo;
@property (nonatomic,weak) IBOutlet UITextField *fullName;

-(IBAction)submitBtn:(id)sender;
-(User *)populateUser;
- (IBAction)cancelBtn:(id)sender;

@end
