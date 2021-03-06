//
//  YRStatusCell.m
//  YRTestOne
//
//  Created by Rocky on 14-9-29.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#import "YRStatusCell.h"
#import "YRStatusFrame.h"
#import "YRStatusToolBar.h"
#import "YRStatusTopView.h"

@interface YRStatusCell ()<YRStatusTopViewDelegate>

@end

@implementation YRStatusCell

#pragma mark - 初始化

+ (YRStatusCell *)creatCellWithTableView:(UITableView *)tableView{

    static NSString *ID = @"status";
    YRStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[YRStatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if ( self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
    
        // 1. 添加原创微博控件
        [self setTopStatusView];
        
        // 2. 添加底部微博工具条
        [self setBottomView];
    }
    
    return self;
}

- (void) setTopStatusView{

//    self.selectedBackgroundView = [[UIView alloc] init];
    
    //  原创微博底部的视图，是个UIImageView
     YRStatusTopView *topView = [[YRStatusTopView alloc] init];
    [self.contentView addSubview:topView];
    topView.delegate = self;
    self.topView = topView;

}

- (void) setBottomView{

    YRStatusToolBar *statusToolbar = [[YRStatusToolBar alloc] init];
    [self.contentView addSubview:statusToolbar];
    self.statusToolbar = statusToolbar;
}

- (void)setFrame:(CGRect)frame{

    frame.size.height -= kGarp + 1;
    
    [super setFrame:frame];
}
#pragma mark - 进行数据的加载

- (void)setStatusFrame:(YRStatusFrame *)statusFrame{

    _statusFrame = statusFrame;

//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    // 1. 设置原创微博
    [self setStatusFrame];
    
    // 2. 设置底部的按钮栏
    [self setButtomViewFrame];
    
}

- (void) setStatusFrame{
    
    _topView.frame = _statusFrame.topViewF;
    _topView.statusFrame = _statusFrame;
    
}

- (void) setButtomViewFrame{

    _statusToolbar.frame = _statusFrame.statusToolbarF;
    _statusToolbar.status = _statusFrame.status;

}


#pragma mark - cell的代理
- (void)statusTopViewUserIconDidClick:(YRStatusTopView *)topView withStatusFrame:(YRStatusFrame *)statusFrame{

    if ([self.delegate respondsToSelector:@selector(statusIconDidClick:)]) {
        [self.delegate statusIconDidClick:self];
    }
}
@end