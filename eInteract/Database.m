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
            marks.courseId = [self toNSString:(char *)sqlite3_column_text(compiledStatement, 2)];
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

-(NSMutableArray *) getAllStudentsCourseMarks {
    NSMutableArray *studentsList = nil;
    
    
    sqlite3 *db;
    if(sqlite3_open([self.databasePath UTF8String], &db) == SQLITE_OK){
        studentsList = [NSMutableArray array];
        
        const char *sqlStatement = [SELECT_STUDENTS_COURSE_MARKS UTF8String];
        sqlite3_stmt *compiledStatement;
        
        if (sqlite3_prepare_v2(db, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
                        
            while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
                Marks *marks = [[Marks alloc]init];
                marks.courseName = [self toNSString:(char *)sqlite3_column_text(compiledStatement, 0)];
                marks.marks = [self toNSString:(char *)sqlite3_column_text(compiledStatement, 1)];
                marks.userId = [self toNSString:(char *)sqlite3_column_text(compiledStatement, 2)];
                marks.fullName = [self toNSString:(char *)sqlite3_column_text(compiledStatement, 3)];
                [studentsList addObject:marks];
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
    return studentsList;
}

-(NSString *) getEnrolCourseId:(NSString *)userId {
    NSString *courseId = nil;
    
    sqlite3 *db;
    if(sqlite3_open([self.databasePath UTF8String], &db) == SQLITE_OK){
        
        const char *sqlStatement = [SELECT_ENROL_COURSE_ID UTF8String];
        sqlite3_stmt *compiledStatement;
        
        if (sqlite3_prepare_v2(db, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            sqlite3_bind_text(compiledStatement,1,[userId UTF8String], -1, SQLITE_TRANSIENT);
            
            
            while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
                courseId = [self toNSString:(char *)sqlite3_column_text(compiledStatement, 0)];
                break;
            }
        }
        //Release the compiled statement from memory
        sqlite3_finalize(compiledStatement);
            
    }
    else {
        NSLog(@"getEnrolCourseId Errpr : %@ ",[NSString stringWithUTF8String:sqlite3_errmsg(db)]);
    }
    //close the database
    sqlite3_close(db);
    return courseId;
    
}

-(AssessTest *) getAssessTest:(NSString *)courseId {
    AssessTest *assessTest = NULL;
    
    sqlite3 *db;
    if(sqlite3_open([self.databasePath UTF8String], &db) == SQLITE_OK) {
        const char *sqlStatement = [SELECT_ASSESS_TEST UTF8String];
        sqlite3_stmt *compiledStatement;
        if(sqlite3_prepare_v2(db, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)  {
            sqlite3_bind_text(compiledStatement, 1, [courseId UTF8String], -1, SQLITE_TRANSIENT);
            
            
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                assessTest = [[AssessTest alloc]init];
                assessTest.subject = [self toNSString:(char *)sqlite3_column_text(compiledStatement, 0)];
                assessTest.questions = [self toNSString:(char *)sqlite3_column_text(compiledStatement, 1)];
                assessTest.duration = [self toNSString:(char *)sqlite3_column_text(compiledStatement, 2)];
                assessTest.testId = [self toNSString:(char *)sqlite3_column_text(compiledStatement, 3)];
                assessTest.courseId = [self toNSString:(char *)sqlite3_column_text(compiledStatement, 4)];
    
                break;
			}
        }
        // Release the compiled statement from memory
        sqlite3_finalize(compiledStatement);
    } else {
        NSLog(@"getAssessTest Error: %@", [NSString stringWithUTF8String:sqlite3_errmsg(db)]);
    }
    //Close the database
    sqlite3_close(db);
    return assessTest;
}

-(NSMutableArray *) getQuestForTest:(NSString *)testId {
    NSMutableArray *questions = nil;
    
    
    sqlite3 *db;
    if(sqlite3_open([self.databasePath UTF8String], &db) == SQLITE_OK){
        questions = [NSMutableArray array];
        
        const char *sqlStatement = [SELECT_TEST_QUEST UTF8String];
        sqlite3_stmt *compiledStatement;
        
        if (sqlite3_prepare_v2(db, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            sqlite3_bind_text(compiledStatement, 1, [testId UTF8String], -1, SQLITE_TRANSIENT);
            while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
                Quest *quest = [[Quest alloc]init];
                quest.qid = [self toNSString:(char *)sqlite3_column_text(compiledStatement, 0)];
                quest.name = [self toNSString:(char *)sqlite3_column_text(compiledStatement, 1)];
                [questions addObject:quest];
            }
        }
        //Release the compiled statement from memory
        sqlite3_finalize(compiledStatement);
    }
    else {
        NSLog(@"getQuestForTest Errpr : %@ ",[NSString stringWithUTF8String:sqlite3_errmsg(db)]);
    }
    //close the database
    sqlite3_close(db);
    return questions;
}


-(NSMutableArray *) getAnsOptoins:(NSString *)qId {
    NSMutableArray *options = nil;
    
    
    sqlite3 *db;
    if(sqlite3_open([self.databasePath UTF8String], &db) == SQLITE_OK){
        options = [NSMutableArray array];
        
        const char *sqlStatement = [SELECT_QUEST_OPT UTF8String];
        sqlite3_stmt *compiledStatement;
        
        if (sqlite3_prepare_v2(db, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            sqlite3_bind_text(compiledStatement, 1, [qId UTF8String], -1, SQLITE_TRANSIENT);
            while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
                AnsOptions *opt = [[AnsOptions alloc]init];
                opt.optid = [self toNSString:(char *)sqlite3_column_text(compiledStatement, 0)];
                opt.name = [self toNSString:(char *)sqlite3_column_text(compiledStatement, 1)];
                opt.iscorrect = [self toNSString:(char *)sqlite3_column_text(compiledStatement, 2)];

                [options addObject:opt];
            }
        }
        //Release the compiled statement from memory
        sqlite3_finalize(compiledStatement);
    }
    else {
        NSLog(@"getAnsOptoins Errpr : %@ ",[NSString stringWithUTF8String:sqlite3_errmsg(db)]);
    }
    //close the database
    sqlite3_close(db);
    return options;
}

-(void)insertUpdateMarks:(Marks *)marks{
    NSString *strCount = [[NSString alloc]init];
    
    sqlite3 *db;
    if(sqlite3_open([self.databasePath UTF8String], &db) == SQLITE_OK){
        
        const char *sqlStatement = [@"select count(*) from marks where userid = ?" UTF8String];
        sqlite3_stmt *compiledStatement;
        
        if (sqlite3_prepare_v2(db, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            sqlite3_bind_text(compiledStatement, 1, [marks.userId UTF8String], -1, SQLITE_TRANSIENT);
            while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
                
                strCount = [self toNSString:(char *)sqlite3_column_text(compiledStatement, 0)];
                NSLog(@" The count is %@",strCount);
            }
        }
        //Release the compiled statement from memory
        sqlite3_finalize(compiledStatement);
        
        const char *strSql = nil;
        sqlite3_stmt *compiledStatementInstUpdate;
        
        if([strCount isEqualToString:@"0"]){
            strSql = [@"insert into marks (marks,userid,courseid) values (?,?,?)" UTF8String];
            
            if(sqlite3_prepare_v2(db, strSql, -1, &compiledStatementInstUpdate, NULL) == SQLITE_OK)  {
                sqlite3_bind_text(compiledStatementInstUpdate, 1, [marks.marks UTF8String], -1, SQLITE_TRANSIENT);
                sqlite3_bind_text(compiledStatementInstUpdate, 2, [marks.userId UTF8String], -1, SQLITE_TRANSIENT);
                sqlite3_bind_text(compiledStatementInstUpdate, 3, [marks.courseId UTF8String], -1, SQLITE_TRANSIENT);
                if(sqlite3_step(compiledStatement) != SQLITE_DONE ) {
                    NSLog( @" Error while inserting marks: %s", sqlite3_errmsg(db) );
                }
                sqlite3_finalize(compiledStatementInstUpdate);
            }
        }
        else {
            strSql = [@"update marks set marks = ? where userid = ?" UTF8String];
            sqlite3_stmt *compiledStatementInstUpdate;
            if(sqlite3_prepare_v2(db, strSql, -1, &compiledStatementInstUpdate, NULL) == SQLITE_OK)  {
                
                sqlite3_bind_int(compiledStatementInstUpdate, 1, [marks.marks intValue]);
                sqlite3_bind_int(compiledStatementInstUpdate, 2, [marks.userId intValue]);

                if(sqlite3_step(compiledStatementInstUpdate) != SQLITE_DONE ) {
                    NSLog( @" Error while updating marks: %s", sqlite3_errmsg(db) );
                }
                sqlite3_finalize(compiledStatementInstUpdate);
            }
        }
        
        
        
    }
    else {
        NSLog(@"insertUpdateMarks Errpr : %@ ",[NSString stringWithUTF8String:sqlite3_errmsg(db)]);
    }
    //close the database
    sqlite3_close(db);
    
}

-(NSMutableArray *)getAllStudents{
    NSMutableArray *students = nil;
    
    
    sqlite3 *db;
    if(sqlite3_open([self.databasePath UTF8String], &db) == SQLITE_OK){
        students = [NSMutableArray array];
        
        const char *sqlStatement = [SELECT_ALL_STUDENTS UTF8String];
        sqlite3_stmt *compiledStatement;
        
        if (sqlite3_prepare_v2(db, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
                User *userObj = [[User alloc]init];
                userObj.userId = [self toNSString:(char *)sqlite3_column_text(compiledStatement, 0)];
                userObj.userName = [self toNSString:(char *)sqlite3_column_text(compiledStatement, 1)];
                userObj.fullName = [self toNSString:(char *)sqlite3_column_text(compiledStatement, 2)];
                
                [students addObject:userObj];
            }
        }
        //Release the compiled statement from memory
        sqlite3_finalize(compiledStatement);
    }
    else {
        NSLog(@"getAllStudents Errpr : %@ ",[NSString stringWithUTF8String:sqlite3_errmsg(db)]);
    }
    //close the database
    sqlite3_close(db);
    return students;
}

-(NSMutableArray *) getCouseMarksForStudent:(NSString *)userId {
    NSMutableArray *couseMarks = nil;
    
    
    sqlite3 *db;
    if(sqlite3_open([self.databasePath UTF8String], &db) == SQLITE_OK){
        couseMarks = [NSMutableArray array];
        
        const char *sqlStatement = [SELECT_COURSE_MARK_FOR_STUDENT UTF8String];
        sqlite3_stmt *compiledStatement;
        
        if (sqlite3_prepare_v2(db, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            sqlite3_bind_text(compiledStatement, 1, [userId UTF8String], -1, SQLITE_TRANSIENT);
            while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
                Marks *marks = [[Marks alloc]init];
                marks.courseName = [self toNSString:(char *)sqlite3_column_text(compiledStatement, 0)];
                marks.marks = [self toNSString:(char *)sqlite3_column_text(compiledStatement, 1)];
                [couseMarks addObject:marks];
            }
        }
        //Release the compiled statement from memory
        sqlite3_finalize(compiledStatement);
    }
    else {
        NSLog(@"getCouseMarksForStudent Errpr : %@ ",[NSString stringWithUTF8String:sqlite3_errmsg(db)]);
    }
    //close the database
    sqlite3_close(db);
    return couseMarks;

}


-(NSMutableArray *) getAvailableCourses {
    NSMutableArray *courses = nil;
    
    
    sqlite3 *db;
    if(sqlite3_open([self.databasePath UTF8String], &db) == SQLITE_OK){
        courses = [NSMutableArray array];
        
        const char *sqlStatement = [SELECT_AVAILABLE_COURSES UTF8String];
        sqlite3_stmt *compiledStatement;
        
        if (sqlite3_prepare_v2(db, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
                Course *course = [[Course alloc]init];
                course.courseId = [self toNSString:(char *)sqlite3_column_text(compiledStatement, 0)];
                course.name = [self toNSString:(char *)sqlite3_column_text(compiledStatement, 1)];
                course.fee = [self toNSString:(char *)sqlite3_column_text(compiledStatement, 2)];
                course.duration = [self toNSString:(char *)sqlite3_column_text(compiledStatement, 3)];
                course.facultyFullName = [self toNSString:(char *)sqlite3_column_text(compiledStatement, 4)];
                [courses addObject:course];
            }
        }
        //Release the compiled statement from memory
        sqlite3_finalize(compiledStatement);
    }
    else {
        NSLog(@"getAvailableCourses Errpr : %@ ",[NSString stringWithUTF8String:sqlite3_errmsg(db)]);
    }
    //close the database
    sqlite3_close(db);
    return courses;
    
}

@end
