//
//  StudentViewProfileViewController.m
//  eInteract
//
//  Created by Mohsin Khan on 28/08/13.
//  Copyright (c) 2013 Codefrux Training. All rights reserved.
//

#import "StudentViewProfileViewController.h"

@interface StudentViewProfileViewController ()

@end

@implementation StudentViewProfileViewController

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
    Marks *marks = [db getCourseMakrs:self.user.userId];
    self.selectedCourse.text = marks.courseName;
    self.marksObtained.text = marks.marks;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
