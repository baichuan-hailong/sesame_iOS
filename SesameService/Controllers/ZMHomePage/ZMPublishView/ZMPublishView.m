//
//  ZMPublishView.m
//  SesameService
//
//  Created by 娄耀文 on 17/4/7.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMPublishView.h"
#import "ZMAgentPublishViewController.h"
#import "ZMInfoMoneyViewController.h"
#import "ZMGetCommissionViewController.h"
#import "ZMMarketingViewController.h"
#import "ZMLoginViewController.h"

@implementation ZMPublishView

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.backGroungEffe];
    [self.backGroungEffe addSubview:self.closeBtn];
    [self.backGroungEffe addSubview:self.businessBtn];
    [self.backGroungEffe addSubview:self.agentBtn];
    [self.backGroungEffe addSubview:self.askBtn];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    [self.view addGestureRecognizer:tapGesture];
    [self.closeBtn addGestureRecognizer:tapGesture];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(publish_to_infoMoney)  name:@"publish_to_infoMoney" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(publish_to_commission) name:@"publish_to_commission" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(publish_to_marketing)  name:@"publish_to_marketing" object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [UIView animateWithDuration:0.28 animations:^{
        self.backGroungEffe.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}


#pragma mark - customMethod
- (void)btnClickAction:(UIButton *)sender {

    if (sender.tag == 1) {
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:IS_LOGIN]) {
        
            ZMInfoMoneyViewController *infoMoney = [[ZMInfoMoneyViewController alloc] init];
            infoMoney.isFromHome = NO;
            infoMoney.from = @"publish";
            UINavigationController *infoMoneyNc = [[UINavigationController alloc] initWithRootViewController:infoMoney];
            [self presentViewController:infoMoneyNc animated:YES completion:^{
                self.backGroungEffe.alpha = 0;
            }];
        } else {
            
            ZMLoginViewController *loginView = [[ZMLoginViewController alloc] init];
            loginView.entranceType = @"publish_to_infoMoney";
            UINavigationController *loginNC = [[UINavigationController alloc] initWithRootViewController:loginView];
            [self presentViewController:loginNC animated:YES completion:nil];
        }
    } else if (sender.tag == 2) {
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:IS_LOGIN]) {
         
            ZMGetCommissionViewController *commission = [[ZMGetCommissionViewController alloc] init];
            commission.isFromHome = NO;
            UINavigationController *commissionNc = [[UINavigationController alloc] initWithRootViewController:commission];
            [self presentViewController:commissionNc animated:YES completion:^{
                self.backGroungEffe.alpha = 0;
            }];
        } else {
            
            ZMLoginViewController *loginView = [[ZMLoginViewController alloc] init];
            loginView.entranceType = @"publish_to_commission";
            UINavigationController *loginNC = [[UINavigationController alloc] initWithRootViewController:loginView];
            [self presentViewController:loginNC animated:YES completion:nil];
        }
    } else if (sender.tag == 3) {
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:IS_LOGIN]) {
         
            ZMMarketingViewController *marketing = [[ZMMarketingViewController alloc] init];
            marketing.isFromHome = NO;
            UINavigationController *marketingNc = [[UINavigationController alloc] initWithRootViewController:marketing];
            [self presentViewController:marketingNc animated:YES completion:^{
                self.backGroungEffe.alpha = 0;
            }];
        } else {
            
            ZMLoginViewController *loginView = [[ZMLoginViewController alloc] init];
            loginView.entranceType = @"publish_to_marketing";
            UINavigationController *loginNC = [[UINavigationController alloc] initWithRootViewController:loginView];
            [self presentViewController:loginNC animated:YES completion:nil];
        }
    }
}

- (void)tapGesture:(UITapGestureRecognizer *)gesture{

    [UIView animateWithDuration:0.18 animations:^{
        
        _backGroungEffe.alpha = 0;
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}


#pragma mark - 监听登陆成功之后跳转
- (void)publish_to_infoMoney {
    
    ZMInfoMoneyViewController *infoMoney = [[ZMInfoMoneyViewController alloc] init];
    infoMoney.isFromHome = NO;
    infoMoney.from = @"publish";
    UINavigationController *infoMoneyNc = [[UINavigationController alloc] initWithRootViewController:infoMoney];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:infoMoneyNc animated:YES completion:^{
            self.backGroungEffe.alpha = 0;
        }];
    });
    
}

- (void)publish_to_commission {
    
    ZMGetCommissionViewController *commission = [[ZMGetCommissionViewController alloc] init];
    commission.isFromHome = NO;
    UINavigationController *commissionNc = [[UINavigationController alloc] initWithRootViewController:commission];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:commissionNc animated:YES completion:^{
            self.backGroungEffe.alpha = 0;
        }];
    });
}

- (void)publish_to_marketing {
    
    ZMMarketingViewController *marketing = [[ZMMarketingViewController alloc] init];
    marketing.isFromHome = NO;
    UINavigationController *marketingNc = [[UINavigationController alloc] initWithRootViewController:marketing];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:marketingNc animated:YES completion:^{
            self.backGroungEffe.alpha = 0;
        }];
    });
}




















#pragma mark - getter
- (UIVisualEffectView *)backGroungEffe {
    
    if (_backGroungEffe == nil) {
        
        UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        _backGroungEffe = [[UIVisualEffectView alloc]initWithEffect:blur];
        _backGroungEffe.frame = CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height);
        _backGroungEffe.alpha = 0;
    }
    return _backGroungEffe;
}

- (UIButton *)closeBtn {

    if (_closeBtn == nil) {
        _closeBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - SCREEN_WIDTH/8.93)/2,
                                                                SCREEN_HEIGHT - SCREEN_WIDTH/8.93 - SCREEN_WIDTH/17,
                                                                SCREEN_WIDTH/8.93,
                                                                SCREEN_WIDTH/8.93)];
        
        [_closeBtn setBackgroundImage:[UIImage imageNamed:@"home_closePublish"] forState:UIControlStateNormal];
        //[_closeBtn addTarget:self action:@selector(hidePublishView) forControlEvents:UIControlEventTouchUpInside];
        
        _closeBtn.layer.shadowColor = [UIColor blackColor].CGColor;
        _closeBtn.layer.shadowOpacity = 0.6f;
        _closeBtn.layer.shadowRadius = 4.f;
        _closeBtn.layer.shadowOffset = CGSizeMake(1.6,1.6);
    }
    //_closeBtn.transform = CGAffineTransformMakeRotation(45 * (M_PI/180.0));
    return  _closeBtn;
}


/** 我要赚信息费 */
- (UIButton *)businessBtn {

    if (_businessBtn == nil) {
        _businessBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/15,
                                                                  SCREEN_HEIGHT/4.2,
                                                                  SCREEN_WIDTH/1.17,
                                                                 (SCREEN_WIDTH/1.17)/2.67)];
        _businessBtn.tag = 1;
        _businessBtn.backgroundColor    = [UIColor whiteColor];
        _businessBtn.layer.cornerRadius = 3;
        
        _businessBtn.layer.shadowColor = [UIColor blackColor].CGColor;
        _businessBtn.layer.shadowOpacity = 0.6f;
        _businessBtn.layer.shadowRadius = 4.f;
        _businessBtn.layer.shadowOffset = CGSizeMake(1.6,1.6);
        [_businessBtn addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                                        (_businessBtn.height - SCREEN_WIDTH/6.94)/2,
                                                                         SCREEN_WIDTH/7.075,
                                                                         SCREEN_WIDTH/6.94)];
        img.image = [UIImage imageNamed:@"home_publish_信息费"];
        [_businessBtn addSubview:img];
        
        UILabel *tips1 = [[UILabel alloc] initWithFrame:CGRectMake(img.right + SCREEN_WIDTH/25,
                                                                   img.top + SCREEN_WIDTH/180,
                                                                   _businessBtn.width - img.width - SCREEN_WIDTH/7.5,
                                                                   SCREEN_WIDTH/26.78)];
        tips1.font = [UIFont systemFontOfSize:SCREEN_WIDTH/23.43 weight:3];
        tips1.text = @"我要赚信息费";
        tips1.textColor = [UIColor colorWithHex:@"333333"];
        [_businessBtn addSubview:tips1];
        
        UILabel *tips2 = [[UILabel alloc] initWithFrame:CGRectMake(img.right + SCREEN_WIDTH/25,
                                                                   tips1.bottom + SCREEN_WIDTH/53.57,
                                                                   SCREEN_WIDTH/2.18,
                                                                   SCREEN_WIDTH/31.25)];
        tips2.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        tips2.numberOfLines = 2;
        tips2.textColor = [UIColor colorWithHex:@"666666"];
        tips2.text = @"您拥有业务信息自己做不了？发布出来卖钱吧！";
        [UILabel changeLineSpaceForLabel:tips2 WithSpace:5];
        [tips2 sizeToFit];
        [_businessBtn addSubview:tips2];
        
        
        UIImage     *rightImg     = [UIImage imageNamed:@"vipRight"];
        UIImageView *rightImgView = [[UIImageView alloc] initWithFrame:CGRectMake(_businessBtn.width - rightImg.size.width - SCREEN_WIDTH/18.75,
                                                                                 (_businessBtn.height - rightImg.size.height)/2,
                                                                                  rightImg.size.width,
                                                                                  rightImg.size.height)];
        rightImgView.image = rightImg;
        [_businessBtn addSubview:rightImgView];
        
    }
    return _businessBtn;
}


/** 我要赚佣金 */
- (UIButton *)agentBtn {
    
    if (_agentBtn == nil) {
        _agentBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/15,
                                                               self.businessBtn.bottom + SCREEN_WIDTH/25,
                                                               SCREEN_WIDTH/1.17,
                                                              (SCREEN_WIDTH/1.17)/2.67)];
        _agentBtn.tag = 2;
        _agentBtn.backgroundColor    = [UIColor whiteColor];
        _agentBtn.layer.cornerRadius = 3;
        
        _agentBtn.layer.shadowColor = [UIColor blackColor].CGColor;
        _agentBtn.layer.shadowOpacity = 0.6f;
        _agentBtn.layer.shadowRadius = 4.f;
        _agentBtn.layer.shadowOffset = CGSizeMake(1.6,1.6);
        [_agentBtn addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                                         (_agentBtn.height - SCREEN_WIDTH/6.94)/2,
                                                                         SCREEN_WIDTH/7.075,
                                                                         SCREEN_WIDTH/6.94)];
        img.image = [UIImage imageNamed:@"home_publish_佣金"];
        [_agentBtn addSubview:img];
        
        UILabel *tips1 = [[UILabel alloc] initWithFrame:CGRectMake(img.right + SCREEN_WIDTH/25,
                                                                   SCREEN_WIDTH/17.05,
                                                                   _agentBtn.width - img.width - SCREEN_WIDTH/7.5,
                                                                   SCREEN_WIDTH/26.78)];
        tips1.font = [UIFont systemFontOfSize:SCREEN_WIDTH/23.43 weight:3];
        tips1.text = @"我要赚佣金";
        tips1.textColor = [UIColor colorWithHex:@"333333"];
        [_agentBtn addSubview:tips1];
        
        UILabel *tips2 = [[UILabel alloc] initWithFrame:CGRectMake(img.right + SCREEN_WIDTH/25,
                                                                   tips1.bottom + SCREEN_WIDTH/53.57,
                                                                   SCREEN_WIDTH/2.18,
                                                                   SCREEN_WIDTH/31.25)];
        tips2.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        tips2.numberOfLines = 0;
        tips2.textColor = [UIColor colorWithHex:@"666666"];
        tips2.text = @"您能够撮合业务签单？这里将为您匹配优质企业，并为您获得佣金保驾护航。";
        [UILabel changeLineSpaceForLabel:tips2 WithSpace:5];
        [tips2 sizeToFit];
        [_agentBtn addSubview:tips2];
        
        UIImage     *rightImg     = [UIImage imageNamed:@"vipRight"];
        UIImageView *rightImgView = [[UIImageView alloc] initWithFrame:CGRectMake(_agentBtn.width - rightImg.size.width - SCREEN_WIDTH/18.75,
                                                                                 (_agentBtn.height - rightImg.size.height)/2,
                                                                                  rightImg.size.width,
                                                                                  rightImg.size.height)];
        rightImgView.image = rightImg;
        [_agentBtn addSubview:rightImgView];
    }
    return _agentBtn;
}


/** 我要赚推介费 */
- (UIButton *)askBtn {
    
    if (_askBtn == nil) {
        _askBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/15,
                                                             self.agentBtn.bottom + SCREEN_WIDTH/25,
                                                             SCREEN_WIDTH/1.17,
                                                            (SCREEN_WIDTH/1.17)/2.67)];
        _askBtn.tag = 3;
        _askBtn.backgroundColor    = [UIColor whiteColor];
        _askBtn.layer.cornerRadius = 3;
        
        _askBtn.layer.shadowColor = [UIColor blackColor].CGColor;
        _askBtn.layer.shadowOpacity = 0.6f;
        _askBtn.layer.shadowRadius = 4.f;
        _askBtn.layer.shadowOffset = CGSizeMake(1.6,1.6);
        [_askBtn addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                                         (_askBtn.height - SCREEN_WIDTH/6.94)/2,
                                                                         SCREEN_WIDTH/7.075,
                                                                         SCREEN_WIDTH/6.94)];
        img.image = [UIImage imageNamed:@"home_publish_推介"];
        [_askBtn addSubview:img];
        
        UILabel *tips1 = [[UILabel alloc] initWithFrame:CGRectMake(img.right + SCREEN_WIDTH/25,
                                                                   SCREEN_WIDTH/17.05,
                                                                   SCREEN_WIDTH/2.18,
                                                                   SCREEN_WIDTH/23.43)];
        tips1.font = [UIFont systemFontOfSize:SCREEN_WIDTH/23.43 weight:3];
        tips1.text = @"我要赚推介费";
        tips1.textColor = [UIColor colorWithHex:@"333333"];
        [_askBtn addSubview:tips1];
        
        UILabel *tips2 = [[UILabel alloc] initWithFrame:CGRectMake(img.right + SCREEN_WIDTH/25,
                                                                   tips1.bottom + SCREEN_WIDTH/53.57,
                                                                   SCREEN_WIDTH/2.18,
                                                                   SCREEN_WIDTH/31.25)];
        tips2.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        tips2.numberOfLines = 0;
        tips2.textColor = [UIColor colorWithHex:@"666666"];
        tips2.text = @"想为业主推荐指定服务商或产品赚取推介费，但缺少人脉和资源进行接洽？平台帮您牵线搭桥！";
        [UILabel changeLineSpaceForLabel:tips2 WithSpace:5];
        [tips2 sizeToFit];
        [_askBtn addSubview:tips2];
        
        UIImage     *rightImg     = [UIImage imageNamed:@"vipRight"];
        UIImageView *rightImgView = [[UIImageView alloc] initWithFrame:CGRectMake(_askBtn.width - rightImg.size.width - SCREEN_WIDTH/18.75,
                                                                                 (_askBtn.height - rightImg.size.height)/2,
                                                                                  rightImg.size.width,
                                                                                  rightImg.size.height)];
        rightImgView.image = rightImg;
        [_askBtn addSubview:rightImgView];
    }
    return _askBtn;
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
