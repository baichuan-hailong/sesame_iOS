//
//  ZMAgentDetailViewController.m
//  SesameService
//
//  Created by 娄耀文 on 17/4/5.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMAgentDetailViewController.h"
#import "ZMAgentDetailView.h"

@interface ZMAgentDetailViewController ()

@property (nonatomic, strong) ZMAgentDetailView *currentView;

@end

@implementation ZMAgentDetailViewController

- (void)loadView {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.currentView = [[ZMAgentDetailView alloc] initWithFrame:SCREEN_BOUNDS];
    self.view        = self.currentView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"代理详情";
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
