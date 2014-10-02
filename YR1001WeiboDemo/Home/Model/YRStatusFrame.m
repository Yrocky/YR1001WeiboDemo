//
//  YRStatusFrame.m
//  YRTestOne
//
//  Created by Rocky on 14-9-29.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#import "YRStatusFrame.h"
#import "YRStatus.h"
#import "YRUser.h"



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

/**  获得数据，进行frame的计算*/
- (void)setStatus:(YRStatus *)status{

    _status = status;

    // cell的宽度
    CGFloat cellW = [[UIScreen mainScreen] bounds].size.width;
    
    // 1. top视图的frame
    CGFloat topX = 0;
    CGFloat topY = 0;
    CGFloat topW = cellW;
    CGFloat topH = 0;// 这个待算

    
    // 2. 头像
    CGFloat iconX = kGarp;
    CGFloat iconY = kGarp;
    CGFloat iconW = kAvatarLargeWH;
    CGFloat iconH = kAvatarLargeWH;
    _iconViewF = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 3. 姓名
    CGFloat nameX = CGRectGetMaxX(_iconViewF) + kGarp;
    CGFloat nameY = iconY;
    CGFloat nameH = kScreenNameHeight;
    CGSize nameSize = CGSizeMake(MAXFLOAT, nameH);
    CGFloat nameW = [_status.user.name sizeWithFont:kScreenNameFont maxSize:nameSize].width;
    _nameLabelF = CGRectMake(nameX, nameY, nameW, nameH);
    
    // 4. 会员图标
    if (_status.user.mbtype) {
        CGFloat vipX = CGRectGetMaxX(_nameLabelF) + kGarp;
        CGFloat vipY = nameY;
        CGFloat vipW = 14;
        CGFloat vipH = nameH;
        _vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    }else{
    
    }
    
    // 5. 发送时间, 由于时间只算过一次，所以当一定时间过后，由于时间是会增加的，但是frame没有增加，导致一定的frame内不能完全显示时间变长的文字，
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(_nameLabelF) + kGarp;
    CGFloat timeH = kContentH;
    CGSize timeSize = CGSizeMake(MAXFLOAT, timeH);
    CGFloat timeW = [_status.created_at sizeWithFont:kCreatAndSourceFont maxSize:timeSize].width;
    _timeLabelF = CGRectMake(timeX, timeY, timeW, timeH);
    
    // 6. 发送来源
    CGFloat sourceX = CGRectGetMaxX(_timeLabelF) + kGarp;
    CGFloat sourceY = timeY;
    CGFloat sourceH = kContentH;
    CGSize sourceSize = CGSizeMake(MAXFLOAT, sourceH);
    CGFloat sourceW =[_status.source sizeWithFont:kCreatAndSourceFont maxSize:sourceSize].width;
    _sourceLabelF = CGRectMake(sourceX, sourceY, sourceW, sourceH);
    
    // 7. 微博正文
    CGFloat contentX = iconX;
    CGFloat contentY = CGRectGetMaxY(_iconViewF) + kGarp;
    CGFloat contentW = kTextW;
    CGSize contentSize = CGSizeMake(contentW, MAXFLOAT);
    CGFloat contentH = [_status.text sizeWithFont:kTextFont maxSize:contentSize].height;
    _contentLabelF = CGRectMake(contentX, contentY, contentW, contentH + kGarp);
    
    // 8. 微博图片
    if (_status.thumbnail_pic) {
        
        CGFloat photoX = contentX + kGarp;
        CGFloat photoY = CGRectGetMaxY(_contentLabelF) ;
        CGFloat photoWH = kThumbnailPicWH;
        _photoViewF = CGRectMake(photoX, photoY, photoWH, photoWH);
    }
    
    // 9. 转发微博
    if (_status.retweeted_status) {
        
        // 10.转发微博的底部视图
        CGFloat retweetedViewX = - kGarp;
        CGFloat retweetedViewY = CGRectGetMaxY(_contentLabelF) ;
        CGFloat retweetedViewW = contentW + 3 * kGarp;
        CGFloat retweetedViewH = 0;// 待算
        
        // 11. 转发微博的用户名称
        CGFloat retweetNameX = 2.5 * kGarp;
        CGFloat retweetNameY = kGarp;
        CGFloat retweetNameH = kScreenNameHeight;
        CGSize retweetSize = CGSizeMake(MAXFLOAT, retweetNameH);
        NSString *name = [NSString stringWithFormat:@"%@",_status.retweeted_status.user.name];
        CGFloat retweetNameW = [name sizeWithFont:kTextFont maxSize:retweetSize].width;
        _retweetNameLabelF = CGRectMake(retweetNameX, retweetNameY, retweetNameW, retweetNameH);
        
        // 12. 转发微博的内容
        CGFloat retweetContentX = retweetNameX;
        CGFloat retweetContentY = CGRectGetMaxY(_retweetNameLabelF) + kGarp;
        CGFloat retweetContentW = kTextW;
        CGSize retweetContentSize = CGSizeMake(retweetContentW, MAXFLOAT);
        CGFloat retweetContentH = [_status.retweeted_status.text sizeWithFont:kTextFont maxSize:retweetContentSize].height;
        _retweetContentLabelF = CGRectMake(retweetContentX, retweetContentY, retweetContentW, retweetContentH);
        
        // 13. 转发微博的图片
        if (_status.retweeted_status.thumbnail_pic) {
            CGFloat retweetPhotoX = retweetContentX + kGarp;
            CGFloat retweetPhotoY = CGRectGetMaxY(_retweetContentLabelF) + kGarp;
            CGFloat retweetPhotoWH = kThumbnailPicWH;
            _retweetPhotoViewF = CGRectMake(retweetPhotoX, retweetPhotoY, retweetPhotoWH, retweetPhotoWH);
            
            retweetedViewH = CGRectGetMaxY(_retweetPhotoViewF) ;
        }else{
            
            retweetedViewH = CGRectGetMaxY(_retweetContentLabelF) ;
        }
        retweetedViewH += kGarp;
        _retweetViewF = CGRectMake(retweetedViewX, retweetedViewY, retweetedViewW, retweetedViewH);
        
        topH = CGRectGetMaxY(_retweetViewF) ;
        
    }else{
        if (!_status.thumbnail_pic) {// 无图
            topH = CGRectGetMaxY(_contentLabelF) ;
        }else{// 有图
            topH = CGRectGetMaxY(_photoViewF) + kGarp;
        }
    }
//    topH += kGarp;
    
    _topViewF = CGRectMake(topX, topY, topW, topH);
    
    // 14.底部按钮父视图
    CGFloat statusToolbarX = -3;
    CGFloat statusToolbarY = CGRectGetMaxY(_topViewF) ;
    CGFloat statusToolbarW = cellW + 6;
    CGFloat statusToolbarH = 30;
    _statusToolbarF = CGRectMake(statusToolbarX, statusToolbarY, statusToolbarW, statusToolbarH);
        
    
    _cellHeight = CGRectGetMaxY(_statusToolbarF) + kGarp;
    

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
 
 CGFloat contentX = iconX;
 CGFloat contentY = CGRectGetMaxY(_iconViewF) + kGarp;
 CGFloat contentW = kTextW;
 CGSize contentSize = CGSizeMake(contentW, MAXFLOAT);
 CGFloat contentH = [_status.text sizeWithFont:kTextFont maxSize:contentSize].width;
 _contentLabelF = CGRectMake(contentX, contentY, contentW, contentH);
 
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
