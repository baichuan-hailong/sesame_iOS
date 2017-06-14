//
//  ZMMyBuyViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/24.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMMyBuyViewController.h"
#import "ZMMyBuyView.h"

#import "ZMSellBuySectionHeaderView.h"
#import "ZMBuyOneTableViewCell.h"
#import "ZMBuyOneLitterTableViewCell.h"
#import "ZMMySellSecondTableViewCell.h"
#import "ZMMySellSecondPartyATableViewCell.h"
#import "ZMMyMoreTableViewCell.h"
#import "ZMPeopleOfSellTableViewCell.h"

#import "ZMComplaintViewController.h"
#import "ZMPostEvaluationViewController.h"
#import "ZMTradingEvaluationViewController.h"
#import "ZMMoreProjectInfoViewController.h"
#import "ZMComplaintsDetailViewController.h"

#import "ZMMoreInfoMoneyViewController.h"

@interface ZMMyBuyViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) ZMMyBuyView *buyView;

@property (nonatomic , strong) NSDictionary       *infoDic;

@property (nonatomic , strong) NSDictionary       *buyTipDic;
@property (nonatomic , strong) NSDictionary       *askerTipDic;
@property (nonatomic , strong) NSArray            *sellArray;
@property (nonatomic , strong) NSArray            *moreArray;
@property (nonatomic , strong) MBProgressHUD      *HUD;


@property (nonatomic , strong) NSString           *complaint_id;

@end

@implementation ZMMyBuyViewController

- (void)loadView {
    //change
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.buyView    = [[ZMMyBuyView alloc] initWithFrame:SCREEN_BOUNDS];
    self.view                                 = self.buyView;
    self.buyView.buyTableView.delegate   = self;
    self.buyView.buyTableView.dataSource = self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我买的";
    
    self.sellArray =      @[@{@"left":@"所在城市",@"right":@"--"},
                            @{@"left":@"项目类型",@"right":@"--"},
                            @{@"left":@"预估标的额",@"right":@"--"},
                            @{@"left":@"消息有效期",@"right":@"--"},
                            @{@"left":@"甲方联系方式",@"right":@"--",@"rightTitle":@"--",@"tel":@"--"},
                            @{@"left":@"可提供的支持",@"right":@"--"},
                            @{@"left":@"项目说明",@"right":@"--"}];

    
    self.moreArray =      @[@{@"left":@"--"}];
    
    [self evokeSouceData];
    
    //have poset evaluation
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(postEvaluationSuccessful:)
                                                 name:@"postEvaluationSuccessful"
                                               object:nil];
    
    //have tousu
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(complainAcSuccessful:)
                                                 name:@"complainAcSuccessful"
                                               object:nil];
}

-(void)backAction{
    if (_isRootPop) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark - 投诉成功
- (void)complainAcSuccessful:(NSNotification *)noti{

    NSMutableDictionary *buyTipTempDic = [NSMutableDictionary dictionaryWithDictionary:self.infoDic];

    [buyTipTempDic setObject:@"1" forKey:@"is_complaint"];
    //[buyTipTempDic setObject:@"1" forKey:@"complaint_id"];
    
    
    NSDictionary *dic = (NSDictionary *)[noti object];
    NSLog(@"tousu ID %@",dic);
    self.complaint_id = [NSString stringWithFormat:@"%@",dic[@"id"]];
    
    self.infoDic = [NSDictionary dictionaryWithDictionary:buyTipTempDic];
    
    NSString *is_complaint = [NSString stringWithFormat:@"%@",self.infoDic[@"is_complaint"]];
    self.states = [NSString stringWithFormat:@"%@",self.infoDic[@"status"]];
    
    NSString *is_more_info = [NSString stringWithFormat:@"%@",self.infoDic[@"is_more_info"]];
    NSLog(@"%@%@",is_complaint,self.states);
    if ([self.states isEqualToString:@"rate_done"]&&[is_complaint integerValue]==1) {
        //已评价 已投诉
        if ([is_more_info integerValue]==1) {
            self.moreArray =      @[@{@"left":@"更多项目信息"},
                                    @{@"left":@"交易评价"},
                                    @{@"left":@"投诉详情"}];
        }else{
            self.moreArray =      @[@{@"left":@"交易评价"},
                                    @{@"left":@"投诉详情"}];
        }
        
    }else if ([is_complaint integerValue]==1) {
        if ([is_more_info integerValue]==1) {
            self.moreArray =      @[@{@"left":@"更多项目信息"},
                                    @{@"left":@"投诉详情"}];
        }else{
            self.moreArray =      @[@{@"left":@"投诉详情"}];
        }
        
    }else if ([self.states isEqualToString:@"rate_done"]) {
        if ([is_more_info integerValue]==1) {
            self.moreArray =      @[@{@"left":@"更多项目信息"},
                                    @{@"left":@"交易评价"}];
        }else{
            self.moreArray =      @[@{@"left":@"交易评价"}];
        }
        
    }else{
        if ([is_more_info integerValue]==1) {
            self.moreArray =      @[@{@"left":@"更多项目信息"}];
        }else{
            self.moreArray =      [NSArray array];
        }
        
    }
    
    [self.buyView.buyTableView reloadData];
}

#pragma mark - 评价成功
- (void)postEvaluationSuccessful:(NSNotification *)noti{
    [noti object];
    NSDictionary *dic = (NSDictionary *)[noti object];
    NSLog(@"myBuy --- infoDic --- %@",dic);
    self.states    = @"rate_done";
    //self.buyTipDic
    NSMutableDictionary *buyTipTempDic = [NSMutableDictionary dictionaryWithDictionary:self.infoDic];
    [buyTipTempDic setObject:self.states forKey:@"status"];
    [buyTipTempDic setObject:@"已评价" forKey:@"status_title"];
    self.infoDic = [NSDictionary dictionaryWithDictionary:buyTipTempDic];
    
    
    
    
    NSString *is_complaint = [NSString stringWithFormat:@"%@",self.infoDic[@"is_complaint"]];
    self.states = [NSString stringWithFormat:@"%@",self.infoDic[@"status"]];
    
    NSString *is_more_info = [NSString stringWithFormat:@"%@",self.infoDic[@"is_more_info"]];
    
    if ([self.states isEqualToString:@"rate_done"]&&[is_complaint integerValue]==1) {
        //已评价 已投诉
        if ([is_more_info integerValue]==1) {
            self.moreArray =      @[@{@"left":@"更多项目信息"},
                                    @{@"left":@"交易评价"},
                                    @{@"left":@"投诉详情"}];
        }else{
            self.moreArray =      @[@{@"left":@"交易评价"},
                                    @{@"left":@"投诉详情"}];
        }
        
    }else if ([is_complaint integerValue]==1) {
        if ([is_more_info integerValue]==1) {
            self.moreArray =      @[@{@"left":@"更多项目信息"},
                                    @{@"left":@"投诉详情"}];
        }else{
            self.moreArray =      @[@{@"left":@"投诉详情"}];
        }
        
    }else if ([self.states isEqualToString:@"rate_done"]) {
        if ([is_more_info integerValue]==1) {
            self.moreArray =      @[@{@"left":@"更多项目信息"},
                                    @{@"left":@"交易评价"}];
        }else{
            self.moreArray =      @[@{@"left":@"交易评价"}];
        }
        
    }else{
        if ([is_more_info integerValue]==1) {
            self.moreArray =      @[@{@"left":@"更多项目信息"}];
        }else{
            self.moreArray =      [NSArray array];
        }
        
    }
    
    [self.buyView.buyTableView reloadData];
}





#pragma mark - Load Data
//left
- (void)evokeSouceData{
    
    
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    [self.HUD show:YES];
    
    NSDictionary *parm = @{@"id":self.buyID};
    NSString *urlStr   = [NSString stringWithFormat:@"%@/info/my-buy-business-detail",APIDev];
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:parm withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"buy --- %@",object);
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            
            self.infoDic = [NSDictionary dictionaryWithDictionary:object[@"data"][@"info"]];
            self.complaint_id = [NSString stringWithFormat:@"%@",self.infoDic[@"complaint_id"]];
            
            
            NSString *is_complaint = [NSString stringWithFormat:@"%@",self.infoDic[@"is_complaint"]];
            self.states = [NSString stringWithFormat:@"%@",self.infoDic[@"status"]];
            NSString *is_more_info = [NSString stringWithFormat:@"%@",self.infoDic[@"is_more_info"]];
            NSLog(@"%@%@",is_complaint,self.states);
            if ([self.states isEqualToString:@"rate_done"]&&[is_complaint integerValue]==1) {
                //已评价 已投诉
                if ([is_more_info integerValue]==1) {
                    self.moreArray =      @[@{@"left":@"更多项目信息"},
                                            @{@"left":@"交易评价"},
                                            @{@"left":@"投诉详情"}];
                }else{
                    self.moreArray =      @[@{@"left":@"交易评价"},
                                            @{@"left":@"投诉详情"}];
                }
                
            }else if ([is_complaint integerValue]==1) {
                if ([is_more_info integerValue]==1) {
                    self.moreArray =      @[@{@"left":@"更多项目信息"},
                                            @{@"left":@"投诉详情"}];
                }else{
                    self.moreArray =      @[@{@"left":@"投诉详情"}];
                }
                
            }else if ([self.states isEqualToString:@"rate_done"]) {
                if ([is_more_info integerValue]==1) {
                    self.moreArray =      @[@{@"left":@"更多项目信息"},
                                            @{@"left":@"交易评价"}];
                }else{
                    self.moreArray =      @[@{@"left":@"交易评价"}];
                }
                
            }else{
                if ([is_more_info integerValue]==1) {
                    self.moreArray =      @[@{@"left":@"更多项目信息"}];
                }else{
                    self.moreArray =      [NSArray array];
                }
                
            }
            
            
            
            
            //one
            //NSString *status       = [NSString stringWithFormat:@"%@",object[@"data"][@"info"][@"status"]];
            NSString *status_title = [NSString stringWithFormat:@"%@",object[@"data"][@"info"][@"status_title"]];
            NSString *title        = [NSString stringWithFormat:@"%@",object[@"data"][@"info"][@"title"]];
            NSString *time         = [NSString stringWithFormat:@"%@",object[@"data"][@"info"][@"time"]];
            NSString *price        = [NSString stringWithFormat:@"%@",object[@"data"][@"info"][@"price"]];
            NSString *local_sn     = [NSString stringWithFormat:@"%@",object[@"data"][@"info"][@"local_sn"]];
            self.buyTipDic =  @{@"title":title,
                                @"time":time,
                                @"status":self.states,
                                @"status_title":status_title,
                                @"price":price,
                                @"local_sn":local_sn};
            
            
            //asker
            self.askerTipDic = [NSDictionary dictionaryWithDictionary:object[@"data"][@"asker"]];
            
            
            
            //two
            NSString *type              = [NSString stringWithFormat:@"%@",object[@"data"][@"info"][@"type"]];
            NSString *expire_time              = [NSString stringWithFormat:@"%@",object[@"data"][@"info"][@"expire_time"]];
            
            
            NSString *target_amountTitle;
            NSDictionary *target_amountTitleDic =object[@"data"][@"info"][@"target_amount"];
            NSLog(@"target_amountTitleDic -------------------------------------------------------- %@",target_amountTitleDic);
            if ([target_amountTitleDic isEqual:[NSNull null]]) {
                target_amountTitle =@"--";
            }else{
                target_amountTitle     = [NSString stringWithFormat:@"%@",object[@"data"][@"info"][@"target_amount"][@"title"]];
            }
            
            
            NSString *demander          = [NSString stringWithFormat:@"%@",
                                           object[@"data"][@"info"][@"demander_name"]];
            
            NSString *demanderPos          = [NSString stringWithFormat:@"%@",
                                           object[@"data"][@"info"][@"demander_title"]];
            NSString *tel               = [NSString stringWithFormat:@"%@",object[@"data"][@"info"][@"demander_tel"]];
            
            NSString *support_level;
            NSDictionary *support_levelDic =object[@"data"][@"info"][@"support_level"];
            NSLog(@"support_levelDic -------------------------------------------------------- %@",support_levelDic);
            if ([support_levelDic isEqual:[NSNull null]]) {
                support_level =@"--";
            }else{
                support_level     = [NSString stringWithFormat:@"%@",object[@"data"][@"info"][@"support_level"][@"title"]];
            }
            
            NSString *description       = [NSString stringWithFormat:@"%@",object[@"data"][@"info"][@"description"]];
            
            NSString *biz_locate       = [NSString stringWithFormat:@"%@",object[@"data"][@"info"][@"biz_locate"]];
            if (biz_locate.length==0||[biz_locate isEqualToString:@"(null)"]||[biz_locate isEqualToString:@"<null>"]) {
                biz_locate = @"暂无";
            }
            
            NSLog(@"biz_locate ***************************** %@",biz_locate);
            
            self.sellArray =      @[@{@"left":@"所在城市",@"right":[biz_locate stringByReplacingOccurrencesOfString:@"^" withString:@" "]},
                                    @{@"left":@"项目类型",@"right":type},
                                    @{@"left":@"预估标的额",@"right":target_amountTitle},
                                    @{@"left":@"消息有效期",@"right":[self timeChange:expire_time]},
                                    @{@"left":@"甲方联系方式",@"right":demander,@"rightTitle":demanderPos,@"tel":tel},
                                    @{@"left":@"可提供的支持",@"right":support_level},
                                    @{@"left":@"项目说明",@"right":description}];
            
            
        }else{
            [self showProgress:object[@"status"][@"message"]];
        }
        [self.buyView.buyTableView reloadData];
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
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else if (section==1){
        return 1;
    }else if (section==2){
        return self.sellArray.count;
    }else{
        return self.moreArray.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        
        NSString *is_complaint = [NSString stringWithFormat:@"%@",self.infoDic[@"is_complaint"]];
        NSString *status = [NSString stringWithFormat:@"%@",self.infoDic[@"status"]];
        
        NSLog(@"%@%@",is_complaint,status);
        
        
        NSString *title  = [NSString stringWithFormat:@"%@",self.infoDic[@"title"]];
        CGSize size = CGSizeMake(SCREEN_WIDTH-SCREEN_WIDTH/375*17.5-SCREEN_WIDTH/375*79, 0);
        CGSize autoSize = [[UILabel new] actualSizeOfLineSpaceLable:title
                                                            andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
                                                            andSize:size];
        if ([status isEqualToString:@"rate_done"]&&[is_complaint integerValue]==1) {
           //已评价 已投诉
            return SCREEN_WIDTH/375*120-SCREEN_WIDTH/375*20+autoSize.height;
        }else{
           return SCREEN_WIDTH/375*170-SCREEN_WIDTH/375*20+autoSize.height;
        }
        
        
    }else if (indexPath.section==1){
        return SCREEN_WIDTH/375*142-SCREEN_WIDTH/375*20;
    }else if (indexPath.section==2){
        
        
        if (indexPath.row==4) {
            return SCREEN_WIDTH/375*82;
        }else{
            NSDictionary *baseDic = self.sellArray[indexPath.row];
            NSString *right = [NSString stringWithFormat:@"%@",baseDic[@"right"]];
            CGSize size = CGSizeMake(SCREEN_WIDTH-SCREEN_WIDTH/375*150, 0);
            CGSize autoSize = [[UILabel new] actualSizeOfLineSpaceLable:right
                                                                andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
                                                                andSize:size];
            return SCREEN_WIDTH/375*26+autoSize.height;
        }
        
    }else{
        return SCREEN_WIDTH/375*45;
    }
    
}

/**header**/
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        return SCREEN_WIDTH/375*0.1;
    }else if (section==1){
        return SCREEN_WIDTH/375*45;
    }else if (section==2){
        return SCREEN_WIDTH/375*45;
    }else{
        return SCREEN_WIDTH/375*0.1;
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        UIView *headerView         = [[UIView alloc] init];
        headerView.backgroundColor = [UIColor clearColor];
        return headerView;
    }else if (section==1){
        
        ZMSellBuySectionHeaderView *header = [[ZMSellBuySectionHeaderView alloc] init];
        [header settitle:@"发布者"];
        header.changeBtn.alpha = 0;
        return header;
    }else if (section==2){
        
        ZMSellBuySectionHeaderView *header = [[ZMSellBuySectionHeaderView alloc] init];
        header.changeBtn.alpha = 0;
        [header settitle:@"信息内容"];
        return header;
    }else{
        UIView *headerView         = [[UIView alloc] init];
        headerView.backgroundColor = [UIColor clearColor];
        return headerView;
    }
}



/**footer**/
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return SCREEN_WIDTH/375*16;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footView         = [[UIView alloc] init];
    footView.backgroundColor = [UIColor clearColor];
    return footView;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *oneIndentifire             = @"oneCell";
    static NSString *onelitterIndentifire       = @"oneLitterCell";
    
    static NSString *peopleIndentifire          = @"peopleCell";
    static NSString *secondIndentifire          = @"secondCell";
    static NSString *secondPartAIndentifire     = @"secondPartACell";
    static NSString *invoiceIndentifire         = @"invoiceCell";
    
    
    
    if (indexPath.section==0) {
        
        NSString *is_complaint = [NSString stringWithFormat:@"%@",self.infoDic[@"is_complaint"]];
        NSString *status       = [NSString stringWithFormat:@"%@",self.infoDic[@"status"]];
        
        NSLog(@"%@%@",is_complaint,status);
        if ([status isEqualToString:@"rate_done"]&&[is_complaint integerValue]==1) {
            //已评价 已投诉
            ZMBuyOneLitterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:onelitterIndentifire];
            if (!cell) {
                cell = [[ZMBuyOneLitterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:onelitterIndentifire];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            [cell setBuyTipOne:self.infoDic];
            return cell;
        }else{
            ZMBuyOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:oneIndentifire];
            if (!cell) {
                cell = [[ZMBuyOneTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:oneIndentifire];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            [cell.tousuBtn addTarget:self action:@selector(tousuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.pingjiaBtn addTarget:self action:@selector(pingjiaBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell setBuyTipOne:self.infoDic];
            //cell.backgroundColor = [UIColor redColor];
            return cell;
        }
        
        
    }else if (indexPath.section==1) {
        
        ZMPeopleOfSellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:peopleIndentifire];
        if (!cell) {
            cell = [[ZMPeopleOfSellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:peopleIndentifire];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell setAsker:self.askerTipDic mask:self.infoDic[@"mask"]];
        return cell;
        
    }else if (indexPath.section==2) {
        NSDictionary *sellDetailDic = self.sellArray[indexPath.row];
        if (indexPath.row==4) {
            ZMMySellSecondPartyATableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:secondPartAIndentifire];
            if (!cell) {
                cell = [[ZMMySellSecondPartyATableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:secondPartAIndentifire];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            [cell setInvoiceDetail:sellDetailDic];
            return cell;
        }else{
            ZMMySellSecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:secondIndentifire];
            if (!cell) {
                cell = [[ZMMySellSecondTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:secondIndentifire];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            [cell setInvoiceDetail:sellDetailDic];
            if (indexPath.row==self.sellArray.count-1) {
                cell.line.alpha = 0;
            }
            return cell;
        }
        
        
        
    }else{
        NSDictionary *moreDic = self.moreArray[indexPath.row];
        ZMMyMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:invoiceIndentifire];
        if (!cell) {
            cell = [[ZMMyMoreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:invoiceIndentifire];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (indexPath.row==self.moreArray.count-1) {
            cell.line.alpha = 0;
        }else{
            cell.line.alpha = 1;
        }
        [cell setMoreTiele:moreDic];
        return cell;
    }
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //NSLog(@"buy");
    if (indexPath.section==3) {
        
        
        NSString *is_complaint = [NSString stringWithFormat:@"%@",self.infoDic[@"is_complaint"]];
        self.states = [NSString stringWithFormat:@"%@",self.infoDic[@"status"]];
        
        NSString *is_more_info = [NSString stringWithFormat:@"%@",self.infoDic[@"is_more_info"]];
        NSLog(@"%@%@",is_complaint,self.states);
        if ([self.states isEqualToString:@"rate_done"]&&[is_complaint integerValue]==1) {
            //已评价 已投诉
            if ([is_more_info integerValue]==1) {
                //self.moreArray =      @[@{@"left":@"更多项目信息"},
                                        //@{@"left":@"交易评价"},
                                        //@{@"left":@"投诉详情"}];
                if (indexPath.row==0) {
                    NSLog(@"更多项目信息");
                    NSString *encodeUrl = [NSString stringWithFormat:@"%@/member/info_more.html?id=%@&buy=1&fromApp=1",h5Dev,self.buyID];
                    ZMMoreInfoMoneyViewController *moreView = [[ZMMoreInfoMoneyViewController alloc] init];
                    moreView.webUrl                         = encodeUrl;
                    moreView.titleStr                       = @"更多项目信息";
                    [self.navigationController pushViewController:moreView animated:YES];
                }else if (indexPath.row==1){
                    NSLog(@"交易评价");
                    ZMTradingEvaluationViewController *tradingEvaluationVC = [[ZMTradingEvaluationViewController alloc] init];
                    tradingEvaluationVC.isSell = NO;
                    tradingEvaluationVC.infoID = self.buyID;
                    tradingEvaluationVC.buyTipDic = self.buyTipDic;
                    [self.navigationController pushViewController:tradingEvaluationVC animated:YES];
                }else{
                    NSLog(@"投诉详情");
                    //NSString *complaint_id = [NSString stringWithFormat:@"%@",self.infoDic[@"complaint_id"]];
                    ZMComplaintsDetailViewController *complaintsDetailVC = [[ZMComplaintsDetailViewController alloc] init];
                    complaintsDetailVC.title = @"投诉详情";
                    complaintsDetailVC.feedID = self.complaint_id;
                    complaintsDetailVC.status = self.states;
                    complaintsDetailVC.topDic = self.infoDic;
                    [self.navigationController pushViewController:complaintsDetailVC animated:YES];
                }
            }else{
                //self.moreArray =      @[@{@"left":@"交易评价"},
                                        //@{@"left":@"投诉详情"}];
                if (indexPath.row==0) {
                    NSLog(@"交易评价");
                    ZMTradingEvaluationViewController *tradingEvaluationVC = [[ZMTradingEvaluationViewController alloc] init];
                    tradingEvaluationVC.isSell = NO;
                    tradingEvaluationVC.infoID = self.buyID;
                    tradingEvaluationVC.buyTipDic = self.buyTipDic;
                    [self.navigationController pushViewController:tradingEvaluationVC animated:YES];
                }else{
                    NSLog(@"投诉详情");
                    ZMComplaintsDetailViewController *complaintsDetailVC = [[ZMComplaintsDetailViewController alloc] init];
                    complaintsDetailVC.title = @"投诉详情";
                    complaintsDetailVC.feedID = self.complaint_id;
                    complaintsDetailVC.status = self.states;
                    complaintsDetailVC.topDic = self.infoDic;
                    [self.navigationController pushViewController:complaintsDetailVC animated:YES];
                }
            }
            
        }else if ([is_complaint integerValue]==1) {
            if ([is_more_info integerValue]==1) {
                //self.moreArray =      @[@{@"left":@"更多项目信息"},
                                        //@{@"left":@"投诉详情"}];
                if (indexPath.row==0) {
                    NSLog(@"更多项目信息");
                    
                    //NSString *encodeUrl = [NSString stringWithFormat:@"%@#info=%@&title=%@&fee=%@&mask=%@&mode=static&token=%@",dynamicFormUrl,self.buyID,
                                           //self.infoDic[@"title"],self.infoDic[@"price"],self.infoDic[@"mask"],
                                           //[[NSUserDefaults standardUserDefaults] objectForKey:TOKEN]];
                    
                    NSString *encodeUrl = [NSString stringWithFormat:@"%@/member/info_more.html?id=%@&buy=1&fromApp=1",h5Dev,self.buyID];
                    
                    ZMMoreInfoMoneyViewController *moreView = [[ZMMoreInfoMoneyViewController alloc] init];
                    moreView.webUrl                         = encodeUrl;
                    moreView.titleStr                       = @"更多项目信息";
                    [self.navigationController pushViewController:moreView animated:YES];
                }else{
                    NSLog(@"投诉详情");
                    //NSString *complaint_id = [NSString stringWithFormat:@"%@",self.infoDic[@"complaint_id"]];
                    ZMComplaintsDetailViewController *complaintsDetailVC = [[ZMComplaintsDetailViewController alloc] init];
                    complaintsDetailVC.title = @"投诉详情";
                    complaintsDetailVC.feedID = self.complaint_id;
                    complaintsDetailVC.status = self.states;
                    complaintsDetailVC.topDic = self.infoDic;
                    [self.navigationController pushViewController:complaintsDetailVC animated:YES];
                }
            }else{
                //self.moreArray =      @[@{@"left":@"投诉详情"}];
                NSLog(@"投诉详情");
                //NSString *complaint_id = [NSString stringWithFormat:@"%@",self.infoDic[@"complaint_id"]];
                ZMComplaintsDetailViewController *complaintsDetailVC = [[ZMComplaintsDetailViewController alloc] init];
                complaintsDetailVC.title = @"投诉详情";
                complaintsDetailVC.feedID = self.complaint_id;
                complaintsDetailVC.status = self.states;
                complaintsDetailVC.topDic = self.infoDic;
                [self.navigationController pushViewController:complaintsDetailVC animated:YES];
            }
            
        }else if ([self.states isEqualToString:@"rate_done"]) {
            if ([is_more_info integerValue]==1) {
                //self.moreArray =      @[@{@"left":@"更多项目信息"},
                                        //@{@"left":@"交易评价"}];
                if (indexPath.row==0) {
                    NSLog(@"更多项目信息");
                    
                    //NSString *encodeUrl = [NSString stringWithFormat:@"%@#info=%@&title=%@&fee=%@&mask=%@&mode=static&token=%@",dynamicFormUrl,self.buyID,
                                           //self.infoDic[@"title"],self.infoDic[@"price"],self.infoDic[@"mask"],
                                           //[[NSUserDefaults standardUserDefaults] objectForKey:TOKEN]];
                    
                    NSString *encodeUrl = [NSString stringWithFormat:@"%@/member/info_more.html?id=%@&buy=1&fromApp=1",h5Dev,self.buyID];
                    ZMMoreInfoMoneyViewController *moreView = [[ZMMoreInfoMoneyViewController alloc] init];
                    moreView.webUrl                         = encodeUrl;
                    moreView.titleStr                       = @"更多项目信息";
                    [self.navigationController pushViewController:moreView animated:YES];
                }else{
                    NSLog(@"交易评价");
                    ZMTradingEvaluationViewController *tradingEvaluationVC = [[ZMTradingEvaluationViewController alloc] init];
                    tradingEvaluationVC.isSell = NO;
                    tradingEvaluationVC.infoID = self.buyID;
                    tradingEvaluationVC.buyTipDic = self.buyTipDic;
                    [self.navigationController pushViewController:tradingEvaluationVC animated:YES];
                }
            }else{
                //self.moreArray =      @[@{@"left":@"交易评价"}];
                NSLog(@"交易评价");
                ZMTradingEvaluationViewController *tradingEvaluationVC = [[ZMTradingEvaluationViewController alloc] init];
                tradingEvaluationVC.isSell = NO;
                tradingEvaluationVC.infoID = self.buyID;
                tradingEvaluationVC.buyTipDic = self.buyTipDic;
                [self.navigationController pushViewController:tradingEvaluationVC animated:YES];
            }
            
        }else{
            if ([is_more_info integerValue]==1) {
                //self.moreArray =      @[@{@"left":@"更多项目信息"}];
                NSLog(@"更多项目信息");
                NSString *encodeUrl = [NSString stringWithFormat:@"%@/member/info_more.html?id=%@&buy=1&fromApp=1",h5Dev,self.buyID];
                
                
                ZMMoreInfoMoneyViewController *moreView = [[ZMMoreInfoMoneyViewController alloc] init];
                moreView.webUrl                         = encodeUrl;
                moreView.titleStr                       = @"更多项目信息";
                [self.navigationController pushViewController:moreView animated:YES];
            }else{
                //self.moreArray =      [NSArray array];
            }
        }
        
    }else if (indexPath.section==2){
        if (indexPath.row==4) {
            NSDictionary *sellDetailDic = self.sellArray[4];
            NSString *tel = [NSString stringWithFormat:@"%@",sellDetailDic[@"tel"]];
            NSMutableString* str = [[NSMutableString alloc] initWithFormat:@"telprompt://%@",tel];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            
        }
    }else if (indexPath.section==1){
        NSString *mask = [NSString stringWithFormat:@"%@",self.infoDic[@"mask"]];
        if ([mask integerValue]==0) {
            NSString *tel = [NSString stringWithFormat:@"%@",self.askerTipDic[@"username"]];
            NSMutableString* str = [[NSMutableString alloc] initWithFormat:@"telprompt://%@",tel];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
    }
}


#pragma mark - TouSu
- (void)tousuBtnClick:(UIButton *)sender{
    NSLog(@"tousu");
    ZMComplaintViewController *complaintVC = [[ZMComplaintViewController alloc] init];
    complaintVC.infoID = self.buyID;
    complaintVC.infoDic= self.infoDic;
    [self.navigationController pushViewController:complaintVC animated:YES];
}

- (void)pingjiaBtnClick:(UIButton *)sender{
    NSLog(@"pingjia");
    ZMPostEvaluationViewController *postEvaluationVC = [[ZMPostEvaluationViewController alloc] init];
    postEvaluationVC.infoID = self.buyID;
    postEvaluationVC.isSell = NO;
    postEvaluationVC.buyTipDic = self.buyTipDic;
    [self.navigationController pushViewController:postEvaluationVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
