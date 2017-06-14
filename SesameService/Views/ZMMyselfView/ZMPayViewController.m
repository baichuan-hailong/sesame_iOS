//
//  ZMPayViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/5/6.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMPayViewController.h"
#import "ZMPayView.h"

#import "ZMPayTypeTableViewCell.h"
#import "ZMPayMoneyTableViewCell.h"

#import "ZMMyBuyViewController.h"
#import "ZMMySounceViewController.h"

#import "ZMAllUnderstandViewController.h"

@interface ZMPayViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL isWechat;
}
@property (nonatomic,strong)ZMPayView *payView;
@property (nonatomic,strong)NSArray   *souceTopArray;
@property (nonatomic,strong)NSArray   *souceArray;
@property (nonatomic ,strong)MBProgressHUD *HUD;
@property (nonatomic,strong)UIAlertController *alertDialog;
@end

@implementation ZMPayViewController
-(void)loadView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.payView = [[ZMPayView alloc] initWithFrame:SCREEN_BOUNDS];
    self.view = self.payView;
    self.payView.payTableView.delegate  = self;
    self.payView.payTableView.dataSource=self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"支付";
    
    //信息费
    //悬赏金额
    
    if (_isInfo) {
        self.souceTopArray =@[@{@"tip":@"项目",@"money":self.infoTitle},
                              @{@"tip":@"信息费",@"money":[NSString stringWithFormat:@"￥%@",self.money]}];
        
        if ([WXApi isWXAppInstalled]) {
            
            self.souceArray = @[@{@"leImage":@"payAliPayType",@"leTip":@"支付宝"},
                                @{@"leImage":@"payWechatType",@"leTip":@"微信支付"}];
        }else{
            self.souceArray = @[@{@"leImage":@"payAliPayType",@"leTip":@"支付宝"}];
        }
        
    }else{
        self.souceTopArray =@[@{@"tip":@"悬赏金额",@"money":[NSString stringWithFormat:@"￥%@",self.money]}];
        
        if ([WXApi isWXAppInstalled]) {
            
            self.souceArray = @[@{@"leImage":@"payAliPayType",@"leTip":@"支付宝"},
                                @{@"leImage":@"payWechatType",@"leTip":@"微信支付"}];
        }else{
            self.souceArray = @[@{@"leImage":@"payAliPayType",@"leTip":@"支付宝"}];
        }
    }
    
    
    
    
    //aliPay
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(aliPaySuccessful)
                                                 name:@"aliPaySuccessful"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(aliPayFailed)
                                                 name:@"aliPayFailed"
                                               object:nil];
    
    //wechat
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(aliPaySuccessful)
                                                 name:@"wechatPaySuccessful"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(aliPayFailed)
                                                 name:@"wechatPayFailed"
                                               object:nil];
    
    
    //Foreground
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(enterForeground)
                                                 name:@"enterForeground"
                                               object:nil];
    
    //maek
    //faile
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(makeOrderFailed)
                                                 name:@"makeOrderFailed"
                                               object:nil];
}

#pragma mark - Foreground
- (void)enterForeground{
    [self hidHud];
    //bug
    //[self payFailPop];
    if (_isInfo) {
        //[self showProgress:@"购买失败！"];
    }else{
        //[self showProgress:@"发布失败！"];
    }
}

#pragma mark - 下单失败
- (void)makeOrderFailed{
    [self hidHud];
}


#pragma mark - aliPay
- (void)aliPaySuccessful{
    [self hidHud];
    
    [self.alertDialog dismissViewControllerAnimated:NO completion:nil];
    
    if (_isInfo) {
        [self showProgress:@"购买成功！"];
    }else{
        [self showProgress:@"发布成功！"];
    }
    
    if (_isInfo) {
        //self.infoID
        ZMMyBuyViewController *buyVC = [[ZMMyBuyViewController alloc] init];
        buyVC.buyID = self.infoID;
        buyVC.states = @"dealt_pending";
        buyVC.isRootPop = YES;
        [self.navigationController pushViewController:buyVC animated:YES];
    }else{
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreWaitListNoti" object:nil];
        
        if (_isSelected) {
            ZMMySounceViewController *mySounceVC = [[ZMMySounceViewController alloc] init];
            [mySounceVC setHidesBottomBarWhenPushed:YES];
            mySounceVC.isSelected = YES;
            [self.navigationController pushViewController:mySounceVC animated:YES];
        }else{
            if (self.isHome) {
                NSLog(@"home");
                for (UIViewController *temp in self.navigationController.viewControllers) {
                    if ([temp isKindOfClass:[ZMAllUnderstandViewController class]]) {
                        [self.navigationController popToViewController:temp animated:YES];
                    }
                }
            }else{
               [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }
    }
}


- (void)aliPayFailed{
    [self hidHud];
    [self payFailPop];
    if (_isInfo) {
        //[self showProgress:@"购买失败！"];
    }else{
        //[self showProgress:@"发布失败！"];
    }
    
}


#pragma mark - Logout
- (void)payFailPop{
    
   self.alertDialog = [UIAlertController alertControllerWithTitle:nil
                                                                         message:@"支付失败"
                                                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction        = [UIAlertAction actionWithTitle:@"再次支付"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction *action) {
                                                                [self okAction];
    }];
    
    
    
    
    UIAlertAction *cancle          = [UIAlertAction actionWithTitle:@"取消"
                                                              style:UIAlertActionStyleCancel
                                                            handler:^(UIAlertAction *action) {
        //[self cancleAction];
    }];
    
    [cancle setValue:[UIColor colorWithHex:@"000000"] forKey:@"titleTextColor"];
    [self.alertDialog addAction:cancle];
    [self.alertDialog addAction:okAction];
    [self presentViewController:self.alertDialog animated:YES completion:nil];
    
    
}


- (void)okAction{
    
    if (isWechat) {
        isWechat = YES;
        if (_isInfo) {
            [self showHud];
            [[WXApiManager sharedManager] evokeWechatPayInfoID:self.infoID];
        }else{
            [self showHud];
            [[WXApiManager sharedManager] evokeWechatPayQuestionID:self.questionID];
        }
    }else{
        if (_isInfo) {
            [[SSAliPayManage defauleSingleton] evokeAliPayInfoID:self.infoID];
        }else{
            [self showHud];
            [[SSAliPayManage defauleSingleton] evokeAliPayQuestionID:self.questionID];
        }
    }
}




#pragma mark - TableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==0) {
        return self.souceTopArray.count;
    }else{
        return self.souceArray.count;
    }
}


/***header***/
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return SCREEN_WIDTH/375*0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header         = [[UIView alloc] init];
    header.backgroundColor = [UIColor clearColor];
    return header;
}

/***footer***/
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return SCREEN_WIDTH/375*32;
    }else{
        return SCREEN_WIDTH/375*0;
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section==0) {
        UIView *headerView         = [[UIView alloc] init];
        //headerView.backgroundColor = [UIColor clearColor];
        
        UILabel *payTypeTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                                     SCREEN_WIDTH/375*0,
                                                                     SCREEN_WIDTH/375*200,
                                                                     SCREEN_WIDTH/375*32)];
        [ZMLabelAttributeMange setLabel:payTypeTipLabel
                                   text:@"选择支付方式"
                                    hex:@"666666"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*13]];
        [headerView addSubview:payTypeTipLabel];
        return headerView;
    }else{
        UIView *headerView         = [[UIView alloc] init];
        headerView.backgroundColor = [UIColor clearColor];
        return headerView;
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0) {
       return SCREEN_WIDTH/375*50;
    }else{
        return SCREEN_WIDTH/375*50;
    }
    
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellMoneyIndentifire = @"payMoneycellID";
    static NSString *cellIndentifire      = @"paycellID";
    
    
    
    if (indexPath.section == 0) {
        NSDictionary *dic = self.souceTopArray[indexPath.row];
        ZMPayMoneyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellMoneyIndentifire];
        if (!cell) {
            cell = [[ZMPayMoneyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellMoneyIndentifire];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell setPayMoney:dic];
        if (_isInfo&&indexPath.row==0) {
            cell.moneyLabel.textColor = [UIColor colorWithHex:@"333333"];
        }
        if (indexPath.row==self.souceTopArray.count-1) {
            cell.line.alpha = 0;
        }else{
            cell.line.alpha = 1;
        }
        return cell;
    }else{
        NSDictionary *dic = self.souceArray[indexPath.row];
        ZMPayTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifire];
        if (!cell) {
            cell = [[ZMPayTypeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifire];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (indexPath.row==self.souceArray.count-1) {
            cell.line.alpha = 0;
        }else{
            cell.line.alpha = 1;
        }
        [cell setPayType:dic];
        return cell;
    }
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            NSLog(@"aliPay");
            isWechat = NO;
            if (_isInfo) {
                [self showHud];
                [[SSAliPayManage defauleSingleton] evokeAliPayInfoID:self.infoID];
            }else{
                [self showHud];
                [[SSAliPayManage defauleSingleton] evokeAliPayQuestionID:self.questionID];
            }
            
        }else if (indexPath.row==1){
            NSLog(@"wePay");
            isWechat = YES;
            if (_isInfo) {
                [self showHud];
                [[WXApiManager sharedManager] evokeWechatPayInfoID:self.infoID];
            }else{
                [self showHud];
                [[WXApiManager sharedManager] evokeWechatPayQuestionID:self.questionID];
            }
            
        }
    }
    
    
}


- (void)showHud{
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    [self.HUD show:YES];
}

- (void)hidHud{
    [self.HUD hide:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
