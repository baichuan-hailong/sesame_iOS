//
//  ZMTabbarViewController.m
//  SesameService
//
//  Created by 娄耀文 on 17/4/7.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMTabbarViewController.h"
#import "ZMTabbar.h"

#import "ZMHomeViewController.h"
#import "ZMShareViewController.h"
#import "ZMAgentViewController.h"
#import "ZMAllUnderstandViewController.h"
#import "ZMMyselfViewController.h"
#import "ZMPublishView.h"

@interface ZMTabbarViewController () <ZMTabbarDelegate>

@end

@implementation ZMTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[UITabBar appearance] setBackgroundImage:[toolClass imageWithColor:[UIColor whiteColor] size:CGSizeMake(SCREEN_WIDTH, 49)]];
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    
    [self dropShadowWithOffset:CGSizeMake(3, 3)
                        radius:3
                         color:[UIColor grayColor]
                       opacity:0.6];

    
    //设置子控制器
    ZMHomeViewController *home = [[ZMHomeViewController alloc] init];
    home.title = @"芝麻商服";
    [self setChildVC:home title:@"首页" image:@"firstPage" selectedImage:@"firstPageSelected"];
    
    ZMShareViewController *sameCity = [[ZMShareViewController alloc] init];
    [self setChildVC:sameCity title:@"业务信息" image:@"threePage" selectedImage:@"threePageSelected"];
    
    ZMAllUnderstandViewController *message = [[ZMAllUnderstandViewController alloc] init];
    [self setChildVC:message title:@"包打听" image:@"allUnderStand" selectedImage:@"allUnderStandSelected"];
    
    ZMMyselfViewController *mine = [[ZMMyselfViewController alloc] init];
    [self setChildVC:mine title:@"我的" image:@"fivePage" selectedImage:@"fivePageSelected"];
    
    ZMTabbar *tabBar = [[ZMTabbar alloc] init];
    tabBar.delegate = self;
    [self setValue:tabBar forKeyPath:@"tabBar"];
}


- (void)setChildVC:(UIViewController *)childVC title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    
    UINavigationController *childNC   = [[UINavigationController alloc] initWithRootViewController:childVC];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    [childNC.tabBarItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
    
    childNC.tabBarItem.title = title;
    childNC.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childNC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [childNC.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor colorWithHex:tonalColor]} forState:UIControlStateSelected];
    
    
    [self addChildViewController:childNC];
}

- (void)tabBarButtonClick:(ZMTabbar *)tabBar {
        
    ZMPublishView *publishView = [[ZMPublishView alloc] init];
    publishView.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    publishView.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    
    UIViewController *rootController = self.view.window.rootViewController;
    rootController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [rootController presentViewController:publishView animated:NO completion:nil];
}


- (void)dropShadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity {

    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.tabBar.bounds);
    self.tabBar.layer.shadowPath = path;
    CGPathCloseSubpath(path);
    CGPathRelease(path);
    
    self.tabBar.layer.shadowColor = color.CGColor;
    self.tabBar.layer.shadowOffset = offset;
    self.tabBar.layer.shadowRadius = radius;
    self.tabBar.layer.shadowOpacity = opacity;

    self.tabBar.clipsToBounds = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
