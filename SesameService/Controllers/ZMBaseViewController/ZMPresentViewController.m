//
//  ZMPresentViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/23.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMPresentViewController.h"

@interface ZMPresentViewController ()

@end

@implementation ZMPresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self leftButton];
}

- (void)leftButton {
    
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 15, 64, 40);
    [button addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = item;
    
}

- (void)backAction:(UIButton *)sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
