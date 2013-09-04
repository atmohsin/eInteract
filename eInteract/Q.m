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
NSString *const SELECT_COURSE_MARKS = @"select c.name as coursename,m.marks,c.courseid marks from course c,marks m where c.courseid = m.courseid and m.userid=?";
NSString *const SELECT_STUDENTS_COURSE_MARKS = @"select c.name as coursename,m.marks as marks ,u.userid as userId,u.fullname as fullname from course c,marks m,users u where c.courseid = m.courseid and m.userId=u.userid and u.usertype = 'S'";
NSString *const SELECT_ENROL_COURSE_ID = @"select courseid from enrol_course where userid = ?;";
NSString *const SELECT_ASSESS_TEST = @"select c.name,at.questions,at.duration,at.testid,c.courseid from assess_test at,course c where at.courseid = c.courseid and at.courseid=?";
NSString *const SELECT_TEST_QUEST = @"SELECT qid,name name FROM assess_quest where testid =?";
NSString *const SELECT_QUEST_OPT = @"SELECT optid,name,iscorrect FROM assess_quest_opt where qid =?";


@end
