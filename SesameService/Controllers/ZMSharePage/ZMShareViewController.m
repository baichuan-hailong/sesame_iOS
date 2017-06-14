//
//  ZMShareViewController.m
//  SesameService
//
//  Created by 娄耀文 on 17/3/22.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMShareViewController.h"
#import "ZMShareViewCell.h"
#import "ZMShareView.h"
#import "ZMShareDetailViewController.h"
#import "ZMInfoMoneyViewController.h"
#import "ZMLoginViewController.h"
#import "ZMPayViewController.h"


@interface ZMShareViewController () <UITableViewDelegate,
                                     UITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, strong) ZMShareView    *currentView;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger      page;
@property (nonatomic, strong) MBProgressHUD  *hud;

@property (nonatomic, copy  ) NSString       *currentInfoId;
@property (nonatomic, copy  ) NSString       *currentInfoPrice;
@property (nonatomic, assign) BOOL           isLoadComplete; //是否加载完数据


@property (nonatomic, copy  ) NSString *infoTitle;

@end

@implementation ZMShareViewController


- (void)loadView {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.currentView = [[ZMShareView alloc] initWithFrame:SCREEN_BOUNDS];
    self.view        = self.currentView;
    self.currentView.shareTableView.delegate   = self;
    self.currentView.shareTableView.dataSource = self;
    self.currentView.shareTableView.emptyDataSetDelegate   = self;
    self.currentView.shareTableView.emptyDataSetSource   = self;
    [self rightButton];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"业务信息";
    
    /** init */
    _dataSource = [[NSMutableArray alloc] init];
    _page       = 1;
    if (_isHome) {
        [self backButton];
    } else {
        self.currentView.shareTableView.contentInset = UIEdgeInsetsMake(0, 0, 55, 0);
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(business_to_infoMoney) name:@"business_to_infoMoney" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(business_to_buyView)   name:@"business_to_buyView" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadDataSource)        name:@"backToHome" object:nil];
    [self setMJRefreshConfig];
    
    //aliPay
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(aliPaySuccessful)
                                                 name:@"aliPaySuccessful"
                                               object:nil];
    
    //wechat
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(aliPaySuccessful)
                                                 name:@"wechatPaySuccessful"
                                               object:nil];
}

#pragma mark - aliPay
- (void)aliPaySuccessful{
    [self.currentView.shareTableView.mj_header beginRefreshing];
}


#pragma mark - dataSource
- (void)loadDataSource {

    _page                 = 1;
    NSString     *urlStr  = [NSString stringWithFormat:@"%@/info/business-lists",APIDev];
    NSDictionary *param = @{@"page":[NSNumber numberWithInteger:_page]};
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:param withSuccessBlock:^(NSDictionary *object) {
        
        if (_dataSource.count > 0) {
            [_dataSource removeAllObjects];
        }
        _page = 2;
        
        NSArray *dataArray = object[@"data"][@"items"];
        [_dataSource addObjectsFromArray:dataArray];
        //_dataSource = (NSMutableArray *)object[@"data"][@"items"];
        NSLog(@"dataSources : %@",object);
        
        _isLoadComplete = YES;
        [self.currentView.shareTableView reloadData];
        [self.currentView.shareTableView.mj_header endRefreshing];

    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
        [self.currentView.shareTableView.mj_header endRefreshing];
        
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
    [self.currentView.shareTableView.mj_footer endRefreshing];
}

- (void)loadMoreData {

    NSString     *urlStr   = [NSString stringWithFormat:@"%@/info/business-lists",APIDev];
    NSDictionary *param = @{@"page":[NSNumber numberWithInteger:_page]};
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:param withSuccessBlock:^(NSDictionary *object) {
        
        NSInteger totalCount = [object[@"data"][@"total"] integerValue];
        
        if (_dataSource.count < totalCount) {
            
            _page++;
            NSArray *dataArray = object[@"data"][@"items"];
            
            NSMutableArray *tempArray = [[NSMutableArray alloc] init];
            
            [tempArray addObjectsFromArray:_dataSource];
            [tempArray addObjectsFromArray:dataArray];
            _dataSource = tempArray;
            
            [self.currentView.shareTableView reloadData];
            [self.currentView.shareTableView.mj_footer endRefreshing];
        } else {
            
            NSLog(@"没有更多数据了");
            [self.currentView.shareTableView.mj_footer endRefreshingWithNoMoreData];
        }
        
    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
        [self.currentView.shareTableView.mj_footer endRefreshing];
        
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}

//Refresh
- (void)setMJRefreshConfig {
    
    MJRefreshNormalHeader     *header = [MJRefreshNormalHeader     headerWithRefreshingTarget:self refreshingAction:@selector(loadDataSource)];
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    header.frame = CGRectMake(0, 0, SCREEN_WIDTH, 60);
    header.lastUpdatedTimeLabel.hidden = YES;
    [header setTitle:@"下拉刷新"  forState:MJRefreshStateIdle];
    [header setTitle:@"释放更新"  forState:MJRefreshStatePulling];
    [header setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    
    
    self.currentView.shareTableView.mj_header = header;
    self.currentView.shareTableView.mj_footer = footer;
    
    [self.currentView.shareTableView.mj_header beginRefreshing];
    [self hud];
    //[self loadDataSource];
}




#pragma mark - UITableView Delegate & Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SCREEN_WIDTH/1.94 + 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIndentifire = @"cell";
    ZMShareViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifire];
    if (!cell) {
        cell = [[ZMShareViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifire];
    }
    cell.buyBtn.tag = indexPath.row;
    [cell.buyBtn addTarget:self action:@selector(buyAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setValueWithDic:(NSDictionary *)[_dataSource objectAt:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    ZMShareDetailViewController *shareDetailView = [[ZMShareDetailViewController alloc] init];
    shareDetailView.detailID = [NSString stringWithFormat:@"%@",[_dataSource objectAt:indexPath.row][@"id"]];
    [shareDetailView setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:shareDetailView animated:YES];
}


#pragma mark - 购买Action
- (void)buyAction:(UIButton *)sender {
    
    NSLog(@"购买%ld",sender.tag);
    _currentInfoId    = [NSString stringWithFormat:@"%@",[_dataSource objectAt:sender.tag][@"id"]];
    _currentInfoPrice = [NSString stringWithFormat:@"%@",[_dataSource objectAt:sender.tag][@"price"]];
    self.infoTitle = [NSString stringWithFormat:@"%@",[_dataSource objectAt:sender.tag][@"title"]];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:IS_LOGIN]) {
        
        ZMPayViewController *payVC = [[ZMPayViewController alloc] init];
        payVC.isInfo = YES;
        payVC.infoID = _currentInfoId;
        payVC.infoTitle=self.infoTitle;
        payVC.money  = _currentInfoPrice;
        [payVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:payVC animated:YES];
        
    } else {
        
        ZMLoginViewController *loginView = [[ZMLoginViewController alloc] init];
        loginView.entranceType = @"business_to_buyView";
        UINavigationController *loginNC = [[UINavigationController alloc] initWithRootViewController:loginView];
        [self presentViewController:loginNC animated:YES completion:nil];
    }
}


- (void)business_to_buyView {
    
    ZMPayViewController *payVC = [[ZMPayViewController alloc] init];
    payVC.isInfo = YES;
    payVC.infoID = _currentInfoId;
    payVC.money  = _currentInfoPrice;
    payVC.infoTitle=self.infoTitle;
    [payVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:payVC animated:YES];
}



#pragma maek - cuntomMethod
- (void)rightButton{
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 80, 44)];
    [rightButton setTitle:@"发布" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor colorWithHex:@"333333"] forState:UIControlStateNormal];
    [rightButton.titleLabel setFont:[UIFont systemFontOfSize:SCREEN_WIDTH/23.43]];
    rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightButton addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

- (void)rightBtnAction {
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:IS_LOGIN]) {
    
        ZMInfoMoneyViewController *infoMoney = [[ZMInfoMoneyViewController alloc] init];
        infoMoney.isFromHome = NO;
        infoMoney.from = @"business";
        [infoMoney setHidesBottomBarWhenPushed:YES];
        UINavigationController *infoMoneyNc = [[UINavigationController alloc] initWithRootViewController:infoMoney];
        [self presentViewController:infoMoneyNc animated:YES completion:nil];
    } else {
    
        ZMLoginViewController *loginView = [[ZMLoginViewController alloc] init];
        loginView.entranceType = @"business_to_infoMoney";
        UINavigationController *loginNC = [[UINavigationController alloc] initWithRootViewController:loginView];
        [self presentViewController:loginNC animated:YES completion:nil];
    }
}


#pragma mark - 监听登陆成功之后跳转
- (void)business_to_infoMoney {
    
    ZMInfoMoneyViewController *infoMoney = [[ZMInfoMoneyViewController alloc] init];
    infoMoney.isFromHome = NO;
    infoMoney.from = @"business";
    [infoMoney setHidesBottomBarWhenPushed:YES];
    UINavigationController *infoMoneyNc = [[UINavigationController alloc] initWithRootViewController:infoMoney];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:infoMoneyNc animated:YES completion:nil];
    });
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


#pragma mark - DZNEmptyDataSetDelegate 列表空视图
- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView {
    
    UIView *emptyView = [[UIView alloc] init];
    emptyView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0);
    UIImage *img = [UIImage imageNamed:@"emptyViewImage"];
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    imgView.frame = CGRectMake((emptyView.width - img.size.width)/2, -100, img.size.width, img.size.height);
    [emptyView addSubview:imgView];
    
    UILabel *tipsLable = [[UILabel alloc] init];
    tipsLable.frame = CGRectMake(0, CGRectGetMaxY(imgView.frame) + 10, SCREEN_WIDTH, SCREEN_WIDTH/26.78);
    tipsLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78];
    tipsLable.textColor = [UIColor colorWithHex:@"9a9a9a"];
    tipsLable.textAlignment = NSTextAlignmentCenter;
    tipsLable.text = @"暂无信息!";

    [emptyView addSubview:tipsLable];
    
    return emptyView;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {

    if (_isLoadComplete) {
        return YES;
    } else {
        return NO;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
