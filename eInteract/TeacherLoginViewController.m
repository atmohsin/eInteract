//
//  TeacherLoginViewController.m
//  eInteract
//
//  Created by Mohsin Khan on 26/08/13.
//  Copyright (c) 2013 Codefrux Training. All rights reserved.
//

#import "TeacherLoginViewController.h"

@interface TeacherLoginViewController ()

@end

@implementation TeacherLoginViewController

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
    TeachersViewProfileViewController *teacherProfileViewController = [[TeachersViewProfileViewController alloc]initWithNibName:@"TeachersViewProfileViewController" bundle:nil];
    [self.navigationController pushViewController:teacherProfileViewController animated:YES];
}

@end
