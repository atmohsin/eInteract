//
//  AssessQuestViewController.m
//  eInteract
//
//  Created by Mohsin Khan on 01/09/13.
//  Copyright (c) 2013 Codefrux Training. All rights reserved.
//

#import "AssessQuestViewController.h"

@interface AssessQuestViewController ()

@end

@implementation AssessQuestViewController

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
    self.questions = [db getQuestForTest:self.assessTest.testId];
    counter = 0;
    Quest *quest = [self.questions objectAtIndex:counter];
    NSString *strQno = [NSString stringWithFormat:@"%d",counter+1];
    self.qno.text = strQno;
    self.qeustion.text = quest.name;
    self.submitBtn.hidden = true;
    
}
-(IBAction)nextBtn:(id)sender{
    counter +=1;
    Quest *quest = [self.questions objectAtIndex:counter];
    
    if(counter+1 == [self.questions count]){
        self.nextBtn.hidden = TRUE;
        self.submitBtn.hidden = FALSE;
    }
    
    
    NSString *strQno = [NSString stringWithFormat:@"%d",counter+1];
    self.qno.text = strQno;
    self.qeustion.text = quest.name;
    
}

-(IBAction)submitBtn:(id)sender{
    AssessResultViewController *resultController = [[AssessResultViewController alloc]initWithNibName:@"AssessResultViewController" bundle:nil];
    [self.navigationController pushViewController:resultController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
