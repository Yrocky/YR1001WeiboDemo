//
//  FPTextCell.m
//  FPWeibot
//
//  Created by Rocky on 14-9-28.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#import "FPTextCell.h"

@implementation FPTextCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
+ (NSString *)cellID{

    return @"text";
}
+ (FPTextCell *) textCell{

    return [[NSBundle mainBundle] loadNibNamed:@"FPSetupCell" owner:nil options:nil][0];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
