//
//  ZMLoginView.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMLoginView.h"

@interface ZMLoginView ()
@property(nonatomic,strong)UIView *telLine;
@property(nonatomic,strong)UIView *coderLine;
//tip
@property(nonatomic,strong)UILabel     *serverLabel;
@end

@implementation ZMLoginView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    self.backgroundColor = [UIColor whiteColor];
    
    self.logoImageView.image = [UIImage imageNamed:@"loginLogoName"];
    //self.logoImageView.backgroundColor = [UIColor redColor];
    [self addSubview:self.logoImageView];
    
    //tel
    [self text:self.telTextField];
    //self.telTextField.backgroundColor = [UIColor redColor];
    self.telTextField.placeholder = @"手机号";
    self.telTextField.keyboardType= UIKeyboardTypeNumberPad;
    [self addSubview:self.telTextField];
    
    //line
    self.telLine.backgroundColor = [UIColor colorWithHex:@"DFDFDF"];
    [self addSubview:self.telLine];
    
    //coder
    [self text:self.coderTextField];
    //self.coderTextField.backgroundColor = [UIColor redColor];
    self.coderTextField.placeholder = @"验证码";
    self.coderTextField.keyboardType= UIKeyboardTypeNumberPad;
    [self addSubview:self.coderTextField];
    
    self.loginButton.alpha = 0.6;
    self.loginButton.userInteractionEnabled = NO;
    
    //line
    self.coderLine.backgroundColor = [UIColor colorWithHex:@"DFDFDF"];
    [self addSubview:self.coderLine];
    
    [self setButton:self.requestButton
              title:@"获取验证码"
              color:[UIColor colorWithHex:tonalColor]
               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
                boo:NO];
    self.requestButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self addSubview:self.requestButton];
    
    [self setButton:self.loginButton
              title:@"登录"
              color:[UIColor colorWithHex:@"FFFFFF"]
               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*16]
                boo:YES];
    [self.loginButton setBackgroundColor:[UIColor colorWithHex:tonalColor]];
    [self addSubview:self.loginButton];
    
    //server
    [ZMLabelAttributeMange setLabel:self.serverLabel
                               text:@"登录即为同意"
                                hex:@"999999"
                      textAlignment:NSTextAlignmentCenter
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*13]];
    //self.serverLabel.backgroundColor = [UIColor redColor];
    [self addSubview:self.serverLabel];
    
    [self setButton:self.serverButton
              title:@"《芝麻商服会员服务协议》"
              color:[UIColor colorWithHex:tonalColor]
               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]
                boo:NO];
    self.serverButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //self.serverButton.backgroundColor = [UIColor yellowColor];
    [self addSubview:self.serverButton];
    
    
    
    //thitd
    self.thirdLine.backgroundColor = [UIColor colorWithHex:@"DFDFDF"];
    [self addSubview:self.thirdLine];
    
    self.thirdLabel.backgroundColor = [UIColor whiteColor];
    self.thirdLabel.font = [UIFont systemFontOfSize:SCREEN_WIDTH/375*12];
    self.thirdLabel.textAlignment = NSTextAlignmentCenter;
    self.thirdLabel.textColor = [UIColor colorWithHex:@"7D7D7D"];
    self.thirdLabel.text = @"合作账号登录";
    [self addSubview:self.thirdLabel];
    
    //wechat
    //self.wechatButton.backgroundColor = [UIColor colorWithHex:tonalColor];
    [self.wechatButton setImage:[UIImage imageNamed:@"wechatLoginImage"] forState:UIControlStateNormal];
    [self addSubview:self.wechatButton];
    
    
    self.wechatLabel.font = [UIFont systemFontOfSize:SCREEN_WIDTH/375*12];
    self.wechatLabel.textAlignment = NSTextAlignmentCenter;
    self.wechatLabel.text = @"微信登录";
    self.wechatLabel.textColor = [UIColor colorWithHex:@"7D7D7D"];
    //self.wechatLabel.backgroundColor = [UIColor redColor];
    [self addSubview:self.wechatLabel];
    
    
    
    //qq
    //self.QQButton.backgroundColor = [UIColor colorWithHex:tonalColor];
    [self.QQButton setImage:[UIImage imageNamed:@"qqLoginImage"] forState:UIControlStateNormal];
    [self addSubview:self.QQButton];
    
    
    self.qqLabel.font = [UIFont systemFontOfSize:SCREEN_WIDTH/375*12];
    self.qqLabel.textAlignment = NSTextAlignmentCenter;
    self.qqLabel.textColor = [UIColor colorWithHex:@"7D7D7D"];
    self.qqLabel.text = @"QQ登录";
    //self.qqLabel.backgroundColor = [UIColor redColor];
    [self addSubview:self.qqLabel];
    
    
    
    
    
    
    
    
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


- (void)text:(UITextField *)textField{
    textField.textAlignment = NSTextAlignmentLeft;
    textField.textColor     = [UIColor colorWithHex:@"666666"];
    textField.font          = [UIFont systemFontOfSize:SCREEN_WIDTH/375*14];
    //textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/375*13, SCREEN_WIDTH/375*40)];
    //textField.leftView.backgroundColor = [UIColor clearColor];
    //textField.leftViewMode = UITextFieldViewModeAlways;
}

-(UIImageView *)logoImageView{
    if (_logoImageView==nil) {
        _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*81)/2,
                                           SCREEN_WIDTH/375*64+SCREEN_WIDTH/375*45,
                                           SCREEN_WIDTH/375*81,
                                           SCREEN_WIDTH/375*104)];
}
    return _logoImageView;
}


//tel
-(UITextField *)telTextField{
    if (!_telTextField) {
        _telTextField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*41, SCREEN_WIDTH/375*64+SCREEN_WIDTH/375*180, SCREEN_WIDTH-SCREEN_WIDTH/375*82, SCREEN_WIDTH/375*30)];
    }
    return _telTextField;
}

-(UIView *)telLine{
    if (!_telLine) {
        _telLine = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*38, SCREEN_WIDTH/375*64+SCREEN_WIDTH/375*208, SCREEN_WIDTH-SCREEN_WIDTH/375*38-SCREEN_WIDTH/375*37, SCREEN_WIDTH/375*1)];
    }
    return _telLine;
}

//coder
-(UITextField *)coderTextField{
    if (!_coderTextField) {
        _coderTextField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*41, SCREEN_WIDTH/375*64+SCREEN_WIDTH/375*230, SCREEN_WIDTH-SCREEN_WIDTH/375*82, SCREEN_WIDTH/375*30)];
    }
    return _coderTextField;
}

-(UIView *)coderLine{
    if (!_coderLine) {
        _coderLine = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*38, SCREEN_WIDTH/375*64+SCREEN_WIDTH/375*258, SCREEN_WIDTH-SCREEN_WIDTH/375*38-SCREEN_WIDTH/375*37, SCREEN_WIDTH/375*1)];
    }
    return _coderLine;
}

-(UIButton *)requestButton{
    if (!_requestButton) {
        _requestButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*45.5-SCREEN_WIDTH/375*100,
                                                                    SCREEN_WIDTH/375*64+SCREEN_WIDTH/375*230,
                                                                    SCREEN_WIDTH/375*100,
                                                                    SCREEN_WIDTH/375*30)];
    }
    return _requestButton;
}


-(UIButton *)loginButton{
    if (!_loginButton) {
        _loginButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*37, SCREEN_WIDTH/375*64+SCREEN_WIDTH/375*303.7, SCREEN_WIDTH-SCREEN_WIDTH/375*74, SCREEN_WIDTH/375*40)];
    }
    return _loginButton;
}

//server
-(UILabel *)serverLabel{
    if (!_serverLabel) {
        _serverLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*36, SCREEN_WIDTH/375*64+SCREEN_WIDTH/375*356.7, SCREEN_WIDTH/375*80, SCREEN_WIDTH/375*17)];
    }
    return _serverLabel;
}

-(UIButton *)serverButton{
    
    if (!_serverButton) {
        _serverButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.serverLabel.frame)+SCREEN_WIDTH/375*1,
                                                                   SCREEN_WIDTH/375*64+SCREEN_WIDTH/375*356.7,
                                                                   SCREEN_WIDTH/375*200,
                                                                   SCREEN_WIDTH/375*17)];
    }
    return _serverButton;
}




//third Line
- (UIView *)thirdLine{
    
    if (_thirdLine==nil) {
        _thirdLine = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*38,
                                                              CGRectGetMaxY(self.loginButton.frame)+SCREEN_WIDTH/375*97,
                                                              SCREEN_WIDTH-SCREEN_WIDTH/375*76,
                                                              SCREEN_WIDTH/375*1)];
    }
    return _thirdLine;
}

-(UILabel *)thirdLabel{
    
    if (_thirdLabel==nil) {
        _thirdLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*86)/2,
                                                                CGRectGetMaxY(self.loginButton.frame)+SCREEN_WIDTH/375*91,
                                                                SCREEN_WIDTH/375*88,
                                                                SCREEN_WIDTH/375*12)];
    }
    return _thirdLabel;
}

-(UIButton *)wechatButton{
    if (!_wechatButton) {
        _wechatButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*120,
                                                                   CGRectGetMaxY(self.thirdLine.frame)+SCREEN_WIDTH/375*33,
                                                                   SCREEN_WIDTH/375*50,
                                                                   SCREEN_WIDTH/375*50)];
    }
    return _wechatButton;
}


-(UILabel *)wechatLabel{
    
    if (_wechatLabel==nil) {
        
        _wechatLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*100,
                                                                 CGRectGetMaxY(self.wechatButton.frame),
                                                                 SCREEN_WIDTH/375*90,
                                                                 SCREEN_WIDTH/375*20)];
    }
    return _wechatLabel;
}

//qq
-(UIButton *)QQButton{
    if (!_QQButton) {
        _QQButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*170,
                                                               CGRectGetMaxY(self.thirdLine.frame)+SCREEN_WIDTH/375*33,
                                                               SCREEN_WIDTH/375*50,
                                                               SCREEN_WIDTH/375*50)];
    }
    return _QQButton;
}


-(UILabel *)qqLabel{
    
    if (_qqLabel==nil) {
        
        _qqLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*190,
                                                             CGRectGetMaxY(self.QQButton.frame),
                                                             SCREEN_WIDTH/375*90,
                                                             SCREEN_WIDTH/375*20)];
    }
    return _qqLabel;
}
@end
