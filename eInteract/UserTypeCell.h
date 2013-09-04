//
//  TableViewCell.h
//  NewProject
//
//  Created by Apple on 28/08/13.
//  Copyright (c) 2013 Codefrux. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserTypeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UITextField *text1;

@end
