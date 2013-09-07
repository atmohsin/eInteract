//
//  TeachersViewProfileViewController.h
//  eInteract
//
//  Created by Mohsin Khan on 30/08/13.
//  Copyright (c) 2013 Codefrux Training. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"
#import "StudentListViewController.h"

@interface TeachersViewProfileViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>{
    
}

@property (strong,nonatomic) IBOutlet UILabel *selectedCourse;
@property (strong,nonatomic) IBOutlet UILabel *marksObtained;
@property (strong,nonatomic) NSMutableArray *studentsList;
@property (strong,nonatomic) NSArray *tableValues;
@end
