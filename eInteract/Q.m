//
//  Q.m
//  eInteract
//
//  Created by Mohsin Khan on 25/08/13.
//  Copyright (c) 2013 Codefrux Training. All rights reserved.
//

#import "Q.h"

@implementation Q

NSString *const SELECT_USER_PROFILE_FOR_USERID = @"select userid,username,password,usertype,fullname,mobileno from users where username = ?";
NSString *const SELECT_COURSE_MARKS = @"select c.name as coursename,m.marks marks from course c,marks m where c.courseid = m.courseid and m.userid=?";

@end
