//
//  WXApiManager.m
//  biufang
//
//  Created by 杜海龙 on 16/9/30.
//  Copyright © 2016年 biufang. All rights reserved.
//

#import "WXApiManager.h"

@interface WXApiManager ()
@property (nonatomic , strong) MBProgressHUD *HUD;
@end

@implementation WXApiManager

#pragma mark - LifeCycle
+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static WXApiManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[WXApiManager alloc] init];
    });
    return instance;
}

#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp {
    NSLog(@"manage onResp -------------------------- %@",resp);
    
    
    if ([resp isKindOfClass:[SendMessageToWXResp class]]){
        
        NSLog(@"wechat share");
        SendMessageToWXResp *response=(SendMessageToWXResp*)resp;
        switch(response.errCode){
            case WXSuccess:
                NSLog(@"manage wechat share successful");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"shareSuccessful" object:nil];
                break;
            default:
                NSLog(@"manage wechat share failed");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"shareFailed" object:nil];
                break;
        }
    
    }else if ([resp isKindOfClass:[PayResp class]]) {
        NSLog(@"wechat pay");
        PayResp *response=(PayResp*)resp;
        switch(response.errCode){
            case WXSuccess:
                NSLog(@"manage wechat pay successful");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"wechatPaySuccessful" object:nil];
                break;
            default:
                NSLog(@"manage wechat pay failed");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"wechatPayFailed" object:nil];
                break;
        }
    }else if ([resp isKindOfClass:[SendAuthResp class]]) {
        SendAuthResp *temp = (SendAuthResp *)resp;
        NSLog(@"SendAuthResp -----------------------  %@",temp.code);
        NSString *code = temp.code;
        NSLog(@"code -----------------------  %@",code);
        
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        self.HUD = [[MBProgressHUD alloc] initWithView:keyWindow];
        [keyWindow addSubview:self.HUD];
        [self.HUD show:YES];
        
        //NSString *url = @"https://api.weixin.qq.com/sns/oauth2/access_token";
        //NSString *codeUrl = [NSString stringWithFormat:@"%@?appid=%@&secret=%@&code=%@&grant_type=authorization_code",url,WechatAppID, wechatAppSecret,temp.code];
        
        
        NSString *codeUrl = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",WechatAppID, wechatAppSecret, code];
        
        
        [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:codeUrl withParaments:nil withSuccessBlock:^(NSDictionary *object) {
            NSLog(@"wechat auth 0 --- %@",object);
            if (![object isEqual:[NSNull null]]) {
                NSDictionary *accessDict= [NSDictionary dictionaryWithDictionary:object];
                NSString *access_token  = [NSString stringWithFormat:@"%@",accessDict[@"access_token"]];
                NSString *openid        = [NSString stringWithFormat:@"%@",accessDict[@"openid"]];
                
                if (openid.length>10) {
                    [self wechatUserInfoWithToke:access_token openID:openid];
                    [[NSUserDefaults standardUserDefaults] setObject:accessDict[@"refresh_token"] forKey:@"refresh_tokenWX"];
                }else{
                    NSString *refresh_tokenWX  = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"refresh_tokenWX"]];
                    if (refresh_tokenWX.length>10) {
                        [self refreshAccTotke:refresh_tokenWX];
                    }else{
                        [self showProgress:@"授权失败！"];
                        [self.HUD hide:YES];
                        
                    }
                }
            }
        } withFailureBlock:^(NSError *error) {
            NSLog(@"wechat auth --- %@",error);
            //NSLog(@"localizedDescription------%@",error.localizedDescription);
            [self.HUD hide:YES];
            [self showProgress:@"授权失败！"];
        } progress:^(float progress) {
            NSLog(@"%f",progress);
        }];
    }
}


//bug
- (void)refreshAccTotke:(NSString *)refreshToken{
    NSString *accessUrlStr = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/refresh_token?appid=%@&grant_type=refresh_token&refresh_token=%@",WechatAppID,refreshToken];
    
    NSLog(@"refreshToken -------- %@",refreshToken);
    
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:accessUrlStr withParaments:nil withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"refresh accToken --- %@",object);
        if (![object isEqual:[NSNull null]]) {
            NSDictionary *accessDict= [NSDictionary dictionaryWithDictionary:object];
            NSString *access_token  = [NSString stringWithFormat:@"%@",accessDict[@"access_token"]];
            NSString *openid        = [NSString stringWithFormat:@"%@",accessDict[@"openid"]];
            
            if (openid.length>10) {
                [self wechatUserInfoWithToke:access_token openID:openid];
                [[NSUserDefaults standardUserDefaults] setObject:accessDict[@"refresh_token"] forKey:@"refresh_tokenWX"];
            }else{
                [self showProgress:@"授权失败！"];
                [self.HUD hide:YES];
            }
        }
    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
        [self.HUD hide:YES];
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}


/*
 
 [[NSUserDefaults standardUserDefaults] setObject:accessDict[@"access_token"] forKey:@"access_tokenWX"];
 [[NSUserDefaults standardUserDefaults] setObject:accessDict[@"openid"] forKey:@"openidWX"];
 
 NSString *access_token  = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"access_tokenWX"]];
 NSString *openid        = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"openidWX"]];
 if (access_token.length>10&&openid.length>0) {
 [self wechatUserInfoWithToke:access_token openID:openid];
 }else{
 [self showProgress:@"授权失败！"];
 [self.HUD hide:YES];
 }
 
 */



//wechat userInfo
- (void)wechatUserInfoWithToke:(NSString *)accessToken openID:(NSString *)openid{
    
    //NSString *url         = @"https://api.weixin.qq.com/sns/userinfo";
    //NSString *accessUrlStr= [NSString stringWithFormat:@"%@?access_token=%@&openid=%@",url,accessToken, openid];
    
    NSString *accessUrlStr = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",accessToken, openid];
    
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:accessUrlStr withParaments:nil withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"wechat auth 1 --- %@",object);
        if (![object isEqual:[NSNull null]]) {
            NSDictionary *accessDict = [NSDictionary dictionaryWithDictionary:object];
            NSString *unionid   = [NSString stringWithFormat:@"%@",accessDict[@"unionid"]];
            NSString *openid    = [NSString stringWithFormat:@"%@",accessDict[@"openid"]];
            NSString *headimgurl= [NSString stringWithFormat:@"%@",accessDict[@"headimgurl"]];
            if (unionid.length>10) {
                [self authType:@"wechat" unionToken:unionid socialToke:openid headimgurl:headimgurl];
            }else{
                [self showProgress:@"授权失败！"];
                [self.HUD hide:YES];
            }
        }
    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
        [self.HUD hide:YES];
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}


- (void)onReq:(BaseReq *)req {
    NSLog(@"manage onReq ---- %@",req);
}



#pragma mark - login
- (void)authType:(NSString *)type unionToken:(NSString *)union_token socialToke:(NSString *)social_token headimgurl:(NSString *)headeUrl{
    
    
    //verify moble
    NSDictionary *parDic = @{@"union_token":union_token,
                             @"social_token":social_token,
                             @"source":type};
    
    NSLog(@"type ------------ %@",parDic);
    NSString *urlStr = [NSString stringWithFormat:@"%@/user/social-auth",APIDev];
    [AFNetManager requestWithType:HttpRequestTypePost withUrlString:urlStr withParaments:parDic withSuccessBlock:^(NSDictionary *object) {
        
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            NSLog(@"Login sucessful ----------------- %@",object);
            //Save Info
            [[NSUserDefaults standardUserDefaults] setObject:object[@"data"][@"id"]   forKey:USER_ID];
            [[NSUserDefaults standardUserDefaults] setObject:object[@"data"][@"token"] forKey:TOKEN];
            
            NSString *isType = [NSString stringWithFormat:@"%@",object[@"data"][@"type"]];
            if ([isType isEqualToString:@"0"]) {
                //Select ID
                NSDictionary *dic = @{@"unionid":union_token,
                                      @"social_token":social_token,
                                      @"headimgurl":headeUrl,
                                      @"type":@"wechat"};
                [[NSNotificationCenter defaultCenter] postNotificationName:@"bindingSelectIden" object:dic];
            }else{
                //fnish login
                [[NSNotificationCenter defaultCenter] postNotificationName:@"bindingFnish" object:nil];
            }
            
        }else{
            NSLog(@"Login WAITING_FOR_BIND ----------------- %@",object);
            
            NSString *messageStr = [NSString stringWithFormat:@"%@",object[@"status"][@"message"]];
            if ([messageStr isEqualToString:@"PENDING|WAITING_FOR_BIND"]) {
                //待绑定Tel
                NSDictionary *dic = @{@"unionid":union_token,
                                      @"social_token":social_token,
                                      @"headimgurl":headeUrl,
                                      @"type":@"wechat"};
                [[NSNotificationCenter defaultCenter] postNotificationName:@"wechatWAITING_FOR_BIND" object:dic];
            }
        }
        [self.HUD hide:YES];
    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
        [self.HUD hide:YES];
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}
































//业务信息支付
- (void)evokeWechatPayInfoID:(NSString *)infoID{

    
    NSDictionary *parameter = @{@"carrier_type":@"wechat",
                                @"info_id":infoID};
    NSLog(@"传参 --- %@",parameter);
    NSString *urlStr = [NSString stringWithFormat:@"%@/trade/info-pay",APIDev];
    NSLog(@"url ------- %@",urlStr);
    [AFNetManager requestWithType:HttpRequestTypePost withUrlString:urlStr withParaments:parameter withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"wechat --- %@",object);
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            [self wechatPayParameter:object[@"data"][@"payload"]];
        }else{
            //faile
            [[NSNotificationCenter defaultCenter] postNotificationName:@"makeOrderFailed" object:nil];
            NSLog(@"tip---tip---tip---%@",object[@"status"][@"message"]);
            [self showProgress:object[@"status"][@"message"]];
        }
    } withFailureBlock:^(NSError *error) {
        NSLog(@"wechat ----------- error:%@",error);
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}



//包打听
- (void)evokeWechatPayQuestionID:(NSString *)questionID{
    
    NSDictionary *parameter = @{@"carrier_type":@"wechat",
                                @"question_id":questionID};
    NSLog(@"传参 --- %@",parameter);
    NSString *urlStr = [NSString stringWithFormat:@"%@/trade/question-pay",APIDev];
    NSLog(@"url ------- %@",urlStr);
    [AFNetManager requestWithType:HttpRequestTypePost withUrlString:urlStr withParaments:parameter withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"wechat --- %@",object);
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            [self wechatPayParameter:object[@"data"][@"payload"]];
        }else{
            //faile
            [[NSNotificationCenter defaultCenter] postNotificationName:@"makeOrderFailed" object:nil];
            NSLog(@"tip---tip---tip---%@",object[@"status"][@"message"]);
            [self showProgress:object[@"status"][@"message"]];
        }
    } withFailureBlock:^(NSError *error) {
        NSLog(@"wechat ----------- error:%@",error);
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}

//wxd7e440b513ecc397
//wxd7e440b513ecc397

////wechat pay
- (void)wechatPayParameter:(NSDictionary *)payload{
    
    NSString *appID           = [NSString stringWithFormat:@"%@",payload[@"appid"]];
    [WXApi registerApp:appID];
    

    NSString *partnerId           = [NSString stringWithFormat:@"%@",payload[@"partnerid"]];
    NSString *prepayId            = [NSString stringWithFormat:@"%@",payload[@"prepayid"]];
    NSMutableString *stamp        = [payload objectForKey:@"timestamp"];
    NSString *timeStamp           = stamp;
    NSString *nonceStr            = [NSString stringWithFormat:@"%@",payload[@"noncestr"]];
    NSString *package             = [NSString stringWithFormat:@"%@",payload[@"pack"]];
    NSString *sign                = [NSString stringWithFormat:@"%@",payload[@"sign"]];
    
    PayReq* req             = [[PayReq alloc] init];
    req.partnerId           = partnerId;
    req.prepayId            = prepayId;
    req.timeStamp           = timeStamp.intValue;
    req.nonceStr            = nonceStr;
    req.package             = package;
    req.sign                = sign;
    [WXApi sendReq:req];
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
