//
//  StudentListViewController.m
//  eInteract
//
//  Created by Mohsin Khan on 05/09/13.
//  Copyright (c) 2013 Codefrux Training. All rights reserved.
//

#import "StudentListViewController.h"

@interface StudentListViewController ()

@end

@implementation StudentListViewController

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
    
    [self.studentSearchBar setShowsScopeBar:NO];
    [self.studentSearchBar sizeToFit];
    
    Database *db = [Database INSTANCE];
    self.students = [db getAllStudents];
    self.title = @"Search Student";
    
    // Initialize the filteredStudents with a capacity equal to the students capacity
    self.filteredStudents = [NSMutableArray arrayWithCapacity:[self.students count]];
    
    
    // Reload the table
    [[self tableView] reloadData];
    
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
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    NSLog(@"Inside the cellForRow");
    // Configure the cell:
    //((UIImageView *)cell.backgroundView).image = [UIImage imageNamed:@"awardbg.png"];
    
    // Create a new User Object
    User *stdObj = nil;
    // Check to see whether the normal table or search results table is being displayed and set the Candy object from the appropriate array
    if (self.tableView == self.searchDisplayController.searchResultsTableView)
	{
        stdObj = [self.filteredStudents objectAtIndex:[indexPath row]];
    }
	else
	{
        stdObj = [self.students objectAtIndex:[indexPath row]];
    }
    
    
    NSString *cellText =stdObj.fullName;
    [(UILabel *)[cell.contentView viewWithTag:1] setText:cellText];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CourseMarksViewController *courseMarksController = [[CourseMarksViewController alloc]initWithNibName:@"CourseMarksViewController" bundle:nil];
    User *stdObj = [self.students objectAtIndex:indexPath.row];
    courseMarksController.user = stdObj;
    [self.navigationController pushViewController:courseMarksController animated:YES];
    
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
    
    // Check to see whether the normal table or search results table is being displayed and return the count from the appropriate array
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.filteredStudents count];
    } else {
        return [self.students count];
    }
}


#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	// Update the filtered array based on the search text and scope.
	
    // Remove all objects from the filtered search array
	[self.filteredStudents removeAllObjects];
    
	// Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.fullName contains[c] %@",searchText];
    NSArray *tempArray = [self.students filteredArrayUsingPredicate:predicate];
    
    /*if(![scope isEqualToString:@"All"]) {
        // Further filter the array with the scope
        NSPredicate *scopePredicate = [NSPredicate predicateWithFormat:@"SELF.fullName contains[c] %@",scope];
        tempArray = [tempArray filteredArrayUsingPredicate:scopePredicate];
    }*/
    
    self.filteredStudents = [NSMutableArray arrayWithArray:tempArray];
}


#pragma mark - UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}







- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
