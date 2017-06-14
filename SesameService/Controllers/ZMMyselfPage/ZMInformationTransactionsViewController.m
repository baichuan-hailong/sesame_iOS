//
//  ZMInformationTransactionsViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/21.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMInformationTransactionsViewController.h"
#import "ZMInformationTranView.h"
#import "ZMInformationTranTableViewCell.h"

#import "ZMMySellViewController.h"
#import "ZMMyBuyViewController.h"

@interface ZMInformationTransactionsViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    BOOL isLeftBool;
    
    NSInteger leftCurrentPage;
    NSInteger leftTotalCount;
    
    NSInteger rightCurrentPage;
    NSInteger rightTotalCount;
}

@property(nonatomic,strong)ZMInformationTranView *sounceView;
@property(nonatomic,strong)NSMutableArray *leftMutableArray;
@property(nonatomic,strong)NSMutableArray *rightMutableArray;
@end

@implementation ZMInformationTransactionsViewController

-(void)loadView{
    
    self.sounceView = [[ZMInformationTranView alloc] initWithFrame:SCREEN_BOUNDS];
    self.sounceView.bottomScrollView.delegate = self;
    self.sounceView.leftTableView.delegate    = self;
    self.sounceView.leftTableView.dataSource  = self;
    self.sounceView.rightTableView.delegate   = self;
    self.sounceView.rightTableView.dataSource = self;
    self.view       = self.sounceView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的信息交易";
    [self addAction];
    
    
    isLeftBool = YES;
    

    [self setMJRefreshConfig:self.sounceView.leftTableView];
    [self setMJRefreshConfig:self.sounceView.rightTableView];
    
    
    [self.sounceView.leftTableView.mj_header beginRefreshing];
    
    //have poset evaluation 评价成功
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(postEvaluationSuccessful:)
                                                 name:@"postEvaluationSuccessful"
                                               object:nil];
    
    //取消发布
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(cancleFabuSuccessful:)
                                                 name:@"cancleFabuSuccessful"
                                               object:nil];
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"cancleFabuSuccessful" object:infoDic];
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"fabuAgainSuccessful" object:infoDic];
    //再次发布
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(fabuAgainSuccessful:)
                                                 name:@"fabuAgainSuccessful"
                                               object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    if (_isPaySuccJump) {
        [self rightButtonAction:nil];
        
        NSLog(@"right");
        NSDictionary *rightDic = self.rightMutableArray[0];
        ZMMyBuyViewController *buyVC = [[ZMMyBuyViewController alloc] init];
        buyVC.buyID = [NSString stringWithFormat:@"%@",rightDic[@"id"]];
        buyVC.states = [NSString stringWithFormat:@"%@",rightDic[@"status"]];
        [self.navigationController pushViewController:buyVC animated:YES];
    }
}

#pragma mark - 再次发布
- (void)fabuAgainSuccessful:(NSNotification *)noti{
    [noti object];
    NSDictionary *dic = (NSDictionary *)[noti object];
    NSLog(@"Infomation -- infoDic --- %@",dic);
    NSString *infoID = [NSString stringWithFormat:@"%@",dic[@"infoID"]];
    
    
    for (int i=0; i<self.leftMutableArray.count; i++) {
        NSDictionary *rightDic = self.leftMutableArray[i];
        NSString *rightID      = [NSString stringWithFormat:@"%@",rightDic[@"id"]];
        if ([infoID integerValue]==[rightID integerValue]) {
            [self.leftMutableArray removeObjectAtIndex:i];
            
            NSMutableDictionary *temDic = [NSMutableDictionary dictionaryWithDictionary:rightDic];
            [temDic setObject:@"submit_pending" forKey:@"status"];
            [temDic setObject:@"发布中" forKey:@"status_title"];
            [self.leftMutableArray insertObject:temDic atIndex:i];
        }
    }
    
    [self.sounceView.leftTableView reloadData];
}

#pragma mark - 取消发布
- (void)cancleFabuSuccessful:(NSNotification *)noti{
    [noti object];
    NSDictionary *dic = (NSDictionary *)[noti object];
    NSLog(@"Infomation -- infoDic --- %@",dic);
    NSString *infoID = [NSString stringWithFormat:@"%@",dic[@"infoID"]];
    
    
    for (int i=0; i<self.leftMutableArray.count; i++) {
        NSDictionary *rightDic = self.leftMutableArray[i];
        NSString *rightID      = [NSString stringWithFormat:@"%@",rightDic[@"id"]];
        if ([infoID integerValue]==[rightID integerValue]) {
            [self.leftMutableArray removeObjectAtIndex:i];
            
            NSMutableDictionary *temDic = [NSMutableDictionary dictionaryWithDictionary:rightDic];
            [temDic setObject:@"cancel_die" forKey:@"status"];
            [temDic setObject:@"已取消" forKey:@"status_title"];
            [self.leftMutableArray insertObject:temDic atIndex:i];
        }
    }
    
    [self.sounceView.leftTableView reloadData];
}

#pragma mark - 评价成功
- (void)postEvaluationSuccessful:(NSNotification *)noti{
    [noti object];
    NSDictionary *dic = (NSDictionary *)[noti object];
    NSLog(@"Infomation -- infoDic --- %@",dic);
    NSString *infoID = [NSString stringWithFormat:@"%@",dic[@"infoID"]];
    


    for (int i=0; i<self.rightMutableArray.count; i++) {
        NSDictionary *rightDic = self.rightMutableArray[i];
        NSString *rightID      = [NSString stringWithFormat:@"%@",rightDic[@"id"]];
        if ([infoID integerValue]==[rightID integerValue]) {
            [self.rightMutableArray removeObjectAtIndex:i];
            
            NSMutableDictionary *temDic = [NSMutableDictionary dictionaryWithDictionary:rightDic];
            [temDic setObject:@"rate_done" forKey:@"status"];
            [temDic setObject:@"已评价" forKey:@"status_title"];
            [self.rightMutableArray insertObject:temDic atIndex:i];
        }
    }
    
    [self.sounceView.rightTableView reloadData];
}






- (void)addAction{
    
    [self.sounceView.lefrButton addTarget:self action:@selector(lefrButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.sounceView.rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - left&right
- (void)lefrButtonAction:(UIButton *)sender{
    [self.sounceView.rightTableView setContentOffset:CGPointMake(0, 0) animated:NO];
    isLeftBool = YES;
    NSLog(@"left");
    if (self.leftMutableArray.count==0) {
        [self.sounceView.leftTableView.mj_header beginRefreshing];
    }
    [self.sounceView.lefrButton setTitleColor:[UIColor colorWithHex:tonalColor] forState:UIControlStateNormal];
    [self.sounceView.rightButton setTitleColor:[UIColor colorWithHex:@"999999"] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.38 animations:^{
        [self.sounceView.bottomScrollView setContentOffset:CGPointMake(0, 0)];
        self.sounceView.tipLine.frame = CGRectMake(0, CGRectGetMaxY(self.sounceView.lefrButton.frame), SCREEN_WIDTH/2, SCREEN_WIDTH/375*3);
    }];
}

- (void)rightButtonAction:(UIButton *)sender{
    [self.sounceView.leftTableView setContentOffset:CGPointMake(0, 0) animated:NO];
    isLeftBool = NO;
    if (self.rightMutableArray.count==0) {
        [self.sounceView.rightTableView.mj_header beginRefreshing];
    }
    NSLog(@"right");
    [self.sounceView.lefrButton setTitleColor:[UIColor colorWithHex:@"999999"] forState:UIControlStateNormal];
    [self.sounceView.rightButton setTitleColor:[UIColor colorWithHex:tonalColor] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.38 animations:^{
        [self.sounceView.bottomScrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0)];
        self.sounceView.tipLine.frame = CGRectMake(SCREEN_WIDTH/2, CGRectGetMaxY(self.sounceView.lefrButton.frame), SCREEN_WIDTH/2, SCREEN_WIDTH/375*3);
    }];
}

#pragma mark - Scroll Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (![scrollView isKindOfClass:[UITableView class]]) {
        NSLog(@"1");
        if (scrollView.mj_offsetX>0) {
            [self rightButtonAction:nil];
        }else{
            [self lefrButtonAction:nil];
        }
    }
    NSLog(@"%f",scrollView.mj_offsetX);
}

#pragma mark - Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag==1026) {
        return self.leftMutableArray.count;
    }else{
        return self.rightMutableArray.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag==1026) {
        return SCREEN_WIDTH/375*100;
    }else{
        return SCREEN_WIDTH/375*100;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return SCREEN_WIDTH/375*20;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footView         = [[UIView alloc] init];
    footView.backgroundColor = [UIColor clearColor];
    return footView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return SCREEN_WIDTH/375*10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *footView         = [[UIView alloc] init];
    footView.backgroundColor = [UIColor clearColor];
    return footView;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *leftIndentifire         = @"leftSelectCell";
    static NSString *rightIndentifire        = @"rightSelectCell";
    
    if (tableView.tag==1026) {
        NSDictionary *leftDic = self.leftMutableArray[indexPath.row];
        ZMInformationTranTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:leftIndentifire];
        if (!cell) {
            cell = [[ZMInformationTranTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:leftIndentifire];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (indexPath.row==self.leftMutableArray.count-1) {
            cell.line.alpha = 0;
        }else{
            cell.line.alpha = 1;
        }
        [cell setInfoTran:leftDic isLeft:YES];
        return cell;
    }else{
        NSDictionary *rightDic = self.rightMutableArray[indexPath.row];
        ZMInformationTranTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rightIndentifire];
        if (!cell) {
            cell = [[ZMInformationTranTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rightIndentifire];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (indexPath.row==self.rightMutableArray.count-1) {
            cell.line.alpha = 0;
        }else{
            cell.line.alpha = 1;
        }
        [cell setInfoTran:rightDic isLeft:NO];
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView.tag==1026) {
        NSLog(@"left");
        NSDictionary *leftDic = self.leftMutableArray[indexPath.row];
        ZMMySellViewController *sellVC = [[ZMMySellViewController alloc] init];
        sellVC.sellID = [NSString stringWithFormat:@"%@",leftDic[@"id"]];
        sellVC.states = [NSString stringWithFormat:@"%@",leftDic[@"status"]];
        [self.navigationController pushViewController:sellVC animated:YES];
    }else{
        NSLog(@"right");
        NSDictionary *rightDic = self.rightMutableArray[indexPath.row];
        ZMMyBuyViewController *buyVC = [[ZMMyBuyViewController alloc] init];
        buyVC.buyID = [NSString stringWithFormat:@"%@",rightDic[@"id"]];
        buyVC.states = [NSString stringWithFormat:@"%@",rightDic[@"status"]];
        [self.navigationController pushViewController:buyVC animated:YES];
    }
}




#pragma mark - Load Data
//left
- (void)evokeLeftSouceData{
    leftCurrentPage = 1;
    
    NSDictionary *parm = @{@"page":@"1"};
    NSString *urlStr   = [NSString stringWithFormat:@"%@/info/my-sell-business-lists",APIDev];
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:parm withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"left --- %@",object);
        NSLog(@"%@",object[@"status"][@"message"]);
        
        self.sounceView.leftTableView.mj_footer.state = MJRefreshStateIdle;
        
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            
            [self.leftMutableArray removeAllObjects];
            self.leftMutableArray = [NSMutableArray arrayWithArray:object[@"data"][@"items"]];
            if (_leftMutableArray.count>0) {
                [self.sounceView.leftTableView reloadData];
            }else{
                ZMEmptyView *emptyView = [[ZMEmptyView alloc] initWithFrame:SCREEN_BOUNDS];
                [emptyView setBottomTitle:@"暂无信息"];
                self.sounceView.leftTableView.tableHeaderView = emptyView;
            }
            
            
            
            leftTotalCount = [[NSString stringWithFormat:@"%@",object[@"data"][@"total"]] integerValue];
            leftCurrentPage= 2;
        }else{
            [self showProgress:object[@"status"][@"message"]];
        }
        [self.sounceView.leftTableView.mj_header endRefreshing];
    } withFailureBlock:^(NSError *error) {
        [self.sounceView.leftTableView.mj_header endRefreshing];
        NSLog(@"%@",error);
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}

- (void)loadMoreLeftSouceData{
    if (self.leftMutableArray.count<leftTotalCount) {
        NSString *currentPageStr = [NSString stringWithFormat:@"%ld",(long)leftCurrentPage];
        NSDictionary *parm = @{@"page":currentPageStr};
        NSString *urlStr   = [NSString stringWithFormat:@"%@/info/my-sell-business-lists",APIDev];
        [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:parm withSuccessBlock:^(NSDictionary *object) {
            NSLog(@"%@",object);
            NSLog(@"%@",object[@"status"][@"message"]);
            
            NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
            if ([stateStr isEqualToString:@"success"]) {
                [self.leftMutableArray addObjectsFromArray:object[@"data"][@"items"]];
                if (self.leftMutableArray.count<leftTotalCount) {
                    leftCurrentPage++;
                }
                [self.sounceView.leftTableView reloadData];
                
            }else{
                [self showProgress:object[@"status"][@"message"]];
            }
            [self.sounceView.leftTableView.mj_footer endRefreshing];
        } withFailureBlock:^(NSError *error) {
            [self.sounceView.leftTableView.mj_footer endRefreshing];
            NSLog(@"%@",error);
        } progress:^(float progress) {
            NSLog(@"%f",progress);
        }];
    }else{
        //[self.sounceView.leftTableView.mj_footer endRefreshing];
        self.sounceView.leftTableView.mj_footer.state = MJRefreshStateNoMoreData;
    }
}

//right
- (void)evokeRightSouceData{
    rightCurrentPage = 1;
    
    NSDictionary *parm = @{@"page":@"1"};
    NSString *urlStr   = [NSString stringWithFormat:@"%@/info/my-buy-business-lists",APIDev];
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:parm withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"right --- %@",object);
        NSLog(@"%@",object[@"status"][@"message"]);
        
        self.sounceView.rightTableView.mj_footer.state = MJRefreshStateIdle;
        
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            [self.rightMutableArray removeAllObjects];
            self.rightMutableArray = [NSMutableArray arrayWithArray:object[@"data"][@"items"]];
           
            if (_rightMutableArray.count>0) {
                [self.sounceView.rightTableView reloadData];
            }else{
                ZMEmptyView *emptyView = [[ZMEmptyView alloc] initWithFrame:SCREEN_BOUNDS];
                [emptyView setBottomTitle:@"暂无信息"];
                self.sounceView.rightTableView.tableHeaderView = emptyView;
            }
            
            rightTotalCount = [[NSString stringWithFormat:@"%@",object[@"data"][@"total"]] integerValue];
            rightCurrentPage= 2;
        }else{
            [self showProgress:object[@"status"][@"message"]];
        }
        [self.sounceView.rightTableView.mj_header endRefreshing];
    } withFailureBlock:^(NSError *error) {
        [self.sounceView.rightTableView.mj_header endRefreshing];
        NSLog(@"%@",error);
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}

- (void)loadMoreRightSouceData{
    if (self.rightMutableArray.count<rightTotalCount) {
        NSString *currentPageStr = [NSString stringWithFormat:@"%ld",(long)rightCurrentPage];
        
        NSDictionary *parm = @{@"page":currentPageStr};
        
        NSString *urlStr   = [NSString stringWithFormat:@"%@/info/my-buy-business-lists",APIDev];
        [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:parm withSuccessBlock:^(NSDictionary *object) {
            NSLog(@"%@",object);
            NSLog(@"%@",object[@"status"][@"message"]);
            
            NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
            if ([stateStr isEqualToString:@"success"]) {
                [self.rightMutableArray addObjectsFromArray:object[@"data"][@"items"]];
                if (self.rightMutableArray.count<rightTotalCount) {
                    rightCurrentPage++;
                }
                [self.sounceView.rightTableView reloadData];
            }else{
                [self showProgress:object[@"status"][@"message"]];
            }
            [self.sounceView.rightTableView.mj_footer endRefreshing];
        } withFailureBlock:^(NSError *error) {
            [self.sounceView.rightTableView.mj_footer endRefreshing];
            NSLog(@"%@",error);
        } progress:^(float progress) {
            NSLog(@"%f",progress);
        }];
    }else{
        //[self.sounceView.rightTableView.mj_footer endRefreshing];
        self.sounceView.rightTableView.mj_footer.state = MJRefreshStateNoMoreData;
    }
}






#pragma mark - MJRefresh
- (void)setMJRefreshConfig:(UITableView *)tableView{
    
    MJRefreshNormalHeader     *header;
    if (tableView.tag==1026) {
        header = [MJRefreshNormalHeader     headerWithRefreshingTarget:self refreshingAction:@selector(evokeLeftSouceData)];
    }else{
        header = [MJRefreshNormalHeader     headerWithRefreshingTarget:self refreshingAction:@selector(evokeRightSouceData)];
    }
    header.lastUpdatedTimeLabel.hidden = YES;
    [header setTitle:@"下拉刷新"  forState:MJRefreshStateIdle];
    [header setTitle:@"释放更新"  forState:MJRefreshStatePulling];
    [header setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    tableView.mj_header = header;
    
    
    
    MJRefreshBackNormalFooter *footer;
    if (tableView.tag==1026) {
        footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreLeftSouceData)];
    }else{
        footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreRightSouceData)];
    }
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
