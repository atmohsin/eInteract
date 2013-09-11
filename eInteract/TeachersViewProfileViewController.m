//
//  TeachersViewProfileViewController.m
//  eInteract
//
//  Created by Mohsin Khan on 30/08/13.
//  Copyright (c) 2013 Codefrux Training. All rights reserved.
//

#import "TeachersViewProfileViewController.h"

@interface TeachersViewProfileViewController ()

@end

@implementation TeachersViewProfileViewController

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
    self.studentsList = [db getAllStudentsCourseMarks];
    self.tableValues = [[NSArray alloc]initWithObjects:@"Select Student",@"Selected Course",@"Marks Obtained", nil];
    name = @"test";
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        // allocate the cell:
        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier];
        
        // create a background image for the cell:
        //UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundView:nil];
        [cell setIndentationWidth:0.0];
        
        // create a custom label:                                        x    y   width  height
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 8.0, 300.0, 30.0)];
        [nameLabel setTag:1];
        [nameLabel setBackgroundColor:[UIColor clearColor]]; // transparent label background
        [nameLabel setFont:[UIFont boldSystemFontOfSize:17.0]];
        //cell.selectionStyle=UITableViewCellSelectionStyleNone;
        // custom views should be added as subviews of the cell's contentView:
        [cell.contentView addSubview:nameLabel];
    }
    
    tableView.backgroundView=nil;

    
    // Configure the cell:
    //((UIImageView *)cell.backgroundView).image = [UIImage imageNamed:@"awardbg.png"];
    [(UILabel *)[cell.contentView viewWithTag:1] setText:[self.tableValues objectAtIndex:indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@" inside the didselect");
    StudentListViewController *studentListController = [[StudentListViewController alloc]initWithNibName:@"StudentListViewController" bundle:nil];
    [self.navigationController pushViewController:studentListController animated:YES];
    
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@" inside the diddselect");
    
    
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
    return 3;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
