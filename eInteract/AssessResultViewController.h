//
//  AssessResultViewController.h
//  eInteract
//
//  Created by Mohsin Khan on 01/09/13.
//  Copyright (c) 2013 Codefrux Training. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StudentLoginViewController.h"

@interface AssessResultViewController : UIViewController {
    
}

@property (nonatomic,retain) NSString *scoreValue;
@property (nonatomic,retain) IBOutlet UILabel *scoreLbl;

-(IBAction)homeBtn:(id)sender;

@end
