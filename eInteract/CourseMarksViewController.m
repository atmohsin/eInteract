//
//  CourseMarksViewController.m
//  eInteract
//
//  Created by Mohsin Khan on 05/09/13.
//  Copyright (c) 2013 Codefrux Training. All rights reserved.
//

#import "CourseMarksViewController.h"

@interface CourseMarksViewController ()

@end

@implementation CourseMarksViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    Database *db = [Database INSTANCE];
    self.marksCourseList = [db getCouseMarksForStudent:self.user.userId];
    self.title = self.user.fullName;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        // allocate the cell:
        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier];
        
        [cell setIndentationWidth:0.0];
        
        // create a custom label:                                        x    y   width  height
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 8.0, 300.0, 30.0)];
        [nameLabel setTag:1];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        [nameLabel setFont:[UIFont boldSystemFontOfSize:17.0]];
        cell.backgroundColor=[UIColor whiteColor];
        [cell.contentView addSubview:nameLabel];
    }
    
    // Configure the cell:
    //((UIImageView *)cell.backgroundView).image = [UIImage imageNamed:@"awardbg.png"];
    Marks *marksObj = [self.marksCourseList objectAtIndex:indexPath.row];
    NSString *cellText = [[NSString alloc]initWithFormat:@" Course : %@  Marks : %@",marksObj.courseName,marksObj.marks];
    [(UILabel *)[cell.contentView viewWithTag:1] setText:cellText];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.marksCourseList count];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
