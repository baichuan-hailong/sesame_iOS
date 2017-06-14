//
//  ZMMyselfViewController.m
//  SesameService
//
//  Created by 娄耀文 on 17/3/22.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMMyselfViewController.h"
#import "ZMMyselfDetailTableViewCell.h"
#import "ZMMyselfStarDetailTableViewCell.h"
#import "ZMMyselfPersonTableViewCell.h"
#import "ZMExitTableViewCell.h"
#import "ZMMyselfStartsManage.h"
#import "ZMMyselfView.h"

#import "ZMEditDataViewController.h"
#import "ZMMyCreditViewController.h"
#import "ZMWordOfMouthViewController.h"
#import "ZMReleaseBusinessViewController.h"
#import "ZMMySaleViewController.h"
#import "ZMBuyingBusinessViewController.h"
#import "ZMMyDelegateViewController.h"

#import "ZMVipPrivilegeViewController.h"
#import "ZMMyInvitationsViewController.h"


//new change
#import "ZMUserDataViewController.h"

#import "ZMInformationTransactionsViewController.h"
#import "ZMCommissionViewController.h"
#import "ZMPromoteIntroduceViewController.h"
#import "ZMMySounceViewController.h"
#import "ZMMyInvitationsViewController.h"

#import "ZMTradingDetailViewController.h"
#import "ZMBanckAccountViewController.h"
#import "ZMMyInvoiceViewController.h"
#import "ZMMyComplaintsViewController.h"


@interface ZMMyselfViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) ZMMyselfView       *myselfView;
@property (nonatomic, strong) NSArray            *twoArray;
@property (nonatomic, strong) NSArray            *threeArray;

//用户类型
@property (nonatomic, strong) NSString *userType;
//person
@property (nonatomic, strong) NSDictionary *personDic;

//@property (nonatomic, strong) UIAlertController *alertDialog;
//@property (nonatomic, strong) UIAlertAction *okAction;
//@property (nonatomic, strong) UIAlertAction *cancle;




@end

@implementation ZMMyselfViewController

- (void)loadView {
    
    //change
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.myselfView    = [[ZMMyselfView alloc] initWithFrame:SCREEN_BOUNDS];
    self.view                                 = self.myselfView;
    self.myselfView.myselTableView.delegate   = self;
    self.myselfView.myselTableView.dataSource = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.interactivePopGestureRecognizer.enabled  = YES;

    self.title = @"我的";
    self.twoArray   = @[@{@"tipIm":@"section1Image",@"tipStr":@"我的信息交易"},
                      @{@"tipIm":@"section2Image",@"tipStr":@"我的佣金交易"},
                        @{@"tipIm":@"section3Image",@"tipStr":@"我的推介交易"},
                        @{@"tipIm":@"section4Image",@"tipStr":@"我的打听"},
                        @{@"tipIm":@"myselfInviteFriedFiveImage",@"tipStr":@"邀请好友赚奖金"}];
    
    //@{@"tipIm":@"myselfInviteFriedFiveImage",@"tipStr":@"邀请好友赚奖金"}
    
    self.threeArray = @[@{@"tipIm":@"section5Image",@"tipStr":@"交易明细"},
                        @{@"tipIm":@"section6Image",@"tipStr":@"收款账号"},
                        @{@"tipIm":@"section8Image",@"tipStr":@"我的投诉"},
                        @{@"tipIm":@"section9Image",@"tipStr":@"联系客服"}];

    
    
    
    [self showUserInfo];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(MySelfLoginNextAc)
                                                 name:@"MySelfLoginNextAction"
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(uploadAvatarSuccessfulAc)
                                                 name:@"uploadAvatarSuccessful"
                                               object:nil];

    //bug
    [self obtainUserInfo];
}

-(void)viewWillAppear:(BOOL)animated{
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:IS_LOGIN]) {
        [self showUserInfo];
    }
   
    
    [self.myselfView.myselTableView setContentOffset:CGPointMake(0, 0) animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    //pop
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}
//bug
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

#pragma mark - 更新用户信息
- (void)showUserInfo{
    //用户Type
    self.userType = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:USER_TYPE]];
    
    
    
    if ([self.userType isEqualToString:@"1"]) {
        //个人头像
        NSString *person_avatar = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Person_avatar]];
        //个人是否认证
        NSString *person_auth = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Person_auth]];
        //个人姓名
        NSString *person_name = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Person_name]];
        //个人等级
        NSString *person_level = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Person_level]];
        
        //person top
        self.personDic = @{@"avatar":person_avatar,
                           @"auth"  :person_auth,
                           @"person_name":person_name,
                           @"level":person_level};
        [self.myselfView.myselTableView reloadData];
        
        //个人是否认证
        NSString *isPersonAuth = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Person_auth]];
        if ([isPersonAuth isEqualToString:@"unauthed"]) {
            //未认证
        }else if ([isPersonAuth isEqualToString:@"authed"]){
            //已认证
        }else if ([isPersonAuth isEqualToString:@"unchecked"]){
            //待审核
            //bug
            [self obtainUserInfo];
        }else if ([isPersonAuth isEqualToString:@"failed"]){
            //未通过
        }else{
            //bug
            [self obtainUserInfo];
        }
    }else{
        //头像
        NSString *person_avatar = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Com_avatar]];
        //是否认证
        NSString *person_auth = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Com_auth]];
        //名称
        NSString *person_name = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Com_name]];
        //等级
        NSString *person_level = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Com_level]];
        
        //person top
        self.personDic = @{@"avatar":person_avatar,
                           @"auth"  :person_auth,
                           @"person_name":person_name,
                           @"level":person_level};
        [self.myselfView.myselTableView reloadData];
        
        //公司是否认证
        NSString *isComAuth = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Com_auth]];
        if ([isComAuth isEqualToString:@"unauthed"]) {
            //未认证
        }else if ([isComAuth isEqualToString:@"authed"]){
            //已认证
        }else if ([isComAuth isEqualToString:@"unchecked"]){
            //待审核
            //bug
            [self obtainUserInfo];
        }else if ([isComAuth isEqualToString:@"failed"]){
            //未通过
        }else{
            //bug
            [self obtainUserInfo];
        }
    }
}


#pragma mark - Avatar upload successful
- (void)uploadAvatarSuccessfulAc{
    
    //个人头像
    NSString *person_avatar = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Person_avatar]];
    //个人是否认证
    NSString *person_auth = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Person_auth]];
    //个人姓名
    NSString *person_name = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Person_name]];
    //个人等级
    NSString *person_level = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Person_level]];
    
    //person top
    self.personDic = @{@"avatar":person_avatar,
                       @"auth"  :person_auth,
                       @"person_name":person_name,
                       @"level":person_level};
    
    [self.myselfView.myselTableView reloadData];
}


#pragma mark - 登录成功
- (void)MySelfLoginNextAc{
    NSLog(@"--- myself(select Type or no select Type) login successful --- ");
    self.myselfView.myselTableView.contentOffset = CGPointMake(0, SCREEN_WIDTH/375*0);
    [self obtainUserInfo];
}


#pragma mark - Obtain User Info
- (void)obtainUserInfo{
    //sender coder
    
    NSString *urlStr   = [NSString stringWithFormat:@"%@/user/my-info",APIDev];
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:nil withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"myself ----------------- %@",object);
        
        NSString *stateStr    = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            NSString *typeStr = [NSString stringWithFormat:@"%@",object[@"data"][@"type"]];
            
            //update
            [[NSUserDefaults standardUserDefaults] setObject:typeStr forKey:USER_TYPE];
            self.userType = typeStr;
            
            
            if ([typeStr isEqualToString:@"1"]) {
                //personal
                
                //个人头像
                [[NSUserDefaults standardUserDefaults] setObject:object[@"data"][@"avatar"]     forKey:Person_avatar];
                //个人是否认证
                [[NSUserDefaults standardUserDefaults] setObject:object[@"data"][@"auth"]        forKey:Person_auth];
                //个人姓名
                [[NSUserDefaults standardUserDefaults] setObject:object[@"data"][@"person_name"] forKey:Person_name];
                //个人等级
                [[NSUserDefaults standardUserDefaults] setObject:object[@"data"][@"level"]       forKey:Person_level];
                
                
                NSString *person_avatar = [NSString stringWithFormat:@"%@",object[@"data"][@"avatar"]];
                NSString *person_auth = [NSString stringWithFormat:@"%@",object[@"data"][@"auth"] ];
                NSString *person_name = [NSString stringWithFormat:@"%@",object[@"data"][@"person_name"]];
                NSString *person_level = [NSString stringWithFormat:@"%@",object[@"data"][@"level"]];
                
                self.personDic = @{@"avatar":person_avatar,
                                   @"auth"  :person_auth,
                                   @"person_name":person_name,
                                   @"level":person_level};
                
                
                [self.myselfView.myselTableView reloadData];
                
                
                //个人主营业务
                [[NSUserDefaults standardUserDefaults] setObject:object[@"data"][@"main_biz"] forKey:Person_main_biz];
                
                //个人性别
                [[NSUserDefaults standardUserDefaults] setObject:object[@"data"][@"gender"]    forKey:Person_gender];
                //个人联系电话
                [[NSUserDefaults standardUserDefaults] setObject:object[@"data"][@"telphone"]  forKey:Person_telphone];
                //个人邮箱
                [[NSUserDefaults standardUserDefaults] setObject:object[@"data"][@"email"]     forKey:Person_email];
                //个人公司名称
                [[NSUserDefaults standardUserDefaults] setObject:object[@"data"][@"corp_name"] forKey:Person_corp_name];
                //个人现任职务
                [[NSUserDefaults standardUserDefaults] setObject:object[@"data"][@"title"]     forKey:Person_title];
                //个人所在城市
                [[NSUserDefaults standardUserDefaults] setObject:object[@"data"][@"city"]      forKey:Person_city];
                NSLog(@"%@",object[@"data"][@"auth_title"]);
                
            }else if([typeStr isEqualToString:@"2"]){
                //company
                //公司头像
                [[NSUserDefaults standardUserDefaults] setObject:object[@"data"][@"avatar"]    forKey:Com_avatar];
                //公司是否认证
                [[NSUserDefaults standardUserDefaults] setObject:object[@"data"][@"auth"]      forKey:Com_auth];
                //公司姓名
                [[NSUserDefaults standardUserDefaults] setObject:object[@"data"][@"corp_name"] forKey:Com_name];
                //公司等级
                [[NSUserDefaults standardUserDefaults] setObject:object[@"data"][@"level"]     forKey:Com_level];
                
                NSString *com_avatar = [NSString stringWithFormat:@"%@",object[@"data"][@"avatar"]];
                NSString *com_auth = [NSString stringWithFormat:@"%@",object[@"data"][@"auth"] ];
                NSString *com_name = [NSString stringWithFormat:@"%@",object[@"data"][@"corp_name"]];
                NSString *com_level = [NSString stringWithFormat:@"%@",object[@"data"][@"level"]];
                self.personDic = @{@"avatar":com_avatar,
                                   @"auth"  :com_auth,
                                   @"person_name":com_name,
                                   @"level":com_level};
                
                [self.myselfView.myselTableView reloadData];
                
                
                //公司主营业务
                [[NSUserDefaults standardUserDefaults] setObject:object[@"data"][@"main_biz"] forKey:Com_main_biz];
                
                //公司性质
                [[NSUserDefaults standardUserDefaults] setObject:object[@"data"][@"corp_property"]  forKey:Com_property];
                //公司城市
                [[NSUserDefaults standardUserDefaults] setObject:object[@"data"][@"city"]     forKey:Com_city];
                //公司-联系人姓名
                [[NSUserDefaults standardUserDefaults] setObject:object[@"data"][@"person_name"] forKey:Com_contact_name];
                //公司-联系人职务
                [[NSUserDefaults standardUserDefaults] setObject:object[@"data"][@"title"]     forKey:Com_contact_position];
                //公司-联系人电话
                [[NSUserDefaults standardUserDefaults] setObject:object[@"data"][@"telphone"]      forKey:Com_contact_tel];
                
                
                
            }
            
            
        }else{
            [self showProgress:object[@"status"][@"message"]];
        }
    } withFailureBlock:^(NSError *error) {
        NSLog(@"myself ---------------------------------------------------- %@",error);
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}





#pragma mark - TableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==0) {
        return 1;
    }else if (section==1){
        return self.twoArray.count;
    }else if (section==2){
        return self.threeArray.count;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return SCREEN_WIDTH/375*13;
    }else if (section==1){
        return SCREEN_WIDTH/375*13;
    }else if (section==2){
        return SCREEN_WIDTH/375*14;
    }else{
        return SCREEN_WIDTH/375*15;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header         = [[UIView alloc] init];
    header.backgroundColor = [UIColor clearColor];
    return header;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section==0) {
        return SCREEN_WIDTH/375*0;
    }else if (section==1){
        return SCREEN_WIDTH/375*0;
    }else if (section==2){
        return SCREEN_WIDTH/375*0;
    }else{
        return SCREEN_WIDTH/375*25;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *headerView         = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return SCREEN_WIDTH/375*87;
    }else{
        return SCREEN_WIDTH/375*50;
    }
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIndentifire = @"myselfPersonCell";
    static NSString *cellIndfdes     = @"myselfDesfilCell";
    static NSString *cellExit        = @"myselfExitCell";
    
    if (indexPath.section==0) {
        ZMMyselfPersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifire];
        if (!cell) {
            cell = [[ZMMyselfPersonTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifire];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        //name level auth
        [cell setPersonCell:self.personDic];
        return cell;
    }else if (indexPath.section==3){
        ZMExitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellExit];
        if (!cell) {
            cell = [[ZMExitTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellExit];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }else{
        
        ZMMyselfDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndfdes];
        if (!cell) {
            cell = [[ZMMyselfDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndfdes];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        if (indexPath.section==1) {
            NSDictionary *dic = self.twoArray[indexPath.row];
            [cell setDetaillCell:dic];
            cell.rightLabel.alpha = 0;
            if (indexPath.row==self.twoArray.count-2){
                cell.biuLine.alpha = 1;
                cell.detailImageView.contentMode     = UIViewContentModeScaleAspectFit;
                //cell.detailImageView.backgroundColor = [UIColor redColor];
                cell.detailImageView.frame = CGRectMake(SCREEN_WIDTH/375*23,
                                                        SCREEN_WIDTH/375*15,
                                                        SCREEN_WIDTH/375*20,
                                                        SCREEN_WIDTH/375*22);
            }else if (indexPath.row==self.twoArray.count-1){
                cell.biuLine.alpha = 0;
                cell.detailImageView.contentMode     = UIViewContentModeScaleAspectFit;
                //cell.detailImageView.backgroundColor = [UIColor redColor];
            }else{
                cell.biuLine.alpha = 1;
                cell.detailImageView.contentMode     = UIViewContentModeScaleAspectFill;
                //cell.detailImageView.backgroundColor = [UIColor yellowColor];
            }
        }else if (indexPath.section==2){
            NSDictionary *dic = self.threeArray[indexPath.row];
            [cell setDetaillCell:dic];
            if (indexPath.row==2||indexPath.row==0) {
                cell.detailImageView.contentMode     = UIViewContentModeScaleAspectFit;
            }else{
                cell.detailImageView.contentMode     = UIViewContentModeScaleAspectFill;
            }
            
            if (indexPath.row==self.threeArray.count-1) {
                cell.biuLine.alpha = 0;
                cell.rightLabel.alpha= 1;
                cell.rightLabel.text = @"400-831-9003";
            }else{
                cell.rightLabel.alpha= 0;
                cell.biuLine.alpha   = 1;
            }
        }
        
        return cell;
        
    }
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0) {
        NSLog(@"person");
        ZMUserDataViewController *userDataVC = [[ZMUserDataViewController alloc] init];
        if ([self.userType isEqualToString:@"1"]) {
            userDataVC.userType = @"1";
        }else{
            userDataVC.userType = @"2";
        }
        
        [userDataVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:userDataVC animated:YES];
    }else if (indexPath.section==1){
        
         if (indexPath.row==0) {
            
             ZMInformationTransactionsViewController *infoTranVC = [[ZMInformationTransactionsViewController alloc] init];
             [infoTranVC setHidesBottomBarWhenPushed:YES];
             [self.navigationController pushViewController:infoTranVC animated:YES];
         }else if (indexPath.row==1){
             
             ZMCommissionViewController *commissionVC = [[ZMCommissionViewController alloc] init];
             [commissionVC setHidesBottomBarWhenPushed:YES];
             [self.navigationController pushViewController:commissionVC animated:YES];
         }else if (indexPath.row==2){
             
             ZMPromoteIntroduceViewController *promoteIntroduceVC = [[ZMPromoteIntroduceViewController alloc] init];
             [promoteIntroduceVC setHidesBottomBarWhenPushed:YES];
             [self.navigationController pushViewController:promoteIntroduceVC animated:YES];
         }else if (indexPath.row==3){
             
             ZMMySounceViewController *mySounceVC = [[ZMMySounceViewController alloc] init];
             [mySounceVC setHidesBottomBarWhenPushed:YES];
             [self.navigationController pushViewController:mySounceVC animated:YES];
         }else{
         
             //NSLog(@"invite");
             ZMMyInvitationsViewController *inviteVC = [[ZMMyInvitationsViewController alloc] init];
             [inviteVC setHidesBottomBarWhenPushed:YES];
             [self.navigationController pushViewController:inviteVC animated:YES];
         }
        
    }else if (indexPath.section==2){
        
         if (indexPath.row==0) {
             
             ZMTradingDetailViewController *tradingVC = [[ZMTradingDetailViewController alloc] init];
             [tradingVC setHidesBottomBarWhenPushed:YES];
             [self.navigationController pushViewController:tradingVC animated:YES];
         }else if (indexPath.row==1){
             
             NSLog(@"pay account");
             ZMBanckAccountViewController *myPayMentAccountVC = [[ZMBanckAccountViewController alloc] init];
             [myPayMentAccountVC setHidesBottomBarWhenPushed:YES];
             [self.navigationController pushViewController:myPayMentAccountVC animated:YES];
         }else if (indexPath.row==2){
             
            
             ZMMyComplaintsViewController *complaintsVC = [[ZMMyComplaintsViewController alloc] init];
             [complaintsVC setHidesBottomBarWhenPushed:YES];
             [self.navigationController pushViewController:complaintsVC animated:YES];
             
         }else{
             
             NSLog(@"tel");
             NSMutableString* str = [[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"400-8319-003"];
             //NSLog(@"str======%@",str);
             [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
             
         }
        
    }else{
        NSLog(@"out");
        [self evokeLogout];
    }
    
}

#pragma mark - Logout
- (void)evokeLogout{
    
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:nil
                                                                         message:@"确认要退出登录吗？"
                                                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction        = [UIAlertAction actionWithTitle:@"确定"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction *action) {
                                                                
                                                                [self okOpeAction];
                                                            }];
    UIAlertAction *cancle          = [UIAlertAction actionWithTitle:@"取消"
                                                              style:UIAlertActionStyleCancel
                                                            handler:^(UIAlertAction *action) {
                                                            }];
    
    [cancle setValue:[UIColor colorWithHex:@"000000"] forKey:@"titleTextColor"];
    [alertDialog addAction:cancle];
    [alertDialog addAction:okAction];
    [self presentViewController:alertDialog animated:YES completion:nil];
    
    NSLog(@"out present");
}



- (void)okOpeAction{
    NSLog(@"ok");
    
    /** 注销网易七鱼 */
    [[QYSDK sharedSDK] logout:^(){}];
    
    //bug
    ZMMyselfPersonTableViewCell *personCell = [self.myselfView.myselTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [personCell.headerImageViwe sd_cancelCurrentImageLoad];
    
    self.myselfView.myselTableView.contentOffset = CGPointMake(0, SCREEN_WIDTH/375*0);
    
    //remove
    [[NSUserDefaults standardUserDefaults] setObject:nil  forKey:USER_ID];
    [[NSUserDefaults standardUserDefaults] setObject:nil  forKey:TOKEN];
    [[NSUserDefaults standardUserDefaults] setObject:nil  forKey:USER_TYPE];
    [[NSUserDefaults standardUserDefaults] setBool:NO     forKey:IS_LOGIN];
    
    //person
    [[NSUserDefaults standardUserDefaults] setObject:nil  forKey:Person_avatar];
    [[NSUserDefaults standardUserDefaults] setObject:nil  forKey:Person_auth];
    [[NSUserDefaults standardUserDefaults] setObject:nil  forKey:Person_level];
    
    [[NSUserDefaults standardUserDefaults] setObject:nil  forKey:Person_name];
    [[NSUserDefaults standardUserDefaults] setObject:nil  forKey:Person_gender];
    [[NSUserDefaults standardUserDefaults] setObject:nil  forKey:Person_telphone];
    [[NSUserDefaults standardUserDefaults] setObject:nil  forKey:Person_email];
    [[NSUserDefaults standardUserDefaults] setObject:nil  forKey:Person_corp_name];
    [[NSUserDefaults standardUserDefaults] setObject:nil  forKey:Person_title];
    [[NSUserDefaults standardUserDefaults] setObject:nil  forKey:Person_city];
    [[NSUserDefaults standardUserDefaults] setObject:nil  forKey:Person_main_biz];
    
    
    //company
    [[NSUserDefaults standardUserDefaults] setObject:nil  forKey:Com_avatar];
    [[NSUserDefaults standardUserDefaults] setObject:nil  forKey:Com_auth];
    [[NSUserDefaults standardUserDefaults] setObject:nil  forKey:Com_level];
    [[NSUserDefaults standardUserDefaults] setObject:nil  forKey:Com_name];
    
    [[NSUserDefaults standardUserDefaults] setObject:nil  forKey:Com_property];
    [[NSUserDefaults standardUserDefaults] setObject:nil  forKey:Com_city];
    [[NSUserDefaults standardUserDefaults] setObject:nil  forKey:Com_contact_name];
    [[NSUserDefaults standardUserDefaults] setObject:nil  forKey:Com_contact_position];
    [[NSUserDefaults standardUserDefaults] setObject:nil  forKey:Com_contact_tel];
    
    
    //first page
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loginOutNextAction" object:nil];
    //[self.tabBarController setSelectedIndex:0];
}



#pragma mark - 会员查看
- (void)lookPersonClickAction:(UIButton *)sender{
    NSLog(@"look");
    ZMVipPrivilegeViewController *vipPrivilegeVC = [[ZMVipPrivilegeViewController alloc] init];
    [vipPrivilegeVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vipPrivilegeVC animated:YES];
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


@end
