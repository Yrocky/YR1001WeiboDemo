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


@implementation YRPhotoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setPhoto:(YRPhoto *)photo{

    _photo = photo;
    
    [self setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted_os7"]];
}

@end
