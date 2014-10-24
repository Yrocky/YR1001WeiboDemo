//
//  FPDataCell.m
//  FPWeibot
//
//  Created by Rocky on 14-9-28.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#import "FPDataCell.h"

@implementation FPDataCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}



+ (FPDataCell *)dataCell{


    return [[NSBundle mainBundle] loadNibNamed:@"FPSetupCell" owner:nil options:nil][2];
}
+ (NSString *)cellID{

    
    return @"data";
}



@end
