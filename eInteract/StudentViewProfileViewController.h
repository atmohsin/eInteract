//
//  StudentViewProfileViewController.h
//  eInteract
//
//  Created by Mohsin Khan on 28/08/13.
//  Copyright (c) 2013 Codefrux Training. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "Database.h"
#import "Marks.h"

@interface StudentViewProfileViewController : UIViewController {
    
}

@property (nonatomic,retain) IBOutlet UILabel *marksObtained;
@property (nonatomic,retain) IBOutlet UILabel *selectedCourse;
@property (nonatomic,retain) User *user;


@end
