//
//  CourseDetailViewController.h
//  CourseList
//
//  Created by Apple on 10/09/13.
//  Copyright (c) 2013 Codefrux. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course.h"

@interface CourseDetailViewController : UIViewController {
    
}
@property (weak, nonatomic) IBOutlet UILabel *faculty;
@property (weak, nonatomic) IBOutlet UILabel *duration;
@property (weak, nonatomic) IBOutlet UILabel *fees;
@property (weak,nonatomic) IBOutlet UILabel *courseName;

@property (strong,nonatomic) Course *course;

@end
