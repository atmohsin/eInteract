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
    self.submitBtn.hidden = true;
    
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
    
}
-(IBAction)nextBtn:(id)sender{
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
        self.nextBtn.hidden = TRUE;
        self.submitBtn.hidden = FALSE;
    }
    
    
    NSString *strQno = [NSString stringWithFormat:@"%d",counter+1];
    self.qno.text = strQno;
    self.qeustion.text = quest.name;
    
}

-(IBAction)submitBtn:(id)sender{
    AssessResultViewController *resultController = [[AssessResultViewController alloc]initWithNibName:@"AssessResultViewController" bundle:nil];
    NSLog(@" No of correct ans %d",noOfCorrectAns);
    int score = (noOfCorrectAns*100)/20;
    NSLog(@"The Score is %d",score);
    resultController.scoreValue =  [NSString stringWithFormat:@"%d",score];;
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
