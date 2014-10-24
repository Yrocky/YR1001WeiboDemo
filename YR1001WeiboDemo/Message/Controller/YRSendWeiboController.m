//
//  YRSendWeiboController.m
//  YR1001WeiboDemo
//
//  Created by Rocky on 14-10-9.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#import "YRSendWeiboController.h"
#import "YRSinaRequestDelegate.h"
#import "SVProgressHUD.h"

@interface YRSendWeiboController ()<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,SinaWeiboRequestDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *senderButton;
@property (nonatomic ,retain) UILabel *placeHolderLabel;
@property (weak, nonatomic) IBOutlet UIView *toolBar;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (nonatomic ,retain) NSMutableArray *pickImages;

- (IBAction)cancelSenderWeibo:(UIButton *)sender;
- (IBAction)clearAllText:(UITapGestureRecognizer *)sender;
- (IBAction)hideKeyboard:(UISwipeGestureRecognizer *)sender;
- (IBAction)senderWeibo:(UIButton *)sender;


- (IBAction)hotTalkButton:(UIButton *)sender;
- (IBAction)smileButton:(UIButton *)sender;
- (IBAction)aiteFriendButton:(UIButton *)sender;
- (IBAction)photoButton:(UIButton *)sender;
@end

@implementation YRSendWeiboController

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillDisappear:animated];

    [_textView becomeFirstResponder];

//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(senderWeiboNoti:) name:kSinaWeiboRequestGetResult object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(senderWeiboError:) name:kSinaWeiboRequestError object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:kSinaWeiboRequestGetResult object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:kSinaWeiboRequestError object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyBoardHide:) name:UIKeyboardWillHideNotification object:nil];
    _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 20)];
    _placeHolderLabel.text = @"分享新鲜事...";
    _placeHolderLabel.textColor = [UIColor lightGrayColor];
    _placeHolderLabel.font = [UIFont systemFontOfSize:12];
    [_textView addSubview:_placeHolderLabel];
    _headerView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _headerView.layer.borderWidth = 0.5;
    _toolBar.layer.borderWidth = 0.5;
    _toolBar.layer.borderColor = [UIColor lightGrayColor].CGColor;

    

}
#pragma mark - uiTextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView{

    if (textView.text.length == 0) {
        // 将发送按钮设置成不能用
        _senderButton.enabled = NO;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if (![text isEqualToString:@""]) {
        // placeHolder隐藏
        _placeHolderLabel.hidden = YES;
    }
    // 这里说明只有一个删除键
    if ([textView.text isEqualToString:@""] && range.location == 0 && range.length == 1) {
        // 将placeHolder显示
        _placeHolderLabel.hidden = NO;
    }
    
#warning  尤明老师讲解，
//    NSString *finalString = [textView.text stringByReplacingCharactersInRange:range withString:text];
//
//    if ([finalString isEqualToString:@""]  ) {
//
//        _senderButton.enabled = NO;
//        _placeHolderLabel.hidden = NO;
//    }else{
//        _placeHolderLabel.hidden = YES;
//        _senderButton.enabled = YES;
//    }
    return YES;
    
    
}

//
- (void) textViewDidChange:(UITextView *)textView{
    if (textView.text.length > 0) {
        // 将button可用
        _senderButton.enabled = YES;
    }else{
        _senderButton.enabled = NO;
        // button不可用
    }
    // 这里是只要文本发生改变，并且为空，就显示placerhold
    if ([textView.text isEqualToString:@""]) {
        _placeHolderLabel.hidden = NO;
    }
}

#pragma mark - 手势和button点击事件
- (IBAction)cancelSenderWeibo:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(senderWeiboConreollerDidCancel)]) {
        
        [self.delegate senderWeiboConreollerDidCancel];
    }
//    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clearAllText:(UITapGestureRecognizer *)sender {
    _textView.text = nil;
    _senderButton.enabled = NO;
    _placeHolderLabel.hidden = NO;

}

- (IBAction)hideKeyboard:(UISwipeGestureRecognizer *)sender {
    [_textView resignFirstResponder];
}

#pragma mark - 点击发送按钮进行网络请求发送微博
- (IBAction)senderWeibo:(UIButton *)sender {

    NSString *weiboText = _textView.text;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSDictionary *userData = [kNSUD valueForKey:kAuthSinaWeiboAuthData];
    NSString *authAccessToken = [userData valueForKey:kAuthAccessTokenKey];
    
    [params setObject:authAccessToken forKey:@"access_token"];
    [params setObject:weiboText forKey:@"status"];
//    [params setObject:@1 forKey:@"visible"];
//    [params setObject:appDelegate.sinaWeibo.userID forKey:@"uid"];
    // 出现一个风火轮
    [SVProgressHUD show];
    if (_pickImages.count == 0 || _pickImages == nil) {
        [appDelegate.sinaWeibo requestWithURL:@"statuses/update.json" params:params httpMethod:@"POST" delegate:self];
//        [[YRSinaRequestDelegate shareSinaWeiboResuestDelegate] request:@"statuses/update.json" withParams:params httpMethod:@"POST"];
    }else{

        UIImage *image = [_pickImages lastObject];
        [params setObject:image forKey:@"pic"];
        [appDelegate.sinaWeibo requestWithURL:@"statuses/upload.json" params:params httpMethod:@"POST" delegate:self];
//        [[YRSinaRequestDelegate shareSinaWeiboResuestDelegate] request:@"statuses/upload.json" withParams:params httpMethod:@"POST"];
    }
    
}

- (IBAction)hotTalkButton:(UIButton *)sender {
}

- (IBAction)smileButton:(UIButton *)sender {
}

- (IBAction)aiteFriendButton:(UIButton *)sender {
}

#pragma mark -  挑选图片
- (IBAction)photoButton:(UIButton *)sender {
    
    // 判断是否支持调用
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        picker.videoQuality = UIImagePickerControllerQualityTypeLow;
        [self presentViewController:picker animated:YES completion:^{
        
        }];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{

    UIImage *image = [info valueForKey: UIImagePickerControllerEditedImage];
    CGSize textSize = [_textView.text sizeWithFont:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(300, MAXFLOAT)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, textSize.height + 100, 150, 100)];
    imageView.image = image;
    [_textView addSubview:imageView];
    
    if ( nil == _pickImages) {
        _pickImages = [NSMutableArray array];
    }
    [_pickImages addObject:image];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{

    [picker dismissViewControllerAnimated:YES completion:^{
        
        [_textView becomeFirstResponder];
        
    }];
}

#pragma mark - 网络请求的结果通知
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result{

    NSString *requestUrl = request.url;
//    NSDictionary *result = [noti valueForKeyPath:@"object.resquestResult"];
    if ([requestUrl isEqualToString:@"https://open.weibo.cn/2/statuses/update.json"]) {

        NSString *statusText = [result valueForKeyPath:@"text"];
        NSString *name = [result valueForKeyPath:@"user.screen_name"];
        NSLog(@"%@发了一条微博:%@",name,statusText);

        // 添加一个库
        [self dismissViewControllerAnimated:YES completion:^{
        
            [SVProgressHUD dismissWithSuccess:@"发送成功"];
        }];
    }else if([requestUrl isEqualToString:@"https://open.weibo.cn/2/statuses/upload.json"]){
        
        [self dismissViewControllerAnimated:YES completion:^{
            
            [SVProgressHUD dismissWithSuccess:@"发送成功"];
        }];
    }else{ return;}
}

#pragma mark - 发送微博的网络请求失败的通知
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error{
    
    [SVProgressHUD showErrorWithStatus:@"发送失败，保存到草稿箱"];
    
}

#pragma mark - 键盘的出现和消失通知
- (void) onKeyBoardShow:(NSNotification *)noti{

    [self changeToolBarOriginWithNotification:noti ];
}

- (void) onKeyBoardHide:(NSNotification *)noti{

    [self changeToolBarOriginWithNotification:noti ];
}
- (void) changeToolBarOriginWithNotification:(NSNotification *)noti {


    NSDictionary *userInfo = [noti valueForKey:@"userInfo"];
    
    CGFloat duration = [[userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    CGRect endFrame = [[userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat keyHeight = endFrame.origin.y - 44;

    [UIView animateWithDuration:duration animations:^{
        _toolBar.frame = CGRectMake(-2, keyHeight, 324, 44);

    }];

//    NSLog(@"%@",NSStringFromCGRect(_toolBar.frame));
}

#pragma mark - 移除通知
- (void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    NSLog(@"dealloc");
}
@end
