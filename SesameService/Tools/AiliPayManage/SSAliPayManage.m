//
//  SSAliPayManage.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/16.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "SSAliPayManage.h"
#import <AlipaySDK/AlipaySDK.h>


@implementation SSAliPayManage

+(instancetype)defauleSingleton{
    static dispatch_once_t onceToken;
    static SSAliPayManage *instance;
    dispatch_once(&onceToken, ^{
        instance = [[SSAliPayManage alloc] init];
    });
    return instance;
}

//业务信息支付
- (void)evokeAliPayInfoID:(NSString *)infoID{
    
    NSDictionary *parameter = @{@"carrier_type":@"alipay",
                                @"info_id":infoID};
    NSLog(@"传参 --- %@",parameter);
    NSString *urlStr = [NSString stringWithFormat:@"%@/trade/info-pay",APIDev];
    NSLog(@"url ------- %@",urlStr);
    [AFNetManager requestWithType:HttpRequestTypePost withUrlString:urlStr withParaments:parameter withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"order --- %@",object);
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            NSString *method = [NSString stringWithFormat:@"%@",object[@"data"][@"method"]];
            if ([method isEqualToString:@"wap"]) {
                //safari pay
                NSString *resultUrl = [NSString stringWithFormat:@"%@",object[@"data"][@"result"]];
                [self evokeWebPayWithWebPayStr:resultUrl];
            }else{
                [self evokeAppPayOrderDic:object];
            }
        }else{
            //faile
            [[NSNotificationCenter defaultCenter] postNotificationName:@"makeOrderFailed" object:nil];
            [self showProgress:object[@"status"][@"message"]];
            NSLog(@"tip---tip---tip---%@",object[@"status"][@"message"]);
        }
    } withFailureBlock:^(NSError *error) {
        NSLog(@"alipay ----------- error:%@",error);
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
    
}




//包打听
- (void)evokeAliPayQuestionID:(NSString *)questionID{
    
    NSDictionary *parameter = @{@"carrier_type":@"alipay",
                                @"question_id":questionID};
    NSLog(@"传参 --- %@",parameter);
    NSString *urlStr = [NSString stringWithFormat:@"%@/trade/question-pay",APIDev];
    
    NSLog(@"url ------- %@",urlStr);
    
    [AFNetManager requestWithType:HttpRequestTypePost withUrlString:urlStr withParaments:parameter withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"order --- %@",object);
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            
            NSString *method = [NSString stringWithFormat:@"%@",object[@"data"][@"method"]];
            if ([method isEqualToString:@"wap"]) {
                //safari pay
                NSString *resultUrl = [NSString stringWithFormat:@"%@",object[@"data"][@"result"]];
                [self evokeWebPayWithWebPayStr:resultUrl];
            }else{
                [self evokeAppPayOrderDic:object];
            }
        }else{
            [self showProgress:object[@"status"][@"message"]];
            NSLog(@"tip---tip---tip---%@",object[@"status"][@"message"]);
        }
    } withFailureBlock:^(NSError *error) {
        NSLog(@"alipay ----------- error:%@",error);
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];

}









//web pay
- (void)evokeWebPayWithWebPayStr:(NSString *)webPayStr{
    //web - safari pay
    NSURL    *webPayURL = [NSURL URLWithString:webPayStr];
    [[UIApplication sharedApplication] openURL:webPayURL];
}

//app pay
- (void)evokeAppPayOrderDic:(NSDictionary *)orderDic{
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"sesameAliPayScheme";
    //orderString
    NSString *order     = [NSString stringWithFormat:@"%@",orderDic[@"data"][@"result"]];
    
    [[AlipaySDK defaultService] payOrder:order fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        //NSLog(@"alipay --- reslut --- %@",resultDic);
        NSString *stateStr = [NSString stringWithFormat:@"%@",resultDic[@"resultStatus"]];
        if ([stateStr isEqualToString:@"9000"]) {
            //successful
            [[NSNotificationCenter defaultCenter] postNotificationName:@"aliPaySuccessful" object:nil];
            NSLog(@"aliPay successful");
        }else{
            //faile
            [[NSNotificationCenter defaultCenter] postNotificationName:@"aliPayFailed" object:nil];
            NSLog(@"aliPay failed");
        }
        
    }];
}




//MBProgress
- (void)showProgress:(NSString *)tipStr{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    MBProgressHUD *hud            = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
    hud.mode                      = MBProgressHUDModeText;
    hud.labelText                 = tipStr;
    hud.margin                    = 20.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}
@end
