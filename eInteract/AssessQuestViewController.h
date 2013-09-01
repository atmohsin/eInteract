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

@interface AssessQuestViewController : UIViewController {
    int counter;
    
}

@property (nonatomic,retain) IBOutlet UILabel *qno;
@property (nonatomic,retain) IBOutlet UILabel *qeustion;
@property (nonatomic,retain) IBOutlet UIButton *nextBtn;
@property (nonatomic,retain) IBOutlet UIButton *submitBtn;

@property (nonatomic,retain) AssessTest *assessTest;
@property (nonatomic,retain) NSMutableArray *questions;

-(IBAction)nextBtn:(id)sender;
-(IBAction)submitBtn:(id)sender;

@end
