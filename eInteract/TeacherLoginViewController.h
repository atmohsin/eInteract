//
//  TeacherLoginViewController.h
//  eInteract
//
//  Created by Mohsin Khan on 26/08/13.
//  Copyright (c) 2013 Codefrux Training. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "StudentListViewController.h"
#import "User.h"

@interface TeacherLoginViewController : UIViewController {
    
}

@property (nonatomic,weak) IBOutlet UILabel *userName;
@property (nonatomic,strong) User *user;


-(IBAction)signOut:(id)sender;
-(IBAction)viewProfileBtn:(id)sender;

@end
