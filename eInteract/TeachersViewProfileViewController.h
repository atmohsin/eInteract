//
//  TeachersViewProfileViewController.h
//  eInteract
//
//  Created by Mohsin Khan on 30/08/13.
//  Copyright (c) 2013 Codefrux Training. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"

@interface TeachersViewProfileViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate>{
    
}

@property (strong,nonatomic) IBOutlet UIPickerView *picker;
@property (strong,nonatomic) IBOutlet UILabel *selectedCourse;
@property (strong,nonatomic) IBOutlet UILabel *marksObtained;
@property (strong,nonatomic) NSMutableArray *studentsList;

@end
