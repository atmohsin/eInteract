//
//  LoginViewController.m
//  eInteract
//
//  Created by Mohsin Khan on 22/08/13.
//  Copyright (c) 2013 Codefrux Training. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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
    self.userId.text = @"test";
    self.password.text = @"test";
    //self.userType.text = @"s";
    self.name = [[NSArray alloc]initWithObjects:@"Teacher",@"Student", nil];
    self.icons = [[NSArray alloc]initWithObjects:@"Teacher.png",@"Student.png", nil];
    self.title = @"Login";
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str=@"CellId";
    cell=(UserTypeCell *)[tableView dequeueReusableCellWithIdentifier:str];
    
    if(cell==nil)
    {
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"UserTypeCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
        
    }
    //    tableView.tableHeaderView= nil;
    //    tableView.tableFooterView=nil;
    tableView.backgroundView=nil;
    cell.label1.text=[self.name objectAtIndex:indexPath.row];
    cell.image1.image=[UIImage imageNamed:[self.icons objectAtIndex:indexPath.row]];
    [cell.image2 setHidden:YES];
    cell.backgroundColor=[UIColor whiteColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return  cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell=(UserTypeCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    userType= [[cell.label1.text substringToIndex:1] substringFromIndex:0];
    [cell.image2 setHidden:NO];
    
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell=(UserTypeCell*)[tableView cellForRowAtIndexPath:indexPath];
    [cell.image2 setHidden:YES];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)signInBtn:(id)sender{
    NSString *userId = self.userId.text;
    NSString *userPassword = self.password.text;
    
    BOOL isValidate = YES;
    
    if([userId isEqualToString:@""]){
        self.userIdMessage.text = MSG_REQ;
        isValidate = NO;
    }
    if([userPassword isEqualToString:@""]){
        self.passwordMessage.text = MSG_REQ;
        isValidate = NO;
    }
    
    if (!isValidate) {
        return;
    }
    
    Database *db = [Database INSTANCE];
    User *user = [db getUser:userId];
    if (user == NULL) {
        [U showErrorMessage:USER_DOES_NOT_EXIT];
        return;
    }
    else{
        if(![userPassword isEqualToString:user.password]){
            [U showErrorMessage:USER_PASS_NOT_MATCH];
            return;
        }
    }
    
    if ([userType isEqualToString:@"S"]){
            StudentLoginViewController *studentLoginController = [[StudentLoginViewController alloc]initWithNibName:@"StudentLoginViewController" bundle:nil];
        [studentLoginController setUser:user];
            [self.navigationController pushViewController:studentLoginController animated:YES];
    }
    else {
        TeacherLoginViewController *teacherLoginController = [[TeacherLoginViewController alloc]initWithNibName:@"TeacherLoginViewController" bundle:nil];
        [teacherLoginController setUser:user];
        [self.navigationController pushViewController:teacherLoginController animated:YES];
    }
}

-(BOOL) textFieldShouldReturn :(UITextField *) textField {
    [textField resignFirstResponder];
    return NO;
}


@end
