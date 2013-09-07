//
//  StudentListViewController.h
//  eInteract
//
//  Created by Mohsin Khan on 05/09/13.
//  Copyright (c) 2013 Codefrux Training. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"
#import "CourseMarksViewController.h"

@interface StudentListViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate, UISearchDisplayDelegate>{
}

@property (nonatomic,retain) NSArray *students;
@property (strong,nonatomic) NSMutableArray *filteredStudents;
@property IBOutlet UISearchBar *studentSearchBar;
@property (nonatomic,strong) IBOutlet UITableView *tableView;

@end
