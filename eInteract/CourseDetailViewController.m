//
//  CourseDetailViewController.m
//  CourseList
//
//  Created by Apple on 10/09/13.
//  Copyright (c) 2013 Codefrux. All rights reserved.
//

#import "CourseDetailViewController.h"

@interface CourseDetailViewController ()

@end

@implementation CourseDetailViewController

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
    self.faculty.text = self.course.facultyFullName;
    self.fees.text = self.course.fee;
    self.duration.text = self.course.duration;
    self.courseName.text = self.course.name;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
