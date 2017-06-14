//
//  ZMCommissionSignViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/5/24.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMCommissionSignViewController.h"

@interface ZMCommissionSignViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView     *webView;
@property (nonatomic, strong) MBProgressHUD *hud;

@property (nonatomic, strong) UIButton      *agreedBtn;
@property (nonatomic, strong) UILabel       *tipLabel;

@property (nonatomic, strong) UIImageView   *emptyImageView;
@property (nonatomic, strong) UILabel       *emptyTipLabel;
@end

@implementation ZMCommissionSignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"协议";
    
    [self setButton:self.agreedBtn
              title:@"同意"
              color:[UIColor colorWithHex:@"FFFFFF"]
               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*16]];
    [self.agreedBtn setBackgroundColor:[UIColor colorWithHex:tonalColor]];
    
    [self.agreedBtn addTarget:self action:@selector(agreedBtnDidClickedAc:) forControlEvents:UIControlEventTouchUpInside];
    
    [ZMLabelAttributeMange setLabel:self.tipLabel
                               text:@"点击即视为您接受此协议"
                                hex:@"999999"
                      textAlignment:NSTextAlignmentCenter
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
    
    
    //empty
    self.emptyImageView.image = [UIImage imageNamed:@"emptySignImage"];
    
    
    [ZMLabelAttributeMange setLabel:self.emptyTipLabel
                               text:@"暂未上传协议，请耐心等待"
                                hex:@"999999"
                      textAlignment:NSTextAlignmentCenter
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
    
    
    [self getContract];
}


- (void)getContract{
    
    [self hud];
    
    NSDictionary *parm = @{@"info_id":self.infoID};
    NSString *urlStr   = [NSString stringWithFormat:@"%@/info/contract",APIDev];
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:parm withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"contract --- %@",object);
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            //[self.hud hide:YES];
            //success failed
            [self.view addSubview:self.webView];
            [self.view addSubview:self.agreedBtn];
            [self.view addSubview:self.tipLabel];
            
            if (_isFnishBool) {
                self.agreedBtn.backgroundColor       = [UIColor lightGrayColor];
                self.agreedBtn.userInteractionEnabled= NO;
                [self.agreedBtn setTitle:@"已同意" forState:UIControlStateNormal];
                self.tipLabel.alpha = 0;
            }

            NSString *path= [NSString stringWithFormat:@"%@",object[@"data"][@"contract"]];
            if (path.length>0) {
                NSURL    *url = [NSURL URLWithString:path];
                NSURLRequest *request = [NSURLRequest requestWithURL:url];
                [self.webView loadRequest:request];
            }else{
                NSLog(@"没有上传pdf文档！");
                [self.view addSubview:self.emptyImageView];
                [self.view addSubview:self.emptyTipLabel];
            }
            
            
        }else{
            [self.hud hide:YES];
            NSString *message = [NSString stringWithFormat:@"%@",object[@"status"][@"message"]];
            if ([message isEqualToString:@"NOCONTRACT"]) {
                NSLog(@"没有上传pdf文档！");
                [self.view addSubview:self.emptyImageView];
                [self.view addSubview:self.emptyTipLabel];
            }
        }
    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
        [self.hud hide:YES];
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}


#pragma mark - 同意
- (void)agreedBtnDidClickedAc:(UIButton *)sender{
    
    [self hud];
    
    NSDictionary *parm = @{@"info_id":self.infoID};
    NSString *urlStr   = [NSString stringWithFormat:@"%@/info/sign",APIDev];
    [AFNetManager requestWithType:HttpRequestTypePost withUrlString:urlStr withParaments:parm withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"sign --- %@",object);
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            
            self.agreedBtn.backgroundColor       = [UIColor lightGrayColor];
            self.agreedBtn.userInteractionEnabled= NO;
            [self.agreedBtn setTitle:@"已同意" forState:UIControlStateNormal];
            self.tipLabel.alpha = 0;
            
            //successful
            [[NSNotificationCenter defaultCenter] postNotificationName:@"finishSignNotifiAc" object:nil];
            
        }else{
            [self showProgress:object[@"status"][@"message"]];
        }
        [self.hud hide:YES];
    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
        [self.hud hide:YES];
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}



#pragma mark - webViewDelegate
//开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"start load!");
    //[self hud];
    
}

//加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    NSLog(@"fnish load!");
    [self.hud hide:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    NSLog(@"error : %@",error);
    [self.hud hide:YES];
}



- (void)setButton:(UIButton *)button title:(NSString *)title color:(UIColor *)textColor font:(UIFont *)textFond{
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    button.titleLabel.font    = textFond;
    button.layer.cornerRadius = SCREEN_WIDTH/375*4;
}



#pragma mark - lazy
- (UIWebView *)webView {
    if (_webView == nil) {
        _webView = [[UIWebView alloc] init];
        _webView.frame = CGRectMake(0,
                                    64,
                                    SCREEN_WIDTH,
                                    SCREEN_HEIGHT-64-SCREEN_WIDTH/375*100);
        _webView.backgroundColor = [UIColor colorWithHex:backColor];
        //_webView.backgroundColor = [UIColor redColor];
        _webView.delegate = self;
    }
    return _webView;
}

-(UIButton *)agreedBtn{
    if (_agreedBtn == nil) {
        _agreedBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                            SCREEN_HEIGHT-SCREEN_WIDTH/375*93,
                                            SCREEN_WIDTH-SCREEN_WIDTH/375*40,
                                            SCREEN_WIDTH/375*40)];
    }
    return _agreedBtn;
}


-(UILabel *)tipLabel{
    if (_tipLabel == nil) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                        CGRectGetMaxY(self.agreedBtn.frame)+SCREEN_WIDTH/375*8,
                        SCREEN_WIDTH,
                        SCREEN_WIDTH/375*20)];
    }
    return _tipLabel;
}


//empty
//@property (nonatomic, strong) UIImageView   *emptyImageView;
//@property (nonatomic, strong) UILabel       *emptyTipLabel;
-(UIImageView *)emptyImageView{
    if (_emptyImageView == nil) {
        _emptyImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*80)/2,
                                                           (SCREEN_HEIGHT-SCREEN_WIDTH/375*150)/2,
                                                           SCREEN_WIDTH/375*80,
                                                           SCREEN_WIDTH/375*86)];
    }
    return _emptyImageView;
}
-(UILabel *)emptyTipLabel{
    if (_emptyTipLabel == nil) {
        _emptyTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                              CGRectGetMaxY(self.emptyImageView.frame)+SCREEN_WIDTH/375*8,
                                                              SCREEN_WIDTH,
                                                              SCREEN_WIDTH/375*20)];
    }
    return _emptyTipLabel;
}

- (MBProgressHUD *)hud {
    if (_hud == nil) {
        
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _hud.userInteractionEnabled = NO;
        _hud.removeFromSuperViewOnHide = YES;
    }
    return _hud;
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
