//
//  Database.h
//  eInteract
//
//  Created by Mohsin Khan on 23/08/13.
//  Copyright (c) 2013 Codefrux Training. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Q.h"
#import "User.h"
#import "Marks.h"

@interface Database : NSObject{
    
}


@property (nonatomic,retain) NSString *databasePath;
@property (nonatomic,retain) NSString *databaseName;

//making Database Class has singleton
-(id)init;
-(void) checkAndCreateDatabase;
+(Database *)INSTANCE;
+(void)CreateInstance;

-(BOOL) createUser : (NSString *)username
password : (NSString *) password
usertype : (NSString *) usertype
fullname : (NSString *) fullname
          mobileno : (NSString *) mobileno;

-(User *)getUser :(NSString *) userName;
-(Marks *)getCourseMakrs : (NSString *)userId;


@end
