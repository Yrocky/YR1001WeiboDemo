//
//  YRPhotoView.m
//  YR1001WeiboDemo
//
//  Created by Rocky on 14-10-2.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#import "YRPhotoView.h"
#import "UIImageView+WebCache.h"
#import "YRPhoto.h"

@interface YRPhotoView ()
@property (nonatomic ,retain) UIImageView *gifImageView;
@end
@implementation YRPhotoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        UIImage *gifImage = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifImageView = [[UIImageView alloc] initWithImage:gifImage];
        [self addSubview:gifImageView];
        self.gifImageView = gifImageView;
    }
    return self;
}

- (void)setPhoto:(YRPhoto *)photo{

    _photo = photo;
    
    self.gifImageView.hidden = ![photo.thumbnail_pic hasSuffix:@"gif"];
    
    [self setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted_os7"]];
}

- (void)layoutSubviews{

    [super layoutSubviews];
    self.gifImageView.layer.position = CGPointMake(self.bounds.size.width, self.bounds.size.height);
    self.gifImageView.layer.anchorPoint = CGPointMake(1, 1);
}
@end
