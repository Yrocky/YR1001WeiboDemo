//
//  CustomSearchBar.m
//  FPWeibot
//
//  Created by qingyun on 14-9-25.
//  Copyright (c) 2014年 qingyun. All rights reserved.
//

#import "CustomSearchBar.h"

@interface CustomSearchBar ()


@end
@implementation CustomSearchBar

+(instancetype)searchBar{

    return [[self alloc] init];

}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.background = [UIImage imageWithName:@"searchbar_textfield_background"];
        self.placeholder = @"搜索";
        
        UIImageView *leftImage = [[UIImageView alloc] init];
        leftImage.contentMode = UIViewContentModeCenter;
        leftImage.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        self.leftView = leftImage;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        self.font = [UIFont systemFontOfSize:13];
        
        self.clearButtonMode = UITextFieldViewModeAlways;
        
        self.returnKeyType = UIReturnKeySearch;
        
        self.enablesReturnKeyAutomatically = YES;

        
    }
    return self;
}

/**
 *  对子控件进行重新布局
 */

- (void)layoutSubviews{

    [super layoutSubviews];
    
    /**
     *  这里可以省去创建一个属性
     */
    self.leftView.frame = CGRectMake(0, 0, 30, self.frame.size.height);
}

@end
