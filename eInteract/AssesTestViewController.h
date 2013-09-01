//
//  AssesTestViewController.h
//  eInteract
//
//  Created by Mohsin Khan on 31/08/13.
//  Copyright (c) 2013 Codefrux Training. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AssessTest.h"
#import "Database.h"
#import "AssessQuestViewController.h"

@interface AssesTestViewController : UIViewController{
    
}

@property (nonatomic,retain) IBOutlet UILabel *subject;
@property (nonatomic,retain) IBOutlet UILabel *questions;
@property (nonatomic,retain) IBOutlet UILabel *durations;

@property (nonatomic,retain) User *user;
@property (nonatomic,retain) AssessTest *assessTest;

-(IBAction)startBtn:(id)sender;

@end
