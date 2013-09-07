//
//  RegistrationViewController.m
//  eInteract
//
//  Created by Mohsin Khan on 22/08/13.
//  Copyright (c) 2013 Codefrux Training. All rights reserved.
//

#import "RegistrationViewController.h"
#import "User.h"
#import "Database.h"
#import "UserTypeCell.h"


@interface RegistrationViewController ()

@end

@implementation RegistrationViewController

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
    
    self.name= [[NSArray alloc]initWithObjects:@"Teacher",@"Student",nil];
    self.icons=[[NSArray alloc]initWithObjects:@"Teacher.png",@"Student.png",nil];

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
    
    tableView.backgroundView=nil;
    cell.label1.text=[self.name objectAtIndex:indexPath.row];
    cell.image1.image=[UIImage imageNamed:[self.icons objectAtIndex:indexPath.row]];
    [cell.image2 setHidden:YES];
    //  cell.backgroundColor=[UIColor whiteColor];
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
    return 40;
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

-(BOOL) textFieldShouldReturn :(UITextField *) textField {
    [textField resignFirstResponder];
    return NO;
}


-(User *)populateUser{
    User *user = [[User alloc]init];
    user.userName = self.emailId.text;
    user.password = self.password.text;
    user.userType = userType;
    user.fullName = self.fullName.text;
    user.mobileNo = self.mobileNo.text;
    
    return user;
    
}

- (IBAction)cancelBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)submitBtn:(id)sender{
    Database *db = [Database INSTANCE];
    User *user = [self populateUser];
    
    [db createUser:user.userName password:user.password usertype:user.userType fullname:user.fullName mobileno:user.mobileNo];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
