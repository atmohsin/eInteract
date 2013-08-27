//
//  StudentLoginViewController.h
//  eInteract
//
//  Created by Mohsin Khan on 23/08/13.
//  Copyright (c) 2013 Codefrux Training. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "ViewController.h"


@interface StudentLoginViewController : UIViewController{
    
}


@property (nonatomic,retain) IBOutlet UILabel *userName;
@property (nonatomic,retain) User *user;

-(IBAction)signOut:(id)sender;

@end
