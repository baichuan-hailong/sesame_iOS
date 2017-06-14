//
//  ZMLoginViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMLoginViewController.h"
#import "ZMLoginView.h"

#import "ZMServiceViewController.h"
#import "ZMSelectIdentityViewController.h"

#import "BFRegularManage.h"

#import <UMSocialCore/UMSocialCore.h>
#import <UMSocialCore/UMSocialSOAuthViewController.h>

#import "BFCheckNewTelNumViewController.h"

#import <TencentOpenAPI/QQApiInterface.h>


@interface ZMLoginViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)ZMLoginView *loginView;

//NSTimer
@property(nonatomic,strong)NSTimer *valiCodeTimer;
//Seconds
@property(nonatomic)NSInteger startTime;

@property (nonatomic , strong) MBProgressHUD *HUD;

@end

@implementation ZMLoginViewController

-(void)loadView{
    
    self.loginView = [[ZMLoginView alloc] initWithFrame:SCREEN_BOUNDS];
    self.loginView.telTextField.delegate = self;
    self.view      = self.loginView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.interactivePopGestureRecognizer.enabled  = YES;
    self.title = @"登录";
    
    [self addAction];
    
    //待绑定
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(wechatWAITING_FOR_BIND:)
                                                 name:@"wechatWAITING_FOR_BIND"
                                               object:nil];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(bindingFnish)
                                                 name:@"bindingFnish"
                                               object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(bindingSelectIden:)
                                                 name:@"bindingSelectIden"
                                               object:nil];
    
    if (![WXApi isWXAppInstalled]&&![QQApiInterface isQQInstalled]) {
    
        self.loginView.thirdLine.alpha   = 0;
        self.loginView.thirdLabel.alpha  = 0;
        self.loginView.wechatButton.alpha= 0;
        self.loginView.wechatLabel.alpha = 0;
        self.loginView.QQButton.alpha    = 0;
        self.loginView.qqLabel.alpha     = 0;
    }else if (![WXApi isWXAppInstalled]) {
        
        self.loginView.thirdLine.alpha   = 1;
        self.loginView.thirdLabel.alpha  = 1;
        self.loginView.wechatButton.alpha= 0;
        self.loginView.wechatLabel.alpha = 0;
        self.loginView.QQButton.alpha    = 1;
        self.loginView.qqLabel.alpha     = 1;
        
        
        self.loginView.QQButton.frame = CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*50)/2,
                                                   CGRectGetMaxY(self.loginView.thirdLine.frame)+SCREEN_WIDTH/375*33,
                                                   SCREEN_WIDTH/375*50,
                                                   SCREEN_WIDTH/375*50);
        
        
        self.loginView.qqLabel.frame = CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*90)/2,
                                                  CGRectGetMaxY(self.loginView.QQButton.frame),
                                                  SCREEN_WIDTH/375*90,
                                                  SCREEN_WIDTH/375*20);
        
    }else if (![QQApiInterface isQQInstalled]) {
        
        self.loginView.thirdLine.alpha   = 1;
        self.loginView.thirdLabel.alpha  = 1;
        self.loginView.wechatButton.alpha= 1;
        self.loginView.wechatLabel.alpha = 1;
        self.loginView.QQButton.alpha    = 0;
        self.loginView.qqLabel.alpha     = 0;
        
        
        
        
        self.loginView.wechatButton.frame = CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*50)/2,
                                                       CGRectGetMaxY(self.loginView.thirdLine.frame)+SCREEN_WIDTH/375*33,
                                                       SCREEN_WIDTH/375*50,
                                                       SCREEN_WIDTH/375*50);
        
        
        self.loginView.wechatLabel.frame = CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*90)/2,
                                                      CGRectGetMaxY(self.loginView.wechatButton.frame),
                                                      SCREEN_WIDTH/375*90,
                                                      SCREEN_WIDTH/375*20);
        
    }else{
    
        
        self.loginView.thirdLine.alpha   = 1;
        self.loginView.thirdLabel.alpha  = 1;
        self.loginView.wechatButton.alpha= 1;
        self.loginView.wechatLabel.alpha = 1;
        self.loginView.QQButton.alpha    = 1;
        self.loginView.qqLabel.alpha     = 1;
    }
    
    //@property (nonatomic , strong) UILabel *thirdLabel;
    
    //wechat
    //@property(nonatomic,strong)UIButton    *wechatButton;
    //@property (nonatomic,strong)UILabel    *wechatLabel;
    //qq
    //@property(nonatomic,strong)UIButton    *QQButton;
    //@property (nonatomic,strong)UILabel    *qqLabel;
    
    if ([QQApiInterface isQQInstalled]){

        NSLog(@"qq yes");
    }
}


#pragma mark - 已绑定Tel Select IDen
- (void)bindingSelectIden:(NSNotification *)noti{
    [noti object];
    
    NSDictionary *dic = (NSDictionary *)[noti object];
    NSLog(@"binding dic ------- %@",dic);
    ZMSelectIdentityViewController *selectIdentityVC = [[ZMSelectIdentityViewController alloc] init];
    selectIdentityVC.entranceType      = self.entranceType;
    selectIdentityVC.bingHeaderImageUrl= [NSString stringWithFormat:@"%@",dic[@"headimgurl"]];
    [self.navigationController pushViewController:selectIdentityVC animated:YES];
    
}

- (void)bindingFnish{
    
    //bug
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:IS_LOGIN];
    
    //login successful
    [self loginNextAc];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 绑定手机号
- (void)wechatWAITING_FOR_BIND:(NSNotification *)noti{
    [noti object];
    
    NSDictionary *dic = (NSDictionary *)[noti object];
    NSLog(@"dic ------- %@",dic);

    BFCheckNewTelNumViewController *checkTelVC = [[BFCheckNewTelNumViewController alloc] init];
    checkTelVC.bingDic = dic;
    checkTelVC.entranceType = self.entranceType;
    [self.navigationController pushViewController:checkTelVC animated:YES];
    
}



- (void)addAction{
    
    [self.loginView.requestButton addTarget:self action:@selector(requestButtonDidClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.loginView.loginButton addTarget:self action:@selector(loginButtonDidClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.loginView.serverButton addTarget:self action:@selector(serverButtonDidClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *viewTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapGRAction:)];
    [self.view addGestureRecognizer:viewTapGR];
    
    //Change
    [self.loginView.telTextField   addTarget:self action:@selector(monitoringChange:) forControlEvents:UIControlEventEditingChanged];
    [self.loginView.coderTextField addTarget:self action:@selector(monitoringChange:) forControlEvents:UIControlEventEditingChanged];
    [self.loginView.wechatButton   addTarget:self action:@selector(wechatButtonDidClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView.QQButton       addTarget:self action:@selector(QQButtonDidClickAction:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Wechat
- (void)wechatButtonDidClickAction:(UIButton *)sender{
    
    [WXApi registerApp:WechatAppID];
    
    SendAuthReq *req = [[SendAuthReq alloc] init];
    req.scope = @"snsapi_userinfo"; //snsapi_base  snsapi_userinfo
    req.state = [self ret16bitString];
    [WXApi sendReq:req];
    
}


#pragma mark - request
- (void)requestButtonDidClickAction:(UIButton *)sender{
    
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    [self.HUD show:YES];
    
    if ([BFRegularManage checkMobile:self.loginView.telTextField.text]){
        
        //sender coder
        NSDictionary *parm = @{@"mobile":self.loginView.telTextField.text};
        NSString *urlStr   = [NSString stringWithFormat:@"%@/user/send-verify-code",APIDev];
        [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:parm withSuccessBlock:^(NSDictionary *object) {
            NSLog(@"%@",object);
            
            NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
            if ([stateStr isEqualToString:@"success"]) {
                [self startCountdown];
                [self.loginView.coderTextField becomeFirstResponder];
            }else{
                [self showProgress:object[@"status"][@"message"]];
                NSLog(@"error show   -------------------  %@",object[@"status"][@"message"]);
                [self stopCount];
            }
            [self.HUD hide:YES];
        } withFailureBlock:^(NSError *error) {
            NSLog(@"%@",error);
            [self.HUD hide:YES];
        } progress:^(float progress) {
            NSLog(@"%f",progress);
        }];
    }else{
        [self showProgress:@"请输入正确的手机号"];
        [self.HUD hide:YES];
    }
}

#pragma mark - 监测输入
- (void)monitoringChange:(UITextField *)sender{
    if (self.loginView.telTextField.text.length>0&&self.loginView.coderTextField.text.length>0) {
        self.loginView.loginButton.alpha = 1;
        self.loginView.loginButton.userInteractionEnabled = YES;
    }else{
        self.loginView.loginButton.alpha = 0.6;
        self.loginView.loginButton.userInteractionEnabled = NO;
    }
}

#pragma mark - TextField Delegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    // Prevent crashing undo bug – see note below.
    if(range.length + range.location > textField.text.length){
        return NO;
    }
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    if (newLength > 11) {
        [self.loginView.coderTextField becomeFirstResponder];
    }
    return newLength <= 11;
}


#pragma mark - NSTimer
-(void)startCountdown{
    self.valiCodeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeGo) userInfo:nil repeats:YES];
    _startTime = 60;
    [self.loginView.requestButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    //[self.loginView.requestButton setTitleColor:[UIColor colorWithHex:@"cfcecc"] forState:UIControlStateHighlighted];
    [self.loginView.requestButton setTitle:[NSString stringWithFormat:@"重新发送(%lds)",(long)_startTime] forState:UIControlStateNormal];
}


-(void)timeGo{
    _startTime--;
    self.loginView.requestButton.userInteractionEnabled = NO;
    [self.loginView.requestButton setTitle:[NSString stringWithFormat:@"重新发送(%lds)",(long)_startTime] forState:UIControlStateNormal];
    if (_startTime==0) {
        self.loginView.requestButton.userInteractionEnabled = YES;
        [self.loginView.requestButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [self.loginView.requestButton setTitleColor:[UIColor colorWithHex:tonalColor] forState:UIControlStateNormal];
        [self.loginView.requestButton setTitle:@"重新发送" forState:UIControlStateNormal];
        //isShowTip = YES;
        [_valiCodeTimer invalidate];
        _valiCodeTimer = nil;
    }
}



- (void)stopCount{
    self.loginView.requestButton.userInteractionEnabled = YES;
    //[self.loginView.requestButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [self.loginView.requestButton setTitleColor:[UIColor colorWithHex:tonalColor] forState:UIControlStateNormal];
    [self.loginView.requestButton setTitle:@"重新发送" forState:UIControlStateNormal];
    
    [_valiCodeTimer invalidate];
    _valiCodeTimer  = nil;
}


#pragma mark - login
- (void)loginButtonDidClickAction:(UIButton *)sender{
    
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    [self.HUD show:YES];
    //NSLog(@"login");
    [self.view endEditing:YES];
    
    
     //NSLog(@"login");
     if ([BFRegularManage checkMobile:self.loginView.telTextField.text]) {
         //verify moble
         NSDictionary *parDic = @{@"mobile":self.loginView.telTextField.text,
         @"code":self.loginView.coderTextField.text};
         //NSLog(@"%@",parDic);
         NSString *urlStr = [NSString stringWithFormat:@"%@/user/verify-mobile",APIDev];
         [AFNetManager requestWithType:HttpRequestTypePost withUrlString:urlStr withParaments:parDic withSuccessBlock:^(NSDictionary *object) {
             NSLog(@"Login ----------------- %@",object);
             NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
             if ([stateStr isEqualToString:@"success"]) {
                 //Save Info
                 [[NSUserDefaults standardUserDefaults] setObject:object[@"data"][@"id"]   forKey:USER_ID];
                 [[NSUserDefaults standardUserDefaults] setObject:object[@"data"][@"token"] forKey:TOKEN];
                 
                 //[self obtainUserInfo];
                 NSString *isType = [NSString stringWithFormat:@"%@",object[@"data"][@"type"]];
                 if ([isType isEqualToString:@"0"]) {
                     //Select ID
                     ZMSelectIdentityViewController *selectIdentityVC = [[ZMSelectIdentityViewController alloc] init];
                     selectIdentityVC.entranceType = self.entranceType;
                     [self.navigationController pushViewController:selectIdentityVC animated:YES];
                 }else{
                     
                     //bug
                     [[NSUserDefaults standardUserDefaults] setBool:YES forKey:IS_LOGIN];
                     
                     //login successful
                     [self loginNextAc];
                     [self dismissViewControllerAnimated:YES completion:nil];
                     
                 }
             }else{
                 [self showProgress:object[@"status"][@"message"]];
                 NSLog(@"error ------------- %@",object[@"status"][@"message"]);
             }
             [self.HUD hide:YES];
         } withFailureBlock:^(NSError *error) {
             NSLog(@"%@",error);
             [self.HUD hide:YES];
         } progress:^(float progress) {
             NSLog(@"%f",progress);
         }];
     
     }else{
         [self showProgress:@"请输入正确的手机号"];
         [self.HUD hide:YES];
     }
}




#pragma mark - 登录下一步
- (void)loginNextAc{
    
    if ([self.entranceType isEqualToString:@"MySelf"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MySelfLoginNextAction" object:nil];
    }else{
        NSLog(@"~~~~~~~~~~~~~~~~~~~~~%@",self.entranceType);
        [[NSNotificationCenter defaultCenter] postNotificationName:self.entranceType object:nil];
    }
}








#pragma mark - server
- (void)serverButtonDidClickAction:(UIButton *)sender{
    NSLog(@"server");
    ZMServiceViewController *serviceVC = [[ZMServiceViewController alloc] init];
    [self.navigationController pushViewController:serviceVC animated:YES];
}

#pragma mark - tap
- (void)viewTapGRAction:(UITapGestureRecognizer *)sender{
    NSLog(@"tap");
    [self.view endEditing:YES];
}



#pragma mark - QQ
- (void)QQButtonDidClickAction:(UIButton *)sender{
    NSLog(@"QQ");
    
    [[UMSocialManager defaultManager] setUmSocialAppkey:UM_APPKEY];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ
                                          appKey:QQAppID/*设置QQ平台的appID*/
                                       appSecret:QQAppKey
                                     redirectURL:nil];
    
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:self completion:^(id result, NSError *error) {
        if (error) {
            [self showProgress:@"授权失败！"];
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"QQ uid: %@", resp.uid);
            NSLog(@"QQ openid: %@", resp.openid);
            NSLog(@"QQ accessToken: %@", resp.accessToken);
            NSLog(@"QQ expiration: %@", resp.expiration);
            
            // 用户信息
            //NSLog(@"QQ name: %@", resp.name);
            //NSLog(@"QQ iconurl: %@", resp.iconurl);
            //NSLog(@"QQ gender: %@", resp.unionGender);
            
            // 第三方平台SDK源数据
            //NSLog(@"QQ originalResponse: %@", resp.originalResponse);
            
            
            
            [self authType:@"qq" unionToken:resp.uid socialToke:resp.openid headimgurl:resp.iconurl];
        }
    }];
}




#pragma mark - login
- (void)authType:(NSString *)type unionToken:(NSString *)union_token socialToke:(NSString *)social_token headimgurl:(NSString *)headeUrl{
    
    
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    [self.HUD show:YES];
    
    //verify moble
    NSDictionary *parDic = @{@"social_token":social_token,
                             @"union_token":union_token,
                             @"source":type};
    
    NSLog(@"type ------------ %@",parDic);
    NSString *urlStr = [NSString stringWithFormat:@"%@/user/social-auth",APIDev];
    [AFNetManager requestWithType:HttpRequestTypePost withUrlString:urlStr withParaments:parDic withSuccessBlock:^(NSDictionary *object) {
        
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            NSLog(@"Login sucessful ----------------- %@",object);
            //Save Info
            [[NSUserDefaults standardUserDefaults] setObject:object[@"data"][@"id"]   forKey:USER_ID];
            [[NSUserDefaults standardUserDefaults] setObject:object[@"data"][@"token"] forKey:TOKEN];
            
            NSString *isType = [NSString stringWithFormat:@"%@",object[@"data"][@"type"]];
            if ([isType isEqualToString:@"0"]) {
                //Select ID
                ZMSelectIdentityViewController *selectIdentityVC = [[ZMSelectIdentityViewController alloc] init];
                selectIdentityVC.entranceType      = self.entranceType;
                selectIdentityVC.bingHeaderImageUrl= headeUrl;
                [self.navigationController pushViewController:selectIdentityVC animated:YES];
                
            }else{
                //fnish login
                //bug
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:IS_LOGIN];
                
                //login successful
                [self loginNextAc];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            
        }else{
            NSLog(@"Login WAITING_FOR_BIND ----------------- %@",object);
            NSString *messageStr = [NSString stringWithFormat:@"%@",object[@"status"][@"message"]];
            if ([messageStr isEqualToString:@"PENDING|WAITING_FOR_BIND"]) {
                
                NSDictionary *dic = @{@"unionid":union_token,
                                      @"social_token":social_token,
                                      @"headimgurl":headeUrl,
                                      @"type":@"qq"};
                
                BFCheckNewTelNumViewController *checkTelVC = [[BFCheckNewTelNumViewController alloc] init];
                checkTelVC.bingDic = dic;
                checkTelVC.entranceType = self.entranceType;
                [self.navigationController pushViewController:checkTelVC animated:YES];
            }
        }
        [self.HUD hide:YES];
    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
        [self.HUD hide:YES];
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}





//MBProgress
- (void)showProgress:(NSString *)tipStr{
    MBProgressHUD *hud            = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode                      = MBProgressHUDModeText;
    hud.labelText                 = tipStr;
    hud.margin                    = 20.f;
    hud.removeFromSuperViewOnHide = YES;
    hud.labelFont = [UIFont systemFontOfSize:SCREEN_WIDTH/375*13];
    [hud hide:YES afterDelay:1];
}


#pragma mark - System
-(NSString *)ret16bitString{
    char data[16];
    for (int x=0;x<16;data[x++] = (char)('A' + (arc4random_uniform(26))));
    return [[NSString alloc] initWithBytes:data length:16 encoding:NSUTF8StringEncoding];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
