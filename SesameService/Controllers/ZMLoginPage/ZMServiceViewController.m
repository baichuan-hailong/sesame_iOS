//
//  ZMServiceViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/28.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMServiceViewController.h"
#import "ZMServiceView.h"

@interface ZMServiceViewController ()<UIWebViewDelegate>
@property (nonatomic,strong)ZMServiceView *serviceView;

@property (nonatomic, strong) UIWebView     *webView;
@property (nonatomic, strong) MBProgressHUD *hud;

@property (nonatomic, strong) UIButton *baBtn;
@end

@implementation ZMServiceViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"";
    //芝麻商服会员服务协议
    [self.view addSubview:self.webView];
    

    //[self.navigationController setNavigationBarHidden:YES animated:YES];
}


#pragma mark - webViewDelegate
//开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView {
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.removeFromSuperViewOnHide = YES;
    
}

//加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [_hud hide:YES];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [_hud hide:YES];
}



#pragma mark - getter
- (UIWebView *)webView {
    
    if (_webView == nil) {
        _webView = [[UIWebView alloc] init];
        _webView.frame = CGRectMake(0,
                                    0,
                                    SCREEN_WIDTH,
                                    SCREEN_HEIGHT);
        _webView.delegate = self;
        _webView.backgroundColor = [UIColor colorWithHex:backGroundColor];
        
        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",AgreementUrl]]];
        [_webView loadRequest:request];
    }
    return _webView;
}


-(UIButton *)baBtn{
    if (_baBtn==nil) {
        _baBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 50, 44)];
    }
    return _baBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
