//
//  ViewController.m
//  SesameService
//
//  Created by 娄耀文 on 17/3/15.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMHomeViewController.h"
#import "ZMHomeView.h"
#import "homeBannerCell.h"
#import "homeMenuBtnCell.h"
#import "homeStarVipCell.h"
#import "homeBusinessCell.h"
#import "homeHeadView.h"
#import "homeFootView.h"

#import "ZMShareViewController.h"
#import "ZMAgentViewController.h"
#import "ZMShareDetailViewController.h"
#import "ZMVipViewController.h"
#import "ZMAllUnderstandViewController.h"
#import "ZMInfoMoneyViewController.h"
#import "ZMGetCommissionViewController.h"
#import "ZMMarketingViewController.h"
#import "ZMCompanyVipViewController.h"
#import "ZMPersonalVipViewController.h"
#import "ZMLoginViewController.h"
#import "ZMPayViewController.h"
#import "ZMGuideViewController.h"
#import "ZMOnlineServiceViewController.h"
#import "ZMGeneralWebViewController.h"

@interface ZMHomeViewController () <UICollectionViewDelegate,
                                    UICollectionViewDataSource,
                                    ZYBannerViewDelegate>

@property (nonatomic, strong) ZMHomeView *currentView;
@property (nonatomic, assign) NSInteger  page;

@property (nonatomic, strong) NSMutableArray *bannerArray;
@property (nonatomic, strong) NSMutableArray *starArray;
@property (nonatomic, strong) NSMutableArray *businessArray;

@property (nonatomic, copy  ) NSString *currentInfoId;
@property (nonatomic, copy  ) NSString *currentInfoPrice;

@property (nonatomic, copy  ) NSString *infoTitle;

@property (nonatomic, assign) BOOL     isCanSideBack;  //右滑返回允许状态

@end

@implementation ZMHomeViewController

- (void)loadView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.currentView = [[ZMHomeView alloc] initWithFrame:SCREEN_BOUNDS];
    self.view        = self.currentView;
    self.currentView.homeCollectionView.delegate   = self;
    self.currentView.homeCollectionView.dataSource = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"芝麻商服";
    
    _bannerArray   = [[NSMutableArray alloc] init];
    _starArray     = [[NSMutableArray alloc] init];
    _businessArray = [[NSMutableArray alloc] init];
    [self setMJRefreshConfig];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MySelfLoginNextAc)  name:@"MySelfLoginNextAction" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MySelfLoginNextAc)  name:@"loginOutNextAction" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(home_to_infoMoney)  name:@"home_to_infoMoney" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(home_to_commission) name:@"home_to_commission" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(home_to_marketing)  name:@"home_to_marketing" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(home_to_buyView)    name:@"home_to_buyView" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(home_to_user_center)name:@"home_to_user_center" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadDataSource)     name:@"backToHome" object:nil];
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self resetSideBack];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self forbiddenSideBack];
}



#pragma mark - aliPay
- (void)aliPaySuccessful{
    [self.currentView.homeCollectionView.mj_header beginRefreshing];
}




#pragma mark - dataSource
- (void)loadDataSource {
    
    /** banner */
    NSString     *bannerUrlStr   = [NSString stringWithFormat:@"%@/common/banner",APIDev];
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:bannerUrlStr withParaments:nil withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"banner : %@",object);
        
        _bannerArray = (NSMutableArray *)object[@"data"];
        
        [self.currentView.homeCollectionView reloadData];
        [self.currentView.homeCollectionView.mj_header endRefreshing];
        
    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
        [self.currentView.homeCollectionView.mj_header endRefreshing];
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
    
    
    /** 明星会员 */
    NSString     *vipUrlStr   = [NSString stringWithFormat:@"%@/common/user-stars",APIDev];
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:vipUrlStr withParaments:nil withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"vip : %@",object);
        
        _starArray = (NSMutableArray *)object[@"data"];
        [self.currentView.homeCollectionView reloadData];
        [self.currentView.homeCollectionView.mj_header endRefreshing];
        
    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
        [self.currentView.homeCollectionView.mj_header endRefreshing];
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
    
    /** 最新信息 */
    NSString     *newUrlStr   = [NSString stringWithFormat:@"%@/common/lasted-info",APIDev];
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:newUrlStr withParaments:nil withSuccessBlock:^(NSDictionary *object) {
        
        _businessArray = (NSMutableArray *)object[@"data"];
        NSLog(@"business : %@",_businessArray);
        
        [self.currentView.homeCollectionView reloadData];
        [self.currentView.homeCollectionView.mj_header endRefreshing];
        
    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
        [self.currentView.homeCollectionView.mj_header endRefreshing];
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}

- (void)loadMoreData {
    
    NSString     *urlStr   = [NSString stringWithFormat:@"%@/business/lists",APIDev];
    NSDictionary *param = @{@"page":[NSNumber numberWithInteger:_page]};
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:param withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"%@",object);
        
        
    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}

//Refresh
- (void)setMJRefreshConfig {
    
    MJRefreshNormalHeader     *header = [MJRefreshNormalHeader     headerWithRefreshingTarget:self refreshingAction:@selector(loadDataSource)];
    //MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    header.frame = CGRectMake(0, 0, SCREEN_WIDTH, 60);
    header.lastUpdatedTimeLabel.hidden = YES;
    [header setTitle:@"下拉刷新"   forState:MJRefreshStateIdle];
    [header setTitle:@"释放更新"   forState:MJRefreshStatePulling];
    [header setTitle:@"加载中..."  forState:MJRefreshStateRefreshing];
    
    
    self.currentView.homeCollectionView.mj_header = header;
    //self.currentView.homeCollectionView.mj_footer = footer;

    [self loadDataSource];
}


#pragma mark - collectionView Delegate & Datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (section == 2) {
        return _businessArray.count;
    } else {
        return 1;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = nil;
    if (indexPath.section == 0) {
        
        /** 顶部banner */
        homeBannerCell *bannerCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"homeBannerCell" forIndexPath:indexPath];
        bannerCell.bannerView.delegate = self;
        [bannerCell setValueWithArray:_bannerArray];
        cell = bannerCell;
        
    } else if (indexPath.section == 1) {
        
        /** 顶部按钮 */
        homeMenuBtnCell *menuCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"homeMenuBtnCell" forIndexPath:indexPath];
        [menuCell.infoMoneyBtn  addTarget:self action:@selector(menuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [menuCell.commissionBtn addTarget:self action:@selector(menuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [menuCell.marketingBtn  addTarget:self action:@selector(menuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [menuCell.findBtn       addTarget:self action:@selector(menuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [menuCell.guideBtn      addTarget:self action:@selector(menuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [menuCell.serviceBtn    addTarget:self action:@selector(menuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        cell = menuCell;
        
    } else if (indexPath.section == 2) {
        
        /** 最新商机 */
        homeBusinessCell *businessCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"homeBusinessCell" forIndexPath:indexPath];
        [businessCell setValueWithDic:(NSDictionary *)[_businessArray objectAt:indexPath.row]];
        businessCell.buyBtn.tag = indexPath.row;
        [businessCell.buyBtn addTarget:self action:@selector(buyAction:) forControlEvents:UIControlEventTouchUpInside];
        cell = businessCell;
        
    } else {
        
        /** 明星会员 */
        homeStarVipCell *vipCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"homeStarVipCell" forIndexPath:indexPath];
        vipCell.starCycleView.delegate = self;
        [vipCell setValueWithArray:_starArray];
        cell = vipCell;
    }
    return cell;
}



#pragma mark --UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH/1.83);
        
    } else if (indexPath.section == 1) {
        
        return CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH/2.25);
        
    } else if (indexPath.section == 2) {
        
        return CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH/2);
        
    } else {
        
        return CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH/2.57);
    }
}

//定义每个UICollectionView 的 margin
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    /** section间距 */
    if (section == 1) {
        return UIEdgeInsetsMake(0, 0, 10, 0);
    } else {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
}

- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    /** 设置headerView尺寸 */
    if(section == 2 || section == 3) {
        
        CGSize size = {SCREEN_WIDTH, SCREEN_WIDTH/9.375};
        return size;
    } else {
        CGSize size = {SCREEN_WIDTH, 0};
        return size;
    }
}

- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    /** 设置footerView尺寸 */
    if(section == 2) {
        
        CGSize size = {SCREEN_WIDTH, SCREEN_WIDTH/9.375 + 10};
        return size;
    } else {
        CGSize size = {SCREEN_WIDTH, 0};
        return size;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    if (kind == UICollectionElementKindSectionHeader) {
        
        /** 定制头部视图的内容 */
        
        UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"homeHeadView" forIndexPath:indexPath];
        
        for (UIView *view in reusableView.subviews) {
            [view removeFromSuperview];
        }
        
        if (indexPath.section == 2) {
            
            homeHeadView *headerV = [[homeHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/9.375)];
            headerV.topBtn.tag = 2;
            [headerV.topBtn addTarget:self action:@selector(checkMore:) forControlEvents:UIControlEventTouchUpInside];
            headerV.titleLable.text = @"最新信息";
            headerV.tipImage.image = [UIImage imageNamed:@"home_fire"];
            [reusableView addSubview:headerV];
        } else if (indexPath.section == 3) {
        
            homeHeadView *headerV = [[homeHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/9.375)];
            headerV.topBtn.tag = 1;
            [headerV.topBtn addTarget:self action:@selector(checkMore:) forControlEvents:UIControlEventTouchUpInside];
            headerV.titleLable.text = @"明星会员";
            headerV.tipImage.image = [UIImage imageNamed:@"home_star"];
            [reusableView addSubview:headerV];
        } else {
            
            UIView *test = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
            test.backgroundColor = [UIColor whiteColor];
            [reusableView addSubview:test];
        }
        return reusableView;
        
    }
    if (kind == UICollectionElementKindSectionFooter) {
    
        /** 定制尾部视图的内容 */
        UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"homeFootView" forIndexPath:indexPath];
        
        for (UIView *view in reusableView.subviews) {
            [view removeFromSuperview];
        }
        
        if (indexPath.section == 2) {
            
            homeFootView *footView = [[homeFootView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/9.375)];
            footView.topBtn.tag = 2;
            [footView.topBtn addTarget:self action:@selector(checkMore:) forControlEvents:UIControlEventTouchUpInside];
            [reusableView addSubview:footView];
        }
        return reusableView;
    }
    return nil;

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    /** collection点击 */
    if (indexPath.section == 2) {
        
        /** 信息详情 */
        ZMShareDetailViewController *shareDetailView = [[ZMShareDetailViewController alloc] init];
        shareDetailView.detailID = [NSString stringWithFormat:@"%@",[_businessArray objectAt:indexPath.row][@"id"]];
        [shareDetailView setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:shareDetailView animated:YES];
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark - 购买Action
- (void)buyAction:(UIButton *)sender {

    NSLog(@"购买%ld",sender.tag);
    _currentInfoId      = [NSString stringWithFormat:@"%@",[_businessArray objectAt:sender.tag][@"id"]];
    _currentInfoPrice   = [NSString stringWithFormat:@"%@",[_businessArray objectAt:sender.tag][@"price"]];
    
    self.infoTitle = [NSString stringWithFormat:@"%@",[_businessArray objectAt:sender.tag][@"title"]];
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
        loginView.entranceType = @"home_to_buyView";
        UINavigationController *loginNC = [[UINavigationController alloc] initWithRootViewController:loginView];
        [self presentViewController:loginNC animated:YES completion:nil];
    }
}


- (void)home_to_buyView {

    ZMPayViewController *payVC = [[ZMPayViewController alloc] init];
    payVC.isInfo = YES;
    payVC.infoID = _currentInfoId;
    payVC.money  = _currentInfoPrice;
    payVC.infoTitle=self.infoTitle;
    [payVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:payVC animated:YES];
}


#pragma mark - ZYBannerViewDelegate && banner广告
- (void)banner:(ZYBannerView *)banner didSelectItemAtIndex:(NSInteger)index{
    
    /** banner广告 */
    NSLog(@"点击了banner广告  第%ld个cell 第%ld张图片!",banner.tag,index);
    if (banner.tag == 1001) {
        
        //顶部banner
        if ([[NSString stringWithFormat:@"%@",[_bannerArray objectAt:index][@"actor"]] isEqualToString:@"info_list"]) {
            /** 信息列表 */
            ZMShareViewController *shareView = [[ZMShareViewController alloc] init];
            shareView.isHome = YES;
            [shareView setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:shareView animated:YES];
            
        } else if ([[NSString stringWithFormat:@"%@",[_bannerArray objectAt:index][@"actor"]] isEqualToString:@"info_detail"]) {
            /** 信息详情 */
            ZMShareDetailViewController *shareDetailView = [[ZMShareDetailViewController alloc] init];
            if ([[NSString stringWithFormat:@"%@",[_bannerArray objectAt:index][@"param"]] isEqualToString:@"<null>"]) {
                shareDetailView.detailID = @"0";
            } else {
                shareDetailView.detailID = [NSString stringWithFormat:@"%@",[_bannerArray objectAt:index][@"param"][@"id"]];
            }
            [shareDetailView setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:shareDetailView animated:YES];
            
        } else if ([[NSString stringWithFormat:@"%@",[_bannerArray objectAt:index][@"actor"]] isEqualToString:@"user_list"]) {
            /** 会员列表 */
            ZMVipViewController *vipView = [[ZMVipViewController alloc] init];
            [vipView setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:vipView animated:YES];
            
        } else if ([[NSString stringWithFormat:@"%@",[_bannerArray objectAt:index][@"actor"]] isEqualToString:@"user_detail"]) {
            /** 会员详情 */
            
            if ([[NSString stringWithFormat:@"%@",[_bannerArray objectAt:index][@"param"]] isEqualToString:@"<null>"]) {
                //...null
            } else {

                if ([[NSString stringWithFormat:@"%@",[_bannerArray objectAt:index][@"param"][@"type"]] isEqualToString:@"1"]) {
                    /** 个人 */
                    ZMPersonalVipViewController *personalVipVC = [[ZMPersonalVipViewController alloc] init];
                    [personalVipVC setHidesBottomBarWhenPushed:YES];
                    personalVipVC.personID = [NSString stringWithFormat:@"%@",[_bannerArray objectAt:index][@"param"][@"id"]];
                    [self.navigationController pushViewController:personalVipVC animated:YES];
                    
                }else{
                    /** 企业 */
                    ZMCompanyVipViewController *companyVipVC = [[ZMCompanyVipViewController alloc] init];
                    [companyVipVC setHidesBottomBarWhenPushed:YES];
                    companyVipVC.companyID = [NSString stringWithFormat:@"%@",[_bannerArray objectAt:index][@"param"][@"id"]];
                    [self.navigationController pushViewController:companyVipVC animated:YES];
                }
            }
            
        } else if ([[NSString stringWithFormat:@"%@",[_bannerArray objectAt:index][@"actor"]] isEqualToString:@"web_pure"]) {
            /** web页面 */
            ZMGeneralWebViewController *wenView = [[ZMGeneralWebViewController alloc] init];
            wenView.webUrl = [NSString stringWithFormat:@"%@",[_bannerArray objectAt:index][@"param"][@"url"]];
            [wenView setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:wenView animated:YES];
            
        } else if ([[NSString stringWithFormat:@"%@",[_bannerArray objectAt:index][@"actor"]] isEqualToString:@"web_mix"]) {
            /** web与原生交互 */
            
        } else if ([[NSString stringWithFormat:@"%@",[_bannerArray objectAt:index][@"actor"]] isEqualToString:@"user_center"]) {
            /** 跳转我的界面（需要鉴权） */
            
            if ([[NSUserDefaults standardUserDefaults] boolForKey:IS_LOGIN]) {
               
                self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:3];
            } else {
            
                ZMLoginViewController *loginView = [[ZMLoginViewController alloc] init];
                loginView.entranceType = @"home_to_user_center";
                UINavigationController *loginNC = [[UINavigationController alloc] initWithRootViewController:loginView];
                [self presentViewController:loginNC animated:YES completion:nil];
            }
        }

    } else if (banner.tag == 1002) {
    
        //明星会员
        if ([[NSString stringWithFormat:@"%@",[_starArray objectAt:index][@"type"]] isEqualToString:@"1"]) {
            /** 个人 */
            ZMPersonalVipViewController *personalVipVC = [[ZMPersonalVipViewController alloc] init];
            [personalVipVC setHidesBottomBarWhenPushed:YES];
            personalVipVC.personID = [NSString stringWithFormat:@"%@",[_starArray objectAt:index][@"id"]];
            [self.navigationController pushViewController:personalVipVC animated:YES];
            
        }else{
            /** 企业 */
            ZMCompanyVipViewController *companyVipVC = [[ZMCompanyVipViewController alloc] init];
            [companyVipVC setHidesBottomBarWhenPushed:YES];
            companyVipVC.companyID = [NSString stringWithFormat:@"%@",[_starArray objectAt:index][@"id"]];
            [self.navigationController pushViewController:companyVipVC animated:YES];
        }
    }
}

- (void)bannerFooterDidTrigger:(ZYBannerView *)banner {
    NSLog(@"拖动了第%ld个banner",banner.tag);
}


#pragma mark - customMethod
/** 菜单按钮点击事件 */
- (void)menuBtnAction:(UIButton *)sender {
    
    if (sender.tag == 1) {
        NSLog(@"赚信息费");
        if ([[NSUserDefaults standardUserDefaults] boolForKey:IS_LOGIN]) {
            
            ZMInfoMoneyViewController *infoMoneyView = [[ZMInfoMoneyViewController alloc] init];
            infoMoneyView.isFromHome = YES;
            infoMoneyView.from = @"home";
            [infoMoneyView setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:infoMoneyView animated:YES];
        } else {
            
            ZMLoginViewController *loginView = [[ZMLoginViewController alloc] init];
            loginView.entranceType = @"home_to_infoMoney";
            UINavigationController *loginNC = [[UINavigationController alloc] initWithRootViewController:loginView];
            [self presentViewController:loginNC animated:YES completion:nil];
        }
        
    } else if (sender.tag == 2) {
        NSLog(@"赚佣金");
        if ([[NSUserDefaults standardUserDefaults] boolForKey:IS_LOGIN]) {
        
            ZMGetCommissionViewController *commissionView = [[ZMGetCommissionViewController alloc] init];
            commissionView.isFromHome = YES;
            [commissionView setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:commissionView animated:YES];
        } else {
            
            ZMLoginViewController *loginView = [[ZMLoginViewController alloc] init];
            loginView.entranceType = @"home_to_commission";
            UINavigationController *loginNC = [[UINavigationController alloc] initWithRootViewController:loginView];
            [self presentViewController:loginNC animated:YES completion:nil];
        }
        
    } else if (sender.tag == 3) {
        NSLog(@"赚推介费");
        if ([[NSUserDefaults standardUserDefaults] boolForKey:IS_LOGIN]) {
        
            ZMMarketingViewController *marketingView = [[ZMMarketingViewController alloc] init];
            marketingView.isFromHome = YES;
            [marketingView setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:marketingView animated:YES];
        } else {
            
            ZMLoginViewController *loginView = [[ZMLoginViewController alloc] init];
            loginView.entranceType = @"home_to_marketing";
            UINavigationController *loginNC = [[UINavigationController alloc] initWithRootViewController:loginView];
            [self presentViewController:loginNC animated:YES completion:nil];
        }
        
    } else if (sender.tag == 4) {
        NSLog(@"包打听");
        ZMAllUnderstandViewController *allUnderstandVC = [[ZMAllUnderstandViewController alloc] init];
        allUnderstandVC.isHome = YES;
        [allUnderstandVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:allUnderstandVC animated:YES];
        
        //[self.tabBarController setSelectedIndex:2];
        
    } else if (sender.tag == 5) {
        NSLog(@"新手指南");
        ZMGuideViewController *guideVC = [[ZMGuideViewController alloc] init];
        guideVC.webUrl = @"http://m.brands500.cn/help.html";
        [guideVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:guideVC animated:YES];
        
    } else {
        NSLog(@"在线客服");
        
        QYSource *source = [[QYSource alloc] init];
        source.title =  @"芝麻商服";
        source.urlString = @"zmsf.qiyukf.com";
        QYSessionViewController *sessionViewController = [[QYSDK sharedSDK] sessionViewController];
        sessionViewController.sessionTitle = @"在线客服";
        sessionViewController.source = source;
        sessionViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:sessionViewController animated:YES];
        
        
        /** UI配置 */
        //头像
        NSString *avatarUrl;
        if ([[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:USER_TYPE]] isEqualToString:@"1"]) {
            avatarUrl = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Person_avatar]];
        } else if ([[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:USER_TYPE]] isEqualToString:@"2"]) {
            avatarUrl = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Com_avatar]];
        }
        [[QYSDK sharedSDK] customUIConfig].customerHeadImageUrl = avatarUrl;
        
        //返回按钮
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        button.frame=CGRectMake(0, 0, 64, 64);
        [button addTarget:self action:@selector(serviceViewBackAction) forControlEvents:UIControlEventTouchUpInside];
        button.imageEdgeInsets = UIEdgeInsetsMake(0,-50, 0, 10);
        UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithCustomView:button];
        sessionViewController.navigationItem.leftBarButtonItem = item;
    }
}

- (void)serviceViewBackAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 监听登陆成功之后跳转
- (void)home_to_infoMoney {

    ZMInfoMoneyViewController *infoMoneyView = [[ZMInfoMoneyViewController alloc] init];
    infoMoneyView.isFromHome = YES;
    infoMoneyView.from = @"home";
    [infoMoneyView setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:infoMoneyView animated:YES];
}

- (void)home_to_commission {
    
    ZMGetCommissionViewController *commissionView = [[ZMGetCommissionViewController alloc] init];
    commissionView.isFromHome = YES;
    [commissionView setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:commissionView animated:YES];
}

- (void)home_to_marketing {
    
    ZMMarketingViewController *marketingView = [[ZMMarketingViewController alloc] init];
    marketingView.isFromHome = YES;
    [marketingView setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:marketingView animated:YES];
}

- (void)home_to_user_center {
    self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:3];
}

/** 查看更多 */
- (void)checkMore:(UIButton *)sender {

    if (sender.tag == 1) {
    
        /** 明星会员 */
        ZMVipViewController *vipView = [[ZMVipViewController alloc] init];
        [vipView setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:vipView animated:YES];
    }else if (sender.tag == 2) {
    
        /** 最新商机 */
        ZMShareViewController *shareView = [[ZMShareViewController alloc] init];
        shareView.isHome = YES;
        [shareView setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:shareView animated:YES];
    }
}

//login next
- (void)MySelfLoginNextAc{
    
    self.currentView.homeCollectionView.contentOffset = CGPointMake(0, 0);
    [self.tabBarController setSelectedIndex:0];
}




#pragma mark - rootView开启和关闭右滑返回
//禁用边缘返回
-(void)forbiddenSideBack{
    
    self.isCanSideBack = NO;
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        
        self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    }
}

//恢复边缘返回
- (void)resetSideBack {
    
    self.isCanSideBack=YES;
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer {
    return self.isCanSideBack;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
