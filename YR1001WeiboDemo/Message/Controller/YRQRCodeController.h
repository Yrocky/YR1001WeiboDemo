//
//  YRQRCodeController.h
//  YR1001WeiboDemo
//
//  Created by Rocky on 14-10-9.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface YRQRCodeController : UIViewController

@property (nonatomic ,retain) AVCaptureDevice *device;
@property (nonatomic ,retain) AVCaptureDeviceInput *input;
@property (nonatomic ,retain) AVCaptureMetadataOutput *output;
@property (nonatomic ,retain) AVCaptureSession *session;
@property (nonatomic ,retain) AVCaptureVideoPreviewLayer *previewLayer;

@end
