//
//  UIBarButtonItem+Custom.h
//  YRTestOne
//
//  Created by Rocky on 14-9-28.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Custom)

+ (UIBarButtonItem *)itemWithNormalImageName:(NSString *)normalImageName highlightedImageName:(NSString *)higlightedImageName andTarget:(id)target action:(SEL)action;
@end
