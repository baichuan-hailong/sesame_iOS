//
//  ZMTradingOrderDetailViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/25.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMTradingOrderDetailViewController.h"
#import "ZMTradingOrderDetailView.h"

#import "ZMTradingOrderTopTableViewCell.h"
#import "ZMTradingOrderInfoTableViewCell.h"

@interface ZMTradingOrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) ZMTradingOrderDetailView *tradingOrderDetailView;

@property (nonatomic , strong) NSArray            *orderDetailArray;
@property (nonatomic , strong) MBProgressHUD      *HUD;
@end

@implementation ZMTradingOrderDetailViewController

- (void)loadView {
    //change
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tradingOrderDetailView   = [[ZMTradingOrderDetailView alloc] initWithFrame:SCREEN_BOUNDS];
    self.view                    = self.tradingOrderDetailView;
    self.tradingOrderDetailView.tradingOrderDetailTableView.delegate   = self;
    self.tradingOrderDetailView.tradingOrderDetailTableView.dataSource = self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"交易详情";
    
    if ([self.refer_type isEqualToString:@"info"]) {
        self.orderDetailArray =@[@{@"left":@"金额",@"right":@"--"},
                                 @{@"left":@"交易时间",@"right":@"--"},
                                 @{@"left":@"交易号",@"right":@"--"},
                                 @{@"left":@"交易类型",@"right":@"--"},
                                 @{@"left":@"交易金额",@"right":@"--"},
                                 @{@"left":@"手续费",@"right":@"--"},
                                 @{@"left":@"实际金额",@"right":@"--"}];
    }else{
        self.orderDetailArray =@[@{@"left":@"金额",@"right":@"--"},
                                 @{@"left":@"交易时间",@"right":@"--"},
                                 @{@"left":@"交易类型",@"right":@"--"},
                                 @{@"left":@"交易金额",@"right":@"--"},
                                 @{@"left":@"手续费",@"right":@"--"},
                                 @{@"left":@"实际金额",@"right":@"--"}];
    }
    
    
    [self evokeSouceData];
    
}


#pragma mark - Load Data
- (void)evokeSouceData{
    
    
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    [self.HUD show:YES];
    
    NSDictionary *parm = @{@"id":self.tradeID};
    NSString *urlStr   = [NSString stringWithFormat:@"%@/trade/detail",APIDev];
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:parm withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"trade-detail --- %@",object);
        NSLog(@"trade-detail --- %@",object[@"status"][@"message"]);
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            NSString *settle_amount = [NSString stringWithFormat:@"%@",object[@"data"][@"settle_amount"]];
            NSString *trade_time = [NSString stringWithFormat:@"%@",object[@"data"][@"trade_time"]];
            NSString *amount = [NSString stringWithFormat:@"%@",object[@"data"][@"amount"]];
            NSString *service_amount = [NSString stringWithFormat:@"%@",object[@"data"][@"service_amount"]];
            NSString *settlement_title = [NSString stringWithFormat:@"%@",object[@"data"][@"settlement_title"]];
            NSString *local_sn = [NSString stringWithFormat:@"%@",object[@"data"][@"local_sn"]];
            //NSLog(@"local_sn ********************************** %@",local_sn);
            if (local_sn.length>0) {
                
                self.orderDetailArray =@[@{@"left":@"金额",@"right":[NSString stringWithFormat:@"+%@",settle_amount]},
                                         @{@"left":@"交易时间",@"right":[self timeChange:trade_time]},
                                         @{@"left":@"交易号",@"right":local_sn},
                                         @{@"left":@"交易类型",@"right":settlement_title},
                                         @{@"left":@"交易金额",@"right":amount},
                                         @{@"left":@"手续费",@"right":service_amount},
                                         @{@"left":@"实际金额",@"right":settle_amount}];
            }else{
                self.orderDetailArray =@[@{@"left":@"金额",@"right":[NSString stringWithFormat:@"+%@",settle_amount]},
                                         @{@"left":@"交易时间",@"right":[self timeChange:trade_time]},
                                         @{@"left":@"交易类型",@"right":settlement_title},
                                         @{@"left":@"交易金额",@"right":amount},
                                         @{@"left":@"手续费",@"right":service_amount},
                                         @{@"left":@"实际金额",@"right":settle_amount}];
            }
        }else{
            [self showProgress:object[@"status"][@"message"]];
        }
        
        [self.tradingOrderDetailView.tradingOrderDetailTableView reloadData];
        [self.HUD hide:YES];
    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
        [self.HUD hide:YES];
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}






#pragma mark - Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.orderDetailArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0) {
        return SCREEN_WIDTH/375*64;
    }else{
        return SCREEN_WIDTH/375*28;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *topIndentifire             = @"topCell";
    static NSString *infoIndentifire            = @"informationCell";
    
    if (indexPath.row==0) {
        NSDictionary *dic = self.orderDetailArray[indexPath.row];
        ZMTradingOrderTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:topIndentifire];
        if (!cell) {
            cell = [[ZMTradingOrderTopTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:topIndentifire];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell setDetail:dic];
        return cell;
        
    }else{
        NSDictionary *dic = self.orderDetailArray[indexPath.row];
        ZMTradingOrderInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:infoIndentifire];
        if (!cell) {
            cell = [[ZMTradingOrderInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infoIndentifire];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell setDetail:dic];
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //NSLog(@"commission");
}




//MBProgress
- (void)showProgress:(NSString *)tipStr{
    MBProgressHUD *hud            = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode                      = MBProgressHUDModeText;
    hud.labelText                 = tipStr;
    hud.margin                    = 20.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}

#pragma mark - 时间戳转换为标准时间
- (NSString *)timeChange:(NSString *)timeStamp {
    NSTimeInterval time = [timeStamp doubleValue];// + 28800;  //因为时差问题要加8小时 == 28800
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSString *currentDateStr = [formatter stringFromDate: date];
    return currentDateStr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
