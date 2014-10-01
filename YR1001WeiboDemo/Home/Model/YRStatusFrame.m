//
//  YRStatusFrame.m
//  YRTestOne
//
//  Created by Rocky on 14-9-29.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#import "YRStatusFrame.h"
#import "YRStatus.h"

/**
 *  微博正文上面的一些设定
 *
 */
#define kGarp 6.18
#define kAvatarLargeWH 30
#define kScreenNameHeight 20
#define kContentH 15
#define kTextW (320 - 2 * kGarp)
/**
 *  转发评论和点赞按钮的尺寸
 *
 */
#define kButtonW 50
#define kButtonH 15
/** 图片的大小*/
#define kThumbnailPicWH 80
@interface YRStatusFrame  ()
@property (nonatomic ,assign) CGRect lastRect;
@end

@implementation YRStatusFrame

- (void)setStatus:(YRStatus *)status{

    _status = status;
    

    
}
/*
- (void) subViewsFrame{

    // 计算头像
    CGFloat avatarLargeX = kGarp;
    CGFloat avatarLargeY = kGarp;
    CGFloat avatarLargeW = kAvatarLargeWH;
    CGFloat avatarLargeH = kAvatarLargeWH;
    _avatarLargeFrame = CGRectMake(avatarLargeX, avatarLargeY, avatarLargeW, avatarLargeH);
    
    // 计算用户昵称
    CGFloat screenNameX = CGRectGetMaxX(_avatarLargeFrame) + 2 * kGarp;
    CGFloat screenNameY = CGRectGetMinY(_avatarLargeFrame);
    CGFloat screenNameH = kScreenNameHeight;
    CGSize screenNameSize = [_status.screenName sizeWithFont:kScreenNameFont maxSize:CGSizeMake(MAXFLOAT, screenNameH)];
    CGFloat screenNameW = screenNameSize.width;
    _screenNameFrame = CGRectMake(screenNameX, screenNameY, screenNameW, screenNameH);
    
    // 计算发送时间
    CGFloat createdAtX = CGRectGetMinX(_screenNameFrame);
    CGFloat createdAtY = CGRectGetMaxY(_screenNameFrame) ;
    CGFloat createdAtH = kContentH;
    CGSize createdAtSize = [_status.createdAt sizeWithFont:kCreatAndSourceFont maxSize:CGSizeMake(MAXFLOAT, createdAtH)];
    CGFloat createdAtW = createdAtSize.width;
    _createdAtFrame = CGRectMake(createdAtX, createdAtY, createdAtW, createdAtH);
    
    // 计算发送终端
    CGFloat sourceX = CGRectGetMaxX(_createdAtFrame) + kGarp;
    CGFloat sourceY = CGRectGetMinY(_createdAtFrame) ;
    CGFloat sourceH = kContentH ;
    CGSize sourceSize = [_status.source sizeWithFont:kCreatAndSourceFont maxSize:CGSizeMake(MAXFLOAT, sourceH)];
    CGFloat sourceW = sourceSize.width;
    _sourceFrame = CGRectMake(sourceX, sourceY, sourceW, sourceH);
    
    // 计算微博内容
    CGFloat textX = kGarp;
    CGFloat textY = CGRectGetMaxY(_avatarLargeFrame) + kGarp;
    CGFloat textW = kTextW;
    CGSize textSize = [_status.text sizeWithFont:kScreenNameFont maxSize:CGSizeMake(textW, MAXFLOAT)];
    CGFloat textH = textSize.height;
    _textFrame = CGRectMake(textX, textY, textW, textH);
    
 
       计算微博配图
 
    if (!_status.picUrlsMutableArray.count == 0) {// 有微博配图
        
        CGFloat picUrlW = kThumbnailPicWH;
        CGFloat picUrlH = kThumbnailPicWH;
        _thumbnailPicFrameMutableArray = [NSMutableArray array];
        
        if (_status.picUrlsMutableArray.count == 1) {// 有一张微博配图
            
            CGFloat picUrlX = kGarp;
            CGFloat picUrlY = CGRectGetMaxY(_textFrame) + kGarp;
            CGRect picUrlRect = CGRectMake(picUrlX, picUrlY, picUrlW, picUrlH);
            [_thumbnailPicFrameMutableArray addObject:[NSValue valueWithCGRect:picUrlRect]];
            NSLog(@"这里是有一张图片");
        }else if(_status.picUrlsMutableArray.count == 4){// 有四张微博配图
        
            
            for (int i = 0; i <= _status.picUrlsMutableArray.count; i ++) {
                // % 是取余数的算法， / 是求整数的方法
                CGFloat picUrlX = kGarp + (i % 2) * (kThumbnailPicGarp + picUrlW);
                CGFloat picUrlY = CGRectGetMaxY(_textFrame) + kGarp + (i / 2) * (kThumbnailPicGarp + picUrlH);
                CGRect picUrlRect = CGRectMake(picUrlX, picUrlY, picUrlW, picUrlH);
                [_thumbnailPicFrameMutableArray addObject:[NSValue valueWithCGRect:picUrlRect]];
            }
            
        }else{// 其他情况
        
            for (int i = 0; i <= _status.picUrlsMutableArray.count; i ++) {
                
                CGFloat picUrlX = kGarp + (i % 3) * (kThumbnailPicGarp + picUrlW);
                CGFloat picUrlY = CGRectGetMaxY(_textFrame) + kGarp + (i / 3) * (kThumbnailPicGarp + picUrlH);
                CGRect picUrlRect = CGRectMake(picUrlX, picUrlY, picUrlW, picUrlH);
                [_thumbnailPicFrameMutableArray addObject:[NSValue valueWithCGRect:picUrlRect]];
            }
        }
    }else{// 没有而微博配图
    
        NSLog(@"没有图片");
    }
    
    // 计算转发微博的内容
    CGFloat retweetedStatusTextX = kGarp;
    CGFloat retweetedStatusTextY = CGRectGetMaxY(_textFrame) + kGarp;
    CGFloat retweetedStatusTextW = kTextW;
    CGSize retweetedStatusTextSize = [_status.retweetedStatusText sizeWithFont:kTextFont maxSize:CGSizeMake(retweetedStatusTextW, MAXFLOAT)];
    CGFloat retweetedStatusTextH = retweetedStatusTextSize.height;
    _retweetedStatusTextFrame = CGRectMake(retweetedStatusTextX, retweetedStatusTextY, retweetedStatusTextW, retweetedStatusTextH);
    
    // 计算三个功能按钮
    _lastRect = [[_thumbnailPicFrameMutableArray lastObject] CGRectValue];
    CGFloat lastRectY = _lastRect.size.height;
    CGFloat RCAY = 0;
    if (!lastRectY ) {
        RCAY = CGRectGetMaxY(_lastRect) + kGarp;
    }else{
        RCAY = CGRectGetMaxY(_retweetedStatusTextFrame) + (retweetedStatusTextH ? 2 * kGarp : kGarp);
    }
    CGFloat RCAW = kButtonW;
    CGFloat RCAH = kButtonH;
    CGFloat tmp = (320 - 3 * RCAW) / 4;
    CGFloat RX = tmp;
    CGFloat CX = tmp * 2 + RCAW;
    CGFloat AX = tmp * 3 + RCAW * 2;
    _repostesFrame = CGRectMake(RX, RCAY, RCAW, RCAH);
    _commentsFrame = CGRectMake(CX, RCAY, RCAW, RCAH);
    _attitudesFrame = CGRectMake(AX, RCAY, RCAW, RCAH);
    
    
    
    _cellHeight = CGRectGetMaxY(_attitudesFrame) + kGarp;
}
*/
@end
