//
//  ZMVipPrivilegeViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/7.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMVipPrivilegeViewController.h"
#import "ZMVipPrivilegeView.h"

@interface ZMVipPrivilegeViewController ()
@property(nonatomic,strong)ZMVipPrivilegeView *vipPrivilegeView;
@end

@implementation ZMVipPrivilegeViewController

-(void)loadView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.vipPrivilegeView = [[ZMVipPrivilegeView alloc] initWithFrame:SCREEN_BOUNDS];
    self.vipPrivilegeView.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(self.vipPrivilegeView.bottomLabel.frame)+SCREEN_WIDTH/375*17);
    self.view = self.vipPrivilegeView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"VIP特权";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
