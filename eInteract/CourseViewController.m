//
//  ViewController.m
//  CourseList
//
//  Created by Apple on 10/09/13.
//  Copyright (c) 2013 Codefrux. All rights reserved.
//

#import "CourseViewController.h"
#import "CourseDetailViewController.h"

@interface CourseViewController ()

@end

@implementation CourseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    Database *db = [Database INSTANCE];
    courses = [db getAvailableCourses];
    self.title = @"Available Courses";
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId=@"Cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    Course *course = [[Course alloc]init];
    course = [courses objectAtIndex:indexPath.row];
    cell.textLabel.text=course.name;
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [courses count];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CourseDetailViewController *courseDetailsController=[[CourseDetailViewController alloc]init];
    Course *course = [[Course alloc]init];
    course = [courses objectAtIndex:indexPath.row];
    courseDetailsController.course = course;
    [self.navigationController pushViewController:courseDetailsController animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
