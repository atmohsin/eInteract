//
//  Database.m
//  eInteract
//
//  Created by Mohsin Khan on 23/08/13.
//  Copyright (c) 2013 Codefrux Training. All rights reserved.
//

#import "Database.h"

@implementation Database

@synthesize databaseName;
@synthesize databasePath;

static Database *instance = NULL;

+(void)CreateInstance{
    @synchronized(self){
        if( NULL == instance){
            instance = [[Database alloc]init];
        }
    }
}

+(Database *)INSTANCE {
    [self CreateInstance];
    return instance;
}

-(id) init{
    self.databaseName = @"eInteractdb.sqlite";
    
    // Get the path to the documents directory and append the databaseName
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    self.databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
    
    // Execute the "checkAndCreateDatabase" function
    [self checkAndCreateDatabase];
    
    return self;
}

-(NSString *)toNSString:(char *)utfString {
    if(NULL != utfString) {
        return [NSString stringWithUTF8String:utfString];
    }
    return nil;
}

-(void) checkAndCreateDatabase {
    //check the databse is copyied into document directory if not copy it
    BOOL sucess;
    
    //Create the object of fileManager, we will use this object to check the
    //status and to copy the database to the document directory
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //check database is created in document folder
    sucess = [fileManager fileExistsAtPath:self.databasePath];
    
    //If the database is exist return it without doing anything
    
    if(sucess){
        return;
    }
    
    // Get the path to the database in the application package
    NSString *databasePathFromApp = [[NSBundle mainBundle]pathForResource:@"eInteractdb"ofType:@"sqlite"];
    
    // Copy the database from the package to the users filesystem
    [fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
}

-(BOOL) createUser:(NSString *)username password:(NSString *)password usertype:(NSString *)usertype fullname:(NSString *)fullname mobileno:(NSString *)mobileno {
    BOOL inserted = YES;
    sqlite3 *db;
    
    if(sqlite3_open([self.databasePath UTF8String], &db) == SQLITE_OK){
        const char *sqlStatement = [@"insert into users (username,password,usertype,fullname,mobileno) values (?,?,?,?,?)" UTF8String];
        sqlite3_stmt *compiledStatement;
        
        if (sqlite3_prepare_v2(db, sqlStatement, -1, &compiledStatement, nil) == SQLITE_OK) {
            sqlite3_bind_text(compiledStatement, 1, [username UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(compiledStatement, 2, [password UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(compiledStatement, 3, [usertype UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(compiledStatement, 4, [fullname UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(compiledStatement, 5, [mobileno UTF8String], -1, SQLITE_TRANSIENT);
            
            if(sqlite3_step(compiledStatement) != SQLITE_DONE ) {
                NSLog( @"createUser Error: %s", sqlite3_errmsg(db) );
                inserted = NO;
            }
            sqlite3_finalize(compiledStatement);
        }
    }
    sqlite3_close(db);
    return inserted;
}

-(User *) getUser:(NSString *)userName {
    User *user = NULL;
    
    sqlite3 *db;
    if(sqlite3_open([self.databasePath UTF8String], &db) == SQLITE_OK) {
        const char *sqlStatement = [SELECT_USER_PROFILE_FOR_USERID UTF8String];
        sqlite3_stmt *compiledStatement;
        if(sqlite3_prepare_v2(db, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)  {
            sqlite3_bind_text(compiledStatement, 1, [userName UTF8String], -1, SQLITE_TRANSIENT);
            
            
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                user = [[User alloc]init];
                user.userId = [self toNSString:(char *)sqlite3_column_text(compiledStatement, 0)];
                user.userName = [self toNSString:(char *)sqlite3_column_text(compiledStatement, 1)];
                user.password = [self toNSString:(char *)sqlite3_column_text(compiledStatement, 2)];
                user.userType = [self toNSString:(char *)sqlite3_column_text(compiledStatement, 3)];
                user.fullName = [self toNSString:(char *)sqlite3_column_text(compiledStatement, 4)];
                user.mobileNo = [self toNSString:(char *)sqlite3_column_text(compiledStatement, 5)];
                
                break;
			}
        }
        // Release the compiled statement from memory
        sqlite3_finalize(compiledStatement);
    } else {
        NSLog(@"getUser Error: %@", [NSString stringWithUTF8String:sqlite3_errmsg(db)]);
    }
    //Close the database
    sqlite3_close(db);
    return user;
}

-(Marks *) getCourseMakrs:(NSString *)userId {
    Marks *marks = NULL;
    sqlite3 *db;
    if(sqlite3_open([self.databasePath UTF8String], &db) == SQLITE_OK){
        const char *sqlStatement = [SELECT_COURSE_MARKS UTF8String];
        sqlite3_stmt *compiledStatement;
        
        if (sqlite3_prepare_v2(db, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            sqlite3_bind_text(compiledStatement,1,[userId UTF8String], -1, SQLITE_TRANSIENT);
        
        
        while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
            marks = [[Marks alloc]init];
            marks.courseName = [self toNSString:(char *)sqlite3_column_text(compiledStatement, 0)];
            marks.marks = [self toNSString:(char *)sqlite3_column_text(compiledStatement, 1)];
            break;
        }
        }
        //Release the compiled statement from memory
        sqlite3_finalize(compiledStatement);
    }
    else {
        NSLog(@"getCourseMarks Errpr : %@ ",[NSString stringWithUTF8String:sqlite3_errmsg(db)]);
    }
    //close the database
    sqlite3_close(db);
    return marks;
}


@end
