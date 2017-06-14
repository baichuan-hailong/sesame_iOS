//
//  ZMMoreInfoMoneyViewController.m
//  SesameService
//
//  Created by 娄耀文 on 17/5/16.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMMoreInfoMoneyViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface ZMMoreInfoMoneyViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView     *webView;
@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation ZMMoreInfoMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _titleStr;
    self.view.backgroundColor = [UIColor colorWithHex:backColor];
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self backButton];
    [self.view addSubview:self.webView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


#pragma mark - webViewDelegate
//开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    [self hud];
}

//加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.hud hide:YES];
    NSLog(@"header : %@",webView.request.allHTTPHeaderFields);
    
    NSString *tokenString = [NSString stringWithFormat:@"localStorage.setItem('token', '%@')",[[NSUserDefaults standardUserDefaults] objectForKey:TOKEN]];
    [_webView stringByEvaluatingJavaScriptFromString:tokenString];
    
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    //JavaScript & Objc
    context[@"goBackAction"] = ^() {
    
        NSString *price  = @"";
        NSArray *args = [JSContext currentArguments];
        for (int i = 0; i < args.count; i++) {
            
            JSValue *jsVal = [args objectAt:i];
            price  = [NSString stringWithFormat:@"%@",jsVal];
            NSLog(@"参数 : %@",[NSString stringWithFormat:@"%@",jsVal]);
        }
        NSDictionary *prama = @{@"price":price};
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"perfectComplete" object:nil userInfo:prama];
            [self.navigationController popViewControllerAnimated:YES];
        });
    };
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {

    NSLog(@"error : %@",error);
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    BOOL headerIsPresent = [[request allHTTPHeaderFields] objectForKey:@"Authorization"]!=nil;
    if(headerIsPresent) return YES;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            NSURL *url = [request URL];
            NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
            
            /** set new headers */
            [request addValue:[NSString stringWithFormat:@"Bearer %@",[[NSUserDefaults standardUserDefaults] objectForKey:TOKEN]] forHTTPHeaderField:@"Authorization"];

            [self.webView loadRequest:request];
        });
    });
    return NO;
}


#pragma mark - getter
- (UIWebView *)webView {
    
    if (_webView == nil) {
        _webView = [[UIWebView alloc] init];
        _webView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
        _webView.backgroundColor = [UIColor colorWithHex:backColor];
        _webView.delegate = self;
        
        //NSString *userContent = [NSString stringWithFormat:@"{\"token\": \"%@\", \"userId\": %@}", @"a1cd4a59-974f-44ab-b264-46400f26c849", @"89"];

        NSString *tokenString = [NSString stringWithFormat:@"localStorage.setItem('token', '%@')",[[NSUserDefaults standardUserDefaults] objectForKey:TOKEN]];
        [_webView stringByEvaluatingJavaScriptFromString:tokenString];

        NSLog(@"webUrl : %@",_webUrl);
        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:_webUrl]];
        [_webView loadRequest:request];
    }
    return _webView;
}

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


- (MBProgressHUD *)hud {
    
    if (_hud == nil) {
        
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _hud.userInteractionEnabled = NO;
        _hud.removeFromSuperViewOnHide = YES;
    }
    return _hud;
}

@end
