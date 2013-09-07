//
//  CourseMarksViewController.h
//  eInteract
//
//  Created by Mohsin Khan on 05/09/13.
//  Copyright (c) 2013 Codefrux Training. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"

@interface CourseMarksViewController : UIViewController <UITableViewDelegate,UITableViewDataSource> {
    
}

@property (nonatomic,strong) NSMutableArray *marksCourseList;
@property (nonatomic,strong) User *user;

@end
