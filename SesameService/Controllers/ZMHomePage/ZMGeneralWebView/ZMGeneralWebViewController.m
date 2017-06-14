//
//  ZMGeneralWebViewController.m
//  SesameService
//
//  Created by 娄耀文 on 17/5/17.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMGeneralWebViewController.h"

@interface ZMGeneralWebViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView     *webView;
@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation ZMGeneralWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self backButton];
    [self.view addSubview:self.webView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


- (MBProgressHUD *)hud {
    
    if (_hud == nil) {
        
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _hud.userInteractionEnabled = NO;
        _hud.removeFromSuperViewOnHide = YES;
    }
    return _hud;
}

#pragma mark - webViewDelegate
//开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    [self hud];
}

//加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.hud hide:YES];
}



#pragma mark - getter
- (UIWebView *)webView {
    
    if (_webView == nil) {
        _webView = [[UIWebView alloc] init];
        _webView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
        _webView.backgroundColor = [UIColor colorWithHex:backColor];
        _webView.delegate = self;
        
        _webUrl = [_webUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:_webUrl]];
        [_webView loadRequest:request];
    }
    return _webView;
}

#pragma mark - backAction
- (void)backButton {
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    button.frame=CGRectMake(0, 0, 64, 64);
    [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    button.imageEdgeInsets = UIEdgeInsetsMake(0,-50, 0, 10);
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem=item;
}

- (void)backAction {
    
    _webView = nil;
    [self cleanCacheAndCookie];
    [self.navigationController popViewControllerAnimated:YES];
}

/**清除缓存和cookie*/
- (void)cleanCacheAndCookie{
    //清除cookies
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]){
        [storage deleteCookie:cookie];
    }
    //清除UIWebView的缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
}

@end
