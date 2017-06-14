//
//  ZMMyInvitationsViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/25.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMMyInvitationsViewController.h"
#import "ZMMyInvitionsView.h"

#import "ZMInvitationUserInfoTableViewCell.h"
#import "ZMInvitationMoneyTableViewCell.h"
#import "ZMInvitateAcTableViewCell.h"
#import "ZMCommissionDetailMoreTableViewCell.h"
#import "ZMInvitateBottomTableViewCell.h"

#import "BFShareView.h"
#import "BFShareQrCodeView.h"

#import "ZMInvitedRecordViewController.h"

#import "WeiboSDK.h"

@interface ZMMyInvitationsViewController ()<UITableViewDelegate,UITableViewDataSource,BFShareViewDelegate>
@property (nonatomic , strong) ZMMyInvitionsView *myInvitionsView;
@property (nonatomic , strong) NSArray           *moreArray;
@property (nonatomic , strong) BFShareView       *shareView;
@property (nonatomic , strong) BFShareQrCodeView *qrCodeView;
@property (nonatomic , strong) MBProgressHUD     *HUD;
@property (nonatomic , strong) NSDictionary      *topDic;

@property (nonatomic , strong) NSString          *ruleString;
@end

@implementation ZMMyInvitationsViewController

- (void)loadView {
    //change
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.myInvitionsView   = [[ZMMyInvitionsView alloc] initWithFrame:SCREEN_BOUNDS];
    self.view              = self.myInvitionsView;
    self.myInvitionsView.invitionsTableView.delegate   = self;
    self.myInvitionsView.invitionsTableView.dataSource = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的邀请";
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(shareSuccessfulAc)
                                                 name:@"shareSuccessful"
                                               object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(shareFailed)
                                                 name:@"shareFailed"
                                               object:nil];
    
    
    
    
    self.topDic    = @{@"count":@"--",@"money":@"--"};
    
    self.moreArray = @[@{@"left":@"我的邀请记录",@"right":@"--"},
                       @{@"left":@"我的专属二维码",@"right":@"--"}];
    
    
    self.ruleString = @"1、每推荐一位好友注册成为个人会员并完成实名认证，或者每推荐一位好友注册成为企业会员并完成企业认证，您可获得--元奖金。\n2、好友每成功买下/售出一条信息，您都可以获得--元奖金。\n3、好友每次成功赚到佣金或推介费，您都可以获得--元奖金。\n4、活动有效期截至：---。\n5、活动最终解释权归芝麻商服所有。";
    
    [self evokeSouceData];
    
    [self evokeRulesData];
}



#pragma mark - Load Data
- (void)evokeSouceData{
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    [self.HUD show:YES];
    NSString *urlStr   = [NSString stringWithFormat:@"%@/user/invite-count",APIDev];
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:nil withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"invite-count--- %@",object);
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            NSString *count = [NSString stringWithFormat:@"%@",object[@"data"][@"user_count"]];
            NSString *money = [NSString stringWithFormat:@"%@",object[@"data"][@"total_reward"]];
            self.topDic    = @{@"count":count,@"money":money};
            //self.topDic    = @{@"count":@"999",@"money":@"9999.99"};
            [self.myInvitionsView.invitionsTableView reloadData];
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


- (void)evokeRulesData{
    
    NSString *urlStr   = [NSString stringWithFormat:@"%@/common/invite-rules",APIDev];
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:nil withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"invite-rules--- %@",object);
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            
            
            NSString *rule = [NSString stringWithFormat:@"%@",object[@"data"][@"rules"]];
            self.ruleString = [rule stringByReplacingOccurrencesOfString:@"^" withString:@"\n"];
            
            [self.myInvitionsView.invitionsTableView reloadData];
        }else{
            [self showProgress:object[@"status"][@"message"]];
        }
    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}







#pragma mark - Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==0) {
        return 1;
    }else if (section==1) {
        return 1;
    }else if (section==2) {
        return self.moreArray.count;
    }else{
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        return SCREEN_WIDTH/375*84;
    }else if (indexPath.section==1) {
        return SCREEN_WIDTH/375*260;
    }else if (indexPath.section==2) {
        return SCREEN_WIDTH/375*45;
    }else{
        
        
        CGSize   size      = CGSizeMake(SCREEN_WIDTH-SCREEN_WIDTH/375*35, 0);
        CGSize autoSize = [[UILabel new] actualSizeOfLineSpaceLable:[NSString stringWithFormat:@"%@",self.ruleString]
                                                            andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]
                                                            andSize:size];
        
        NSLog(@"%f",autoSize.height);
        return SCREEN_WIDTH/375*60+autoSize.height;
    }
}


/**footer**/
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return SCREEN_WIDTH/375*0;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footView         = [[UIView alloc] init];
    footView.backgroundColor = [UIColor clearColor];
    return footView;
}

/****header****/
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return SCREEN_WIDTH/375*14;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *footView         = [[UIView alloc] init];
    footView.backgroundColor = [UIColor clearColor];
    return footView;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //static NSString *noOneIndentifire             = @"noOneCell";
    static NSString *noTwoIndentifire             = @"twoInformationCell";
    static NSString *shareIndentifire             = @"shareInformationCell";
    static NSString *moreIndentifire              = @"moreInformationCell";
    static NSString *bottomIndentifire            = @"bottomInformationCell";
    
    if (indexPath.section==0) {
        
        ZMInvitationMoneyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:noTwoIndentifire];
        if (!cell) {
            cell = [[ZMInvitationMoneyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:noTwoIndentifire];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell setTopMoney:self.topDic];
        return cell;
        
    }else if (indexPath.section==1) {
        
        ZMInvitateAcTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:shareIndentifire];
        if (!cell) {
            cell = [[ZMInvitateAcTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:shareIndentifire];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell.shareButton addTarget:self action:@selector(shareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        
    }else if (indexPath.section==2){
        NSDictionary *moreDic = self.moreArray[indexPath.row];
        ZMCommissionDetailMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:moreIndentifire];
        if (!cell) {
            cell = [[ZMCommissionDetailMoreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:moreIndentifire];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.rightLabel.alpha = 0;
        if (indexPath.row==1) {
            cell.line.alpha = 0;
        }else{
            cell.line.alpha = 1;
        }
        [cell setMoreTiele:moreDic];
        return cell;
    }else{
        ZMInvitateBottomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:bottomIndentifire];
        if (!cell) {
            cell = [[ZMInvitateBottomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:bottomIndentifire];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell setRule:self.ruleString];
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //NSLog(@"share");
    
    if (indexPath.section==1) {
        NSLog(@"share");
        
    }else if (indexPath.section==2){
        if (indexPath.row==0) {
            NSLog(@"no1");
            ZMInvitedRecordViewController *invitedRecordVC = [[ZMInvitedRecordViewController alloc] init];
            [self.navigationController pushViewController:invitedRecordVC animated:YES];
        }else{
            NSLog(@"no2");
            self.qrCodeView          = [[BFShareQrCodeView alloc] initWithFrame:SCREEN_BOUNDS];
            [self.qrCodeView shareShow];
        }
    }
}

#pragma mark - Share
- (void)shareButtonClick:(UIButton *)sender{
    
    [self shareAc];
}

#pragma mark - Invite Friend
- (void)shareAc{
    
    self.shareView          = [[BFShareView alloc] initWithFrame:SCREEN_BOUNDS];
    self.shareView.delegate = self;
    [self.shareView shareShow];
}

#pragma mark - share Successful
- (void)shareSuccessfulAc{
    
    [self.shareView shareHide];
    [self showProgress:@"分享成功~"];
}


- (void)shareFailed{
    
    [self.shareView shareHide];
    [self showProgress:@"分享失败~"];
}



#pragma mark - BFShareDelegate
-(void)shareViewDidSelectButWithBtnTag:(NSInteger)btnTag{
    
    NSLog(@"share ------ %ld",(long)btnTag);
    
    if (btnTag==701) {
        [self shareWebPageToPlatformType:UMSocialPlatformType_WechatSession];
    }else if (btnTag==702){
        [self shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine];
    }else if (btnTag==703){
        [[UMSocialManager defaultManager] setUmSocialAppkey:UM_APPKEY];
        [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ
                                              appKey:QQAppID/*设置QQ平台的appID*/
                                           appSecret:QQAppKey
                                         redirectURL:nil];
        [self shareWebPageToPlatformType:UMSocialPlatformType_QQ];
    }else{
        [[UMSocialManager defaultManager] setUmSocialAppkey:UM_APPKEY];
        [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ
                                              appKey:QQAppID/*设置QQ平台的appID*/
                                           appSecret:QQAppKey
                                         redirectURL:nil];
        [self shareWebPageToPlatformType:UMSocialPlatformType_Qzone];
        /*if (![WeiboSDK isWeiboAppInstalled]){
         [self.shareView shareHide];
         [self showProgress:@"未安装微博客户端"];
         }else{
         [self shareWebPageToPlatformType:UMSocialPlatformType_Sina];
         }
         */
    }
}


- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType{
    
    
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //NSString *thumbURL =  @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
    UIImage *thumImage = [UIImage imageNamed:@"loginIcon"];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"我在芝麻商服赚项目佣金，你也来吧！地产圈的人都在这里！"
                                                                             descr:@"工作中、饭局中、闲聊中获取的商务信息一文不值？别傻了，来这里卖钱吧！"
                                                                         thumImage:thumImage];
    
    
    
    NSString *name;
    NSString *user_ID = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:USER_ID]];
    NSString *typeStr = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:USER_TYPE]];
    if ([typeStr isEqualToString:@"1"]) {
        //personal
        name = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Person_name]];
    }else{
        //company
        name = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Com_name]];
    }
    
    NSString *shreUrl = [NSString stringWithFormat:@"%@?id=%@&name=%@",InviteFriends,user_ID,name];
    shreUrl           = [shreUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    shareObject.webpageUrl    = shreUrl;
    messageObject.shareObject = shareObject;
    
    
    
    NSLog(@"share url ---------- %@",shareObject.webpageUrl);
    
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
            NSLog(@"************Share fail with error *********");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"shareFailed" object:nil];
        }else{
            NSLog(@"%@",data);
            NSLog(@"************Share successful *********");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"shareSuccessful" object:nil];
            /*
             if ([data isKindOfClass:[UMSocialShareResponse class]]) {
             UMSocialShareResponse *resp = data;
             NSLog(@"resp.originalResponse ---- %@",resp.originalResponse);
             //分享结果消息
             UMSocialLogInfo(@"response message is %@",resp.message);
             //第三方原始返回的数据
             UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
             
             }else{
             UMSocialLogInfo(@"response data is %@",data);
             }
             */
        }
    }];
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
