//
//  BFTabBarController.m
//  biufang
//
//  Created by 杜海龙 on 16/9/29.
//  Copyright © 2016年 biufang. All rights reserved.
//

#import "ZMTabBarController.h"
#import "ZMHomeViewController.h"
#import "ZMShareViewController.h"
#import "ZMAgentViewController.h"
#import "ZMVipViewController.h"
#import "ZMMyselfViewController.h"


@interface ZMTabBarController ()

@end

@implementation ZMTabBarController


+ (void)addAllChildViewController:(UITabBarController *)tabBarController{
    
    tabBarController.view.backgroundColor = [UIColor whiteColor];
    
    ZMHomeViewController   *homeVC   = [[ZMHomeViewController   alloc] init];
    ZMShareViewController  *shareVC  = [[ZMShareViewController  alloc] init];
    ZMAgentViewController  *agentVC  = [[ZMAgentViewController  alloc] init];
    ZMVipViewController    *vipVC    = [[ZMVipViewController    alloc] init];
    ZMMyselfViewController *myselfVC = [[ZMMyselfViewController alloc] init];
    
    UINavigationController *homeNC   = [[UINavigationController alloc] initWithRootViewController:homeVC];
    UINavigationController *shareNC  = [[UINavigationController alloc] initWithRootViewController:shareVC];
    UINavigationController *agentNC  = [[UINavigationController alloc] initWithRootViewController:agentVC];
    UINavigationController *vipNC    = [[UINavigationController alloc] initWithRootViewController:vipVC];
    UINavigationController *myselfNC = [[UINavigationController alloc] initWithRootViewController:myselfVC];
    
    NSArray *naArray = [NSArray arrayWithObjects:homeNC,shareNC,agentNC,vipNC,myselfNC,nil];
    [tabBarController setViewControllers:naArray animated:YES];
    tabBarController.tabBar.alpha = 1.0;
   
    
    [homeNC.tabBarItem   setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor colorWithHex:tonalColor]} forState:UIControlStateSelected];
    [shareNC.tabBarItem  setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor colorWithHex:tonalColor]} forState:UIControlStateSelected];
    [agentNC.tabBarItem  setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor colorWithHex:tonalColor]} forState:UIControlStateSelected];
    [vipNC.tabBarItem    setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor colorWithHex:tonalColor]} forState:UIControlStateSelected];
    [myselfNC.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor colorWithHex:tonalColor]} forState:UIControlStateSelected];

    //homeNC.title   = @"芝麻商服";
    //shareNC.title  = @"商机共享";
    //agentNC.title  = @"业务代理";
    //vipNC.title    = @"会员名录";
    //myselfNC.title = @"我的";
    
    homeNC.tabBarItem.title   = @"首页";
    shareNC.tabBarItem.title  = @"商机共享";
    agentNC.tabBarItem.title  = @"业务代理";
    vipNC.tabBarItem.title    = @"会员名录";
    myselfNC.tabBarItem.title = @"我的";
    
    homeNC.tabBarItem.image   = [[UIImage imageNamed:@"firstPage"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    shareNC.tabBarItem.image  = [[UIImage imageNamed:@"secondPage"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    agentNC.tabBarItem.image  = [[UIImage imageNamed:@"threePage"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vipNC.tabBarItem.image    = [[UIImage imageNamed:@"fourPage"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    myselfNC.tabBarItem.image = [[UIImage imageNamed:@"fivePage"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    homeNC.tabBarItem.selectedImage   = [[UIImage imageNamed:@"firstPageSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    shareNC.tabBarItem.selectedImage  = [[UIImage imageNamed:@"secondPageSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    agentNC.tabBarItem.selectedImage  = [[UIImage imageNamed:@"threePageSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vipNC.tabBarItem.selectedImage    = [[UIImage imageNamed:@"fourPageSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    myselfNC.tabBarItem.selectedImage = [[UIImage imageNamed:@"fivePageSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
}

@end
