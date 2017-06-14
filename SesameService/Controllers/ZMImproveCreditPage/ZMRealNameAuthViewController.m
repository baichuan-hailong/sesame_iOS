//
//  ZMRealNameAuthViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/30.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMRealNameAuthViewController.h"
#import "ZMRealNameAuthView.h"

@interface ZMRealNameAuthViewController ()<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    BOOL isOn;
    BOOL isOff;
    BOOL isSelectedOn;
    BOOL isSelectedOff;
}
@property (nonatomic,strong)ZMRealNameAuthView *realNameAuthView;
@property(nonatomic,strong)UIActionSheet       *camerSheet;
@property (nonatomic , strong) MBProgressHUD   *HUD;
@end

@implementation ZMRealNameAuthViewController

-(void)loadView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.realNameAuthView = [[ZMRealNameAuthView alloc] initWithFrame:SCREEN_BOUNDS];
    
    self.realNameAuthView.contentSize     = CGSizeMake(SCREEN_WIDTH,
                                                       CGRectGetMaxY(self.realNameAuthView.tipLabel.frame)+SCREEN_WIDTH/375*20);
    self.view = self.realNameAuthView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"实名认证";
    
    [self addAction];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(cardIDUploadSuccessfulAc)
                                                 name:@"cardIDUploadSuccessful"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(cardIDUploadFailedAc)
                                                 name:@"cardIDUploadFailed"
                                               object:nil];
    
    
    //个人是否认证
    NSString *isPersonAuth = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Person_auth]];
    NSString *person_name = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Person_name]];
    
    if ([isPersonAuth isEqualToString:@"unauthed"]) {
        //未认证
        self.realNameAuthView.nameTextField.text = person_name;
    }else if ([isPersonAuth isEqualToString:@"authed"]){
        //已认证
        [self.realNameAuthView.commitBtn setTitle:@"已认证" forState:UIControlStateNormal];
        self.realNameAuthView.commitBtn.userInteractionEnabled = NO;
        self.realNameAuthView.commitBtn.backgroundColor = [UIColor lightGrayColor];
        
        [self observeCerInfoAC];
    }else if ([isPersonAuth isEqualToString:@"unchecked"]){
        //待审核
        [self.realNameAuthView.commitBtn setTitle:@"待审核" forState:UIControlStateNormal];
        self.realNameAuthView.commitBtn.userInteractionEnabled = NO;
        self.realNameAuthView.commitBtn.backgroundColor = [UIColor lightGrayColor];
        
        
        [self observeCerInfoAC];
    }else if ([isPersonAuth isEqualToString:@"failed"]){
        //认证失败
        self.realNameAuthView.nameTextField.text = person_name;
    }
    
    /*
     self.realNameAuthView.tipLabel.frame = CGRectMake(SCREEN_WIDTH/375*20,
     SCREEN_WIDTH/375*624+SCREEN_WIDTH/375*64,
     SCREEN_WIDTH/375*300,
     SCREEN_WIDTH/375*17);
     */
    
}


#pragma mark - 获取认证信息
- (void)observeCerInfoAC{
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    [self.HUD show:YES];
    NSString *urlStr   = [NSString stringWithFormat:@"%@/user/auth-info",APIDev];
    [AFNetManager requestWithType:HttpRequestTypePost withUrlString:urlStr withParaments:nil withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"user---auth---info---%@",object);
        NSString *stateStr    = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            
            NSString *person_name         = [NSString stringWithFormat:@"%@",object[@"data"][@"person_name"]];
            NSString *identify_number     = [NSString stringWithFormat:@"%@",object[@"data"][@"identify_number"]];
            NSString *identify_image_front= [NSString stringWithFormat:@"%@",object[@"data"][@"identify_image_front"]];
            NSString *identify_image_back = [NSString stringWithFormat:@"%@",object[@"data"][@"identify_image_back"]];
            self.realNameAuthView.nameTextField.text  = person_name;
            self.realNameAuthView.cardIDTextField.text=identify_number;
            self.realNameAuthView.nameTextField.userInteractionEnabled     =NO;
            self.realNameAuthView.cardIDTextField.userInteractionEnabled   =NO;
            self.realNameAuthView.cardIDOnImageView.userInteractionEnabled =NO;
            self.realNameAuthView.cardIDOffImageView.userInteractionEnabled=NO;
            //on
            [self.realNameAuthView.cardIDOnImageView sd_setImageWithURL:[NSURL URLWithString:identify_image_front]
                                                       placeholderImage:[UIImage imageNamed:@"cardIDOnnImage"]];
            //off
            [self.realNameAuthView.cardIDOffImageView sd_setImageWithURL:[NSURL URLWithString:identify_image_back]
                                                       placeholderImage:[UIImage imageNamed:@"cardIDOnImage"]];
        }else{
            [self showProgress:object[@"status"][@"message"]];
        }
        [self.HUD hide:YES];
    } withFailureBlock:^(NSError *error) {
        NSLog(@"cer ----- %@",error);
        [self.HUD hide:YES];
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}





- (void)addAction{
    
    UITapGestureRecognizer *viewTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapGRAction:)];
    [self.view addGestureRecognizer:viewTapGR];
    
    [self.realNameAuthView.nameTextField addTarget:self action:@selector(checkBtn) forControlEvents:UIControlEventEditingChanged];
    [self.realNameAuthView.cardIDTextField addTarget:self action:@selector(checkBtn) forControlEvents:UIControlEventEditingChanged];
    
    [self.realNameAuthView.commitBtn addTarget:self action:@selector(commitButtonDidClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UITapGestureRecognizer *cardIDOnTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cardIDOnTapGRTapGRAction:)];
    [self.realNameAuthView.cardIDOnImageView addGestureRecognizer:cardIDOnTapGR];
    
    UITapGestureRecognizer *cardIDOffTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cardIDOffTapGRTapGRAction:)];
    [self.realNameAuthView.cardIDOffImageView addGestureRecognizer:cardIDOffTapGR];
}
#pragma mark - transmission
- (void)cardIDUploadSuccessfulAc{
    NSString *cardOnFilename = [[NSUserDefaults standardUserDefaults] objectForKey:@"personcardIDOn"];
    NSString *cardOffFilename= [[NSUserDefaults standardUserDefaults] objectForKey:@"personcardIDOff"];
    NSLog(@"%@ --- %@",cardOnFilename,cardOffFilename);
    NSString *urlStr   = [NSString stringWithFormat:@"%@/user/auth",APIDev];
    NSDictionary *praDic = @{@"name":self.realNameAuthView.nameTextField.text,
                             @"identify_number":self.realNameAuthView.cardIDTextField.text,
                             @"identify_image_front":cardOnFilename,
                             @"identify_image_back":cardOffFilename};
    NSMutableDictionary *praMutableDic = [NSMutableDictionary dictionaryWithDictionary:praDic];
    [AFNetManager requestWithType:HttpRequestTypePost withUrlString:urlStr withParaments:praMutableDic withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"%@",object);
        NSString *stateStr    = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            [[NSUserDefaults standardUserDefaults] setObject:@"unchecked" forKey:Person_auth];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"haveCommitCheckSuccessful" object:nil];
            [self showProgress:object[@"data"][@"success"]];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            [self showProgress:object[@"status"][@"message"]];
        }
        [self.HUD hide:YES];
    } withFailureBlock:^(NSError *error) {
        NSLog(@"cer ----- %@",error);
        [self.HUD hide:YES];
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}

- (void)cardIDUploadFailedAc{
    [self.HUD hide:YES];
    [self showProgress:@"认证失败!"];
}

#pragma mark - Tap
- (void)viewTapGRAction:(UITapGestureRecognizer *)sender{
    NSLog(@"tap");
    [self.view endEditing:YES];
}

#pragma mark - on
- (void)cardIDOnTapGRTapGRAction:(UITapGestureRecognizer *)sender{
    NSLog(@"on");
    [self.view endEditing:YES];
    isOn = YES;
    isOff= NO;
    self.camerSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                  delegate:self
                                         cancelButtonTitle:@"取消"
                                    destructiveButtonTitle:nil
                                         otherButtonTitles:@"拍照",@"图片上传", nil];
    [self.camerSheet showInView:self.view];
}

#pragma mark - off
- (void)cardIDOffTapGRTapGRAction:(UITapGestureRecognizer *)sender{
    NSLog(@"off");
    [self.view endEditing:YES];
    isOn = NO;
    isOff= YES;
    self.camerSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                  delegate:self
                                         cancelButtonTitle:@"取消"
                                    destructiveButtonTitle:nil
                                         otherButtonTitles:@"拍照",@"图片上传", nil];
    [self.camerSheet showInView:self.view];
}

#pragma mark - SheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == actionSheet.firstOtherButtonIndex) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *imagePickerVC = [[UIImagePickerController alloc] init];
            imagePickerVC.delegate = self;
            imagePickerVC.allowsEditing = YES;
            imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePickerVC animated:YES completion:nil];
        }
    }else if (buttonIndex == actionSheet.firstOtherButtonIndex + 1){
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            UIImagePickerController *imagePickerVC = [[UIImagePickerController alloc] init];
            [imagePickerVC setModalPresentationStyle:UIModalPresentationFullScreen];
            imagePickerVC.delegate = self;
            imagePickerVC.allowsEditing = YES;
            imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePickerVC animated:YES completion:nil];
        }
    }
}


#pragma mark - Picture
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    
    if (isOn) {
        NSLog(@"on");
        isSelectedOn = YES;
        self.realNameAuthView.cardIDOnImageView.image = image;
    }
    
    if (isOff) {
        NSLog(@"off");
        isSelectedOff = YES;
        self.realNameAuthView.cardIDOffImageView.image = image;
    }
    
    
    [self checkBtn];
}



-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Commit
- (void)commitButtonDidClickAction:(UIButton *)sender{
    NSLog(@"commit");
    
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    [self.HUD show:YES];
    
    NSLog(@"NAME---%@---CARDID---%@",self.realNameAuthView.nameTextField.text,self.realNameAuthView.cardIDTextField.text);
    AliyunOSSManager *ossManager = [AliyunOSSManager new];
    [ossManager creatOSSClient:PrefixResource];
    
    //on
    UIImage *onImage = self.realNameAuthView.cardIDOnImageView.image;
    NSData *onImageData = UIImageJPEGRepresentation(onImage, 0.3);
    //off
    UIImage *offImage = self.realNameAuthView.cardIDOffImageView.image;
    NSData *offImageData = UIImageJPEGRepresentation(offImage, 0.3);
    
    NSArray *dataArray = @[onImageData,offImageData];
    for (int i=0; i<dataArray.count; i++) {
        [ossManager uploadObjectAsyncResister:dataArray[i] path:ResourceUser index:i total:dataArray.count];
    }
}



#pragma mark - Check Commit Btn
- (void)checkBtn{
    if (isSelectedOn&&isSelectedOff&&self.realNameAuthView.nameTextField.text.length>0&&self.realNameAuthView.cardIDTextField.text.length>0) {
        self.realNameAuthView.commitBtn.alpha = 1;
        self.realNameAuthView.commitBtn.userInteractionEnabled = YES;
    }else{
        self.realNameAuthView.commitBtn.alpha = 0.6;
        self.realNameAuthView.commitBtn.userInteractionEnabled = NO;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//MBProgress
- (void)showProgress:(NSString *)tipStr{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud            = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
    hud.mode                      = MBProgressHUDModeText;
    hud.labelText                 = tipStr;
    hud.margin                    = 20.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}


@end
