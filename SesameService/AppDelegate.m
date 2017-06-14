//
//  AppDelegate.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/15.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "AppDelegate.h"
#import "ZMTabBarController.h"
#import "ZMTabbarViewController.h"
#import "ZMLoginViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "CheckNetManage.h"
#import "BFGuideView.h"


#import <UMSocialCore/UMSocialCore.h>


@interface AppDelegate () <UITabBarControllerDelegate>
@property (nonatomic, assign) NSInteger    fontInteger;
@property (nonatomic, strong) BFGuideView  *guideView;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self umengTrack];
    [self netEaseQIYU];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor    = [UIColor whiteColor];
    ZMTabbarViewController *ZMTabBar   = [[ZMTabbarViewController alloc] init];
    ZMTabBar.delegate = self;
    self.window.rootViewController = ZMTabBar;
    [self.window makeKeyAndVisible];
    
    [CheckNetManage checkCurrentNetStateWindow:self.window];
    
    //GP
    if (![[NSUserDefaults standardUserDefaults] boolForKey:[NSString stringWithFormat:@"%@%@",IS_First,VERSION]]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:[NSString stringWithFormat:@"%@%@",IS_First,VERSION]];
        self.guideView = [[BFGuideView alloc] initWithFrame:SCREEN_BOUNDS];
        [self.guideView.startButton addTarget:self
                                       action:@selector(guideStartButtonDidClicked:)
                             forControlEvents:UIControlEventTouchUpInside];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        [[UIApplication sharedApplication].keyWindow addSubview:self.guideView];
    }

    return YES;
}


- (void)umengTrack {
    
    [[UMSocialManager defaultManager] setUmSocialAppkey:UM_APPKEY];
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    
    [MobClick setLogEnabled:YES];
    UMConfigInstance.appKey = UM_APPKEY;
    
    //错误统计
    [MobClick setCrashReportEnabled:YES];
    [MobClick startWithConfigure:UMConfigInstance];
    
    
    
    
    
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession
                                          appKey:WechatAppID
                                       appSecret:wechatAppSecret
                                     redirectURL:@"http://mobile.umeng.com/social"];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ
                                          appKey:QQAppID/*设置QQ平台的appID*/
                                       appSecret:nil
                                     redirectURL:@"http://mobile.umeng.com/social"];
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Qzone
                                          appKey:QQAppID/*设置QQ平台的appID*/
                                       appSecret:nil
                                     redirectURL:@"http://mobile.umeng.com/social"];
    
    /* 设置新浪的appKey和appSecret */
    //[[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina
      //                                    appKey:SinaAppKey
        //                               appSecret:SinaAppSecret
          //                           redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
    
    
}

/** 网易七鱼 集成 */
- (void)netEaseQIYU {
    [[QYSDK sharedSDK] registerAppId:@"914f6e5842753862197cfa7cebd63758" appName:@"芝麻商服"];
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    //NSLog(@"openURL   ------   %@",url);
    //NSLog(@"openURL   ------   %@",url.host);
    
    if ([url.host isEqualToString:@"safepay"]) {
        //Alipay
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"appDelegate result 9.0 = %@",resultDic);
            NSLog(@"appDelegate result 9.0 = %@",resultDic[@"memo"]);
            NSString *stateStr = [NSString stringWithFormat:@"%@",resultDic[@"resultStatus"]];
            //pay successful
            if ([stateStr isEqualToString:@"9000"]) {
                NSLog(@"appDelegate 9.0 pay successful");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"aliPaySuccessful" object:nil];
            }else{
                NSLog(@"appDelegate 9.0 pay failed");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"aliPayFailed" object:nil];
            }
        }];
    }else if ([url.host isEqualToString:@"platformId=wechat"]){
        //wechat share
        NSLog(@"wechat share");
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }else if ([url.host isEqualToString:@"oauth"]){
        //wechat oauth
        NSLog(@"wechat oauth");
        //调用其他SDK，例如支付宝SDK等
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }else if ([url.host isEqualToString:@"qzapp"]){
        //qq oauth
        return [[UMSocialManager defaultManager] handleOpenURL:url];
    }else if ([url.host isEqualToString:@"response_from_qq"]){
        //qq share
        return [[UMSocialManager defaultManager] handleOpenURL:url];
    }else{
        //调用其他SDK，例如支付宝SDK等
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }
    //调用其他SDK，例如支付宝SDK等
    //return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    
    return YES;
}




// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options{
    
    
    NSLog(@"openURL   ------   %@",url);
    NSLog(@"openURL   ------   %@",url.host);
    
    if ([url.host isEqualToString:@"safepay"]) {
        //Alipay
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"appDelegate result 9.0 = %@",resultDic);
            NSLog(@"appDelegate result 9.0 = %@",resultDic[@"memo"]);
            NSString *stateStr = [NSString stringWithFormat:@"%@",resultDic[@"resultStatus"]];
            //pay successful
            if ([stateStr isEqualToString:@"9000"]) {
                NSLog(@"appDelegate 9.0 pay successful");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"aliPaySuccessful" object:nil];
            }else{
                NSLog(@"appDelegate 9.0 pay failed");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"aliPayFailed" object:nil];
            }
        }];
    }else if ([url.host isEqualToString:@"platformId=wechat"]){
        //wechat share
        NSLog(@"wechat share");
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }else if ([url.host isEqualToString:@"oauth"]){
        //wechat oauth
        NSLog(@"wechat oauth");
        //调用其他SDK，例如支付宝SDK等
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }else if ([url.host isEqualToString:@"qzapp"]){
        //qq oauth
        return [[UMSocialManager defaultManager] handleOpenURL:url];
    }else if ([url.host isEqualToString:@"response_from_qq"]){
        //qq share
        return [[UMSocialManager defaultManager] handleOpenURL:url];
    }else{
        //调用其他SDK，例如支付宝SDK等
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }
    //调用其他SDK，例如支付宝SDK等
    //return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];

    return YES;
}


/***
 
 - (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
 
     BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
     if (!result) {
     // 其他如支付等SDK的回调
     return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
     }else{
     NSLog(@"*************************************分享成功***********************************");
     }
     return result;
 }
 
 
 
 ***/




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
    NSLog(@"Foreground");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enterForeground" object:nil];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - UITabbarDelegate
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    NSLog(@"%lu",(unsigned long)tabBarController.selectedIndex);

    if (tabBarController.selectedIndex!=3){
        _fontInteger = tabBarController.selectedIndex;
    }
    
    if (tabBarController.selectedIndex==3&&![[NSUserDefaults standardUserDefaults] boolForKey:IS_LOGIN]) {
        [tabBarController setSelectedIndex:_fontInteger];
        
        ZMLoginViewController *loginRegVC   = [[ZMLoginViewController alloc] init];
        loginRegVC.entranceType = @"MySelf";
        UINavigationController *loginRegNC  = [[UINavigationController alloc] initWithRootViewController:loginRegVC];
        [self.window.rootViewController presentViewController:loginRegNC animated:YES completion:nil];
    }
}

#pragma mark - 引导页按钮
- (void)guideStartButtonDidClicked:(UIButton *)sender{
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [UIView animateWithDuration:0.38 animations:^{
        self.guideView.alpha = 0;
        self.guideView.frame = CGRectMake(0, 0, SCREEN_WIDTH*1.0, SCREEN_HEIGHT*1.2);
    } completion:^(BOOL finished) {
        [self.guideView removeFromSuperview];
    }];
}

@end
