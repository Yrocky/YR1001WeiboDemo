//
//  YRPhotosView.m
//  YR1001WeiboDemo
//
//  Created by Rocky on 14-10-2.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#import "YRPhotosView.h"
#import "YRPhotoView.h"
#import "YRPhoto.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"

@implementation YRPhotosView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        // 初始化的时候进行九张图片的初始化
        for (int index = 0; index < 9; index ++) {
            YRPhotoView *photoView = [[YRPhotoView alloc] init];
            photoView.tag = index;
            [photoView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)] ];
            photoView.userInteractionEnabled = YES;
            [self addSubview:photoView];
        }
    }
    return self;
}

- (void) tapGesture:(UIGestureRecognizer *)gesture{
    
    int count = self.photos.count;
    
    // 1.封装图片数据
    NSMutableArray *myphotos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 一个MJPhoto对应一张显示的图片
        MJPhoto *mjphoto = [[MJPhoto alloc] init];
        
        mjphoto.srcImageView = self.subviews[i]; // 来源于哪个UIImageView
        
        YRPhoto *iwphoto = self.photos[i];
        NSString *photoUrl = [iwphoto.thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        mjphoto.url = [NSURL URLWithString:photoUrl]; // 图片路径
        
        [myphotos addObject:mjphoto];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = gesture.view.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = myphotos; // 设置所有的图片
    [browser show];
}

- (void)setPhotos:(NSArray *)photos{
    
// 数组中装的是图片模型
    _photos = photos;
    
    // 下面进行图片的排列
    for (int index = 0; index < self.subviews.count; index ++) {
        
        YRPhotoView *photoView = self.subviews[index];
        
        if (index < photos.count) {// 判断哪个图片是否要显示
            
            photoView.hidden = NO;
        
            // 将模型数据给图片，然后进行图片的加载
            photoView.photo = photos[index];
        
            CGFloat photoViewW = kImageWH;
            CGFloat photoViewH = kImageWH;
            
            int maxColum = (photos.count == 4) ? 2 : 3;
            int col = index % maxColum;
            int row = index / maxColum;
            
            CGFloat photoViewX = col * (photoViewW + kPhotoMargin);
            CGFloat photoViewY = row * (photoViewH + kPhotoMargin);
            
            photoView.frame = CGRectMake(photoViewX, photoViewY, photoViewW, photoViewH);
            
            // Aspect : 按照图片的原来宽高比进行缩
            // UIViewContentModeScaleAspectFit : 按照图片的原来宽高比进行缩放(一定要看到整张图片)
            // UIViewContentModeScaleAspectFill :  按照图片的原来宽高比进行缩放(只能图片最中间的内容)
            // UIViewContentModeScaleToFill : 直接拉伸图片至填充整个imageView
            
            if (photos.count == 1) {
                
                photoView.contentMode = UIViewContentModeScaleAspectFit;
                photoView.clipsToBounds = NO;
            }else{
                
                photoView.contentMode = UIViewContentModeScaleAspectFill;
                photoView.clipsToBounds = YES;
            }
        
        }else{
        
            photoView.hidden = YES;
        }
        
    }
    
}
#warning 这里是实在不会算，copy的MJ
+ (CGSize)photoViewWithPhoutCount:(int)count
{
    // 一行最多有3列
    int maxColumns = (count == 4) ? 2 : 3;
    
    //  总行数
    int rows = (count + maxColumns - 1) / maxColumns;
    // 高度
    CGFloat photosH = rows * kImageWH + (rows - 1) * kPhotoMargin;
    
    // 总列数
    int cols = (count >= maxColumns) ? maxColumns : count;
    // 宽度
    CGFloat photosW = cols * kImageWH + (cols - 1) * kPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
}

@end
