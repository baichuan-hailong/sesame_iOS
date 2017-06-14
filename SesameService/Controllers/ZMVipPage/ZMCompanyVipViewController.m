//
//  ZMCompanyVipViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMCompanyVipViewController.h"
#import "ZMCompanyVipView.h"

#import "ZMEvaluationCompanyViewController.h"
#import "ZMWordOfMouthTableViewCell.h"

#import "ZMBaseInfoTableViewCell.h"
#import "ZMProjectCaseInfoTableViewCell.h"
#import "ZMAwardHonorInfoTableViewCell.h"
#import "ZMWeboInfoTableViewCell.h"

#import "ZMCompanyVipLeftHeaderView.h"
#import "ZMCompanyVipLeftOneHeaderView.h"

@interface ZMCompanyVipViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL isLeft;
    
    BOOL isLoad;
}
@property (nonatomic,strong)ZMCompanyVipView *companyVipView;

@property (nonatomic,strong)NSArray *baseInfoArray;
@property (nonatomic,strong)NSArray *caseInfoArray;
@property (nonatomic,strong)NSArray *honorListArray;
@property (nonatomic , strong)MBProgressHUD *HUD;
@property (nonatomic,strong)NSArray *comProArray;
@end

@implementation ZMCompanyVipViewController

-(void)loadView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.companyVipView = [[ZMCompanyVipView alloc] initWithFrame:SCREEN_BOUNDS];
    
    self.companyVipView.leftTableView.delegate    = self;
    self.companyVipView.leftTableView.dataSource  = self;
    
    self.view = self.companyVipView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"会员详情";
    
    isLeft = YES;
    
    self.baseInfoArray = @[@{@"left":@"--",@"right":@"--"},
                           @{@"left":@"--",@"right":@"--"},
                           @{@"left":@"--",@"right":@"---"}];
    
    
    //self.caseInfoArray = @[@{@"left":@"项目1",@"right":@"设计、代理、制作、发布国内及外商"},
                           //@{@"left":@"项目2",@"right":@"华广告信息咨询（不含中介服务）"},
                           //@{@"left":@"项目3",@"right":@"华广告信息咨询（不含中介服务）"}];
    
    
    NSLog(@"companyID --- %@",self.companyID);
    
    
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    [self.HUD show:YES];
    
    if (self.mainBizArray.count==0) {
        [self observeProjectTag];
    }else{
        [self observeComPro];
    }
    
}



#pragma mark - 业务类型
- (void)observeProjectTag{

    
    NSString *urlStr   = [NSString stringWithFormat:@"%@/common/project-tag",APIDev];
    
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:nil withSuccessBlock:^(NSDictionary *object) {
        
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            self.mainBizArray = [NSArray arrayWithArray:object[@"data"]];
            NSLog(@"%@",self.mainBizArray);
            [self observeComPro];
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



#pragma mark - 公司性质
- (void)observeComPro{
    
    NSString *urlStr   = [NSString stringWithFormat:@"%@/common/info-config",APIDev];
    NSDictionary *pra = @{@"param":@"corp"};
    
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:pra withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"Com Pro -----------------------***********************************************--- %@",object);
        [self.HUD hide:YES];
        
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            self.comProArray = [NSArray arrayWithArray:object[@"data"][@"corp_property"]];
            [self dataSouce];
        }else{
            [self showProgress:object[@"status"][@"message"]];
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

    NSDictionary *parm = @{@"id":self.companyID};
    NSString *urlStr   = [NSString stringWithFormat:@"%@/user/detail",APIDev];
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:parm withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"Company Detail --------------------------- %@",object);
        
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            
            isLoad = YES;
            
            //top
            [self.companyVipView setTopCom:object[@"data"][@"detail"]];
            //more
            NSString *city = [NSString stringWithFormat:@"%@",object[@"data"][@"detail"][@"city"]];
            NSString *corp_property = [NSString stringWithFormat:@"%@",object[@"data"][@"detail"][@"corp_property"]];
            NSString *main_bizStr = @"";
            
            NSString *main_biz = [NSString stringWithFormat:@"%@",object[@"data"][@"detail"][@"main_biz"]];
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
            
            
            NSLog(@"mainBizArray --- %@",self.mainBizArray);
            NSLog(@"main_bizStr  --- %@",main_bizStr);
            
            if (city.length==0||[city isEqualToString:@"(null)"]) {
                city = @"暂无";
            }else{
                city = [city stringByReplacingOccurrencesOfString:@"^" withString:@" "];
            }
            
            
            
            if ([corp_property isEqualToString:@"0"]) {
                corp_property = @"暂无";
            }else{
            
                //公司性质
                for (NSDictionary *comProDic in self.comProArray) {
                    NSString *coPr = [NSString stringWithFormat:@"%@",comProDic[@"id"]];
                    if ([coPr integerValue]==[corp_property integerValue]) {
                        corp_property = [NSString stringWithFormat:@"%@",comProDic[@"title"]];
                    }
                }
            }
        
            
            self.baseInfoArray = @[@{@"left":@"公司性质",@"right":corp_property},
                                   @{@"left":@"所在城市",@"right":city},
                                   @{@"left":@"主营业务",@"right":main_bizStr}];
            
            
            //case
            self.caseInfoArray = [NSArray arrayWithArray:object[@"data"][@"case_lists"]];
            
            //honor
            self.honorListArray = [NSArray arrayWithArray:object[@"data"][@"honor_lists"]];
            NSLog(@"honor row -------------------- %ld",self.honorListArray.count/2+1);
            
            [self.companyVipView.leftTableView reloadData];
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



#pragma mark - 评价
- (void)evaluationButtonDidClickedAction:(UIButton *)sender{
    ZMEvaluationCompanyViewController *evaluationCompanyVC = [[ZMEvaluationCompanyViewController alloc] init];
    [self.navigationController pushViewController:evaluationCompanyVC animated:YES];
}

#pragma mark - left&right
- (void)lefrButtonAction:(UIButton *)sender{
    NSLog(@"left");
    
}

- (void)rightButtonAction:(UIButton *)sender{
    NSLog(@"right");
    
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
        
        if (indexPath.row==2) {
            NSDictionary *baseDic = self.baseInfoArray[2];
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
    if (indexPath.section==0) {
        ZMBaseInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:baseInfoIndentifier];
        if (!cell) {
            cell = [[ZMBaseInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:baseInfoIndentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (indexPath.row==2) {
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
        //cell.backgroundColor = [UIColor redColor];
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



#pragma mark - Heder View
- (UIView *)setHeaderView:(NSString *)title{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                  0,
                                                                  SCREEN_WIDTH,
                                                                  SCREEN_WIDTH/375*68)];
    headerView.backgroundColor = [UIColor colorWithHex:backGroundColor];
    
    //headerView.backgroundColor = [UIColor yellowColor];
    
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
