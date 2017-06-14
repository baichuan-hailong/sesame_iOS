//
//  ZMTradingBusinessDetailViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/5/8.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMTradingBusinessDetailViewController.h"
#import "ZMTradingBusniessView.h"

//ZMMySellSecondTableViewCell
#import "ZMMySellSecondTableViewCell.h"

@interface ZMTradingBusinessDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)ZMTradingBusniessView *tradingBusniessView;
@property(nonatomic,strong)NSArray          *detailArray;
@property (nonatomic , strong)MBProgressHUD *HUD;
@end

@implementation ZMTradingBusinessDetailViewController


- (void)loadView {
    //change
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tradingBusniessView    = [[ZMTradingBusniessView alloc] initWithFrame:SCREEN_BOUNDS];
    self.view                                 = self.tradingBusniessView;
    self.tradingBusniessView.tradingBusniessTableView.delegate   = self;
    self.tradingBusniessView.tradingBusniessTableView.dataSource = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"交易详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.detailArray =      @[@{@"left":@"交易时间",@"right":@"--"},
                              @{@"left":@"交易号",@"right":@"--"},
                              @{@"left":@"购买者",@"right":@"--"},
                              @{@"left":@"联系电话",@"right":@"--"}];
    
    
    [self evokeSouceData];
}




#pragma mark - Load Data
- (void)evokeSouceData{
    
    
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    [self.HUD show:YES];
    
    NSDictionary *parm = @{@"id":self.sellID};
    NSString *urlStr   = [NSString stringWithFormat:@"%@/info/trade-detail",APIDev];
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:parm withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"/info/trade-detail ------ %@",object);
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            
            NSString *trade_time = [NSString stringWithFormat:@"%@",object[@"data"][@"trade_time"]];
            NSString *local_sn   = [NSString stringWithFormat:@"%@",object[@"data"][@"local_sn"]];
            //NSString *price      = [NSString stringWithFormat:@"￥%@",object[@"data"][@"price"]];
            NSString *person_name= [NSString stringWithFormat:@"%@",object[@"data"][@"bidder"][@"person_name"]];
            NSString *username   = [NSString stringWithFormat:@"%@",object[@"data"][@"bidder"][@"username"]];
            
            
            self.detailArray =      @[@{@"left":@"交易时间",@"right":[self timeChange:trade_time]},
                                      @{@"left":@"交易号",@"right":local_sn},
                                      @{@"left":@"购买者",@"right":person_name},
                                      @{@"left":@"联系电话",@"right":username}];
        }else{
            [self showProgress:object[@"status"][@"message"]];
        }
        
        [self.tradingBusniessView.tradingBusniessTableView reloadData];
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
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return SCREEN_WIDTH/375*46;
}




/**footer**/
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return SCREEN_WIDTH/375*13;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footView         = [[UIView alloc] init];
    footView.backgroundColor = [UIColor clearColor];
    return footView;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *sellIndentifire = @"sellCell";
    NSDictionary *dic = self.detailArray[indexPath.row];
    ZMMySellSecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sellIndentifire];
    if (!cell) {
        cell = [[ZMMySellSecondTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                  reuseIdentifier:sellIndentifire];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setInvoiceDetail:dic];
    if (indexPath.row==4) {
        cell.line.alpha = 0;
    }else{
        cell.line.alpha = 1;
    }
    return cell;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"trEva");
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@end
