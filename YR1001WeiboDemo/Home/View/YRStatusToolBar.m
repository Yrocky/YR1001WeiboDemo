//
//  YRStatusToolBar.m
//  YR1001WeiboDemo
//
//  Created by Rocky on 14-10-1.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#import "YRStatusToolBar.h"
#import "YRRCAButton.h"
#import "YRStatus.h"

/**
 *  转发评论和点赞按钮的尺寸
 *
 */
//#define kButtonW 100
#define kButtonH 15
#define kGarp 6.18

@interface YRStatusToolBar ()
@property (nonatomic ,retain) YRRCAButton *rButton;
@property (nonatomic ,retain) YRRCAButton *cButton;
@property (nonatomic ,retain) YRRCAButton *aButton;
@end

@implementation YRStatusToolBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithName:@"timeline_card_bottom_background"];
        self.highlightedImage = [UIImage imageWithName:@"timeline_card_bottom_background_highlighted"];
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"timeline_card_middlebottom_highlighted"]];
//        self.layer.borderWidth = .1;
//        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.rButton = [[YRRCAButton alloc] init];
        [self addSubview:self.rButton];
        
        self.cButton = [[YRRCAButton alloc] init];
        [self addSubview:self.cButton];

        self.aButton = [[YRRCAButton alloc] init];
        [self addSubview:self.aButton];

    }
    return self;
}


- (void)layoutSubviews{

    [super layoutSubviews];
    
    CGFloat RCAW = kButtonW;
    CGFloat RCAH = kButtonH;
    CGFloat RCAY = kGarp;
    int count = self.subviews.count;
    CGFloat viewW = self.frame.size.width;
    CGFloat tmp = (viewW -  count * RCAW) / (count + 1);
    
    for (int index = 0; index < count; index ++) {
    
        YRRCAButton *btn = self.subviews[index];
        
        CGFloat RCAX = tmp * (index + 1) + RCAW * index;
        btn.frame = CGRectMake(RCAX, RCAY, RCAW, RCAH);
    }

}

- (void)setStatus:(YRStatus *)status{

    _status = status;
    
    [self.rButton setCount:_status.reposts_count andImage:@"statusdetail_icon_retweet" title:@"转发"];
    [self.cButton setCount:_status.comments_count andImage:@"statusdetail_icon_comment" title:@"评论"];
    [self.aButton setCount:_status.attitudes_count andImage:@"statusdetail_icon_like" title:@"赞"];
    [self.aButton setImage:[UIImage imageNamed:@"timeline_icon_like"] forState:UIControlStateSelected];
    
    [self.rButton addTarget:self action:@selector(rButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.cButton addTarget:self action:@selector(cButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.aButton addTarget:self action:@selector(aButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - buttonClick Delegate

- (void) rButtonClick:(YRRCAButton *)button{

    if ([self.delegate respondsToSelector:@selector(statusToolBar:repostsButtonDidClick:)]) {
        [self.delegate statusToolBar:self repostsButtonDidClick:button];
    }
    
}
- (void) cButtonClick:(YRRCAButton *)button{

    if ([self.delegate respondsToSelector:@selector(statusToolBar:commentsButtonDidClick:)]) {
        [self.delegate statusToolBar:self commentsButtonDidClick:button];
    }
    
}
- (void) aButtonClick:(YRRCAButton *)button{
    
    
    if ([self.delegate respondsToSelector:@selector(statusToolBar:attitudesButtonDidClick:)]) {
        [self.delegate statusToolBar:self attitudesButtonDidClick:button];
    }
//    NSLog(@"gbdfkjbkm");
//    NSInteger count;
//    if (button.selected) {
//        button.selected = NO;
//        count = [[button titleForState:UIControlStateSelected] integerValue];
//        if (count > 1) {
//            count --;
//            [button setTitle:[NSString stringWithFormat:@"%d",count] forState:UIControlStateNormal];
//        }else{
//        
//            [button setTitle:@"赞" forState:UIControlStateNormal];
//        }
//    }else{
//    
//        button.selected = YES;
//        NSString *title = [button titleForState:UIControlStateNormal];
//        if ([title isEqualToString:@"赞"]) {
//            count = 1;
//        }else{
//            count = [[button titleForState:UIControlStateNormal] integerValue];
//            count ++;
//        }
//        [button setTitle:[NSString stringWithFormat:@"%d",count] forState:UIControlStateSelected];
//    }
}

@end
