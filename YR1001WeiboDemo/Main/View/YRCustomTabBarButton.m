//
//  YRCustomTabBarButton.m
//  YRTestOne
//
//  Created by Rocky on 14-9-26.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#import "YRCustomTabBarButton.h"

#define kImageScale 0.6

@implementation YRCustomTabBarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        self.titleLabel.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    }
    return self;
}


- (CGRect)imageRectForContentRect:(CGRect)contentRect{

    CGFloat imageH = contentRect.size.height * kImageScale;
    CGFloat imageW = contentRect.size.width;
    CGFloat imageY = 0;
    CGFloat imageX = 0;
    
    return CGRectMake(imageX, imageY, imageW, imageH);
    
}


- (CGRect)titleRectForContentRect:(CGRect)contentRect{

    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - contentRect.size.height * kImageScale;
    CGFloat titleY = contentRect.size.height * kImageScale;
    CGFloat titleX = 0;
    
    return CGRectMake(titleX, titleY, titleW, titleH);
    
}
- (void)setItem:(UITabBarItem *)item{

    _item = item;
    
    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
    [item addObserver:self forKeyPath:@"image" options:0 context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{

    [self setImage:_item.image forState:UIControlStateNormal];
    [self setTitle:_item.title forState:UIControlStateNormal];
    [self setImage:_item.selectedImage forState:UIControlStateSelected];
    
}

- (void)dealloc{

    [_item removeObserver:self forKeyPath:@"title"];
    [_item removeObserver:self forKeyPath:@"title"];
    [_item removeObserver:self forKeyPath:@"title"];
    
}

@end
