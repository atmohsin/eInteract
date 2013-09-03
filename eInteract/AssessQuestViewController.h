//
//  AssessQuestViewController.h
//  eInteract
//
//  Created by Mohsin Khan on 01/09/13.
//  Copyright (c) 2013 Codefrux Training. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"
#import "AssessTest.h"
#import "AssessResultViewController.h"
#import "GSRadioButtonSetController.h"

@interface AssessQuestViewController : UIViewController {
    int counter;
    int noOfCorrectAns;
    
}

@property (nonatomic,retain) IBOutlet UILabel *qno;
@property (nonatomic,retain) IBOutlet UILabel *qeustion;
@property (nonatomic,retain) IBOutlet UIButton *nextBtn;
@property (nonatomic,retain) IBOutlet UIButton *submitBtn;
@property (nonatomic,retain) IBOutlet UILabel *optionLbl1;
@property (nonatomic,retain) IBOutlet UILabel *optionLbl2;
@property (nonatomic,retain) IBOutlet UILabel *optionLbl3;
@property (nonatomic,retain) IBOutlet UILabel *optionLbl4;

@property (nonatomic,retain) AssessTest *assessTest;
@property (nonatomic,retain) NSMutableArray *questions;
@property (nonatomic,retain) NSMutableArray *options;

// Declare a property to represent your
// GSRadioButtonSetController instance
@property (nonatomic, strong) GSRadioButtonSetController *radioButtonSetController;
@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *optionsButtons;
@property (nonatomic,retain) IBOutlet UIButton *radioBtn1;
@property (nonatomic,retain) IBOutlet UIButton *radioBtn2;
@property (nonatomic,retain) IBOutlet UIButton *radioBtn3;
@property (nonatomic,retain) IBOutlet UIButton *radioBtn4;




-(IBAction)nextBtn:(id)sender;
-(IBAction)submitBtn:(id)sender;

@end
