//
//  ZMTradingDetailViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/21.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMTradingDetailViewController.h"
#import "ZMTradingDetailView.h"
#import "ZMTradingTableViewCell.h"

#import "ZMTradingOrderDetailViewController.h"

@interface ZMTradingDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger currentPage;
    NSInteger totalCount;
}
@property(nonatomic,strong)ZMTradingDetailView *tradingDetailView;
@property(nonatomic,strong)NSMutableArray *sourceDataArray;
@end

@implementation ZMTradingDetailViewController

-(void)loadView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tradingDetailView = [[ZMTradingDetailView alloc] initWithFrame:SCREEN_BOUNDS];
    self.tradingDetailView.tradingDetailTableView.delegate   = self;
    self.tradingDetailView.tradingDetailTableView.dataSource = self;
    self.view       = self.tradingDetailView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"交易明细";
    
    [self setMJRefreshConfig:self.tradingDetailView.tradingDetailTableView];
    [self.tradingDetailView.tradingDetailTableView.mj_header beginRefreshing];
}


#pragma mark - Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sourceDataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return SCREEN_WIDTH/375*60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return SCREEN_WIDTH/375*20;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footView         = [[UIView alloc] init];
    footView.backgroundColor = [UIColor clearColor];
    return footView;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *tradingIndentifire         = @"tradingCell";
    NSDictionary *dic = self.sourceDataArray[indexPath.row];
    ZMTradingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tradingIndentifire];
    if (!cell) {
        cell = [[ZMTradingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tradingIndentifire];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row==self.sourceDataArray.count-1) {
        cell.line.alpha = 0;
    }else{
        cell.line.alpha = 1;
    }
    [cell setPromoteIntro:dic];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"trading");
    
    NSDictionary *dic = self.sourceDataArray[indexPath.row];
    
    ZMTradingOrderDetailViewController *oneTradingVC = [[ZMTradingOrderDetailViewController alloc] init];
    oneTradingVC.tradeID = [NSString stringWithFormat:@"%@",dic[@"id"]];
    oneTradingVC.refer_type = [NSString stringWithFormat:@"%@",dic[@"refer_type"]];
    [self.navigationController pushViewController:oneTradingVC animated:YES];
}

#pragma mark - SourceData
- (void)evokeSouceData{
    
    currentPage = 1;
    NSDictionary *parm = @{@"page":@"1"};
    NSString *urlStr   = [NSString stringWithFormat:@"%@/trade/lists",APIDev];
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:parm withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"right --- %@",object);
        NSLog(@"%@",object[@"status"][@"message"]);
        
        self.tradingDetailView.tradingDetailTableView.mj_footer.state = MJRefreshStateIdle;
        
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            [self.sourceDataArray removeAllObjects];
            self.sourceDataArray = [NSMutableArray arrayWithArray:object[@"data"][@"items"]];
            
            if (self.sourceDataArray.count>0) {
                [self.tradingDetailView.tradingDetailTableView reloadData];
            }else{
                ZMEmptyView *emptyView = [[ZMEmptyView alloc] initWithFrame:SCREEN_BOUNDS];
                [emptyView setBottomTitle:@"暂无信息"];
                self.tradingDetailView.tradingDetailTableView.tableHeaderView = emptyView;
            }
            
            totalCount = [[NSString stringWithFormat:@"%@",object[@"data"][@"total"]] integerValue];
            currentPage= 2;
        }else{
            [self showProgress:object[@"status"][@"message"]];
        }
        [self.tradingDetailView.tradingDetailTableView.mj_header endRefreshing];
    } withFailureBlock:^(NSError *error) {
        [self.tradingDetailView.tradingDetailTableView.mj_header endRefreshing];
        NSLog(@"%@",error);
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}



- (void)loadMoreSouceData{
    if (self.sourceDataArray.count<totalCount) {
        NSString *currentPageStr = [NSString stringWithFormat:@"%ld",(long)currentPage];
        NSDictionary *parm = @{@"page":currentPageStr};
        NSString *urlStr   = [NSString stringWithFormat:@"%@/trade/lists",APIDev];
        [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:parm withSuccessBlock:^(NSDictionary *object) {
            NSLog(@"%@",object);
            NSLog(@"%@",object[@"status"][@"message"]);
            NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
            if ([stateStr isEqualToString:@"success"]) {
                [self.sourceDataArray addObjectsFromArray:object[@"data"][@"items"]];
                if (self.sourceDataArray.count<totalCount) {
                    currentPage++;
                }
                [self.tradingDetailView.tradingDetailTableView reloadData];
                
            }else{
                [self showProgress:object[@"status"][@"message"]];
            }
            [self.tradingDetailView.tradingDetailTableView.mj_footer endRefreshing];
        } withFailureBlock:^(NSError *error) {
            [self.tradingDetailView.tradingDetailTableView.mj_footer endRefreshing];
            NSLog(@"%@",error);
        } progress:^(float progress) {
            NSLog(@"%f",progress);
        }];
    }else{
        //[self.tradingDetailView.tradingDetailTableView.mj_footer endRefreshing];
        self.tradingDetailView.tradingDetailTableView.mj_footer.state = MJRefreshStateNoMoreData;
        
    }
}



#pragma mark - MJRefresh
- (void)setMJRefreshConfig:(UITableView *)tableView{
    
    MJRefreshNormalHeader     *header;
    header = [MJRefreshNormalHeader  headerWithRefreshingTarget:self refreshingAction:@selector(evokeSouceData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    [header setTitle:@"下拉刷新"  forState:MJRefreshStateIdle];
    [header setTitle:@"释放更新"  forState:MJRefreshStatePulling];
    [header setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    tableView.mj_header = header;
    
    
    
    MJRefreshBackNormalFooter *footer;
    footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreSouceData)];
    [footer setTitle:mj_footTitle forState:MJRefreshStateNoMoreData];
    tableView.mj_footer = footer;
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




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end
