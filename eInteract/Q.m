//
//  Q.m
//  eInteract
//
//  Created by Mohsin Khan on 25/08/13.
//  Copyright (c) 2013 Codefrux Training. All rights reserved.
//

#import "Q.h"

@implementation Q

NSString *const SELECT_USER_PROFILE_FOR_USERID = @"select userid,password,usertype,fullname,mobileno from userprofile where userid = ?";

@end
