//
//  ZMShareDetailViewController.m
//  SesameService
//
//  Created by 娄耀文 on 17/3/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMShareDetailViewController.h"
#import "ZMShareDetailView.h"
#import "ZMShareTopCell.h"
#import "ZMShareSuggestCell.h"
#import "ZMShareDetailCell.h"
#import "ZMPersonalVipViewController.h"
#import "ZMCompanyVipViewController.h"
#import "ZMPayViewController.h"
#import "ZMLoginViewController.h"
#import "ZMMoreInfoMoneyViewController.h"

@interface ZMShareDetailViewController () <UITableViewDelegate,
                                           UITableViewDataSource>

@property (nonatomic, strong) ZMShareDetailView *currentView;
@property (nonatomic, strong) NSDictionary      *dataSource;
@property (nonatomic, strong) MBProgressHUD     *hud;


@end

@implementation ZMShareDetailViewController

- (void)loadView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.currentView = [[ZMShareDetailView alloc] initWithFrame:SCREEN_BOUNDS];
    self.view        = self.currentView;
    self.currentView.detailTableView.delegate   = self;
    self.currentView.detailTableView.dataSource = self;
    self.currentView.detailTableView.alpha = 0;
    self.currentView.footView.alpha = 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"信息详情";
    
    [self loadDataSources];
    
    [self.currentView.buyBtn addTarget:self
                                action:@selector(buyBtnClickedAction:)
                      forControlEvents:UIControlEventTouchUpInside];
    
    [self.currentView.serviceBtn addTarget:self
                                action:@selector(toService)
                      forControlEvents:UIControlEventTouchUpInside];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(businessDetail_to_buyView) name:@"businessDetail_to_buyView" object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

#pragma mark - dataSources
- (void)loadDataSources {
    
    [self hud];
    NSString     *urlStr   = [NSString stringWithFormat:@"%@/info/business-detail",APIDev];
    NSDictionary *param = @{@"id":_detailID};
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:param withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"%@",object);
        
        _dataSource = object[@"data"];
        
        [self.hud hide:YES];
        if ([[NSString stringWithFormat:@"%@",object[@"status"][@"state"]] isEqualToString:@"success"]) {

            /** 先判断问题状态 */
            if ([[NSString stringWithFormat:@"%@",_dataSource[@"info"][@"status"]] isEqualToString:@"dealt_pending"] ||
                [[NSString stringWithFormat:@"%@",_dataSource[@"info"][@"status"]] isEqualToString:@"rate_done"]) {
                [self.currentView.buyBtn setBackgroundImage:[toolClass imageWithColor:[UIColor colorWithHex:@"cccccc"] size:self.currentView.buyBtn.frame.size] forState:UIControlStateNormal];
                [self.currentView.buyBtn setTitle:@"被买走了" forState:UIControlStateNormal];
                self.currentView.buyBtn.userInteractionEnabled = NO;
            }
            
            self.currentView.priceLable.text = [NSString stringWithFormat:@"¥%@",_dataSource[@"info"][@"price"]];
            [self.currentView.detailTableView reloadData];
            [UIView animateWithDuration:0.28 animations:^{
                self.currentView.detailTableView.alpha = 1;
                self.currentView.footView.alpha = 1;
            }];
            
        } else {
            [toolClass showProgress:[NSString stringWithFormat:@"%@",object[@"status"][@"message"]] toView:self.view];
        }
        
        
        
        
    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
        
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}



#pragma mark - UITableView Delegate & Datasource
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return nil;
    } else {
        
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 12, SCREEN_WIDTH, 45)];
//        view.backgroundColor = [UIColor colorWithHex:backColor];
//        
//        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 12, SCREEN_WIDTH, SCREEN_WIDTH/8.33)];
//        titleLable.backgroundColor = [UIColor whiteColor];
//        titleLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/23.43 weight:3];
//        titleLable.textColor = [UIColor colorWithHex:@"333333"];
//        titleLable.textAlignment = NSTextAlignmentCenter;
//        
//        if (section == 1) {
//            titleLable.text = @"平台审核意见";
//        } else if (section == 2) {
//            titleLable.text = @"项目信息";
//        } else if (section == 3) {
//            titleLable.text = @"对服务商的要求";
//        } else if (section == 4) {
//            titleLable.text = @"发布人信息";
//        } else {
//            titleLable.text = @"";
//        }
//        [view addSubview:titleLable];
//        
//        return view;
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.1;
    } else {
        return 12 /*+ SCREEN_WIDTH/8.33*/;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([[NSString stringWithFormat:@"%@",_dataSource[@"info"][@"is_more_info"]] isEqualToString:@"1"]) {
        return 4;
    } else {
        return 3;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 1;
    } else if (section == 2) {
        return 7;
    } else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        
        NSString *content = [NSString stringWithFormat:@"%@",_dataSource[@"info"][@"title"]];
        CGSize titleSize = [content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - SCREEN_WIDTH/12.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:SCREEN_WIDTH/26.78]} context:nil].size;
        
        return SCREEN_WIDTH/8 + titleSize.height;
        
    } else if (indexPath.section == 1) {
        return SCREEN_WIDTH/3.125;
    } else if (indexPath.section == 2){
        
        NSString *currentStr;
        if (indexPath.row == 0) {
            currentStr = [[NSString stringWithFormat:@"%@",_dataSource[@"info"][@"biz_locate"]] stringByReplacingOccurrencesOfString:@"^" withString:@" "];
        } else if (indexPath.row == 1) {
            currentStr = _dataSource[@"info"][@"type"];
        } else if (indexPath.row == 2) {
            currentStr = [[NSString stringWithFormat:@"%@",_dataSource[@"info"][@"target_amount"]] isEqualToString:@"<null>"] ? @"--" : _dataSource[@"info"][@"target_amount"][@"title"];
        } else if (indexPath.row == 3) {
            currentStr = [toolClass changeTimeToDay:[NSString stringWithFormat:@"%@",_dataSource[@"info"][@"time"]]];
        } else if (indexPath.row == 4) {
            currentStr = @"购买可见";
        } else if (indexPath.row == 5) {
            currentStr = [[NSString stringWithFormat:@"%@",_dataSource[@"info"][@"support_level"]] isEqualToString:@"<null>"] ? @"--" : _dataSource[@"info"][@"support_level"][@"title"];;
        } else {
            currentStr = _dataSource[@"info"][@"description"];
        }
        
        /* 计算Lable实际高度 */
        CGSize size = CGSizeMake(SCREEN_WIDTH - SCREEN_WIDTH/3.41, 0);
        CGSize autoSize = [[UILabel new] actualSizeOfLable:[NSString stringWithFormat:@"%@",currentStr]
                                                   andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/26.78] andSize:size];
        
        return (SCREEN_WIDTH/8.33 - SCREEN_WIDTH/26.78) + autoSize.height;
        
    } else {
        return SCREEN_WIDTH/8.33;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString *cellIndentifire = [NSString stringWithFormat:@"%ld%ld",(long)indexPath.section,(long)indexPath.row];
    
    if (indexPath.section == 0) {
        
        ZMShareTopCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifire];
        if (!cell) {
            cell = [[ZMShareTopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifire];
        }
        
        [cell setValueWithDic:_dataSource];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.section == 1){
        
        ZMShareSuggestCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifire];
        if (!cell) {
            cell = [[ZMShareSuggestCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifire];
        }
        [cell setValueWithDic:_dataSource];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if ([[NSString stringWithFormat:@"%@",_dataSource[@"info"][@"mask"]] isEqualToString:@"0"]) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        return cell;
    } else if (indexPath.section == 2){
        
        ZMShareDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifire];
        if (!cell) {
            cell = [[ZMShareDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifire];
        }
        cell.tag = indexPath.row;
        [cell setValueWithDic:_dataSource ofSection:indexPath.section];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            cell.line.alpha = 0;
        } else {
            cell.line.alpha = 1;
        }
        return cell;
    } else {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifire];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifire];
        }
        cell.textLabel.text = @"更多项目信息";
        cell.textLabel.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78];
        cell.textLabel.textColor = [UIColor colorWithHex:@"333333"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section == 1) {
    
        /* 用户信息 */
        NSLog(@"用户信息");
        if ([[NSString stringWithFormat:@"%@",_dataSource[@"info"][@"mask"]] isEqualToString:@"0"]) {
            
            //明星会员
            if ([[NSString stringWithFormat:@"%@",_dataSource[@"asker"][@"type"]] isEqualToString:@"1"]) {
                /** 个人 */
                ZMPersonalVipViewController *personalVipVC = [[ZMPersonalVipViewController alloc] init];
                [personalVipVC setHidesBottomBarWhenPushed:YES];
                personalVipVC.personID = [NSString stringWithFormat:@"%@",_dataSource[@"asker"][@"id"]];
                [self.navigationController pushViewController:personalVipVC animated:YES];
                
            }else{
                /** 企业 */
                ZMCompanyVipViewController *companyVipVC = [[ZMCompanyVipViewController alloc] init];
                [companyVipVC setHidesBottomBarWhenPushed:YES];
                companyVipVC.companyID = [NSString stringWithFormat:@"%@",_dataSource[@"asker"][@"id"]];
                [self.navigationController pushViewController:companyVipVC animated:YES];
            }
        }
        
    } else if (indexPath.section == 3) {
    
        /*更多项目信息*/
        NSLog(@"更多项目信息");
//        NSString *titleUTF8Str = [_dataSource[@"info"][@"title"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        NSString *encodeUrl = [NSString stringWithFormat:@"%@#info=%@&title=%@&fee=%@&mask=%@&mode=static&token=%@",dynamicFormUrl,_detailID,
//                                    titleUTF8Str,_dataSource[@"info"][@"price"],_dataSource[@"info"][@"mask"],
//                                    [[NSUserDefaults standardUserDefaults] objectForKey:TOKEN]];
        
        NSString *encodeUrl = [NSString stringWithFormat:@"%@/member/info_more.html?id=%@&fromApp=1",h5Dev,_detailID];
        
        ZMMoreInfoMoneyViewController *moreView = [[ZMMoreInfoMoneyViewController alloc] init];
        moreView.titleStr = @"更多项目信息";
        moreView.webUrl   = encodeUrl;
        [self.navigationController pushViewController:moreView animated:YES];
    }
}



#pragma mark - 立即买走
- (void)buyBtnClickedAction:(UIButton *)sender{

    if ([[NSUserDefaults standardUserDefaults] boolForKey:IS_LOGIN]) {
        
        ZMPayViewController *payVC = [[ZMPayViewController alloc] init];
        payVC.isInfo = YES;
        payVC.infoID = [NSString stringWithFormat:@"%@",_dataSource[@"info"][@"id"]];
        payVC.infoTitle= [NSString stringWithFormat:@"%@",_dataSource[@"info"][@"title"]];
        payVC.money  = [NSString stringWithFormat:@"%@",_dataSource[@"info"][@"price"]];
        [self.navigationController pushViewController:payVC animated:YES];
    } else {
        
        ZMLoginViewController *loginView = [[ZMLoginViewController alloc] init];
        loginView.entranceType = @"businessDetail_to_buyView";
        UINavigationController *loginNC = [[UINavigationController alloc] initWithRootViewController:loginView];
        [self presentViewController:loginNC animated:YES completion:nil];
    }
}

- (void)businessDetail_to_buyView {
    
    ZMPayViewController *payVC = [[ZMPayViewController alloc] init];
    payVC.isInfo = YES;
    payVC.infoID = [NSString stringWithFormat:@"%@",_dataSource[@"info"][@"id"]];
    payVC.infoTitle = [NSString stringWithFormat:@"%@",_dataSource[@"info"][@"title"]];
    payVC.money  = [NSString stringWithFormat:@"%@",_dataSource[@"info"][@"price"]];
    [self.navigationController pushViewController:payVC animated:YES];
}

#pragma mark - 客服
- (void)toService {

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

- (void)serviceViewBackAction {
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - getter
- (MBProgressHUD *)hud {
    
    if (_hud == nil) {
        
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _hud.userInteractionEnabled = NO;
        _hud.removeFromSuperViewOnHide = YES;
    }
    return _hud;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
