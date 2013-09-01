//
//  TeachersViewProfileViewController.m
//  eInteract
//
//  Created by Mohsin Khan on 30/08/13.
//  Copyright (c) 2013 Codefrux Training. All rights reserved.
//

#import "TeachersViewProfileViewController.h"

@interface TeachersViewProfileViewController ()

@end

@implementation TeachersViewProfileViewController

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
    
    Database *db = [Database INSTANCE];
    self.studentsList = [db getAllStudentsCourseMarks];

}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.studentsList count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.studentsList objectAtIndex:row];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
