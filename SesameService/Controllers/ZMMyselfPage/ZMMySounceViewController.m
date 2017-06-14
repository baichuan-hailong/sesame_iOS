//
//  ZMMySounceViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/23.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMMySounceViewController.h"
#import "ZMSounceView.h"
#import "ZMSounceLeftTableViewCell.h"
#import "ZMSounceRightTableViewCell.h"

#import "ZMMySounceAskerDetailViewController.h"
#import "ZMMySounceAnswerDetailViewController.h"
#import "ZMAllUnderStandDetailViewController.h"


@interface ZMMySounceViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    BOOL isLeftBool;
    
    NSInteger leftCurrentPage;
    NSInteger leftTotalCount;
    
    NSInteger rightCurrentPage;
    NSInteger rightTotalCount;
}
@property(nonatomic,strong)ZMSounceView *sounceView;
@property(nonatomic,strong)NSMutableArray *leftMutableArray;
@property(nonatomic,strong)NSMutableArray *rightMutableArray;
@property (nonatomic , strong)MBProgressHUD *HUD;
@end

@implementation ZMMySounceViewController

-(void)loadView{
    
    self.sounceView = [[ZMSounceView alloc] initWithFrame:SCREEN_BOUNDS];
    self.sounceView.bottomScrollView.delegate = self;
    self.sounceView.leftTableView.delegate    = self;
    self.sounceView.leftTableView.dataSource  = self;
    self.sounceView.rightTableView.delegate   = self;
    self.sounceView.rightTableView.dataSource = self;
    self.view       = self.sounceView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的打听";
    [self addAction];
    
    isLeftBool = YES;
    
    [self setMJRefreshConfig:self.sounceView.leftTableView];
    [self setMJRefreshConfig:self.sounceView.rightTableView];
    
    
    [self.sounceView.leftTableView.mj_header beginRefreshing];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(evokeLeftSouceData)
                                                 name:@"cancelQuestionRefresh"
                                               object:nil];
    
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"refreshMySounceAc" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshMySounceAc)
                                                 name:@"refreshMySounceAc"
                                               object:nil];
    [self evokeUserConuntSouceData];
}

-(void)backAction{
    if (_isSelected) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Refresh List
- (void)refreshMySounceAc{
    if (isLeftBool) {
        [self.sounceView.leftTableView.mj_header beginRefreshing];
    }else{
        [self.sounceView.rightTableView.mj_header beginRefreshing];
    }
}



- (void)evokeUserConuntSouceData{
    
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    [self.HUD show:YES];
    
    NSString *urlStr   = [NSString stringWithFormat:@"%@/answer/count",APIDev];
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:nil withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"user Count --- %@",object);
        
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            
            NSString *answer_num = [NSString stringWithFormat:@"%@",object[@"data"][@"answer_num"]];
            NSString *reward_sum = [NSString stringWithFormat:@"%@",object[@"data"][@"reward_sum"]];
            self.sounceView.tipLable.text = [NSString stringWithFormat:@"当前已回答%@个问题，累计收入%@元",answer_num,reward_sum];
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
    
    [self.sounceView.lefrButton addTarget:self
                                   action:@selector(lefrButtonAction:)
                         forControlEvents:UIControlEventTouchUpInside];
    [self.sounceView.rightButton addTarget:self
                                    action:@selector(rightButtonAction:)
                          forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - left&right
- (void)lefrButtonAction:(UIButton *)sender{
    [self.sounceView.rightTableView setContentOffset:CGPointMake(0, 0) animated:NO];
    isLeftBool = YES;
    NSLog(@"left");
    if (self.leftMutableArray.count==0) {
        [self.sounceView.leftTableView.mj_header beginRefreshing];
    }
    [self.sounceView.lefrButton setTitleColor:[UIColor colorWithHex:tonalColor]
                                     forState:UIControlStateNormal];
    [self.sounceView.rightButton setTitleColor:[UIColor colorWithHex:@"999999"]
                                      forState:UIControlStateNormal];
    [UIView animateWithDuration:0.38 animations:^{
        [self.sounceView.bottomScrollView setContentOffset:CGPointMake(0, 0)];
        self.sounceView.tipLine.frame = CGRectMake(0,
                                                   CGRectGetMaxY(self.sounceView.lefrButton.frame),
                                                   SCREEN_WIDTH/2,
                                                   SCREEN_WIDTH/375*3);
    }];
}

- (void)rightButtonAction:(UIButton *)sender{
    [self.sounceView.leftTableView setContentOffset:CGPointMake(0, 0)
                                           animated:NO];
    NSLog(@"right");
    isLeftBool = NO;
    if (self.rightMutableArray.count==0) {
        [self.sounceView.rightTableView.mj_header beginRefreshing];
    }
    [self.sounceView.lefrButton setTitleColor:[UIColor colorWithHex:@"999999"]
                                     forState:UIControlStateNormal];
    [self.sounceView.rightButton setTitleColor:[UIColor colorWithHex:tonalColor]
                                      forState:UIControlStateNormal];
    [UIView animateWithDuration:0.38 animations:^{
        [self.sounceView.bottomScrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0)];
        self.sounceView.tipLine.frame = CGRectMake(SCREEN_WIDTH/2,
                                                   CGRectGetMaxY(self.sounceView.lefrButton.frame),
                                                   SCREEN_WIDTH/2,
                                                   SCREEN_WIDTH/375*3);
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
    
    if (tableView.tag==1020) {
        return self.leftMutableArray.count;
    }else{
        return self.rightMutableArray.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (tableView.tag==1020) {
    
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
        NSLog(@"%ld ------------ %f",indexPath.section,autoSize.height);
        int height = (int)autoSize.height;
        //NSLog(@"%ld ------------ %d",indexPath.section,height);
        if (height>70) {
            //height = 59;
            question = [NSString stringWithFormat:@"%@...",[question substringToIndex:60]];
        }
        
        CGSize  HHautoSize = [label actualSizeOfLineSpaceLable:[NSString stringWithFormat:@"%@ ",question]
                                                     andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
                                                     andSize:size];
        height = (int)HHautoSize.height;
        return (int)(SCREEN_WIDTH/375*105/*其他*/ + height/*文字*/);
        
    }else{
        NSDictionary *rightDic = self.rightMutableArray[indexPath.section];
        
        NSString *question = [NSString stringWithFormat:@"%@",rightDic[@"question"]];
        
        CGSize   size      = CGSizeMake(SCREEN_WIDTH-SCREEN_WIDTH/375*34, 0);
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*0,
                                                                   SCREEN_WIDTH/375*0,
                                                                   SCREEN_WIDTH-SCREEN_WIDTH/375*34,
                                                                   SCREEN_WIDTH/375*0)];
        label.numberOfLines = 0;
        
        CGSize  autoSize = [label actualSizeOfLineSpaceLable:[NSString stringWithFormat:@"%@ ",question]
                                                     andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
                                                     andSize:size];
        NSLog(@"%ld ------------ %f",indexPath.section,autoSize.height);
        int height = (int)autoSize.height;
        if (height>70) {
            //height = 59;
            question = [NSString stringWithFormat:@"%@...",[question substringToIndex:60]];
        }
        CGSize  HHautoSize = [label actualSizeOfLineSpaceLable:[NSString stringWithFormat:@"%@ ",question]
                                                     andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
                                                     andSize:size];
        height = (int)HHautoSize.height;
        return SCREEN_WIDTH/375*100+height;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (tableView.tag==1020) {
        if (section==self.leftMutableArray.count-1) {
            return SCREEN_WIDTH/375*20;
        }else{
            return SCREEN_WIDTH/375*0;
        }
    }else{
        if (section==self.rightMutableArray.count-1) {
            return SCREEN_WIDTH/375*20;
        }else{
            return SCREEN_WIDTH/375*0;
        }
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footView         = [[UIView alloc] init];
    footView.backgroundColor = [UIColor clearColor];
    return footView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return SCREEN_WIDTH/375*10;
    }else{
        return SCREEN_WIDTH/375*0;
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *footView         = [[UIView alloc] init];
    footView.backgroundColor = [UIColor clearColor];
    return footView;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *leftIndentifire         = @"leftSelectCell";
    static NSString *rightIndentifire        = @"rightSelectCell";
    
    if (tableView.tag==1020) {
        NSDictionary *leftDic = self.leftMutableArray[indexPath.section];
        ZMSounceLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:leftIndentifire];
        if (!cell) {
            cell = [[ZMSounceLeftTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                    reuseIdentifier:leftIndentifire];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell setMyAsk:leftDic];
        if (indexPath.section==self.leftMutableArray.count-1) {
            cell.line.alpha = 0;
        }else{
            cell.line.alpha = 1;
        }
        cell.bottomButton.alpha = 0;
        /*cell.bottomButton.tag = 7676+indexPath.section;
         [cell.bottomButton addTarget:self
         action:@selector(bottomButtonClicked:)
         forControlEvents:UIControlEventTouchUpInside];
         */
        
        
        return cell;
        
        
    }else{
        
        NSDictionary *rightDic = self.rightMutableArray[indexPath.section];
        ZMSounceRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rightIndentifire];
        if (!cell) {
            cell = [[ZMSounceRightTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rightIndentifire];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell setMyAnswer:rightDic];
        if (indexPath.section==self.rightMutableArray.count-1) {
            cell.line.alpha = 0;
        }else{
            cell.line.alpha = 1;
        }
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView.tag == 1020) {
        
        NSLog(@"left");
        
        NSDictionary *leftDic = self.leftMutableArray[indexPath.section];
        ZMAllUnderStandDetailViewController *askDetailVC = [[ZMAllUnderStandDetailViewController alloc] init];
        askDetailVC.title = @"我的打听";
        askDetailVC.isMine = YES;
        askDetailVC.detailId = [NSString stringWithFormat:@"%@",leftDic[@"id"]];
        [self.navigationController pushViewController:askDetailVC animated:YES];
        
        
    } else{
        NSLog(@"right");
        NSDictionary *rightDic = self.rightMutableArray[indexPath.section];
        ZMMySounceAnswerDetailViewController *answerDetailVC = [[ZMMySounceAnswerDetailViewController alloc] init];
        answerDetailVC.answerDic = rightDic;
        [self.navigationController pushViewController:answerDetailVC animated:YES];
    }
}



#pragma mark - 取消问题
- (void)bottomButtonClicked:(UIButton *)sender{
    
    //NSLog(@"%ld",sender.tag);
    //NSLog(@"%@",self.leftMutableArray[sender.tag-7676]);
    NSDictionary *leftDic = self.leftMutableArray[sender.tag-7676];
    NSString *questionID = [NSString stringWithFormat:@"%@",leftDic[@"id"]];
    [self evokePop:@"确定要取消问题吗?" questionID:questionID index:sender.tag-7676];
}

- (void)closeQuesiton:(NSString *)questionID index:(NSInteger)index{
    
    
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    [self.HUD show:YES];
    
    NSString *urlStr   = [NSString stringWithFormat:@"%@/question/close",APIDev];
    NSDictionary *pra  = @{@"id":questionID};
    
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:pra withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"close qustion --- %@",object);
        
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            
            NSDictionary *leftDic = self.leftMutableArray[index];
            NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:leftDic];
            
            [tempDic setObject:@"closed" forKey:@"status"];
            [tempDic setObject:@"已撤销" forKey:@"status_title"];
            
            [self.leftMutableArray removeObjectAtIndex:index];
            [self.leftMutableArray insertObject:tempDic atIndex:index];
            
            
            [self.sounceView.leftTableView reloadData];
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

#pragma mark - pop
- (void)evokePop:(NSString *)title questionID:(NSString *)questionId index:(NSInteger)index{
    
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:nil message:title preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction        = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    
        [self closeQuesiton:questionId index:index];
    }];
    UIAlertAction *cancle          = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    
    [cancle setValue:[UIColor colorWithHex:@"000000"] forKey:@"titleTextColor"];
    [alertDialog addAction:cancle];
    [alertDialog addAction:okAction];
    [self presentViewController:alertDialog animated:YES completion:nil];
}


#pragma mark - Load Data
//left
- (void)evokeLeftSouceData{
    leftCurrentPage = 1;
    
    NSDictionary *parm = @{@"page":@"1"};
    NSString *urlStr   = [NSString stringWithFormat:@"%@/question/my-publish-lists",APIDev];
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
        NSString *urlStr   = [NSString stringWithFormat:@"%@/question/my-publish-lists",APIDev];
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
    NSString *urlStr   = [NSString stringWithFormat:@"%@/question/my-answer-lists",APIDev];
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:parm withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"right --- %@",object);
        NSLog(@"%@",object[@"status"][@"message"]);
        
        self.sounceView.rightTableView.mj_footer.state = MJRefreshStateIdle;
        
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            [self.rightMutableArray removeAllObjects];
            self.rightMutableArray = [NSMutableArray arrayWithArray:object[@"data"][@"items"]];
            
            if (self.rightMutableArray.count>0) {
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
        
        NSString *urlStr   = [NSString stringWithFormat:@"%@/question/my-answer-lists",APIDev];
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
    if (tableView.tag==1020) {
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
    if (tableView.tag==1020) {
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
