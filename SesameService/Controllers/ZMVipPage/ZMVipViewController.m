//
//  ZMVipViewController.m
//  SesameService
//
//  Created by 娄耀文 on 17/3/22.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMVipViewController.h"
#import "ZMVipView.h"

#import "ZMPersonalVipTableViewCell.h"
#import "ZMCompanyVipTableViewCell.h"

#import "ZMPersonalVipViewController.h"
#import "ZMCompanyVipViewController.h"

@interface ZMVipViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

{
    BOOL isLeftBool;
    
    NSInteger leftCurrentPage;
    NSInteger leftTotalCount;
    
    NSInteger rightCurrentPage;
    NSInteger rightTotalCount;
}
@property (nonatomic,strong)ZMVipView     *vipView;
@property(nonatomic,strong)NSMutableArray *leftMutableArray;
@property(nonatomic,strong)NSMutableArray *rightMutableArray;


@property(nonatomic,strong)MBProgressHUD *HUD;

@property(nonatomic,strong)NSArray *tagArray;
@end

@implementation ZMVipViewController

-(void)loadView{
    self.vipView = [[ZMVipView alloc] initWithFrame:SCREEN_BOUNDS];
    self.vipView.bottomScrollView.delegate = self;
    self.vipView.leftTableView.delegate = self;
    self.vipView.leftTableView.dataSource = self;
    self.vipView.rightTableView.delegate = self;
    self.vipView.rightTableView.dataSource = self;
    
    
    self.view = self.vipView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"会员名录";
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.interactivePopGestureRecognizer.enabled  = YES;
    
    [self addAction];
    
    isLeftBool = YES;
    
    
    
    [self setMJRefreshConfig:self.vipView.leftTableView];
    [self setMJRefreshConfig:self.vipView.rightTableView];
    
    
    [self observeProjectTag];
    
}


#pragma mark - 业务类型
- (void)observeProjectTag{
    
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self.HUD];
    [self.HUD show:YES];
    
    NSString *urlStr   = [NSString stringWithFormat:@"%@/common/project-tag",APIDev];
    
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:nil withSuccessBlock:^(NSDictionary *object) {
        
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            self.tagArray = [NSArray arrayWithArray:object[@"data"]];
            NSLog(@"%@",self.tagArray);
            
            [self.vipView.leftTableView.mj_header beginRefreshing];
        }else{
            [self showProgress:object[@"status"][@"message"]];
        }
        
        [self.HUD hide:YES];
    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
        [self.HUD hide:YES];
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}




- (void)addAction{
    
    [self.vipView.lefrButton addTarget:self action:@selector(lefrButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.vipView.rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];    
}



#pragma mark - left&right
- (void)lefrButtonAction:(UIButton *)sender{
    [self.vipView.rightTableView setContentOffset:CGPointMake(0, 0) animated:NO];
    NSLog(@"left");
    if (self.leftMutableArray.count==0) {
        [self.vipView.leftTableView.mj_header beginRefreshing];
    }
    isLeftBool = YES;
    [self.vipView.lefrButton setTitleColor:[UIColor colorWithHex:tonalColor] forState:UIControlStateNormal];
    [self.vipView.rightButton setTitleColor:[UIColor colorWithHex:@"999999"] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.38 animations:^{
        [self.vipView.bottomScrollView setContentOffset:CGPointMake(0, 0)];
        self.vipView.tipLine.frame = CGRectMake(0, CGRectGetMaxY(self.vipView.lefrButton.frame), SCREEN_WIDTH/2, SCREEN_WIDTH/375*3);
    }];
}

- (void)rightButtonAction:(UIButton *)sender{
    [self.vipView.leftTableView setContentOffset:CGPointMake(0, 0) animated:NO];
    
    if (self.rightMutableArray.count==0) {
        [self.vipView.rightTableView.mj_header beginRefreshing];
    }
    NSLog(@"right");
    isLeftBool = NO;
    [self.vipView.lefrButton setTitleColor:[UIColor colorWithHex:@"999999"] forState:UIControlStateNormal];
    [self.vipView.rightButton setTitleColor:[UIColor colorWithHex:tonalColor] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.38 animations:^{
        [self.vipView.bottomScrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0)];
        self.vipView.tipLine.frame = CGRectMake(SCREEN_WIDTH/2, CGRectGetMaxY(self.vipView.lefrButton.frame), SCREEN_WIDTH/2, SCREEN_WIDTH/375*3);
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
    
    if (tableView.tag==1010) {
        return self.leftMutableArray.count;
    }else{
        return self.rightMutableArray.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag==1010) {
        return SCREEN_WIDTH/375*90;
    }else{
        return SCREEN_WIDTH/375*90;
    }
}

/***header**/
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return SCREEN_WIDTH/375*13;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *footView         = [[UIView alloc] init];
    footView.backgroundColor = [UIColor clearColor];
    return footView;
}

/***footer**/
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return SCREEN_WIDTH/375*0+SCREEN_WIDTH/375*0;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footView         = [[UIView alloc] init];
    footView.backgroundColor = [UIColor clearColor];
    return footView;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *personalcellIndentifire = @"personalcellIndentifire";
    static NSString *companycellIndentifire  = @"companycellIndentifire";
    
    if (tableView.tag==1011) {
        NSDictionary *personDic = self.rightMutableArray[indexPath.row];
        ZMPersonalVipTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:personalcellIndentifire];
        if (!cell) {
            cell = [[ZMPersonalVipTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:personalcellIndentifire];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell setPersonVip:personDic mainBizArray:self.tagArray];
        return cell;
    }else{
        
        NSDictionary *companyDic = self.leftMutableArray[indexPath.row];
        ZMCompanyVipTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:companycellIndentifire];
        if (!cell) {
            cell = [[ZMCompanyVipTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:companycellIndentifire];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell setCompanyVip:companyDic mainBizArray:self.tagArray];
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView.tag==1010) {
        //NSLog(@"left");
        NSDictionary *companyDic = self.leftMutableArray[indexPath.row];
        NSString *companyID     = [NSString stringWithFormat:@"%@",companyDic[@"id"]];
        ZMCompanyVipViewController *companyVipVC = [[ZMCompanyVipViewController alloc] init];
        [companyVipVC setHidesBottomBarWhenPushed:YES];
        companyVipVC.companyID = companyID;
        companyVipVC.mainBizArray = self.tagArray;
        [self.navigationController pushViewController:companyVipVC animated:YES];
    }else{
        //NSLog(@"right");
        NSDictionary *personDic = self.rightMutableArray[indexPath.row];
        NSString *persionID     = [NSString stringWithFormat:@"%@",personDic[@"id"]];
        ZMPersonalVipViewController *personalVipVC = [[ZMPersonalVipViewController alloc] init];
        [personalVipVC setHidesBottomBarWhenPushed:YES];
        personalVipVC.personID = persionID;
        personalVipVC.mainBizArray = self.tagArray;
        [self.navigationController pushViewController:personalVipVC animated:YES];
    }
}





#pragma mark - Load Data
//left
- (void)evokeLeftSouceData{
    leftCurrentPage = 1;
    
    NSDictionary *parm = @{@"type":@"2",
                           @"page":@"1"};
    NSString *urlStr   = [NSString stringWithFormat:@"%@/user/lists",APIDev];
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:parm withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"left --- %@",object);
        NSLog(@"%@",object[@"status"][@"message"]);
        
        self.vipView.leftTableView.mj_footer.state = MJRefreshStateIdle;
        
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            
            [self.leftMutableArray removeAllObjects];
            self.leftMutableArray = [NSMutableArray arrayWithArray:object[@"data"][@"items"]];
            
            if (self.leftMutableArray.count>0) {
                
                //bug
                [self.vipView.leftTableView.tableHeaderView removeFromSuperview];
                self.vipView.leftTableView.tableHeaderView = nil;
                
                
                [self.vipView.leftTableView reloadData];
            }else{
                ZMEmptyView *emptyView = [[ZMEmptyView alloc] initWithFrame:SCREEN_BOUNDS];
                [emptyView setBottomTitle:@"暂无信息"];
                self.vipView.leftTableView.tableHeaderView = emptyView;
            }
            
            leftTotalCount = [[NSString stringWithFormat:@"%@",object[@"data"][@"total"]] integerValue];
            leftCurrentPage= 2;
        }else{
            [self showProgress:object[@"status"][@"message"]];
        }
        [self.vipView.leftTableView.mj_header endRefreshing];
    } withFailureBlock:^(NSError *error) {
        [self.vipView.leftTableView.mj_header endRefreshing];
        NSLog(@"%@",error);
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}

- (void)loadMoreLeftSouceData{
    if (self.leftMutableArray.count<leftTotalCount) {
        NSString *currentPageStr = [NSString stringWithFormat:@"%ld",(long)leftCurrentPage];
        
        NSDictionary *parm = @{@"type":@"2",
                               @"page":currentPageStr};
        NSString *urlStr   = [NSString stringWithFormat:@"%@/user/lists",APIDev];
        [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:parm withSuccessBlock:^(NSDictionary *object) {
            NSLog(@"%@",object);
            NSLog(@"%@",object[@"status"][@"message"]);
            
            NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
            if ([stateStr isEqualToString:@"success"]) {
                [self.leftMutableArray addObjectsFromArray:object[@"data"][@"items"]];
                if (self.leftMutableArray.count<leftTotalCount) {
                    leftCurrentPage++;
                }
                [self.vipView.leftTableView reloadData];
                
            }else{
                [self showProgress:object[@"status"][@"message"]];
            }
            [self.vipView.leftTableView.mj_footer endRefreshing];
        } withFailureBlock:^(NSError *error) {
            [self.vipView.leftTableView.mj_footer endRefreshing];
            NSLog(@"%@",error);
        } progress:^(float progress) {
            NSLog(@"%f",progress);
        }];
    }else{
        //[self.vipView.leftTableView.mj_footer endRefreshing];
        self.vipView.leftTableView.mj_footer.state = MJRefreshStateNoMoreData;
    }
}

//right
- (void)evokeRightSouceData{
    rightCurrentPage = 1;
    
    NSDictionary *parm = @{@"type":@"1",
                           @"page":@"1"};
    NSString *urlStr   = [NSString stringWithFormat:@"%@/user/lists",APIDev];
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:parm withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"right --- %@",object);
        NSLog(@"%@",object[@"status"][@"message"]);
        
        self.vipView.rightTableView.mj_footer.state = MJRefreshStateIdle;
        
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            [self.rightMutableArray removeAllObjects];
            self.rightMutableArray = [NSMutableArray arrayWithArray:object[@"data"][@"items"]];
            
            if (self.rightMutableArray.count>0) {
                
                //bug
                [self.vipView.rightTableView.tableHeaderView removeFromSuperview];
                self.vipView.rightTableView.tableHeaderView = nil;
                
                
                [self.vipView.rightTableView reloadData];
            }else{
                ZMEmptyView *emptyView = [[ZMEmptyView alloc] initWithFrame:SCREEN_BOUNDS];
                [emptyView setBottomTitle:@"暂无信息"];
                self.vipView.rightTableView.tableHeaderView = emptyView;
            }
            
            rightTotalCount = [[NSString stringWithFormat:@"%@",object[@"data"][@"total"]] integerValue];
            rightCurrentPage= 2;
        }else{
            [self showProgress:object[@"status"][@"message"]];
        }
        [self.vipView.rightTableView.mj_header endRefreshing];
    } withFailureBlock:^(NSError *error) {
        [self.vipView.rightTableView.mj_header endRefreshing];
        NSLog(@"%@",error);
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}

- (void)loadMoreRightSouceData{
    if (self.rightMutableArray.count<rightTotalCount) {
        NSString *currentPageStr = [NSString stringWithFormat:@"%ld",(long)rightCurrentPage];
        
        NSDictionary *parm = @{@"type":@"1",
                               @"page":currentPageStr};
        
        NSString *urlStr   = [NSString stringWithFormat:@"%@/user/lists",APIDev];
        [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:parm withSuccessBlock:^(NSDictionary *object) {
            NSLog(@"%@",object);
            NSLog(@"%@",object[@"status"][@"message"]);
            
            NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
            if ([stateStr isEqualToString:@"success"]) {
                [self.rightMutableArray addObjectsFromArray:object[@"data"][@"items"]];
                if (self.rightMutableArray.count<rightTotalCount) {
                    rightCurrentPage++;
                }
                [self.vipView.rightTableView reloadData];
            }else{
                [self showProgress:object[@"status"][@"message"]];
            }
            [self.vipView.rightTableView.mj_footer endRefreshing];
        } withFailureBlock:^(NSError *error) {
            [self.vipView.rightTableView.mj_footer endRefreshing];
            NSLog(@"%@",error);
        } progress:^(float progress) {
            NSLog(@"%f",progress);
        }];
    }else{
        //[self.vipView.rightTableView.mj_footer endRefreshing];
        self.vipView.rightTableView.mj_footer.state = MJRefreshStateNoMoreData;
    }
}







- (void)setMJRefreshConfig:(UITableView *)tableView{
    
    MJRefreshNormalHeader     *header;
    if (tableView.tag==1010) {
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
    if (tableView.tag==1010) {
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
