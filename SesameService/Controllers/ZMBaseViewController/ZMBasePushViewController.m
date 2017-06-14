//
//  ZMPushViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/23.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMBasePushViewController.h"

@interface ZMBasePushViewController ()

@end

@implementation ZMBasePushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self backButton];
    
    //add
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(tokenFailureAction)
                                                 name:@"tokenFailureAction"
                                               object:nil];

}

- (void)tokenFailureAction{
    
    [self showProgress:@"登录失效,请重新登录！"];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"loginOutNextAction" object:nil];
    //[self.tabBarController setSelectedIndex:0];
}


//MBProgress
- (void)showProgress:(NSString *)tipStr{
    UIWindow *keyWindow           = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud            = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
    hud.mode                      = MBProgressHUDModeText;
    hud.labelText                 = tipStr;
    hud.margin                    = 20.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
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

- (void)backAc {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)backAction {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
