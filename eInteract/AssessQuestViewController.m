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
    noOfCorrectAns = 0;
    Quest *quest = [self.questions objectAtIndex:counter];
    NSString *strQno = [NSString stringWithFormat:@"%d",counter+1];
    self.qno.text = strQno;
    self.qeustion.text = quest.name;
    
    // Instantiate your GSRadioButtonSetController object
    self.radioButtonSetController = [[GSRadioButtonSetController alloc] init];
    
    // Set its delegate to your view controller
    self.radioButtonSetController.delegate = self;
    
    // Set its buttons property to an array of buttons that you've
    // created previously.
    self.radioButtonSetController.buttons = self.optionsButtons;
    
    [self.radioBtn1 setImage:[UIImage imageNamed:@"button-off.png"] forState:UIControlStateNormal];
    [self.radioBtn1 setImage:[UIImage imageNamed:@"button-on.png"] forState:UIControlStateSelected];
    
    [self.radioBtn2 setImage:[UIImage imageNamed:@"button-off.png"] forState:UIControlStateNormal];
    [self.radioBtn2 setImage:[UIImage imageNamed:@"button-on.png"] forState:UIControlStateSelected];
    
    
    [self.radioBtn3 setImage:[UIImage imageNamed:@"button-off.png"] forState:UIControlStateNormal];
    [self.radioBtn3 setImage:[UIImage imageNamed:@"button-on.png"] forState:UIControlStateSelected];
    
    
    [self.radioBtn4 setImage:[UIImage imageNamed:@"button-off.png"] forState:UIControlStateNormal];
    [self.radioBtn4 setImage:[UIImage imageNamed:@"button-on.png"] forState:UIControlStateSelected];
    
    self.options = [[NSMutableArray alloc]init];
    
    self.options = [db getAnsOptoins:quest.qid];
    
    AnsOptions *opt1 = [[AnsOptions alloc]init];
    opt1 = [self.options objectAtIndex:0];
    self.optionLbl1.text = opt1.name;
    
    AnsOptions *opt2 = [[AnsOptions alloc]init];
    opt2 = [self.options objectAtIndex:1];
    self.optionLbl2.text = opt2.name;
    
    AnsOptions *opt3 = [[AnsOptions alloc]init];
    opt3 = [self.options objectAtIndex:2];
    self.optionLbl3.text = opt3.name;
    
    AnsOptions *opt4 = [[AnsOptions alloc]init];
    opt4 = [self.options objectAtIndex:3];
    self.optionLbl4.text = opt4.name;
    
    if(counter+1 == [self.questions count]){
        
        UIBarButtonItem *submitButton = [[UIBarButtonItem alloc] initWithTitle:@"Submit" style:UIBarButtonItemStylePlain target:self action:@selector(submitBtn:)];
        self.navigationItem.rightBarButtonItem = submitButton;
        
    }
    else {
        UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(nextBtn:)];
        self.navigationItem.rightBarButtonItem = nextButton;
    }

   self.secondsLeft = 60;
   [self countdownTimer];

}

-(void)countdownTimer{
    
    self.hours = self.minutes = self.seconds = 0;
    [self.timer invalidate];
    self.timer = nil;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateCounter:) userInfo:nil repeats:YES];
}

- (void)updateCounter:(NSTimer *)theTimer {
    if(self.secondsLeft > 0 ){
        self.secondsLeft -- ;
        self.hours = self.secondsLeft / 3600;
        self.minutes = (self.secondsLeft % 3600) / 60;
        self.seconds = (self.secondsLeft %3600) % 60;
        self.counterLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d",self.hours, self.minutes, self.seconds];
    }
    else{
        [self.timer invalidate];
        self.timer = nil;
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@""
                                                          message:@"Time for test is over. Click ok to View the score."
                                                         delegate:self
                                                cancelButtonTitle:@"Ok"
                                                otherButtonTitles:nil, nil];
        [message show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
	if([title isEqualToString:@"Ok"])
	{
		[self submitBtn:nil];
	}
}


-(IBAction)nextBtn:(id)sender{

    self.radioButtonSetController.selectedIndex = NSNotFound;
    self.radioBtn1.selected = NO;
    self.radioBtn2.selected = NO;
    self.radioBtn3.selected = NO;
    self.radioBtn4.selected = NO;
    
    counter +=1;
    Quest *quest = [self.questions objectAtIndex:counter];
    
    Database *db = [Database INSTANCE];
    
    
    self.options = [db getAnsOptoins:quest.qid];
    
    AnsOptions *opt1 = [[AnsOptions alloc]init];
    opt1 = [self.options objectAtIndex:0];
    self.optionLbl1.text = opt1.name;
    
    AnsOptions *opt2 = [[AnsOptions alloc]init];
    opt2 = [self.options objectAtIndex:1];
    self.optionLbl2.text = opt2.name;
    
    AnsOptions *opt3 = [[AnsOptions alloc]init];
    opt3 = [self.options objectAtIndex:2];
    self.optionLbl3.text = opt3.name;
    
    AnsOptions *opt4 = [[AnsOptions alloc]init];
    opt4 = [self.options objectAtIndex:3];
    self.optionLbl4.text = opt4.name;
    
    
    if(counter+1 == [self.questions count]){
        
        UIBarButtonItem *submitButton = [[UIBarButtonItem alloc] initWithTitle:@"Submit" style:UIBarButtonItemStylePlain target:self action:@selector(submitBtn:)];
        self.navigationItem.rightBarButtonItem = submitButton;
        
    }
    else {
        UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(nextBtn:)];
        self.navigationItem.rightBarButtonItem = nextButton;
    }
    
    
    NSString *strQno = [NSString stringWithFormat:@"%d",counter+1];
    self.qno.text = strQno;
    self.qeustion.text = quest.name;
    
}

-(IBAction)submitBtn:(id)sender{
    [self.timer invalidate];
    self.timer = nil;

    AssessResultViewController *resultController = [[AssessResultViewController alloc]initWithNibName:@"AssessResultViewController" bundle:nil];
    NSLog(@" No of correct ans %d",noOfCorrectAns);
    int score = (noOfCorrectAns*100)/20;
    NSLog(@"The Score is %d",score);
    NSString *scoreValue = [NSString stringWithFormat:@"%d",score];
    
    Database *db = [Database INSTANCE];
    Marks *mObj = [[Marks alloc]init];
    mObj.courseId = self.assessTest.courseId;
    mObj.marks = scoreValue;
    mObj.userId = self.user.userId;
    [db insertUpdateMarks:mObj];
    
    resultController.scoreValue =  scoreValue;
    resultController.user = self.user;
    [self.navigationController pushViewController:resultController animated:YES];
}


- (void)radioButtonSetController:(GSRadioButtonSetController *)controller
          didSelectButtonAtIndex:(NSUInteger)selectedIndex
{
    // Handle button selection here
    NSLog(@"Someone just selected button %u!", selectedIndex);
    
    AnsOptions *selectedOpt = [[AnsOptions alloc]init];
    selectedOpt = [self.options objectAtIndex:selectedIndex];
    
    for (AnsOptions *opt in self.options){
    
        if([opt.iscorrect isEqualToString:@"1"] && [selectedOpt.optid isEqualToString:opt.optid]){
            NSLog(@"This is correct ans");
            noOfCorrectAns += 1;
            
        }
    }
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
