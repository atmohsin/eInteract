//
//  AssesTestViewController.m
//  eInteract
//
//  Created by Mohsin Khan on 31/08/13.
//  Copyright (c) 2013 Codefrux Training. All rights reserved.
//

#import "AssesTestViewController.h"

@interface AssesTestViewController ()

@end

@implementation AssesTestViewController

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
    
    //get the enroled course for the logged in user
    Database *db = [Database INSTANCE];
    NSString *courseId = [db getEnrolCourseId:self.user.userId];
    
    //if we get the course then get the test for this course
    if(courseId != nil){
        self.assessTest = [db getAssessTest:courseId];
        self.subject.text = self.assessTest.subject;
        self.questions.text = self.assessTest.questions;
        self.durations.text = self.assessTest.duration;
    }
    
    UIBarButtonItem *startButton = [[UIBarButtonItem alloc] initWithTitle:@"Start" style:UIBarButtonItemStylePlain target:self action:@selector(startBtn:)];
    self.navigationItem.rightBarButtonItem = startButton;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)startBtn:(id)sender{
    AssessQuestViewController *questController = [[AssessQuestViewController alloc]initWithNibName:@"AssessQuestViewController" bundle:nil];
    questController.assessTest = self.assessTest;
    questController.user = self.user;
    [self.navigationController pushViewController:questController animated:YES];
}

@end
