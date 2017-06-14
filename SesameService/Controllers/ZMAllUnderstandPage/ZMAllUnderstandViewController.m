//
//  ZMAllUnderstandViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/6.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMAllUnderstandViewController.h"
#import "ZMAllUnderStandDetailViewController.h"
#import "ZMAllUnderstandView.h"

#import "ZMAllUnderstandLeftTableViewCell.h"
#import "ZMAllUnderstandRIghtTableViewCell.h"
#import "ZMAllUnderstandRightAudioTableViewCell.h"

#import "ZMUnderstandViewController.h"

@interface ZMAllUnderstandViewController ()<UIScrollViewDelegate,
                                            UITableViewDelegate,
                                            UITableViewDataSource>
{
    
    NSInteger leftCurrentPage;
    NSInteger leftTotalCount;
    
    NSInteger rightCurrentPage;
    NSInteger rightTotalCount;
}
@property(nonatomic,strong)ZMAllUnderstandView *allUnderstandView;

@property(nonatomic,strong)NSMutableArray *leftMutableArray;
@property(nonatomic,strong)NSMutableArray *rightMutableArray;
@end


@implementation ZMAllUnderstandViewController

-(void)loadView{
    
    self.allUnderstandView  = [[ZMAllUnderstandView alloc] initWithFrame:SCREEN_BOUNDS];
    self.allUnderstandView.bottomScrollView.delegate = self;
    self.allUnderstandView.leftTableView.delegate = self;
    self.allUnderstandView.leftTableView.dataSource = self;
    self.allUnderstandView.rightTableView.delegate = self;
    self.allUnderstandView.rightTableView.dataSource = self;
    self.view = self.allUnderstandView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.interactivePopGestureRecognizer.enabled  = YES;

    self.title = @"包打听";
    
    [self addAction];
    [self rightButton];
    
    if (_isHome) {
        [self backButton];
    } else {
        self.allUnderstandView.leftTableView.contentInset  = UIEdgeInsetsMake(0, 0, 55, 0);
        self.allUnderstandView.rightTableView.contentInset = UIEdgeInsetsMake(0, 0, 55, 0);
    }
    
    self.leftMutableArray  = [NSMutableArray array];
    self.rightMutableArray = [NSMutableArray array];
    
    [self setMJRefreshConfig:self.allUnderstandView.leftTableView];
    [self setMJRefreshConfig:self.allUnderstandView.rightTableView];
    
    
    [self.allUnderstandView.leftTableView.mj_header beginRefreshing];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(allUnderFabuControllerNotifiAc)
                                                 name:@"allUnderFabuControllerNotifi"
                                               object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreWaitListNotiAC)
                                                 name:@"refreWaitListNoti"
                                               object:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[AudioPlayer sharedManager] stopPlayRecord:nil]; /** 停止所有播放的录音 */
    
    //pop GR
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}
//bug
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

#pragma mark - Refresh Left List
- (void)refreWaitListNotiAC{
    
    [self.allUnderstandView.leftTableView.mj_header beginRefreshing];
}



#pragma mark - Souce Data Left
- (void)evokeLeftSouceData{
    
    leftCurrentPage = 1;
    
    NSDictionary *parm = @{@"tab":@"1",
                           @"page":@"1"};
    NSString *urlStr   = [NSString stringWithFormat:@"%@/question/lists",APIDev];
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:parm withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"left --- %@",object);
        NSLog(@"%@",object[@"status"][@"message"]);
        
        self.allUnderstandView.leftTableView.mj_footer.state = MJRefreshStateIdle;
        
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            [self.leftMutableArray removeAllObjects];
            self.leftMutableArray = [NSMutableArray arrayWithArray:object[@"data"][@"items"]];
            //[self.allUnderstandView.leftTableView reloadData];
            if (self.leftMutableArray.count>0) {
                //bug
                [self.allUnderstandView.leftTableView.tableHeaderView removeFromSuperview];
                self.allUnderstandView.leftTableView.tableHeaderView = nil;
                
                [self.allUnderstandView.leftTableView reloadData];
            }else{
                ZMEmptyView *emptyView = [[ZMEmptyView alloc] initWithFrame:SCREEN_BOUNDS];
                [emptyView setBottomTitle:@"暂无信息"];
                self.allUnderstandView.leftTableView.tableHeaderView = emptyView;
            }
            
            leftTotalCount = [[NSString stringWithFormat:@"%@",object[@"data"][@"total"]] integerValue];
            leftCurrentPage= 2;
        }
        [self.allUnderstandView.leftTableView.mj_header endRefreshing];
    } withFailureBlock:^(NSError *error) {
        [self.allUnderstandView.leftTableView.mj_header endRefreshing];
        NSLog(@"%@",error);
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}



- (void)loadMoreLeftSouceData{
    if (self.leftMutableArray.count<leftTotalCount) {
        NSString *currentPageStr = [NSString stringWithFormat:@"%ld",(long)leftCurrentPage];
        NSDictionary *parm = @{@"tab":@"1",
                               @"page":currentPageStr};
        NSString *urlStr   = [NSString stringWithFormat:@"%@/question/lists",APIDev];
        [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:parm withSuccessBlock:^(NSDictionary *object) {
            NSLog(@"%@",object);
            NSLog(@"%@",object[@"status"][@"message"]);
            
            NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
            if ([stateStr isEqualToString:@"success"]) {
                [self.leftMutableArray addObjectsFromArray:object[@"data"][@"items"]];
                if (self.leftMutableArray.count<leftTotalCount) {
                    leftCurrentPage++;
                }
                [self.allUnderstandView.leftTableView reloadData];

            }
            [self.allUnderstandView.leftTableView.mj_footer endRefreshing];
        } withFailureBlock:^(NSError *error) {
            [self.allUnderstandView.leftTableView.mj_footer endRefreshing];
            NSLog(@"%@",error);
        } progress:^(float progress) {
            NSLog(@"%f",progress);
        }];
    }else{
        
        self.allUnderstandView.leftTableView.mj_footer.state = MJRefreshStateNoMoreData;
        //[self.allUnderstandView.leftTableView.mj_footer endRefreshing];
    }
}



#pragma mark - Souce Data Right
- (void)evokeRightSouceData{
    
    rightCurrentPage = 1;
    
    NSDictionary *parm = @{@"tab":@"2",
                           @"page":@"1"};
    NSString *urlStr   = [NSString stringWithFormat:@"%@/question/lists",APIDev];
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:parm withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"right --- %@",object);
        NSLog(@"%@",object[@"status"][@"message"]);
        
        self.allUnderstandView.rightTableView.mj_footer.state = MJRefreshStateIdle;
        
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            [self.rightMutableArray removeAllObjects];
             self.rightMutableArray = [NSMutableArray arrayWithArray:object[@"data"][@"items"]];
            
            if (self.rightMutableArray.count>0) {
                //bug
                [self.allUnderstandView.rightTableView.tableHeaderView removeFromSuperview];
                self.allUnderstandView.rightTableView.tableHeaderView = nil;
                
                [self.allUnderstandView.rightTableView reloadData];
            }else{
                ZMEmptyView *emptyView = [[ZMEmptyView alloc] initWithFrame:SCREEN_BOUNDS];
                [emptyView setBottomTitle:@"暂无信息"];
                self.allUnderstandView.rightTableView.tableHeaderView = emptyView;
            }
            
            rightTotalCount = [[NSString stringWithFormat:@"%@",object[@"data"][@"total"]] integerValue];
            rightCurrentPage= 2;
        }else{
            
        }
        [self.allUnderstandView.rightTableView.mj_header endRefreshing];
    } withFailureBlock:^(NSError *error) {
        [self.allUnderstandView.rightTableView.mj_header endRefreshing];
        NSLog(@"%@",error);
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}



- (void)loadMoreRightSouceData{
    
    if (self.rightMutableArray.count<rightTotalCount) {
        
        
        NSString *currentPageStr = [NSString stringWithFormat:@"%ld",(long)rightCurrentPage];
        NSDictionary *parm = @{@"tab":@"2",
                               @"page":currentPageStr};
        NSString *urlStr   = [NSString stringWithFormat:@"%@/question/lists",APIDev];
        [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:parm withSuccessBlock:^(NSDictionary *object) {
            NSLog(@"%@",object);
            NSLog(@"%@",object[@"status"][@"message"]);
            
            NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
            if ([stateStr isEqualToString:@"success"]) {
                
                
                [self.rightMutableArray addObjectsFromArray:object[@"data"][@"items"]];
                if (self.rightMutableArray.count<rightTotalCount) {
                    rightCurrentPage++;
                }
                [self.allUnderstandView.rightTableView reloadData];

            }
            [self.allUnderstandView.rightTableView.mj_footer endRefreshing];
        } withFailureBlock:^(NSError *error) {
            [self.allUnderstandView.rightTableView.mj_footer endRefreshing];
            NSLog(@"%@",error);
        } progress:^(float progress) {
            NSLog(@"%f",progress);
        }];
    }else{
        //[self.allUnderstandView.rightTableView.mj_footer endRefreshing];
        self.allUnderstandView.rightTableView.mj_footer.state = MJRefreshStateNoMoreData;
    }
    
    
}

#pragma mark - Right
- (void)rightBtnAction {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:IS_LOGIN]) {
        ZMUnderstandViewController *understandVC = [[ZMUnderstandViewController alloc] init];
        understandVC.isHome = self.isHome;
        [understandVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:understandVC animated:YES];
    }else{
        ZMLoginViewController  *loginVC = [[ZMLoginViewController alloc] init];
        UINavigationController *loginNC = [[UINavigationController alloc] initWithRootViewController:loginVC];
        loginVC.entranceType = @"allUnderFabuControllerNotifi";
        [self presentViewController:loginNC animated:YES completion:nil];
    }
}

#pragma mark - login next
- (void)allUnderFabuControllerNotifiAc{
    ZMUnderstandViewController *understandVC = [[ZMUnderstandViewController alloc] init];
    [understandVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:understandVC animated:YES];
}

- (void)addAction{
    
    [self.allUnderstandView.lefrButton addTarget:self action:@selector(lefrButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.allUnderstandView.rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - left&right
- (void)lefrButtonAction:(UIButton *)sender{
    [self.allUnderstandView.rightTableView setContentOffset:CGPointMake(0, 0) animated:NO];
    NSLog(@"left");
    if (self.leftMutableArray.count==0) {
        [self.allUnderstandView.leftTableView.mj_header beginRefreshing];
    }
    [self.allUnderstandView.lefrButton setTitleColor:[UIColor colorWithHex:tonalColor] forState:UIControlStateNormal];
    [self.allUnderstandView.rightButton setTitleColor:[UIColor colorWithHex:@"999999"] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.38 animations:^{
        [self.allUnderstandView.bottomScrollView setContentOffset:CGPointMake(0, 0)];
        self.allUnderstandView.tipLine.frame = CGRectMake(0, CGRectGetMaxY(self.allUnderstandView.lefrButton.frame), SCREEN_WIDTH/2, SCREEN_WIDTH/375*3);
    }];
}

- (void)rightButtonAction:(UIButton *)sender{
    [self.allUnderstandView.leftTableView setContentOffset:CGPointMake(0, 0) animated:NO];
    
    if (self.rightMutableArray.count==0) {
        [self.allUnderstandView.rightTableView.mj_header beginRefreshing];
    }
    
    NSLog(@"right");
    [self.allUnderstandView.lefrButton setTitleColor:[UIColor colorWithHex:@"999999"] forState:UIControlStateNormal];
    [self.allUnderstandView.rightButton setTitleColor:[UIColor colorWithHex:tonalColor] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.38 animations:^{
        [self.allUnderstandView.bottomScrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0)];
        self.allUnderstandView.tipLine.frame = CGRectMake(SCREEN_WIDTH/2, CGRectGetMaxY(self.allUnderstandView.lefrButton.frame), SCREEN_WIDTH/2, SCREEN_WIDTH/375*3);
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
    
    if (tableView.tag==1060) {
        return self.leftMutableArray.count;
    }else{
        return self.rightMutableArray.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag==1060) {
        
        NSDictionary *leftDic = self.leftMutableArray[indexPath.section];
        NSString *question = [NSString stringWithFormat:@"%@",leftDic[@"question"]];
        
        CGSize   size      = CGSizeMake(SCREEN_WIDTH-SCREEN_WIDTH/375*34, 0);
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*0,
                                                           SCREEN_WIDTH/375*0,
                                                           SCREEN_WIDTH-SCREEN_WIDTH/375*34,
                                                           SCREEN_WIDTH/375*0)];
        label.numberOfLines = 0;
        CGSize  autoSize = [label actualSizeOfLineSpaceLable:[NSString stringWithFormat:@"%@",leftDic[@"question"]]
                                                     andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
                                                     andSize:size];
        NSLog(@"left -- %ld ------------ %f",indexPath.section,autoSize.height);
        int height = (int)autoSize.height;
        
        if (height>70) {
            //height=59;
            question = [NSString stringWithFormat:@"%@...",[question substringToIndex:60]];
        }
        
        CGSize  HHautoSize = [label actualSizeOfLineSpaceLable:[NSString stringWithFormat:@"%@  ",question]
                                                     andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
                                                     andSize:size];
        height  = (int)HHautoSize.height +1;
        
        return (int)(SCREEN_WIDTH/375*104/*其他*/ + height/*文字*/);
    } else {
        
        NSDictionary *rightDic = self.rightMutableArray[indexPath.section];
        NSString *answer = [NSString stringWithFormat:@"%@",rightDic[@"accept_anwer"][@"answer"]];
        if (answer.length>0) {
            //文字
            //question
            NSString *question = [NSString stringWithFormat:@"%@",rightDic[@"question"]];
            CGSize   size      = CGSizeMake(SCREEN_WIDTH-SCREEN_WIDTH/375*34, 0);
            CGSize autoSize = [[UILabel new] actualSizeOfLineSpaceLable:[NSString stringWithFormat:@"%@  ",question]
                                                                andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
                                                                andSize:size];
            
            //answer
            NSString *answer = [NSString stringWithFormat:@"%@",rightDic[@"accept_anwer"][@"answer"]];
            CGSize sizeAns = CGSizeMake(SCREEN_WIDTH-SCREEN_WIDTH/375*70, 0);
            CGSize autoSizeAns = [[UILabel new] actualSizeOfSpaceLable:[NSString stringWithFormat:@"%@",answer]
                                                               andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]
                                                               andSize:sizeAns];
            
            int autoSizeAnsHe = (int)autoSizeAns.height;
            int autoSizeHe = (int)autoSize.height;
            
            if (autoSizeHe>70) {
                //autoSizeHe=59;
                question = [NSString stringWithFormat:@"%@...",[question substringToIndex:60]];
            }
            CGSize HHautoSize = [[UILabel new] actualSizeOfLineSpaceLable:[NSString stringWithFormat:@"%@  ",question]
                                                                andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
                                                                andSize:size];
            autoSizeHe = (int)HHautoSize.height+1;
            
            
            
            NSLog(@"ans qu ------- %d",autoSizeHe);
            return (int)(SCREEN_WIDTH/375*139+autoSizeAnsHe+autoSizeHe);
        }else{
            //语音
            NSString *question = [NSString stringWithFormat:@"%@",rightDic[@"question"]];
            CGSize size = CGSizeMake(SCREEN_WIDTH-SCREEN_WIDTH/375*34, 0);
            CGSize autoSize = [[UILabel new] actualSizeOfLineSpaceLable:[NSString stringWithFormat:@"%@  ",question]
                                                                  andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
                                                                  andSize:size];
            
            int autoSizeHe = (int)autoSize.height;
            NSLog(@"section %ld --- %d",indexPath.section,autoSizeHe);
            
            if (autoSizeHe>70) {
                //autoSizeHe=59;
                question = [NSString stringWithFormat:@"%@...",[question substringToIndex:60]];
            }
            CGSize HHautoSize = [[UILabel new] actualSizeOfLineSpaceLable:[NSString stringWithFormat:@"%@  ",question]
                                                                andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
                                                                andSize:size];
            autoSizeHe = (int)HHautoSize.height+1;
            
            return (int)(SCREEN_WIDTH/375*171/*其他*/ + autoSizeHe/*文字*/);
        }
    }
}
//add

//header
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return SCREEN_WIDTH/375*12;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView         = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *leftIndentifire         = @"leftAllUnderstanCell";
    static NSString *rightIndentifire        = @"rightAllUnderstanCell";
    static NSString *rightAudioIndentifire   = @"rightAudionAllUnderstanCell";
    
    if (tableView.tag==1060) {
        
        NSDictionary *leftDic = self.leftMutableArray[indexPath.section];
        ZMAllUnderstandLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:leftIndentifire];
        if (!cell) {
            cell = [[ZMAllUnderstandLeftTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                           reuseIdentifier:leftIndentifire];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell setLeftAllUnderstan:leftDic];
        return cell;
    }else{
        
        NSDictionary *rightDic = self.rightMutableArray[indexPath.section];
        NSString *answer = [NSString stringWithFormat:@"%@",rightDic[@"accept_anwer"][@"answer"]];
        if (answer.length>0) {
            //文字
            ZMAllUnderstandRIghtTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rightIndentifire];
            if (!cell) {
                cell = [[ZMAllUnderstandRIghtTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rightIndentifire];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            [cell setRightAllUnderstan:rightDic];
            return cell;
        }else{
            //语音
            ZMAllUnderstandRightAudioTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rightAudioIndentifire];
            if (!cell) {
                cell = [[ZMAllUnderstandRightAudioTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rightAudioIndentifire];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            [cell setRightAudioAllUnderstan:rightDic];
            [cell.voiceBtn addTarget:self action:@selector(voiceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            cell.voiceBtn.tag = 1011+indexPath.section;
            return cell;
        }
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView.tag==1060) {
        NSLog(@"left");
        ZMAllUnderStandDetailViewController *detailView = [[ZMAllUnderStandDetailViewController alloc] init];
        detailView.title = @"包打听";
        detailView.detailId = [NSString stringWithFormat:@"%@",[_leftMutableArray objectAt:indexPath.section][@"id"]];
        [detailView setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:detailView animated:YES];
        
    }else{
        NSLog(@"right");
        ZMAllUnderStandDetailViewController *detailView = [[ZMAllUnderStandDetailViewController alloc] init];
        detailView.title = @"包打听";
        detailView.detailId = [NSString stringWithFormat:@"%@",[_rightMutableArray objectAt:indexPath.section][@"id"]];
        [detailView setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:detailView animated:YES];
    }
}


#pragma mark - voice player
- (void)voiceBtnClick:(UIButton *)sender{
    NSLog(@"%@",self.rightMutableArray[sender.tag-1011]);
    NSDictionary *dic = self.rightMutableArray[sender.tag-1011];
    [[AudioPlayer sharedManager] playRecord:[NSString stringWithFormat:@"%@",dic[@"accept_anwer"][@"audio"]]
                                    withBtn:sender];
}


- (void)rightButton{
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 80, 44)];
    [rightButton setTitle:@"发布" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor colorWithHex:@"333333"] forState:UIControlStateNormal];
    [rightButton.titleLabel setFont:[UIFont systemFontOfSize:SCREEN_WIDTH/23.43]];
    rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightButton addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}



- (void)setMJRefreshConfig:(UITableView *)tableView{
    
    MJRefreshNormalHeader     *header;
    if (tableView.tag==1060) {
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
    if (tableView.tag==1060) {
        footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreLeftSouceData)];
    }else{
        footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreRightSouceData)];
    }
    [footer setTitle:mj_footTitle forState:MJRefreshStateNoMoreData];
    tableView.mj_footer = footer;
}


#pragma mark - backAction
- (void)backButton {
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    button.frame=CGRectMake(0, 0, 64, 64);
    [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    button.imageEdgeInsets = UIEdgeInsetsMake(0,-50, 0, 10);
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem=item;
}
- (void)backAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
