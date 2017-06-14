//
//  BFCheckNewTelNumViewController.m
//  biufang
//
//  Created by 杜海龙 on 16/10/14.
//  Copyright © 2016年 biufang. All rights reserved.
//

#import "BFCheckNewTelNumViewController.h"
#import "BFRegularManage.h"

#import "ZMServiceViewController.h"
#import "ZMSelectIdentityViewController.h"

@interface BFCheckNewTelNumViewController ()<UITextFieldDelegate>
{

    BOOL isResetSmsCode;
}
@property (nonatomic , strong) UITextField *telTextField;
@property (nonatomic , strong) UIView *telline;

@property (nonatomic , strong) UITextField *coderTextField;
@property (nonatomic , strong) UIView *coderline;

@property (nonatomic , strong) UIButton *loginButton;

@property (nonatomic , strong) UIButton *requestCoderButton;

// NSTimer
@property(nonatomic,strong)NSTimer *valiCodeTimer;
// 秒数
@property(nonatomic)NSInteger startTime;

//服务条款
@property (nonatomic , strong) UIButton *serverButton;
@property (nonatomic , strong) UILabel *tipLabel;

//loading
@property(nonatomic,strong)UIView *loadingView;
//loading-Image
@property(nonatomic,strong)UIImageView *loadImageView;
@end

@implementation BFCheckNewTelNumViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title                = @"验证手机号码";
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUIAc];
    
}


- (void)wiewTapGRAction:(UITapGestureRecognizer *)sender{
    
    [self.telTextField resignFirstResponder];
    [self.coderTextField resignFirstResponder];
}


#pragma mark - 服务条款
- (void)serverButtonDidClickedAction:(UIButton *)sender{
    NSLog(@"server");
    ZMServiceViewController *serviceVC = [[ZMServiceViewController alloc] init];
    [self.navigationController pushViewController:serviceVC animated:YES];
}

#pragma mark - 获取验证码
- (void)requestCoderButtonDidClickedAction:(UIButton *)sender{
    
    if ([BFRegularManage checkMobile:self.telTextField.text]){
        [self startCountdown];
        //sender coder
        NSDictionary *parm = @{@"mobile":self.telTextField.text};
        NSString *urlStr   = [NSString stringWithFormat:@"%@/user/send-verify-code",APIDev];
        [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:parm withSuccessBlock:^(NSDictionary *object) {
            NSLog(@"%@",object);
            NSLog(@"%@",object[@"status"][@"message"]);
            
            NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
            if ([stateStr isEqualToString:@"success"]) {
                
                [self.coderTextField becomeFirstResponder];
            }else{
                [self showProgress:object[@"status"][@"message"]];
                [self stopCount];
            }
            //[self.HUD hide:YES];
        } withFailureBlock:^(NSError *error) {
            NSLog(@"%@",error);
            //[self.HUD hide:YES];
        } progress:^(float progress) {
            NSLog(@"%f",progress);
        }];
    }else{
        [self showProgress:@"请输入正确的手机号"];
        //[self.HUD hide:YES];
    }
    
}


//login
- (void)loginButtonDidClickedAction:(UIButton *)sender{
    
    /*
     1494570860.563000 dic ------- {
     "social_token" = "orR-K05HmlJllCGvh4LF2fsOpN6s";
     type = wechat;
     unionid = oNFVy1cAx3bMMU0KkkAlu2gnsMSY;
     headimgurl = 00001
     }
     */
    
    
    
    if ([BFRegularManage checkMobile:self.telTextField.text]) {
        NSDictionary *parDic;
        NSString *type = [NSString stringWithFormat:@"%@",self.bingDic[@"type"]];
        
        
        if ([type isEqualToString:@"wechat"]) {
            
            NSString *social_token = [NSString stringWithFormat:@"%@",self.bingDic[@"social_token"]];
            NSString *unionid = [NSString stringWithFormat:@"%@",self.bingDic[@"unionid"]];
            parDic = @{@"mobile":self.telTextField.text,
                       @"code":self.coderTextField.text,
                       @"scene":@"bind",
                       @"social_token":social_token,
                       @"source":type,
                       @"union_token":unionid};
        }else{
            NSString *social_token = [NSString stringWithFormat:@"%@",self.bingDic[@"social_token"]];
            NSString *unionid = [NSString stringWithFormat:@"%@",self.bingDic[@"unionid"]];
            parDic = @{@"mobile":self.telTextField.text,
                       @"code":self.coderTextField.text,
                       @"scene":@"bind",
                       @"social_token":social_token,
                       @"source":type,
                       @"union_token":unionid};
        }
        NSLog(@"bing ------------------------------ %@",parDic);
        NSString *urlStr = [NSString stringWithFormat:@"%@/user/verify-mobile",APIDev];
        [AFNetManager requestWithType:HttpRequestTypePost withUrlString:urlStr withParaments:parDic withSuccessBlock:^(NSDictionary *object) {

            NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
            if ([stateStr isEqualToString:@"success"]) {
                NSLog(@"bing successful --------------------------%@",object);
                //Save Info
                [[NSUserDefaults standardUserDefaults] setObject:object[@"data"][@"id"]   forKey:USER_ID];
                [[NSUserDefaults standardUserDefaults] setObject:object[@"data"][@"token"] forKey:TOKEN];
                
                
                NSString *isType = [NSString stringWithFormat:@"%@",object[@"data"][@"type"]];
                if ([isType isEqualToString:@"0"]) {
                    //Select ID
                    ZMSelectIdentityViewController *selectIdentityVC = [[ZMSelectIdentityViewController alloc] init];
                    selectIdentityVC.entranceType      = self.entranceType;
                    selectIdentityVC.bingHeaderImageUrl= [NSString stringWithFormat:@"%@",self.bingDic[@"headimgurl"]];
                    [self.navigationController pushViewController:selectIdentityVC animated:YES];
                }else{
                    
                    //bug
                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:IS_LOGIN];
                    
                    //bing successful
                    [self loginNextAc];
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
                
                
                
            }else{
                [self showProgress:object[@"status"][@"message"]];
            }
        } withFailureBlock:^(NSError *error) {
            NSLog(@"%@",error);
        } progress:^(float progress) {
            NSLog(@"%f",progress);
        }];
        
    }else{
        [self showProgress:@"请输入正确的手机号"];
    }
}

#pragma mark - 登录下一步
- (void)loginNextAc{
    if ([self.entranceType isEqualToString:@"MySelf"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MySelfLoginNextAction" object:nil];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:self.entranceType object:nil];
    }
}



#pragma mark - 三方创建用户成功
- (void)crearUserSuccessful{

}

#pragma mark - 三方登录 tel新用户 更新用户信息
- (void)updateUserInfoThirdLogin:(BOOL)isCreatUser{
    
    
}




#pragma mark - 更新手机号
- (void)updateUserTelAc{

    
}


#pragma mark - 输入
- (void)textFieldDidChange:(UITextField *)sender{

    if (self.telTextField.text.length>0&&self.coderTextField.text.length>0) {
        
        self.loginButton.alpha = 1;
        self.loginButton.userInteractionEnabled = YES;
    }else{
    
        self.loginButton.alpha = 0.6;
        self.loginButton.userInteractionEnabled = NO;
    }
}


#pragma mark - NSTimer
-(void)startCountdown{
    
    self.valiCodeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeGo) userInfo:nil repeats:YES];
    _startTime = 60;
    
    
    [self.requestCoderButton setTitleColor:[UIColor colorWithHex:@"cfcecc"] forState:UIControlStateHighlighted];
    [self.requestCoderButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.requestCoderButton setTitle:[NSString stringWithFormat:@"重新发送(%lds)",(long)_startTime] forState:UIControlStateNormal];
}

-(void)timeGo{
    
    _startTime--;
    
    self.requestCoderButton.userInteractionEnabled = NO;
    [self.requestCoderButton setTitleColor:[UIColor colorWithHex:@"cfcecc"] forState:UIControlStateHighlighted];
    [self.requestCoderButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.requestCoderButton setTitle:[NSString stringWithFormat:@"重新发送(%lds)",(long)_startTime] forState:UIControlStateNormal];
    
    if (_startTime==0) {
        
        self.requestCoderButton.userInteractionEnabled = YES;
        [self.requestCoderButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [self.requestCoderButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.requestCoderButton setTitle:@"重新发送" forState:UIControlStateNormal];
        
        isResetSmsCode = YES;
        [_valiCodeTimer invalidate];
        _valiCodeTimer = nil;
    }
}


- (void)stopCount{
    
    self.requestCoderButton.userInteractionEnabled = YES;
    [self.requestCoderButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [self.requestCoderButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.requestCoderButton setTitle:@"重新发送" forState:UIControlStateNormal];
    
    [_valiCodeTimer invalidate];
    _valiCodeTimer = nil;
}

#pragma mark - TextField Delegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    // Prevent crashing undo bug – see note below.
    if(range.length + range.location > textField.text.length){
        return NO;
    }
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    if (newLength > 11) {
        [self.coderTextField becomeFirstResponder];
    }
    return newLength <= 11;
}


//MBProgress
- (void)showProgress:(NSString *)tipStr{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    //只显示文字
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = tipStr;
    hud.margin = 20.f;
    //hud.yOffset = 150.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



















/*
-----------------------------------------------UI---------------------------------------------------
 */



- (void)setUIAc{
    
    self.telTextField.textColor = [UIColor colorWithHex:@"000000"];
    self.telTextField.tintColor = [UIColor colorWithHex:@"B2B2B2"];
    self.telTextField.textAlignment = NSTextAlignmentLeft;
    self.telTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.telTextField.font = [UIFont systemFontOfSize:14];
    self.telTextField.placeholder = @"手机号";
    self.telTextField.delegate = self;
    self.telTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.telTextField becomeFirstResponder];
    [self.view addSubview:self.telTextField];
    
    self.telline.backgroundColor = [UIColor colorWithHex:@"DFDFDF"];
    [self.view addSubview:self.telline];
    
    
    //self.coderTextField.backgroundColor = [UIColor redColor];
    self.coderTextField.textColor = [UIColor colorWithHex:@"000000"];
    self.coderTextField.tintColor = [UIColor colorWithHex:@"B2B2B2"];
    self.coderTextField.textAlignment = NSTextAlignmentLeft;
    self.coderTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.coderTextField.font = [UIFont systemFontOfSize:14];
    self.coderTextField.placeholder = @"验证码";
    self.coderTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.coderTextField];
    
    
    [self.requestCoderButton setTitleColor:[UIColor colorWithHex:tonalColor] forState:UIControlStateNormal];
    [self.requestCoderButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.requestCoderButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.requestCoderButton.titleLabel.font = [UIFont systemFontOfSize:16];
    self.requestCoderButton.titleLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:self.requestCoderButton];
    
    
    self.coderline.backgroundColor = [UIColor colorWithHex:@"DFDFDF"];
    [self.view addSubview:self.coderline];
    
    
    
    [self setButton:self.loginButton
              title:@"登录"
              color:[UIColor colorWithHex:@"FFFFFF"]
               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*16]
                boo:YES];
    [self.loginButton setBackgroundColor:[UIColor colorWithHex:tonalColor]];
    [self.view addSubview:self.loginButton];
    
    
    
    
    
    self.tipLabel.font = [UIFont systemFontOfSize:SCREEN_WIDTH/375*12];
    self.tipLabel.textAlignment = NSTextAlignmentCenter;
    self.tipLabel.textColor = [UIColor colorWithHex:@"999999"];
    self.tipLabel.text = @"登录即为同意";
    [self.view addSubview:self.tipLabel];
    
    
    [self.serverButton setTitle:@"《芝麻商服会员服务协议》" forState:UIControlStateNormal];
    [self.serverButton setTitleColor:[UIColor colorWithHex:tonalColor] forState:UIControlStateNormal];
    self.serverButton.titleLabel.font = [UIFont systemFontOfSize:SCREEN_WIDTH/375*12];
    self.serverButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:self.serverButton];
    
    [self.tipLabel sizeToFit];
    
    self.serverButton.frame = CGRectMake(CGRectGetMaxX(self.tipLabel.frame)+SCREEN_WIDTH/375*1,
                                         CGRectGetMaxY(self.loginButton.frame)+SCREEN_WIDTH/375*18,
                                         200,
                                         SCREEN_WIDTH/375*14);
    
    //服务条款
    [self.serverButton addTarget:self action:@selector(serverButtonDidClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.telTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.coderTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    UITapGestureRecognizer *viewTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wiewTapGRAction:)];
    [self.view addGestureRecognizer:viewTapGR];
    
    [self.loginButton addTarget:self action:@selector(loginButtonDidClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.requestCoderButton addTarget:self action:@selector(requestCoderButtonDidClickedAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setButton:(UIButton *)button title:(NSString *)title color:(UIColor *)textColor font:(UIFont *)textFond boo:(BOOL)islayer{
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    button.titleLabel.font    = textFond;
    if (islayer) {
        //button.layer.borderColor  = [UIColor whiteColor].CGColor;
        //button.layer.borderWidth  = SCREEN_WIDTH/375*1;
        button.layer.cornerRadius = SCREEN_WIDTH/375*4;
    }
}






//lazy
-(UITextField *)telTextField{
    
    if (_telTextField==nil) {
        _telTextField = [[UITextField alloc] initWithFrame:CGRectMake(41, SCREEN_WIDTH/375*(88+64), SCREEN_WIDTH-82, SCREEN_WIDTH/375*20)];
    }
    return _telTextField;
}

-(UIView *)telline{
    
    if (_telline==nil) {
        _telline = [[UITextField alloc] initWithFrame:CGRectMake(38, SCREEN_WIDTH/375*(88+20+2+64), SCREEN_WIDTH-76, SCREEN_WIDTH/375*1)];
    }
    return _telline;
}


-(UITextField *)coderTextField{
    
    if (_coderTextField==nil) {
        _coderTextField = [[UITextField alloc] initWithFrame:CGRectMake(41, SCREEN_WIDTH/375*(138+64), SCREEN_WIDTH/2-41, SCREEN_WIDTH/375*20)];
    }
    return _coderTextField;
}

-(UIView *)coderline{
    
    if (_coderline==nil) {
        _coderline = [[UITextField alloc] initWithFrame:CGRectMake(38, SCREEN_WIDTH/375*(138+20+2+64), SCREEN_WIDTH-76, SCREEN_WIDTH/375*1)];
    }
    return _coderline;
}

-(UIButton *)loginButton{
    
    if (_loginButton==nil) {
        _loginButton = [[UIButton alloc] initWithFrame:CGRectMake(38, SCREEN_WIDTH/375*(192+64), SCREEN_WIDTH-76, SCREEN_WIDTH/375*40)];
    }
    return _loginButton;
}

-(UIButton *)requestCoderButton{
    
    if (_requestCoderButton==nil) {
        _requestCoderButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-41-120, SCREEN_WIDTH/375*(138+64), 120, SCREEN_WIDTH/375*20)];
    }
    return _requestCoderButton;
}

-(UILabel *)tipLabel{
    
    if (_tipLabel==nil) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(38,
                                                              CGRectGetMaxY(self.loginButton.frame)+SCREEN_WIDTH/375*18,
                                                              SCREEN_WIDTH,
                                                              SCREEN_WIDTH/375*14)];
    }
    return _tipLabel;
}

-(UIButton *)serverButton{
    
    if (_serverButton==nil) {
        _serverButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.tipLabel.frame)+SCREEN_WIDTH/375*224,
                                                                   CGRectGetMaxY(self.loginButton.frame)+SCREEN_WIDTH/375*18,
                                                                   200,
                                                                   SCREEN_WIDTH/375*14)];
    }
    return _serverButton;
}

@end
