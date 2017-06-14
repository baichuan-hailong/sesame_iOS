//
//  ZMCommissionViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/21.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMCommissionViewController.h"
#import "ZMCommissionView.h"
#import "ZMCommissionTableViewCell.h"
#import "ZMCommissionOnGoingTableViewCell.h"

#import "ZMCommissionDetailViewController.h"

@interface ZMCommissionViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    BOOL isLeftBool;
    
    NSInteger leftCurrentPage;
    NSInteger leftTotalCount;
    
    NSInteger rightCurrentPage;
    NSInteger rightTotalCount;
}
@property(nonatomic,strong)ZMCommissionView *sounceView;
@property(nonatomic,strong)NSMutableArray *leftMutableArray;
@property(nonatomic,strong)NSMutableArray *rightMutableArray;
@end

@implementation ZMCommissionViewController


-(void)loadView{
    self.sounceView = [[ZMCommissionView alloc] initWithFrame:SCREEN_BOUNDS];
    self.sounceView.bottomScrollView.delegate = self;
    self.sounceView.leftTableView.delegate    = self;
    self.sounceView.leftTableView.dataSource  = self;
    self.sounceView.rightTableView.delegate   = self;
    self.sounceView.rightTableView.dataSource = self;
    self.view       = self.sounceView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的佣金交易";
    [self addAction];
    
    isLeftBool = YES;
    
    [self setMJRefreshConfig:self.sounceView.leftTableView];
    [self setMJRefreshConfig:self.sounceView.rightTableView];
    
    
    [self.sounceView.leftTableView.mj_header beginRefreshing];
    
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"finishSignNotifiAc" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(finishSignNotifiAc)
                                                 name:@"finishSignNotifiAc"
                                               object:nil];
    
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"finishFeedBackNotifiAc" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(finishFeedBackNotifiAc)
                                                 name:@"finishFeedBackNotifiAc"
                                               object:nil];
    
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"BackRefreshNotifiAc" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(BackRefreshNotifiAc)
                                                 name:@"BackRefreshNotifiAc"
                                               object:nil];
}


#pragma mark - Refresh
- (void)BackRefreshNotifiAc{
    
    if (isLeftBool) {
        [self.sounceView.leftTableView.mj_header beginRefreshing];
    }else{
        [self.sounceView.rightTableView.mj_header beginRefreshing];
    }
}



#pragma mark - Sign Successful
- (void)finishSignNotifiAc{
    
    if (isLeftBool) {
        [self.sounceView.leftTableView.mj_header beginRefreshing];
    }else{
        [self.sounceView.rightTableView.mj_header beginRefreshing];
    }
}

#pragma mark - feedBack Successful
- (void)finishFeedBackNotifiAc{
    
    if (isLeftBool) {
        [self.sounceView.leftTableView.mj_header beginRefreshing];
    }else{
        [self.sounceView.rightTableView.mj_header beginRefreshing];
    }
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView.tag==626) {
        return self.leftMutableArray.count;
    }else{
        return self.rightMutableArray.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag==626) {
        
        NSDictionary *leftDic = self.leftMutableArray[indexPath.section];
        NSString *note = [NSString stringWithFormat:@"%@",leftDic[@"status_note"][@"note"]];
        if (note.length>0&&![note isEqualToString:@"(null)"]) {
        
            return SCREEN_WIDTH/375*135;
        }else{
            return SCREEN_WIDTH/375*113;
        }
        
        
    }else{
        NSDictionary *rightDic = self.rightMutableArray[indexPath.section];
        NSString *note = [NSString stringWithFormat:@"%@",rightDic[@"status_note"][@"note"]];
        if (note.length>0&&![note isEqualToString:@"(null)"]) {
            return SCREEN_WIDTH/375*135;
        }else{
            return SCREEN_WIDTH/375*113;
        }
    
    }
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return SCREEN_WIDTH/375*13;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *footView         = [[UIView alloc] init];
    footView.backgroundColor = [UIColor clearColor];
    return footView;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *leftIndentifire         = @"leftSelectCell";
    static NSString *rightIndentifire        = @"rightSelectCell";
    
    static NSString *leftOngoIndentifire         = @"leftOngoSelectCell";
    static NSString *rightOngoIndentifire        = @"rightOngoSelectCell";
    
    if (tableView.tag==626) {
        
        NSDictionary *leftDic = self.leftMutableArray[indexPath.section];
        NSString *note = [NSString stringWithFormat:@"%@",leftDic[@"status_note"][@"note"]];
        if (note.length>0&&![note isEqualToString:@"(null)"]) {
            ZMCommissionOnGoingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:leftOngoIndentifire];
            if (!cell) {
                cell = [[ZMCommissionOnGoingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:leftOngoIndentifire];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            [cell setCommission:leftDic isLeft:YES isCom:YES];
            return cell;
        }else{
            ZMCommissionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:leftIndentifire];
            if (!cell) {
                cell = [[ZMCommissionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:leftIndentifire];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            [cell setCommission:leftDic isLeft:YES isCom:YES];
            return cell;
        }
        
        
    }else{
        
        
        NSDictionary *rightDic = self.rightMutableArray[indexPath.section];
        NSString *note = [NSString stringWithFormat:@"%@",rightDic[@"status_note"][@"note"]];
        if (note.length>0&&![note isEqualToString:@"(null)"]) {
            ZMCommissionOnGoingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rightOngoIndentifire];
            if (!cell) {
                cell = [[ZMCommissionOnGoingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rightOngoIndentifire];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            [cell setCommission:rightDic isLeft:NO isCom:YES];
            
            return cell;
        }else{
            ZMCommissionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rightIndentifire];
            if (!cell) {
                cell = [[ZMCommissionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rightIndentifire];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            [cell setCommission:rightDic isLeft:NO isCom:YES];
            
            return cell;
        }
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (tableView.tag==626) {
        NSLog(@"left");
        NSDictionary *leftDic = self.leftMutableArray[indexPath.section];
        ZMCommissionDetailViewController *commissionDetailVC = [[ZMCommissionDetailViewController alloc] init];
        commissionDetailVC.commissionID = [NSString stringWithFormat:@"%@",leftDic[@"id"]];
        commissionDetailVC.isCom        = YES;
        [self.navigationController pushViewController:commissionDetailVC animated:YES];
    }else{
        NSLog(@"right");
        NSDictionary *rightDic = self.rightMutableArray[indexPath.section];
        ZMCommissionDetailViewController *commissionDetailVC = [[ZMCommissionDetailViewController alloc] init];
        commissionDetailVC.commissionID = [NSString stringWithFormat:@"%@",rightDic[@"id"]];
        commissionDetailVC.isCom = NO;
        //commissionDetailVC.isGoing=YES;
        [self.navigationController pushViewController:commissionDetailVC animated:YES];
    }
    
}





#pragma mark - Load Data
//left
- (void)evokeLeftSouceData{
    leftCurrentPage = 1;
    
    NSDictionary *parm = @{@"page":@"1"};
    NSString *urlStr   = [NSString stringWithFormat:@"%@/info/my-commit-commission-lists",APIDev];
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:parm withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"left --- %@",object);
        NSLog(@"%@",object[@"status"][@"message"]);
        
        self.sounceView.leftTableView.mj_footer.state = MJRefreshStateIdle;
        
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            
            [self.leftMutableArray removeAllObjects];
            self.leftMutableArray = [NSMutableArray arrayWithArray:object[@"data"][@"items"]];
            
            
            if (self.leftMutableArray.count>0) {
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
        NSString *urlStr   = [NSString stringWithFormat:@"%@/info/my-commit-commission-lists",APIDev];
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
    NSString *urlStr   = [NSString stringWithFormat:@"%@/info/my-accept-commission-lists",APIDev];
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:parm withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"right --- %@",object);
        NSLog(@"%@",object[@"status"][@"message"]);
        
        self.sounceView.rightTableView.mj_footer.state = MJRefreshStateIdle;
        
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            [self.rightMutableArray removeAllObjects];
            self.rightMutableArray = [NSMutableArray arrayWithArray:object[@"data"][@"items"]];
            
            if (self.rightMutableArray.count>0) {
                
                //bug
                [self.sounceView.rightTableView.tableHeaderView removeFromSuperview];
                self.sounceView.rightTableView.tableHeaderView = nil;
                
                
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
        
        NSString *urlStr   = [NSString stringWithFormat:@"%@/info/my-accept-commission-lists",APIDev];
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
    if (tableView.tag==626) {
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
    if (tableView.tag==626) {
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
