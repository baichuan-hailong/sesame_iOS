//
//  ZMPersonalVipViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMPersonalVipViewController.h"
#import "ZMPersonalVipView.h"

#import "ZMBaseInfoTableViewCell.h"
#import "ZMProjectCaseInfoTableViewCell.h"
#import "ZMAwardHonorInfoTableViewCell.h"
#import "ZMWeboInfoTableViewCell.h"

#import "ZMUnderstandToSpecificViewController.h"

@interface ZMPersonalVipViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL isLoad;
}
@property (nonatomic,strong)ZMPersonalVipView *personalVipView;
@property (nonatomic,strong)NSArray *baseInfoArray;
@property (nonatomic,strong)NSArray *caseInfoArray;
@property (nonatomic,strong)NSArray *honorListArray;
@property (nonatomic,strong)NSDictionary *personDetailDic;
@property (nonatomic , strong)MBProgressHUD *HUD;
@end

@implementation ZMPersonalVipViewController

-(void)loadView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.personalVipView = [[ZMPersonalVipView alloc] initWithFrame:SCREEN_BOUNDS];
    self.personalVipView.personalTableView.delegate  = self;
    self.personalVipView.personalTableView.dataSource= self;
    self.view = self.personalVipView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"会员详情";
    
    self.baseInfoArray = @[@{@"left":@"--",@"right":@"--"},
                           @{@"left":@"--",@"right":@"--"},
                           @{@"left":@"--",@"right":@"--"},
                           @{@"left":@"--",@"right":@"--"}];
    
    
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    [self.HUD show:YES];
    
    if (self.mainBizArray.count==0) {
        [self observeProjectTag];
    }else{
        [self dataSouce];
    }
    
    
    //self.caseInfoArray = @[@{@"left":@"项目1",@"right":@"设计、代理、制作、发布国内及外商"},
                           //@{@"left":@"项目2",@"right":@"华广告信息咨询（不含中介服务）"},
                           //@{@"left":@"项目3",@"right":@"华广告信息咨询（不含中介服务）"}];
    [self addAction];
    NSLog(@"personID --- %@",self.personID);
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(personVipControllerNotifiAc)
                                                 name:@"personVipControllerNotifi"
                                               object:nil];
}


- (void)addAction{
    
    [self.personalVipView.evaluationButton addTarget:self action:@selector(evaluationButtonDidClickedAction:) forControlEvents:UIControlEventTouchUpInside];
}



#pragma mark - 业务类型
- (void)observeProjectTag{
    
    
    NSString *urlStr   = [NSString stringWithFormat:@"%@/common/project-tag",APIDev];
    
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:nil withSuccessBlock:^(NSDictionary *object) {
        
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            self.mainBizArray = [NSArray arrayWithArray:object[@"data"]];
            NSLog(@"%@",self.mainBizArray);
            [self dataSouce];
        }else{
            [self showProgress:object[@"status"][@"message"]];
            [self.HUD hide:YES];
        }
        
        
    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
        [self.HUD hide:YES];
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}



#pragma mark - DataSouce
- (void)dataSouce{
    

    NSDictionary *parm = @{@"id":self.personID};
    NSString *urlStr   = [NSString stringWithFormat:@"%@/user/detail",APIDev];
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:parm withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"Person Detail --------------------------- %@",object);
       
        
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            
            isLoad = YES;
            
            //top
            [self.personalVipView setTopPer:object[@"data"][@"detail"]];
            self.personDetailDic = [NSDictionary dictionaryWithDictionary:object[@"data"][@"detail"]];
            
            //more
            NSString *corp_name = [NSString stringWithFormat:@"%@",object[@"data"][@"detail"][@"corp_name"]];
            NSString *title = [NSString stringWithFormat:@"%@",object[@"data"][@"detail"][@"title"]];
            NSString *city = [NSString stringWithFormat:@"%@",object[@"data"][@"detail"][@"city"]];
            NSString *main_biz = [NSString stringWithFormat:@"%@",object[@"data"][@"detail"][@"main_biz"]];
            
            
            NSString *main_bizStr = @"";
            if (![main_biz isEqualToString:@"0"]) {
                int per_main_int = [main_biz intValue];
                for (int i=0; i<self.mainBizArray.count; i++) {
                    int compare = (int)pow(2, i);
                    if (per_main_int&compare) {
                        NSDictionary *mainBizDic = self.mainBizArray[i];
                        if (main_bizStr.length>0) {
                            main_bizStr = [NSString stringWithFormat:@"%@,%@",main_bizStr,mainBizDic[@"tag"]];
                        }else{
                            main_bizStr = [NSString stringWithFormat:@"%@",mainBizDic[@"tag"]];
                        }
                        
                        NSLog(@"seledt ---- %@",mainBizDic);
                        
                    }
                }
            }else{
                main_bizStr = @"暂无";
                
            }
            
            if (corp_name.length==0||[corp_name isEqualToString:@"(null)"]) {
                corp_name = @"暂无";
            }
            
            if (title.length==0||[title isEqualToString:@"(null)"]) {
                title = @"暂无";
            }
            
            if (city.length==0||[city isEqualToString:@"(null)"]) {
                city = @"暂无";
            }else{
                city = [city stringByReplacingOccurrencesOfString:@"^" withString:@" "];
            }
            
            
            self.baseInfoArray = @[@{@"left":@"所在企业",@"right":corp_name},
                                   @{@"left":@"所在职位",@"right":title},
                                   @{@"left":@"所在城市",@"right":city},
                                   @{@"left":@"主营业务",@"right":main_bizStr}];
            
            //case
            self.caseInfoArray = [NSArray arrayWithArray:object[@"data"][@"case_lists"]];
            
            //honor
            self.honorListArray = [NSArray arrayWithArray:object[@"data"][@"honor_lists"]];
            NSLog(@"honor row -------------------- %ld",self.honorListArray.count/2+1);
            
            [self.personalVipView.personalTableView reloadData];
        }
        [self.HUD hide:YES];
    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
        [self.HUD hide:YES];
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}


#pragma mark - Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    /*
     if (isLoad) {
     return 3;
     }else{
     return 0;
     }
     */
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==0) {
        return self.baseInfoArray.count;
    }else if (section==1){
        return self.caseInfoArray.count;
    }else{
        if (self.honorListArray.count>0) {
            if (self.honorListArray.count%2==0) {
               return self.honorListArray.count/2;
            }else{
               return self.honorListArray.count/2+1;
            }
            
        }else{
            return 0;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        
        if (indexPath.row==3) {
            
            
            NSDictionary *baseDic = self.baseInfoArray[3];
            NSString *right = [NSString stringWithFormat:@"%@",baseDic[@"right"]];
            CGSize size = CGSizeMake(SCREEN_WIDTH-SCREEN_WIDTH/375*101-SCREEN_WIDTH/375*20, 0);
            CGSize autoSize = [[UILabel new] actualSizeOfLineSpaceLable:right
                                                                andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
                                                                andSize:size];
            
            return SCREEN_WIDTH/375*24+autoSize.height;
        }else{
            return SCREEN_WIDTH/375*44;
        }
        
        
    }else if (indexPath.section==1){
        return SCREEN_WIDTH/375*39;
    }else{
        return SCREEN_WIDTH/375*190;
    }
}


//header
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        return SCREEN_WIDTH/375*58;
    }else if (section==1){
        if (self.caseInfoArray.count==0) {
            return SCREEN_WIDTH/375*58;
        }else{
            return SCREEN_WIDTH/375*68;
        }
    }else{
        return SCREEN_WIDTH/375*58;
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSString *title;
    if (section==0) {
        title = @"基本信息";
    }else if (section==1){
        title = @"项目案例";
    }else{
        title = @"奖项荣誉";
    }
    
    return [self setHeaderView:title];
}


//footer
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return SCREEN_WIDTH/375*0.1;
    }else if (section==1){
        if (self.caseInfoArray.count==0) {
            return SCREEN_WIDTH/375*50;
        }else{
            return SCREEN_WIDTH/375*0.1;
        }
    }else{
        if (self.honorListArray.count==0) {
            return SCREEN_WIDTH/375*50;
        }else{
            return SCREEN_WIDTH/375*0.1;
        }
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section==0) {
        UIView *footView         = [[UIView alloc] init];
        footView.backgroundColor = [UIColor clearColor];
        return footView;
    }else if (section==1){
        if (self.caseInfoArray.count==0) {
            return [self setFooterView:@"还没有项目案例"];
        }else{
            UIView *footView         = [[UIView alloc] init];
            footView.backgroundColor = [UIColor clearColor];
            return footView;
        }
    }else{
        if (self.honorListArray.count==0) {
            return [self setFooterView:@"还没有奖项荣誉"];
        }else{
            UIView *footView         = [[UIView alloc] init];
            footView.backgroundColor = [UIColor clearColor];
            return footView;
        }
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *baseInfoIndentifier  = @"baseInfoCell";
    static NSString *caseInfoIndentifier  = @"caseInfoCell";
    static NSString *awardInfoIndentifier = @"awardInfoCell";
    //static NSString *weboInfoIndentifier = @"weboInfoCell";
    if (indexPath.section==0) {
        ZMBaseInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:baseInfoIndentifier];
        if (!cell) {
            cell = [[ZMBaseInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:baseInfoIndentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (indexPath.row==3) {
            cell.line.alpha = 0;
        }else{
            cell.line.alpha = 1;
        }
        NSDictionary *baseDic = self.baseInfoArray[indexPath.row];
        [cell setBaseInfoCell:baseDic];
        return cell;
    }else if (indexPath.section==1){
        ZMProjectCaseInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:caseInfoIndentifier];
        if (!cell) {
            cell = [[ZMProjectCaseInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:caseInfoIndentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        NSDictionary *caseDic = self.caseInfoArray[indexPath.row];
        [cell setCaseInfoCell:caseDic row:indexPath.row];
        return cell;
    }else{
        ZMAwardHonorInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:awardInfoIndentifier];
        if (!cell) {
            cell = [[ZMAwardHonorInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:awardInfoIndentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (self.honorListArray.count>0) {
            
            if (self.honorListArray.count%2==0) {
                //NSLog(@"ou");
                NSDictionary *leftDic   = self.honorListArray[indexPath.row*2];
                NSDictionary *righttDic = self.honorListArray[indexPath.row*2+1];
                [cell setAwardHonor:leftDic right:righttDic];
            }else{
                //NSLog(@"ji");
                if (indexPath.row==self.honorListArray.count/2) {
                    NSDictionary *leftDic   = self.honorListArray[indexPath.row*2];
                    [cell setAwardHonor:leftDic];
                }else{
                    NSDictionary *leftDic   = self.honorListArray[indexPath.row*2];
                    NSDictionary *righttDic = self.honorListArray[indexPath.row*2+1];
                    [cell setAwardHonor:leftDic right:righttDic];
                }
            }
        }
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


#pragma mark - 打听
- (void)evaluationButtonDidClickedAction:(UIButton *)sender{
    
    NSLog(@"click");
    if ([[NSUserDefaults standardUserDefaults] boolForKey:IS_LOGIN]) {
        ZMUnderstandToSpecificViewController *understandToSpecificVC = [[ZMUnderstandToSpecificViewController alloc] init];
        understandToSpecificVC.personDetailDic = self.personDetailDic;
        [self.navigationController pushViewController:understandToSpecificVC animated:YES];
    }else{
        ZMLoginViewController  *loginVC = [[ZMLoginViewController alloc] init];
        UINavigationController *loginNC = [[UINavigationController alloc] initWithRootViewController:loginVC];
        loginVC.entranceType = @"personVipControllerNotifi";
        [self presentViewController:loginNC animated:YES completion:nil];
    }
}

#pragma mark - Login Next
- (void)personVipControllerNotifiAc{
    NSLog(@"login next");
    ZMUnderstandToSpecificViewController *understandToSpecificVC = [[ZMUnderstandToSpecificViewController alloc] init];
    understandToSpecificVC.personDetailDic = self.personDetailDic;
    [self.navigationController pushViewController:understandToSpecificVC animated:YES];
}


#pragma mark - Heder View
- (UIView *)setHeaderView:(NSString *)title{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                  0,
                                                                  SCREEN_WIDTH,
                                                                  SCREEN_WIDTH/375*68)];
    headerView.backgroundColor = [UIColor colorWithHex:backGroundColor];
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                     SCREEN_WIDTH/375*12,
                                                                     SCREEN_WIDTH,
                                                                     SCREEN_WIDTH/375*56)];
    headerLabel.backgroundColor = [UIColor whiteColor];
    
    
    [ZMLabelAttributeMange setLabel:headerLabel
                               text:title
                                hex:@"333333"
                      textAlignment:NSTextAlignmentCenter
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*16]];
    [headerView addSubview:headerLabel];
    //headerView.backgroundColor = [UIColor redColor];
    return headerView;
}

- (UIView *)setFooterView:(NSString *)title{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                  0,
                                                                  SCREEN_WIDTH,
                                                                  SCREEN_WIDTH/375*50)];
    footerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *footerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                     SCREEN_WIDTH/375*5,
                                                                     SCREEN_WIDTH,
                                                                     SCREEN_WIDTH/375*20)];
    footerLabel.backgroundColor = [UIColor whiteColor];
    [ZMLabelAttributeMange setLabel:footerLabel
                               text:title
                                hex:@"999999"
                      textAlignment:NSTextAlignmentCenter
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    [footerView addSubview:footerLabel];
    //footerView.backgroundColor = [UIColor yellowColor];
    return footerView;
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
