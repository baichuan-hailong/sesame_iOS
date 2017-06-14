//
//  ZMPromoteIntroduceDetailViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/25.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMPromoteIntroduceDetailViewController.h"
#import "ZMPromoteIntroduceDetailView.h"

#import "ZMCommissionDetailTableHeaderView.h"
#import "ZMPromoteIntroduceDetailTopTableViewCell.h"
#import "ZMMySellSecondTableViewCell.h"
#import "ZMCommissionDetailMoreTableViewCell.h"


#import "ZMOrderProgressViewController.h"
#import "ZMCommissionSignViewController.h"
#import "ZMFeedBackSignResultViewController.h"

@interface ZMPromoteIntroduceDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) ZMPromoteIntroduceDetailView *promoteIntroduceDetailView;
@property (nonatomic , strong) NSArray            *twoArray;
@property (nonatomic , strong) NSArray            *moreArray;
@property (nonatomic , strong) MBProgressHUD      *HUD;
@property (nonatomic , strong) NSDictionary       *sourceDic;
@end

@implementation ZMPromoteIntroduceDetailViewController

- (void)loadView {
    //change
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.promoteIntroduceDetailView    = [[ZMPromoteIntroduceDetailView alloc] initWithFrame:SCREEN_BOUNDS];
    self.view                    = self.promoteIntroduceDetailView;
    self.promoteIntroduceDetailView.promoteIntroduceDetailTableView.delegate   = self;
    self.promoteIntroduceDetailView.promoteIntroduceDetailTableView.dataSource = self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"推介交易详情";

    self.twoArray =       @[@{@"left":@"--",@"right":@"--"},
                            @{@"left":@"--",@"right":@"--"},
                            @{@"left":@"--",@"right":@"--"},
                            @{@"left":@"--",@"right":@"--"},
                            @{@"left":@"--",@"right":@"--"},
                            @{@"left":@"--",@"right":@"--"}];
    
    self.moreArray =      @[@{@"left":@"--",@"right":@"--"}];
    
    if (_isCom) {
        //我提交的
        [self evokeSouceData];
    }else{
        //我接单的
        [self evokeAcceptSouceData];
        
    }
    
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"finishSignNotifiAc" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(finishSignNotifiAc)
                                                 name:@"finishSignNotifiAc"
                                               object:nil];
    
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"finishFeedBackNotifiAc" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(finishFeedBackNotifiAc)
                                                 name:@"finishFeedBackNotifiAc"
                                               object:nil];
}


-(void)backAction{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BackRefreshNotifiAc" object:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Sign Successful
- (void)finishSignNotifiAc{
    
    /*
     NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:self.sourceDic];
     NSMutableDictionary *status_noteTempDic = [NSMutableDictionary dictionaryWithDictionary:self.sourceDic[@"status_note"]];
     [status_noteTempDic setObject:@"1" forKey:@"is_finish_sign"];
     [tempDic setObject:status_noteTempDic forKey:@"status_note"];
     self.sourceDic = [NSDictionary dictionaryWithDictionary:tempDic];
     
     [self.promoteIntroduceDetailView.promoteIntroduceDetailTableView reloadData];

     */
    
    if (_isCom) {
        //我提交的
        [self evokeSouceData];
    }else{
        //我接单的
        [self evokeAcceptSouceData];
        
    }
}

#pragma mark - feedBack Successful
- (void)finishFeedBackNotifiAc{
    
    /*
     NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:self.sourceDic];
     NSMutableDictionary *status_noteTempDic = [NSMutableDictionary dictionaryWithDictionary:self.sourceDic[@"status_note"]];
     [status_noteTempDic setObject:@"1" forKey:@"is_finish_perform"];
     [tempDic setObject:status_noteTempDic forKey:@"status_note"];
     self.sourceDic = [NSDictionary dictionaryWithDictionary:tempDic];
     
     [self.promoteIntroduceDetailView.promoteIntroduceDetailTableView reloadData];

     */
    
    if (_isCom) {
        //我提交的
        [self evokeSouceData];
    }else{
        //我接单的
        [self evokeAcceptSouceData];
        
    }
}




#pragma mark - Load Data
- (void)evokeSouceData{
    
    
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    [self.HUD show:YES];
    
    NSDictionary *parm = @{@"id":self.promoteID};
    NSString *urlStr   = [NSString stringWithFormat:@"%@/info/my-commit-recommend-detail",APIDev];
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:parm withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"commit recommend-detail --- %@",object);
        NSLog(@"%@",object[@"status"][@"message"]);
        
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            self.sourceDic = [NSDictionary dictionaryWithDictionary:object[@"data"]];
            
            
            
            //预估标的额
            NSString *target_amount_value = [NSString stringWithFormat:@"%@",self.sourceDic[@"target_amount_value"]];
            if (target_amount_value.length>0&&![target_amount_value isEqualToString:@"(null)"]) {
                target_amount_value = [NSString stringWithFormat:@"%@W",target_amount_value];
            }else{
                target_amount_value = @"--";
            }
            
            
            NSString *yongjin;
            //期望佣金
            NSString *reward_type = [NSString stringWithFormat:@"%@",self.sourceDic[@"reward_type"]];
            if ([reward_type isEqualToString:@"fixed_value"]) {
                //按金额
                NSString *reward_value = [NSString stringWithFormat:@"%@",self.sourceDic[@"reward_value"]];
                if (reward_value.length>0&&![reward_value isEqualToString:@"(null)"]) {
                    yongjin = [NSString stringWithFormat:@"%@W",reward_value];
                }else{
                    yongjin = @"--";
                }
                
            }else if ([reward_type isEqualToString:@"fixed_percent"]) {
                //按比例
                NSString *reward_percent = [NSString stringWithFormat:@"%@",self.sourceDic[@"reward_percent"]];
                float rewaidPercent = [reward_percent floatValue];
                //@"期望佣金：%.2f%@",rewaidPercent*100
                if (reward_percent.length>0&&![reward_percent isEqualToString:@"(null)"]) {
                    yongjin = [NSString stringWithFormat:@"%.2f%@",rewaidPercent*100,@"%"];
                }else{
                    yongjin = @"--";
                }
                
            }else if ([reward_type isEqualToString:@"market_avg"]) {
                //按行业惯例或接单方规定
                yongjin = @"按行业惯例或接单方规定";
            }else if ([reward_type isEqualToString:@"negotiable"]) {
                //认可平台协商的结果
                yongjin = @"认可平台协商的结果";
            }
            
            
            //推介的公司
            NSString *demander_name = [NSString stringWithFormat:@"%@",self.sourceDic[@"demander_name"]];
            if (demander_name.length>0&&![demander_name isEqualToString:@"(null)"]) {
                
            }else{
                demander_name = @"--";
            }
            
            
            //业务类型
            NSString *type = [NSString stringWithFormat:@"%@",self.sourceDic[@"type"]];
            NSString *type_title = [NSString stringWithFormat:@"%@",self.sourceDic[@"type_title"]];
            
            NSLog(@"type---%@",type);
            if (type.length>0&&![type isEqualToString:@"(null)"]&&![type isEqualToString:@"<null>"]) {
                
            }else{
                type = type_title;
            }
            
            //业务地域
            NSString *biz_locate = [NSString stringWithFormat:@"%@",self.sourceDic[@"biz_locate"]];
            if (biz_locate.length>0&&![biz_locate isEqualToString:@"(null)"]) {
                
            }else{
                biz_locate = @"--";
            }
            //项目说明
            NSString *description = [NSString stringWithFormat:@"%@",self.sourceDic[@"description"]];
            if (description.length>0&&![description isEqualToString:@"(null)"]) {
                
            }else{
                description = @"--";
            }
            self.twoArray =       @[@{@"left":@"预估标的额",@"right":target_amount_value},
                                    @{@"left":@"期望推介费",@"right":yongjin},
                                    @{@"left":@"推介的公司",@"right":demander_name},
                                    @{@"left":@"产品(或服务)名称",@"right":type},
                                    @{@"left":@"业务地域",@"right":biz_locate},
                                    @{@"left":@"项目说明",@"right":description}];
            
            
            //more
            
            //居间协议
            NSString *is_show_sign  = [NSString stringWithFormat:@"%@",self.sourceDic[@"status_note"][@"is_show_sign"]];
            NSString *is_finish_sign= [NSString stringWithFormat:@"%@",self.sourceDic[@"status_note"][@"is_finish_sign"]];
            if ([is_finish_sign integerValue]==1) {
                is_finish_sign = @"已完成";
            }else{
                is_finish_sign = @"未完成";
            }
            
            
            //反馈项目
            NSString *is_show_perform  = [NSString stringWithFormat:@"%@",self.sourceDic[@"status_note"][@"is_show_perform"]];
            NSString *is_finish_perform= [NSString stringWithFormat:@"%@",self.sourceDic[@"status_note"][@"is_finish_perform"]];
            if ([is_finish_perform integerValue]==1) {
                is_finish_perform = @"已完成";
            }else{
                is_finish_perform = @"未完成";
            }
            
            if ([is_show_sign integerValue]==1&&[is_show_perform integerValue]==1) {
                self.moreArray =      @[@{@"left":@"订单进度详情",@"right":@"--"},
                                        @{@"left":@"签署协议",@"right":is_finish_sign},
                                        @{@"left":@"反馈项目双方签约结果",@"right":is_finish_perform}];
            }else if ([is_show_sign integerValue]==1){
                self.moreArray =      @[@{@"left":@"订单进度详情",@"right":@"--"},
                                        @{@"left":@"签署协议",@"right":is_finish_sign}];
            }else if ([is_show_perform integerValue]==1){
                self.moreArray =      @[@{@"left":@"订单进度详情",@"right":@"--"},
                                        @{@"left":@"反馈项目双方签约结果",@"right":is_finish_perform}];
            }else{
                self.moreArray =      @[@{@"left":@"订单进度详情",@"right":@"--"}];
            }
            [self.promoteIntroduceDetailView.promoteIntroduceDetailTableView reloadData];
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


- (void)evokeAcceptSouceData{
    
    
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    [self.HUD show:YES];
    
    NSDictionary *parm = @{@"id":self.promoteID};
    NSString *urlStr   = [NSString stringWithFormat:@"%@/info/my-accept-recommend-detail",APIDev];
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:parm withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"accept-recommend-detail --- %@",object);
        NSLog(@"%@",object[@"status"][@"message"]);
        
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            self.sourceDic = [NSDictionary dictionaryWithDictionary:object[@"data"]];
            
            //预估标的额
            NSString *target_amount_value = [NSString stringWithFormat:@"%@",self.sourceDic[@"target_amount_value"]];
            if (target_amount_value.length>0&&![target_amount_value isEqualToString:@"(null)"]) {
                target_amount_value = [NSString stringWithFormat:@"%@W",target_amount_value];
            }else{
                target_amount_value = @"--";
            }
            
            
            NSString *yongjin;
            //期望佣金
            NSString *reward_type = [NSString stringWithFormat:@"%@",self.sourceDic[@"reward_type"]];
            if ([reward_type isEqualToString:@"fixed_value"]) {
                //按金额
                NSString *reward_value = [NSString stringWithFormat:@"%@",self.sourceDic[@"reward_value"]];
                if (reward_value.length>0&&![reward_value isEqualToString:@"(null)"]) {
                    yongjin = [NSString stringWithFormat:@"%@W",reward_value];
                }else{
                    yongjin = @"--";
                }
                
            }else if ([reward_type isEqualToString:@"fixed_percent"]) {
                //按比例
                NSString *reward_percent = [NSString stringWithFormat:@"%@",self.sourceDic[@"reward_percent"]];
                float rewaidPercent = [reward_percent floatValue];
                //@"期望佣金：%.2f%@",rewaidPercent*100
                if (reward_percent.length>0&&![reward_percent isEqualToString:@"(null)"]) {
                    yongjin = [NSString stringWithFormat:@"%.2f%@",rewaidPercent*100,@"%"];
                }else{
                    yongjin = @"--";
                }
                
            }else if ([reward_type isEqualToString:@"market_avg"]) {
                //按行业惯例或接单方规定
                yongjin = @"按行业惯例或接单方规定";
            }else if ([reward_type isEqualToString:@"negotiable"]) {
                //认可平台协商的结果
                yongjin = @"认可平台协商的结果";
            }
            
            
            //推介的公司
            NSString *demander_name = [NSString stringWithFormat:@"%@",self.sourceDic[@"demander_name"]];
            if (demander_name.length>0&&![demander_name isEqualToString:@"(null)"]) {
                
            }else{
                demander_name = @"--";
            }
            
            
            //业务类型
            NSString *type = [NSString stringWithFormat:@"%@",self.sourceDic[@"type"]];
            NSString *type_title = [NSString stringWithFormat:@"%@",self.sourceDic[@"type_title"]];
            
            NSLog(@"type---%@",type);
            if (type.length>0&&![type isEqualToString:@"(null)"]&&![type isEqualToString:@"<null>"]) {
                
            }else{
                type = type_title;
            }
            
            //业务地域
            NSString *biz_locate = [NSString stringWithFormat:@"%@",self.sourceDic[@"biz_locate"]];
            if (biz_locate.length>0&&![biz_locate isEqualToString:@"(null)"]) {
                
            }else{
                biz_locate = @"--";
            }
            //项目说明
            NSString *description = [NSString stringWithFormat:@"%@",self.sourceDic[@"description"]];
            if (description.length>0&&![description isEqualToString:@"(null)"]) {
                
            }else{
                description = @"--";
            }
            self.twoArray =       @[@{@"left":@"预估标的额",@"right":target_amount_value},
                                    @{@"left":@"期望推介费",@"right":yongjin},
                                    @{@"left":@"推介的公司",@"right":demander_name},
                                    @{@"left":@"产品(或服务)名称",@"right":type},
                                    @{@"left":@"业务地域",@"right":biz_locate},
                                    @{@"left":@"项目说明",@"right":description}];
            
            
            //more
            
            //居间协议
            NSString *is_show_sign  = [NSString stringWithFormat:@"%@",self.sourceDic[@"status_note"][@"is_show_sign"]];
            NSString *is_finish_sign= [NSString stringWithFormat:@"%@",self.sourceDic[@"status_note"][@"is_finish_sign"]];
            if ([is_finish_sign integerValue]==1) {
                is_finish_sign = @"已完成";
            }else{
                is_finish_sign = @"未完成";
            }
            
            
            //反馈项目
            NSString *is_show_perform  = [NSString stringWithFormat:@"%@",self.sourceDic[@"status_note"][@"is_show_perform"]];
            NSString *is_finish_perform= [NSString stringWithFormat:@"%@",self.sourceDic[@"status_note"][@"is_finish_perform"]];
            if ([is_finish_perform integerValue]==1) {
                is_finish_perform = @"已完成";
            }else{
                is_finish_perform = @"未完成";
            }
            
            if ([is_show_sign integerValue]==1&&[is_show_perform integerValue]==1) {
                self.moreArray =      @[@{@"left":@"订单进度详情",@"right":@"--"},
                                        @{@"left":@"签署协议",@"right":is_finish_sign},
                                        @{@"left":@"反馈项目双方签约结果",@"right":is_finish_perform}];
            }else if ([is_show_sign integerValue]==1){
                self.moreArray =      @[@{@"left":@"订单进度详情",@"right":@"--"},
                                        @{@"left":@"签署协议",@"right":is_finish_sign}];
            }else if ([is_show_perform integerValue]==1){
                self.moreArray =      @[@{@"left":@"订单进度详情",@"right":@"--"},
                                        @{@"left":@"反馈项目双方签约结果",@"right":is_finish_perform}];
            }else{
                self.moreArray =      @[@{@"left":@"订单进度详情",@"right":@"--"}];
            }
            
            [self.promoteIntroduceDetailView.promoteIntroduceDetailTableView reloadData];
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







#pragma mark - Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else if (section==1){
        return self.twoArray.count;
    }else{
        return self.moreArray.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        
        NSString *status = [NSString stringWithFormat:@"%@",self.sourceDic[@"status"]];
        
        
        
        //SCREEN_WIDTH-SCREEN_WIDTH/375*17.5-SCREEN_WIDTH/375*79,
        //20
        
        NSString *title = [NSString stringWithFormat:@"%@",self.sourceDic[@"title"]];
        
        CGSize   size      = CGSizeMake(SCREEN_WIDTH-SCREEN_WIDTH/375*17.5-SCREEN_WIDTH/375*79, 0);
        
        CGSize  autoSize = [[UILabel new] actualSizeOfLineSpaceLable:[NSString stringWithFormat:@"%@",title]
                                                             andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
                                                             andSize:size];
        
        int height = (int)autoSize.height+1;
        if ([status isEqualToString:@"reject_die"]) {
            //已关闭
            //return SCREEN_WIDTH/375*78+height;
        }else if ([status isEqualToString:@"finish_done"]) {
            //已完成
            //return SCREEN_WIDTH/375*78+height;
        }else{
            //进行中
            //return SCREEN_WIDTH/375*59+height;
        }
        return SCREEN_WIDTH/375*59+height;
        
    }else if (indexPath.section==1){
        
        NSDictionary *baseDic = self.twoArray[indexPath.row];
        NSString *right = [NSString stringWithFormat:@"%@",baseDic[@"right"]];
        CGSize size = CGSizeMake(SCREEN_WIDTH-SCREEN_WIDTH/375*150, 0);
        CGSize autoSize = [[UILabel new] actualSizeOfLineSpaceLable:right
                                                            andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
                                                            andSize:size];
        return SCREEN_WIDTH/375*26+autoSize.height;
        /*
         if (indexPath.row==5) {
         NSDictionary *baseDic = self.twoArray[5];
         NSString *right = [NSString stringWithFormat:@"%@",baseDic[@"right"]];
         CGSize size = CGSizeMake(SCREEN_WIDTH-SCREEN_WIDTH/375*150, 0);
         CGSize autoSize = [[UILabel new] actualSizeOfLineSpaceLable:right
         andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
         andSize:size];
         return SCREEN_WIDTH/375*26+autoSize.height;
         }else{
         return SCREEN_WIDTH/375*46;
         }
         */
        
    }else{
        return SCREEN_WIDTH/375*45;
    }
    
}

/**header**/
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        NSString *note = [NSString stringWithFormat:@"%@",self.sourceDic[@"status_note"][@"note"]];
        if (note.length>0&&![note isEqualToString:@"(null)"]) {
            return SCREEN_WIDTH/375*30;
        }else{
            return SCREEN_WIDTH/375*0.1;
        }
        
        
    }else if (section==1){
        return SCREEN_WIDTH/375*0.1;
    }else{
        return SCREEN_WIDTH/375*0.1;
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        
        NSString *note = [NSString stringWithFormat:@"%@",self.sourceDic[@"status_note"][@"note"]];
        if (note.length>0&&![note isEqualToString:@"(null)"]) {
            ZMCommissionDetailTableHeaderView *detailHeaderView = [[ZMCommissionDetailTableHeaderView alloc] init];
            [detailHeaderView settitle:note color:tonalColor titleColor:@"FFFFFF"];
            return detailHeaderView;
        }else{
            UIView *headerView         = [[UIView alloc] init];
            headerView.backgroundColor = [UIColor clearColor];
            return headerView;
        }
        
    }else if (section==1){
        UIView *headerView         = [[UIView alloc] init];
        headerView.backgroundColor = [UIColor clearColor];
        return headerView;
    }else{
        UIView *headerView         = [[UIView alloc] init];
        headerView.backgroundColor = [UIColor clearColor];
        return headerView;
    }
}



/**footer**/
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return SCREEN_WIDTH/375*13;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footView         = [[UIView alloc] init];
    footView.backgroundColor = [UIColor clearColor];
    return footView;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *oneIndentifire             = @"topCell";
    static NSString *secondIndentifire          = @"secondCell";
    static NSString *invoiceIndentifire         = @"invoiceCell";
    
    if (indexPath.section==0) {
        ZMPromoteIntroduceDetailTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:oneIndentifire];
        if (!cell) {
            cell = [[ZMPromoteIntroduceDetailTopTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:oneIndentifire];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell setTopDetail:self.sourceDic isLeft:_isCom];
        return cell;
        
    }if (indexPath.section==1) {
        NSDictionary *detailDic = self.twoArray[indexPath.row];
        ZMMySellSecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:secondIndentifire];
        if (!cell) {
            cell = [[ZMMySellSecondTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:secondIndentifire];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell setInvoiceDetail:detailDic];
        if (indexPath.row==self.twoArray.count-1) {
            cell.line.alpha = 0;
        }
        if (indexPath.row==0||indexPath.row==1) {
            cell.rightLabel.textColor = [UIColor colorWithHex:tonalColor];
        }
        
        if (indexPath.row==4) {
            NSString *city = cell.rightLabel.text;
            city =[city stringByReplacingOccurrencesOfString:@"^" withString:@" "];
            cell.rightLabel.text = city;
        }

        return cell;
        
    }else{
        NSDictionary *moreDic = self.moreArray[indexPath.row];
        ZMCommissionDetailMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:invoiceIndentifire];
        if (!cell) {
            cell = [[ZMCommissionDetailMoreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:invoiceIndentifire];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (indexPath.row==0) {
            cell.rightLabel.alpha = 0;
        }else{
            cell.rightLabel.alpha = 1;
        }
        if (indexPath.row==self.moreArray.count-1) {
            cell.line.alpha = 0;
        }else{
            cell.line.alpha = 1;
        }
        [cell setMoreTiele:moreDic];
        
        if (self.sourceDic!=nil) {
            NSString *is_finish_sign= [NSString stringWithFormat:@"%@",self.sourceDic[@"status_note"][@"is_finish_sign"]];
            NSLog(@"is_finish_sign -------- %@",is_finish_sign);
            if (indexPath.row==1) {
                if ([is_finish_sign integerValue]==1) {
                    cell.rightLabel.text = @"已完成";
                    cell.rightLabel.textColor = [UIColor colorWithHex:@"999999"];
                    
                }else{
                    cell.rightLabel.text = @"未完成";
                    cell.rightLabel.textColor = [UIColor colorWithHex:@"FA4A4A"];
                }
            }
            NSString *is_finish_perform= [NSString stringWithFormat:@"%@",self.sourceDic[@"status_note"][@"is_finish_perform"]];
            if (indexPath.row==2) {
                if ([is_finish_perform integerValue]==1) {
                    cell.rightLabel.textColor = [UIColor colorWithHex:@"999999"];
                    cell.rightLabel.text = @"已完成";
                }else{
                    cell.rightLabel.textColor = [UIColor colorWithHex:@"FA4A4A"];
                    cell.rightLabel.text = @"未完成";
                }
            }
        }
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //NSLog(@"commission");
    if (indexPath.section==2) {
        if (indexPath.row==0) {
            NSLog(@"0");
            ZMOrderProgressViewController *orderProgressVC = [[ZMOrderProgressViewController alloc] init];
            orderProgressVC.infoID = self.promoteID;
            orderProgressVC.isleft = _isCom;
            orderProgressVC.isYongjin = NO;
            [self.navigationController pushViewController:orderProgressVC animated:YES];
        }else if (indexPath.row==1){
            NSLog(@"2");
            NSString *is_finish_sign= [NSString stringWithFormat:@"%@",self.sourceDic[@"status_note"][@"is_finish_sign"]];
            ZMCommissionSignViewController *commissionSignVC = [[ZMCommissionSignViewController alloc] init];
            commissionSignVC.infoID = self.promoteID;
            if ([is_finish_sign integerValue]==1) {
                commissionSignVC.isFnishBool = YES;
            }else{
                commissionSignVC.isFnishBool = NO;
            }
            [self.navigationController pushViewController:commissionSignVC animated:YES];
        }else if (indexPath.row==2){
            NSLog(@"3");
            ZMFeedBackSignResultViewController *feedBackSignVC = [[ZMFeedBackSignResultViewController alloc] init];
            NSString *is_finish_perform= [NSString stringWithFormat:@"%@",self.sourceDic[@"status_note"][@"is_finish_perform"]];
            if ([is_finish_perform integerValue]==1) {
                feedBackSignVC.isFnishFeedBackBool = YES;
                feedBackSignVC.sign_time = [NSString stringWithFormat:@"%@",self.sourceDic[@"sign_time"]];;
            }else{
                feedBackSignVC.isFnishFeedBackBool = NO;
            }
            feedBackSignVC.infoID = self.promoteID;
            [self.navigationController pushViewController:feedBackSignVC animated:YES];
        }
    }
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

#pragma mark - 时间戳转换为标准时间
- (NSString *)timeChange:(NSString *)timeStamp {
    NSTimeInterval time = [timeStamp doubleValue];// + 28800;  //因为时差问题要加8小时 == 28800
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSString *currentDateStr = [formatter stringFromDate: date];
    return currentDateStr;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
