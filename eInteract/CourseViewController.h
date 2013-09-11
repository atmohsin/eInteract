//
//  ViewController.h
//  CourseList
//
//  Created by Apple on 10/09/13.
//  Copyright (c) 2013 Codefrux. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"
#import "Course.h"

@interface CourseViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate>
{
    NSMutableArray *courses;
}

@end
