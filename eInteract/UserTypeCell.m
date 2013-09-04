//
//  TableViewCell.m
//  NewProject
//
//  Created by Apple on 28/08/13.
//  Copyright (c) 2013 Codefrux. All rights reserved.
//

#import "UserTypeCell.h"

@implementation UserTypeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
