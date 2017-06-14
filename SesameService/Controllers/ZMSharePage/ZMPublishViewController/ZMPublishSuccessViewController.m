//
//  ZMPublishSuccessViewController.m
//  SesameService
//
//  Created by 娄耀文 on 17/3/30.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMPublishSuccessViewController.h"
#import "ZMShareDetailViewController.h"
#import "ZMCommissionDetailViewController.h"
#import "ZMPromoteIntroduceDetailViewController.h"
#import "ZMMoreInfoMoneyViewController.h"

@interface ZMPublishSuccessViewController ()

@end

@implementation ZMPublishSuccessViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提交成功";
    self.view.backgroundColor = [UIColor whiteColor];
    [self leftButton];
    
    [self.view addSubview:self.topImageView];
    [self.view addSubview:self.titleLable];
    [self.view addSubview:self.tipsLable];
    
    [self.view addSubview:self.checkBtn];
    [self.view addSubview:self.perfectBtn];
    [self.view addSubview:self.detailBtn];
    [self.view addSubview:self.againBtn];
    [self.view addSubview:self.backBtn];
    [self.view addSubview:self.callBtn];
    
    NSLog(@"from %@",_from);
    NSLog(@"id   %@",_detailId);
    NSLog(@"dic  %@",_moreInfoDic);
    
    //通知监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(perfectComplete:) name:@"perfectComplete" object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


#pragma mark - customMethod
- (void)back {

    /** 返回首页 */
    NSLog(@"返回首页");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"backToHome" object:nil]; //发送通知到上一级，dismiss到根控制器
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)checkAction {
    
    /** 查看信息详情 */
    NSLog(@"checkAction");
    ZMShareDetailViewController *detailView = [[ZMShareDetailViewController alloc] init];
    detailView.detailID = _detailId;
    [self.navigationController pushViewController:detailView animated:YES];
}

- (void)toDetail {

    /** 查看佣金或推介详情 */
    if ([_from isEqualToString:@"commission"]) {
        //佣金详情
        ZMCommissionDetailViewController *detailView = [[ZMCommissionDetailViewController alloc] init];
        detailView.commissionID = _detailId;
        detailView.isCom = YES;
        [self.navigationController pushViewController:detailView animated:YES];
    } else if ([_from isEqualToString:@"marketing"]) {
        //推介详情
        ZMPromoteIntroduceDetailViewController *detailView = [[ZMPromoteIntroduceDetailViewController alloc] init];
        detailView.promoteID = _detailId;
        detailView.isCom = YES;
        [self.navigationController pushViewController:detailView animated:YES];
    }
}

- (void)perfectAction {

    /** 第二部 H5 */
    NSLog(@"完善项目资料，赚更多信息费");
    NSString *titleUTF8Str = [_moreInfoDic[@"title"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *encodeUrl = [NSString stringWithFormat:@"%@/business/dynamic_form.html#info=%@&title=%@&fee=%@&mask=%@&mode=other&token=%@",
                           h5Dev,
                           _detailId,
                           titleUTF8Str,
                           _moreInfoDic[@"fee"],
                           _moreInfoDic[@"mask"],
                           [[NSUserDefaults standardUserDefaults] objectForKey:TOKEN]];
    
    ZMMoreInfoMoneyViewController *moreView = [[ZMMoreInfoMoneyViewController alloc] init];
    moreView.titleStr = @"完善项目信息";
    moreView.webUrl   = encodeUrl;
    [self.navigationController pushViewController:moreView animated:YES];
    
}

- (void)againAction {
    
    NSInteger count = self.navigationController.viewControllers.count - 3;
    UIViewController *viewCtl = self.navigationController.viewControllers[count];
    [self.navigationController popToViewController:viewCtl animated:YES];
}

- (void)callAction {

    NSLog(@"拨打电话");
    NSMutableString* str = [[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"400-8319-003"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

- (void)perfectComplete:(NSNotification*)notification {

    NSLog(@"成功完善信息");
    NSDictionary *price = notification.userInfo;
    
    self.perfectBtn.alpha = 0;
    self.againBtn.frame = CGRectMake(SCREEN_WIDTH/11.36,
                                     CGRectGetMaxY(self.tipsLable.frame) + SCREEN_WIDTH/6.25,
                                     SCREEN_WIDTH - SCREEN_WIDTH/5.68,
                                     SCREEN_WIDTH/9.375);
    self.backBtn.frame  = CGRectMake(SCREEN_WIDTH/11.36,
                                     CGRectGetMaxY(self.detailBtn.frame) + SCREEN_WIDTH/18.75,
                                     SCREEN_WIDTH - SCREEN_WIDTH/5.68,
                                     SCREEN_WIDTH/9.375);
    self.tipsLable.text = [NSString stringWithFormat:@"信息售出后，您将获得信息费%@元！",price[@"price"]];
    
    [self.againBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.againBtn setBackgroundImage:[toolClass imageWithColor:[UIColor colorWithHex:tonalColor] size:_detailBtn.frame.size] forState:UIControlStateNormal];
}

- (void)leftButton {
    
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(0, 0, 0, 0);
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = item;
    
}


#pragma mark - getter
- (UIImageView *)topImageView {

    if (_topImageView == nil) {
        _topImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - SCREEN_WIDTH/8.52)/2,
                                                                      SCREEN_WIDTH/5.68 + 64,
                                                                      SCREEN_WIDTH/8.52,
                                                                      SCREEN_WIDTH/7.81)];
        _topImageView.image = [UIImage imageNamed:@"share_success"];
    }
    return _topImageView;
}

- (UILabel *)titleLable {
    
    if (_titleLable == nil) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.frame = CGRectMake(SCREEN_WIDTH/11.36,
                                       CGRectGetMaxY(self.topImageView.frame) + SCREEN_WIDTH/17.86,
                                       SCREEN_WIDTH - SCREEN_WIDTH/5.68,
                                       SCREEN_WIDTH/22.1);
        _titleLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/22.1 weight:3];
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.textColor = [UIColor colorWithHex:@"030303"];
        
        if ([_from isEqualToString:@"info"]) {
            _titleLable.text = @"发布成功";
        } else {
            _titleLable.text = @"提交成功";
        }
    }
    return _titleLable;
}


- (UILabel *)tipsLable {
    
    if (_tipsLable == nil) {
        _tipsLable = [[UILabel alloc] init];
        _tipsLable.frame = CGRectMake(SCREEN_WIDTH/11.36,
                                      CGRectGetMaxY(self.titleLable.frame) + SCREEN_WIDTH/16.3,
                                      SCREEN_WIDTH - SCREEN_WIDTH/5.68,
                                      SCREEN_WIDTH/26.78);
        _tipsLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78];
        _tipsLable.textAlignment = NSTextAlignmentCenter;
        _tipsLable.numberOfLines = 0;
        _tipsLable.textColor = [UIColor colorWithHex:@"666666"];
        if ([_from isEqualToString:@"info"]) {
            _tipsLable.text = [NSString stringWithFormat:@"信息售出后，您将获得基础信息费%@元！",_moreInfoDic[@"fee"]];
        } else {
            _tipsLable.text = @"平台客服将于24小时内与您联系，请保持通讯畅通";
            [_tipsLable sizeToFit];
        }
    }
    return _tipsLable;
}


/** 按钮 */
- (UIButton *)checkBtn {
    
    if (_checkBtn == nil) {
        _checkBtn = [[UIButton alloc] init];
        _checkBtn.frame = CGRectMake((SCREEN_WIDTH - SCREEN_WIDTH/2)/2,
                                    self.tipsLable.bottom + SCREEN_WIDTH/37.5,
                                    SCREEN_WIDTH/2,
                                    20);
        [_checkBtn addTarget:self action:@selector(checkAction) forControlEvents:UIControlEventTouchUpInside];
        
        [_checkBtn setTitle:@"查看详情" forState:UIControlStateNormal];
        [_checkBtn.titleLabel setFont:[UIFont systemFontOfSize:SCREEN_WIDTH/26.78]];
        [_checkBtn setTitleColor:[UIColor colorWithHex:tonalColor] forState:UIControlStateNormal];
        
        if ([_from isEqualToString:@"info"]) {
            _checkBtn.alpha = 1;
        } else {
            _checkBtn.alpha = 0;
        }
    }
    return _checkBtn;
}

- (UIButton *)perfectBtn {
    
    if (_perfectBtn == nil) {
        _perfectBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/11.36,
                                                                CGRectGetMaxY(self.tipsLable.frame) + SCREEN_WIDTH/6.25,
                                                                SCREEN_WIDTH - SCREEN_WIDTH/5.68,
                                                                SCREEN_WIDTH/9.375)];
        [_perfectBtn.titleLabel setFont:[UIFont systemFontOfSize:SCREEN_WIDTH/26.78]];
        [_perfectBtn setTitle:@"完善项目资料，赚更多信息费" forState:UIControlStateNormal];
        [_perfectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _perfectBtn.layer.cornerRadius = 4;
        _perfectBtn.layer.masksToBounds = YES;
        [_perfectBtn setBackgroundImage:[toolClass imageWithColor:[UIColor colorWithHex:tonalColor] size:_perfectBtn.frame.size] forState:UIControlStateNormal];
        
        [_perfectBtn addTarget:self action:@selector(perfectAction) forControlEvents:UIControlEventTouchUpInside];
        
        if ([_from isEqualToString:@"info"]) {
            _perfectBtn.alpha = 1;
        } else {
            _perfectBtn.alpha = 0;
        }
    }
    return _perfectBtn;
}

- (UIButton *)detailBtn {
    
    if (_detailBtn == nil) {
        _detailBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/11.36,
                                                                CGRectGetMaxY(self.tipsLable.frame) + SCREEN_WIDTH/6.25,
                                                                SCREEN_WIDTH - SCREEN_WIDTH/5.68,
                                                                SCREEN_WIDTH/9.375)];
        [_detailBtn.titleLabel setFont:[UIFont systemFontOfSize:SCREEN_WIDTH/26.78]];
        [_detailBtn setTitle:@"查看详情" forState:UIControlStateNormal];
        [_detailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _detailBtn.layer.cornerRadius = 4;
        _detailBtn.layer.masksToBounds = YES;
        [_detailBtn setBackgroundImage:[toolClass imageWithColor:[UIColor colorWithHex:tonalColor] size:_detailBtn.frame.size] forState:UIControlStateNormal];
        
        [_detailBtn addTarget:self action:@selector(toDetail) forControlEvents:UIControlEventTouchUpInside];
        
        if ([_from isEqualToString:@"info"]) {
            _detailBtn.alpha = 0;
        } else {
            _detailBtn.alpha = 1;
        }
    }
    return _detailBtn;
}

- (UIButton *)againBtn {
    
    if (_againBtn == nil) {
        _againBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/11.36,
                                                              CGRectGetMaxY(self.detailBtn.frame) + SCREEN_WIDTH/18.75,
                                                              SCREEN_WIDTH - SCREEN_WIDTH/5.68,
                                                              SCREEN_WIDTH/9.375)];
        [_againBtn.titleLabel setFont:[UIFont systemFontOfSize:SCREEN_WIDTH/26.78]];
        [_againBtn setTitle:@"再发一条" forState:UIControlStateNormal];
        [_againBtn setTitleColor:[UIColor colorWithHex:tonalColor] forState:UIControlStateNormal];
        _againBtn.layer.cornerRadius = 4;
        _againBtn.layer.masksToBounds = YES;
        _againBtn.layer.borderColor = [UIColor colorWithHex:tonalColor].CGColor;
        _againBtn.layer.borderWidth = 1;
        [_againBtn setBackgroundImage:[toolClass imageWithColor:[UIColor whiteColor] size:_backBtn.frame.size] forState:UIControlStateNormal];
        [_againBtn setBackgroundImage:[toolClass imageWithColor:[UIColor colorWithHex:backColor] size:_detailBtn.frame.size] forState:UIControlStateHighlighted];
        
        [_againBtn addTarget:self action:@selector(againAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _againBtn;
}

- (UIButton *)backBtn {
    
    if (_backBtn == nil) {
        _backBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/11.36,
                                                             CGRectGetMaxY(self.againBtn.frame) + SCREEN_WIDTH/18.75,
                                                             SCREEN_WIDTH - SCREEN_WIDTH/5.68,
                                                             SCREEN_WIDTH/9.375)];
        [_backBtn.titleLabel setFont:[UIFont systemFontOfSize:SCREEN_WIDTH/26.78]];
        [_backBtn setTitle:@"返回首页" forState:UIControlStateNormal];
        [_backBtn setTitleColor:[UIColor colorWithHex:tonalColor] forState:UIControlStateNormal];
        _backBtn.layer.cornerRadius = 4;
        _backBtn.layer.masksToBounds = YES;
        _backBtn.layer.borderColor = [UIColor colorWithHex:tonalColor].CGColor;
        _backBtn.layer.borderWidth = 1;
        [_backBtn setBackgroundImage:[toolClass imageWithColor:[UIColor whiteColor] size:_backBtn.frame.size] forState:UIControlStateNormal];
        [_backBtn setBackgroundImage:[toolClass imageWithColor:[UIColor colorWithHex:backColor] size:_detailBtn.frame.size] forState:UIControlStateHighlighted];
        
        [_backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (UIButton *)callBtn {
    
    if (_callBtn == nil) {
        _callBtn = [[UIButton alloc] init];
        _callBtn.frame = CGRectMake((SCREEN_WIDTH - SCREEN_WIDTH/2.12)/2,
                                     SCREEN_HEIGHT - (SCREEN_WIDTH/2.12)/5.9 - 20,
                                     SCREEN_WIDTH/2.12,
                                    (SCREEN_WIDTH/2.12)/5.9);
        [_callBtn addTarget:self action:@selector(callAction) forControlEvents:UIControlEventTouchUpInside];
        [_callBtn setBackgroundImage:[toolClass imageWithColor:[UIColor whiteColor] size:_callBtn.frame.size]
                            forState:UIControlStateNormal];
        [_callBtn setBackgroundImage:[toolClass imageWithColor:[UIColor colorWithHex:backColor] size:_callBtn.frame.size]
                            forState:UIControlStateHighlighted];
        
        _callBtn.layer.borderWidth   = 0.5;
        _callBtn.layer.borderColor   = [UIColor colorWithHex:@"979797"].CGColor;
        _callBtn.layer.masksToBounds = YES;
        _callBtn.layer.cornerRadius  = (SCREEN_WIDTH/2.12)/11.8;
        [_callBtn setTitle:@"客服电话：400-831-9003" forState:UIControlStateNormal];
        [_callBtn.titleLabel setFont:[UIFont systemFontOfSize:SCREEN_WIDTH/31.25]];
        [_callBtn setTitleColor:[UIColor colorWithHex:@"979797"] forState:UIControlStateNormal];
    }
    return _callBtn;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
