//
//  ZMCompanyAuthViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMCompanyAuthViewController.h"
#import "ZMCompanyAuthView.h"

@interface ZMCompanyAuthViewController ()<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    BOOL isSelectedOn;
}
@property(nonatomic,strong)ZMCompanyAuthView *companyAuthView;
@property(nonatomic,strong)UIActionSheet     *camerSheet;
@property (nonatomic , strong) MBProgressHUD *HUD;
@end

@implementation ZMCompanyAuthViewController

-(void)loadView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.companyAuthView = [[ZMCompanyAuthView alloc] initWithFrame:SCREEN_BOUNDS];
    self.view     = self.companyAuthView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"企业认证";
    
    isSelectedOn = NO;
    [self addAction];
    
    
    //附件Noti
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(cardIDUploadSuccessfulAc)
                                                 name:@"cardIDUploadSuccessful"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(cardIDUploadFailedAc)
                                                 name:@"cardIDUploadFailed"
                                               object:nil];
    
    
    //公司是否认证
    NSString *isComAuth = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Com_auth]];
    //公司姓名
    NSString *comName = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Com_name]];
    
    if ([isComAuth isEqualToString:@"unauthed"]) {
        self.companyAuthView.commitBtn.alpha = 0.6;
        self.companyAuthView.commitBtn.userInteractionEnabled = NO;
        //未认证
        self.companyAuthView.companyTextField.text = comName;
        
    }else if ([isComAuth isEqualToString:@"authed"]){
        self.companyAuthView.commitBtn.alpha = 1;
        self.companyAuthView.commitBtn.userInteractionEnabled = NO;
        self.companyAuthView.commitBtn.backgroundColor = [UIColor lightGrayColor];
        [self.companyAuthView.commitBtn setTitle:@"已认证" forState:UIControlStateNormal];
        
        //已认证
        [self observeCerInfoAC];
    }else if ([isComAuth isEqualToString:@"unchecked"]){
        self.companyAuthView.commitBtn.alpha = 1;
        self.companyAuthView.commitBtn.userInteractionEnabled = NO;
        self.companyAuthView.commitBtn.backgroundColor = [UIColor lightGrayColor];
        [self.companyAuthView.commitBtn setTitle:@"待审核" forState:UIControlStateNormal];
        //待审核
        [self observeCerInfoAC];
    }else if ([isComAuth isEqualToString:@"failed"]){
        self.companyAuthView.companyTextField.text = comName;
        //认证失败
        self.companyAuthView.commitBtn.alpha = 0.6;
        self.companyAuthView.commitBtn.userInteractionEnabled = NO;
        
    }
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

            
            NSString *corp_name              = [NSString stringWithFormat:@"%@",object[@"data"][@"corp_name"]];
            NSString *business_license_image = [NSString stringWithFormat:@"%@",object[@"data"][@"business_license_image"]];
            
            self.companyAuthView.companyTextField.text                    = corp_name;
            self.companyAuthView.companyTextField.userInteractionEnabled  = NO;
            self.companyAuthView.cardIDOnImageView.userInteractionEnabled = NO;
            //on
            [self.companyAuthView.cardIDOnImageView sd_setImageWithURL:[NSURL URLWithString:business_license_image]
                                                       placeholderImage:[UIImage imageNamed:@"yingyezhizhaoImage"]];
            
            
           
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




#pragma mark - transmission
- (void)cardIDUploadSuccessfulAc{
    
    NSString *cardOnFilename = [[NSUserDefaults standardUserDefaults] objectForKey:@"personcardIDOn"];
    
    NSLog(@"cardOnFilename --- %@",cardOnFilename);
    
    NSString *urlStr     = [NSString stringWithFormat:@"%@/user/auth",APIDev];
    NSDictionary *praDic = @{@"name":self.companyAuthView.companyTextField.text,
                             @"business_license_image":cardOnFilename};
    NSMutableDictionary *praMutableDic = [NSMutableDictionary dictionaryWithDictionary:praDic];
    
    [AFNetManager requestWithType:HttpRequestTypePost withUrlString:urlStr withParaments:praMutableDic withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"company auth ----- %@",object);
        NSString *stateStr    = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            [[NSUserDefaults standardUserDefaults] setObject:@"unchecked" forKey:Com_auth];
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





- (void)addAction{
    
    UITapGestureRecognizer *viewTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapGRAction:)];
    [self.view addGestureRecognizer:viewTapGR];
    
    
    [self.companyAuthView.companyTextField addTarget:self action:@selector(checkBtn) forControlEvents:UIControlEventEditingChanged];
    
    [self.companyAuthView.commitBtn addTarget:self action:@selector(commitButtonDidClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UITapGestureRecognizer *cardIDOnTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cardIDOnTapGRTapGRAction:)];
    [self.companyAuthView.cardIDOnImageView addGestureRecognizer:cardIDOnTapGR];
}


#pragma mark - Commit
- (void)commitButtonDidClickAction:(UIButton *)sender{
    NSLog(@"commit");
    
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    [self.HUD show:YES];
    
    AliyunOSSManager *ossManager = [AliyunOSSManager new];
    [ossManager creatOSSClient:PrefixResource];
    
    //on
    UIImage *onImage = self.companyAuthView.cardIDOnImageView.image;
    NSData *onImageData = UIImageJPEGRepresentation(onImage, 0.5);
   
    //NSArray *dataArray = @[onImageData,onImageData];
    [ossManager uploadObjectAsyncResister:onImageData path:ResourceUser index:0 total:1];
}




#pragma mark - on
- (void)cardIDOnTapGRTapGRAction:(UITapGestureRecognizer *)sender{
    NSLog(@"on");
    [self.view endEditing:YES];
    
    
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
    
    isSelectedOn = YES;
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    
    self.companyAuthView.cardIDOnImageView.image = image;
    [self checkBtn];
}



-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Check Commit Btn
- (void)checkBtn{
    if (isSelectedOn&&self.companyAuthView.companyTextField.text.length>0) {
        self.companyAuthView.commitBtn.alpha = 1;
        self.companyAuthView.commitBtn.userInteractionEnabled = YES;
    }else{
        self.companyAuthView.commitBtn.alpha = 0.6;
        self.companyAuthView.commitBtn.userInteractionEnabled = NO;
    }
}



#pragma mark - tap
- (void)viewTapGRAction:(UITapGestureRecognizer *)sender{
    //NSLog(@"tap");
    [self.view endEditing:YES];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
