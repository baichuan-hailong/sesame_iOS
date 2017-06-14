//
//  ZMMySellViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/24.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMMySellViewController.h"
#import "ZMMySellView.h"
#import "ZMSellBuySectionHeaderView.h"
#import "ZMMySellOneTableViewCell.h"
#import "ZMMySellSecondPartyATableViewCell.h"
#import "ZMMySellSecondTableViewCell.h"
#import "ZMMyMoreTableViewCell.h"
#import "ZMTradingEvaluationViewController.h"
#import "ZMMoreProjectInfoViewController.h"
#import "ZMTradingBusinessDetailViewController.h"

#import "ZMMoreInfoMoneyViewController.h"

@interface ZMMySellViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) ZMMySellView       *sellView;

@property (nonatomic , strong) NSDictionary       *infoDic;

@property (nonatomic , strong) NSDictionary       *sellTipDic;
@property (nonatomic , strong) NSArray            *sellArray;
@property (nonatomic , strong) NSArray            *moreArray;
@property (nonatomic , strong) MBProgressHUD      *HUD;
@end

@implementation ZMMySellViewController

- (void)loadView {
    //change
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.sellView    = [[ZMMySellView alloc] initWithFrame:SCREEN_BOUNDS];
    self.view                                 = self.sellView;
    self.sellView.sellTableView.delegate   = self;
    self.sellView.sellTableView.dataSource = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我卖的";
    
    self.sellArray =      @[@{@"left":@"所在城市",@"right":@"--"},
                            @{@"left":@"项目类型",@"right":@"--"},
                            @{@"left":@"预估标的额",@"right":@"--"},
                            @{@"left":@"消息有效期",@"right":@"--"},
                            @{@"left":@"甲方联系方式",@"right":@"--",@"rightTitle":@"--",@"tel":@"--"},
                            @{@"left":@"可提供的支持",@"right":@"--"},
                            @{@"left":@"项目说明",@"right":@"--"}];
    
    self.moreArray =      @[@{@"left":@"--"}];
    
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(perfectCompleteAc) name:@"perfectComplete" object:nil];
    
    [self evokeSouceData];
}

#pragma mark - 完善成功
- (void)perfectCompleteAc{
    [self showProgress:@"项目完善成功！"];
    
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:self.infoDic];
    [tempDic setObject:@"1" forKey:@"is_more_info"];
    self.infoDic = tempDic;
    [self.sellView.sellTableView reloadData];
}


#pragma mark - Load Data
- (void)evokeSouceData{
    
    
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    [self.HUD show:YES];
    
    NSDictionary *parm = @{@"id":self.sellID};
    NSString *urlStr   = [NSString stringWithFormat:@"%@/info/my-sell-business-detail",APIDev];
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:parm withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"sell --- %@",object);
    
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        
        
        
        if ([stateStr isEqualToString:@"success"]) {
            
            self.infoDic = object[@"data"];
            
            //one
            NSString *status       = [NSString stringWithFormat:@"%@",object[@"data"][@"status"]];
            NSString *status_title = [NSString stringWithFormat:@"%@",object[@"data"][@"status_title"]];
            NSString *title        = [NSString stringWithFormat:@"%@",object[@"data"][@"title"]];
            NSString *time         = [NSString stringWithFormat:@"%@",object[@"data"][@"time"]];
            NSString *price        = [NSString stringWithFormat:@"%@",object[@"data"][@"price"]];
            NSString *accept_time  = [NSString stringWithFormat:@"%@",object[@"data"][@"accept_time"]];
            NSString *cancel_time  = [NSString stringWithFormat:@"%@",object[@"data"][@"cancel_time"]];
            NSString *expire_time  = [NSString stringWithFormat:@"%@",object[@"data"][@"expire_time"]];
            NSString *local_sn     = [NSString stringWithFormat:@"%@",object[@"data"][@"local_sn"]];
            self.sellTipDic = @{@"title":title,
                                @"time":time,
                                @"status":status,
                                @"status_title":status_title,
                                @"price":price,
                                @"accept_time":accept_time,
                                @"cancel_time":cancel_time,
                                @"expire_time":expire_time,
                                @"local_sn":local_sn};
            
            
            
            
            
            //two
            NSString *type = [NSString stringWithFormat:@"%@",object[@"data"][@"type"]];
            
            
            NSString *target_amountTitle;
            NSDictionary *target_amountTitleDic =object[@"data"][@"target_amount"];
            NSLog(@"target_amountTitleDic -------------------------------------------------------- %@",target_amountTitleDic);
            if ([target_amountTitleDic isEqual:[NSNull null]]) {
                target_amountTitle =@"暂无";
            }else{
                target_amountTitle     = [NSString stringWithFormat:@"%@",object[@"data"][@"target_amount"][@"title"]];
            }
            
            
            NSString *demander          = [NSString stringWithFormat:@"%@",
                                           object[@"data"][@"demander_name"]];
            
            NSString *demanderPos        = [NSString stringWithFormat:@"%@",
                                           object[@"data"][@"demander_title"]];
            
            NSString *tel = [NSString stringWithFormat:@"%@",object[@"data"][@"demander_tel"]];
            
            NSString *support_level;
            NSDictionary *support_levelDic =object[@"data"][@"support_level"];
            NSLog(@"support_levelDic -------------------------------------------------------- %@",support_levelDic);
            if ([support_levelDic isEqual:[NSNull null]]) {
                support_level =@"暂无";
            }else{
                support_level     = [NSString stringWithFormat:@"%@",object[@"data"][@"support_level"][@"title"]];
            }
            
            NSString *description       = [NSString stringWithFormat:@"%@",object[@"data"][@"description"]];
            
            NSString *biz_locate       = [NSString stringWithFormat:@"%@",object[@"data"][@"biz_locate"]];
            if (biz_locate.length==0||[biz_locate isEqualToString:@"(null)"]||[biz_locate isEqualToString:@"<null?"]) {
                biz_locate = @"暂无";
            }
            
            self.sellArray =      @[@{@"left":@"所在城市",@"right":[biz_locate stringByReplacingOccurrencesOfString:@"^" withString:@" "]},
                                    @{@"left":@"项目类型",@"right":type},
                                    @{@"left":@"预估标的额",@"right":target_amountTitle},
                                    @{@"left":@"消息有效期",@"right":[self timeChange:expire_time]},
                                    @{@"left":@"甲方联系方式",@"right":demander,@"rightTitle":demanderPos,@"tel":tel},
                                    @{@"left":@"可提供的支持",@"right":support_level},
                                    @{@"left":@"项目说明",@"right":description}];
            
            
            
            
            self.states            = [NSString stringWithFormat:@"%@",self.infoDic[@"status"]];
            NSString *is_more_info = [NSString stringWithFormat:@"%@",self.infoDic[@"is_more_info"]];
            
            
        
            //static
            //more
            if ([self.states isEqualToString:@"submit_pending"]) {
                //发布中
                self.moreArray =      @[@{@"left":@"更多项目信息"}];
            }else if ([self.states isEqualToString:@"dealt_pending"]) {
                //已售出
                if ([is_more_info integerValue]==1) {
                    self.moreArray =      @[@{@"left":@"更多项目信息"},
                                            @{@"left":@"交易详情"}];
                }else{
                    self.moreArray =      @[@{@"left":@"交易详情"}];
                }
                
            }else if ([self.states isEqualToString:@"rate_done"]) {
                //已评价
                if ([is_more_info integerValue]==1) {
                    self.moreArray =      @[@{@"left":@"更多项目信息"},
                                            @{@"left":@"交易详情"},
                                            @{@"left":@"交易评价"}];
                }else{
                    self.moreArray =      @[@{@"left":@"交易详情"},
                                            @{@"left":@"交易评价"}];
                }
                
                
            }else{
                //过期下架
                //cancel_die  expired_die
                if ([is_more_info integerValue]==1) {
                    self.moreArray =      @[@{@"left":@"更多项目信息"}];
                }else{
                    self.moreArray =      [NSArray array];
                }
                
            }
            
            /*
             if ([is_more_info integerValue]==1) {
             
             
             }else{
             //other
             if ([self.states isEqualToString:@"dealt_pending"]) {
             //已售出
             self.moreArray =      @[@{@"left":@"交易详情"}];
             }else if ([self.states isEqualToString:@"rate_done"]) {
             //已评价
             self.moreArray =      @[@{@"left":@"交易详情"},
             @{@"left":@"交易评价"}];
             
             }else if ([self.states isEqualToString:@"submit_pending"]) {
             //发布中
             self.moreArray =      [NSArray array];
             }else{
             //过期下架
             self.moreArray =      [NSArray array];
             }
             }
             
             */
            
        }else{
            [self showProgress:object[@"status"][@"message"]];
        }
        
        [self.sellView.sellTableView reloadData];
        
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
        return self.sellArray.count;
    }else{
        return self.moreArray.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        
        //SCREEN_WIDTH-SCREEN_WIDTH/375*17.5-SCREEN_WIDTH/375*79,
        //SCREEN_WIDTH/375*20
        NSString *title  = [NSString stringWithFormat:@"%@",self.sellTipDic[@"title"]];
        CGSize size = CGSizeMake(SCREEN_WIDTH-SCREEN_WIDTH/375*17.5-SCREEN_WIDTH/375*79, 0);
        CGSize autoSize = [[UILabel new] actualSizeOfLineSpaceLable:title
                                                            andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
                                                            andSize:size];
        
        return SCREEN_WIDTH/375*130+autoSize.height;
    }else if (indexPath.section==1){
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
        [header settitle:@"信息内容"];
        if ([self.states isEqualToString:@"submit_pending"]) {
            header.changeBtn.alpha = 0;
        }else{
            header.changeBtn.alpha = 0;
        }
        [header.changeBtn addTarget:self action:@selector(changeBtnClickAc:) forControlEvents:UIControlEventTouchUpInside];
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
    static NSString *secondIndentifire          = @"secondCell";
    static NSString *secondPartAIndentifire     = @"secondpartaCell";
    static NSString *invoiceIndentifire         = @"invoiceCell";
    
    
    
    if (indexPath.section==0) {
        ZMMySellOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:oneIndentifire];
        if (!cell) {
            cell = [[ZMMySellOneTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:oneIndentifire];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell setSellOne:self.sellTipDic];
        [cell.cancleBtn addTarget:self action:@selector(cancleBtnClickedAc:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        
    }if (indexPath.section==1) {
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
            NSLog(@"indexPath.row  ------ %ld",indexPath.row);
            
            return cell;
        }
        
        
        
    }else{
        NSDictionary *moreDic = self.moreArray[indexPath.row];
        ZMMyMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:invoiceIndentifire];
        if (!cell) {
            cell = [[ZMMyMoreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:invoiceIndentifire];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        if (indexPath.row==(self.moreArray.count-1)) {
            cell.line.alpha = 0;
        }else{
            cell.line.alpha = 1;
        }
        
        NSLog(@"%ld ---- %ld",self.moreArray.count-1,indexPath.row);
        
        [cell setMoreTiele:moreDic];
        return cell;
    }
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //NSLog(@"sell");
    
    if (indexPath.section==2) {

        NSString *is_more_info = [NSString stringWithFormat:@"%@",self.infoDic[@"is_more_info"]];
        //NSString *titleUTF8Str = [self.infoDic[@"title"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        if ([self.states isEqualToString:@"submit_pending"]) {
            //发布中
            //self.moreArray =      @[@{@"left":@"更多项目信息"}];
            if (indexPath.row==0) {
                NSLog(@"more");
                if ([is_more_info integerValue]==1) {
                    //static
                    //NSString *encodeUrl = [NSString stringWithFormat:@"%@#info=%@&title=%@&fee=%@&mask=%@&mode=static&token=%@",dynamicFormUrl,self.sellID,
                                           //titleUTF8Str,self.infoDic[@"price"],self.infoDic[@"mask"],
                                           //[[NSUserDefaults standardUserDefaults] objectForKey:TOKEN]];
                    
                    NSString *encodeUrl = [NSString stringWithFormat:@"%@/member/info_more.html?id=%@&buy=1&fromApp=1",h5Dev,self.sellID];
                    
                    ZMMoreInfoMoneyViewController *moreView = [[ZMMoreInfoMoneyViewController alloc] init];
                    moreView.webUrl                         = encodeUrl;
                    moreView.titleStr                       = @"更多项目信息";
                    [self.navigationController pushViewController:moreView animated:YES];
                    
                }else{
                    //other
                    if ([self.states isEqualToString:@"submit_pending"]) {
                        [self fnishProjectPop];
                    }
                }
            }
        }else if ([self.states isEqualToString:@"dealt_pending"]) {
            //已售出
            if ([is_more_info integerValue]==1) {
                //self.moreArray =      @[@{@"left":@"更多项目信息"},
                                       //@{@"left":@"交易详情"}];
                if (indexPath.row==0) {
                    //static
                    NSString *encodeUrl = [NSString stringWithFormat:@"%@/member/info_more.html?id=%@&buy=1&fromApp=1",h5Dev,self.sellID];
                    
                    ZMMoreInfoMoneyViewController *moreView = [[ZMMoreInfoMoneyViewController alloc] init];
                    moreView.webUrl                         = encodeUrl;
                    moreView.titleStr                       = @"更多项目信息";
                    [self.navigationController pushViewController:moreView animated:YES];
                    
                }else{
                    //交易详情
                    ZMTradingBusinessDetailViewController *tradingBusinessDetailVC = [[ZMTradingBusinessDetailViewController alloc] init];
                    tradingBusinessDetailVC.sellID = self.sellID;
                    [self.navigationController pushViewController:tradingBusinessDetailVC animated:YES];
                    
                }
            }else{
                //self.moreArray =      @[@{@"left":@"交易详情"}];
                //交易详情
                ZMTradingBusinessDetailViewController *tradingBusinessDetailVC = [[ZMTradingBusinessDetailViewController alloc] init];
                tradingBusinessDetailVC.sellID = self.sellID;
                [self.navigationController pushViewController:tradingBusinessDetailVC animated:YES];
                
            }
            
        }else if ([self.states isEqualToString:@"rate_done"]) {
            //已评价
            if ([is_more_info integerValue]==1) {
                //self.moreArray =      @[@{@"left":@"更多项目信息"},
                                        //@{@"left":@"交易详情"},
                                        //@{@"left":@"交易评价"}];
                if (indexPath.row==0) {
                    NSLog(@"more");
                    //static
                    NSString *encodeUrl = [NSString stringWithFormat:@"%@/member/info_more.html?id=%@&buy=1&fromApp=1",h5Dev,self.sellID];
                    
                    ZMMoreInfoMoneyViewController *moreView = [[ZMMoreInfoMoneyViewController alloc] init];
                    moreView.webUrl                         = encodeUrl;
                    moreView.titleStr                       = @"更多项目信息";
                    [self.navigationController pushViewController:moreView animated:YES];
                }else if (indexPath.row==1){
                    NSLog(@"jiaoyi");
                    //交易详情
                    ZMTradingBusinessDetailViewController *tradingBusinessDetailVC = [[ZMTradingBusinessDetailViewController alloc] init];
                    tradingBusinessDetailVC.sellID = self.sellID;
                    [self.navigationController pushViewController:tradingBusinessDetailVC animated:YES];
                }else if (indexPath.row==2){
                    //NSLog(@"交易评价......");
                    ZMTradingEvaluationViewController *tradingEvaluationVC = [[ZMTradingEvaluationViewController alloc] init];
                    tradingEvaluationVC.isSell = YES;
                    tradingEvaluationVC.infoID = self.sellID;
                    [self.navigationController pushViewController:tradingEvaluationVC animated:YES];
                }
            }else{
                //self.moreArray =      @[@{@"left":@"交易详情"},
                                        //@{@"left":@"交易评价"}];
                if (indexPath.row==0){
                    NSLog(@"jiaoyi");
                    //交易详情
                    ZMTradingBusinessDetailViewController *tradingBusinessDetailVC = [[ZMTradingBusinessDetailViewController alloc] init];
                    tradingBusinessDetailVC.sellID = self.sellID;
                    [self.navigationController pushViewController:tradingBusinessDetailVC animated:YES];
                }else if (indexPath.row==1){
                    //NSLog(@"交易评价......");
                    ZMTradingEvaluationViewController *tradingEvaluationVC = [[ZMTradingEvaluationViewController alloc] init];
                    tradingEvaluationVC.isSell = YES;
                    tradingEvaluationVC.infoID = self.sellID;
                    [self.navigationController pushViewController:tradingEvaluationVC animated:YES];
                }
            }
            
            
        }else{
            //过期下架
            //cancel_die  expired_die
            if ([is_more_info integerValue]==1) {
                //self.moreArray =      @[@{@"left":@"更多项目信息"}];
                //static
                NSString *encodeUrl = [NSString stringWithFormat:@"%@/member/info_more.html?id=%@&buy=1&fromApp=1",h5Dev,self.sellID];
                
                ZMMoreInfoMoneyViewController *moreView = [[ZMMoreInfoMoneyViewController alloc] init];
                moreView.webUrl                         = encodeUrl;
                moreView.titleStr                       = @"更多项目信息";
                [self.navigationController pushViewController:moreView animated:YES];
            }else{
                //self.moreArray =      [NSArray array];
            }
        }
        
    }else if (indexPath.section==1){
        if (indexPath.row==4) {
            NSDictionary *sellDetailDic = self.sellArray[4];
            NSString *tel = [NSString stringWithFormat:@"%@",sellDetailDic[@"tel"]];
            NSMutableString* str = [[NSMutableString alloc] initWithFormat:@"telprompt://%@",tel];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            
        }
    }
}


#pragma mark - Logout
- (void)fnishProjectPop{
    
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:nil
                                                                         message:@"您没有填写更多项目信息"
                                                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction        = [UIAlertAction actionWithTitle:@"立即填写"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction *action) {
    NSString *titleUTF8Str = [self.infoDic[@"title"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *encodeUrl    = [NSString stringWithFormat:@"%@/business/dynamic_form.html#info=%@&title=%@&fee=%@&mask=%@&mode=other&token=%@",h5Dev,self.sellID,
                           titleUTF8Str,self.infoDic[@"price"],self.infoDic[@"mask"],
                           [[NSUserDefaults standardUserDefaults] objectForKey:TOKEN]];
    
    ZMMoreInfoMoneyViewController *moreView = [[ZMMoreInfoMoneyViewController alloc] init];
    moreView.webUrl                         = encodeUrl;
    moreView.titleStr                       = @"完善项目信息";
    [self.navigationController pushViewController:moreView animated:YES];
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



#pragma mark - 更改
- (void)changeBtnClickAc:(UIButton *)sender{
    NSLog(@"edit");
    NSString *encodeUrl = [NSString stringWithFormat:@"%@/business/dynamic_form.html?info=%@&title=%@&fee=%@&mask=%@&mode=other&token=%@",h5Dev,self.sellID,
                           self.infoDic[@"title"],self.infoDic[@"price"],self.infoDic[@"mask"],
                           [[NSUserDefaults standardUserDefaults] objectForKey:TOKEN]];
    
    ZMMoreInfoMoneyViewController *moreView = [[ZMMoreInfoMoneyViewController alloc] init];
    moreView.webUrl                         = encodeUrl;
    moreView.titleStr                       = @"更多项目信息";
    [self.navigationController pushViewController:moreView animated:YES];
}



#pragma mark - 取消&再次发布
- (void)cancleBtnClickedAc:(UIButton *)sender{
    if ([self.states isEqualToString:@"dealt_pending"]||[self.states isEqualToString:@"rate_done"]) {
        NSLog(@"已出售");
    }else if ([self.states isEqualToString:@"submit_pending"]) {
        NSLog(@"发布中---取消发布");
        [self cancleFabuPop];
    }else if ([self.states isEqualToString:@"cancel_die"]) {
        NSLog(@"已取消---再次发布");
        [self againFabuPop];
        
    }else if ([self.states isEqualToString:@"expired_die"]) {
        NSLog(@"过期下架---再次发布");
        [self againFabuPop];
        
    }
}

#pragma mark - 再次发布POP
- (void)againFabuPop{
    
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:nil
                                                                         message:@"再次发布?"
                                                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction        = [UIAlertAction actionWithTitle:@"确定"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction *action) {
                                                                [self fabuAgainAction];
                                                            }];
    UIAlertAction *cancle          = [UIAlertAction actionWithTitle:@"取消"
                                                              style:UIAlertActionStyleCancel
                                                            handler:^(UIAlertAction *action) {
                                                            }];
    
    [cancle setValue:[UIColor colorWithHex:@"000000"] forKey:@"titleTextColor"];
    [alertDialog addAction:okAction];
    [alertDialog addAction:cancle];
    [self presentViewController:alertDialog animated:YES completion:nil];
}

#pragma mark - 取消发布POP
- (void)cancleFabuPop{
    
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:nil
                                                                         message:@"您确认取消发布?"
                                                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction        = [UIAlertAction actionWithTitle:@"确定"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction *action) {
                                                                
                                                                [self cancleFabuAction];
                                                            }];
    UIAlertAction *cancle          = [UIAlertAction actionWithTitle:@"取消"
                                                              style:UIAlertActionStyleCancel
                                                            handler:^(UIAlertAction *action) {
                                                            }];
    
    [cancle setValue:[UIColor colorWithHex:@"000000"] forKey:@"titleTextColor"];
    [alertDialog addAction:cancle];
    [alertDialog addAction:okAction];
    [self presentViewController:alertDialog animated:YES completion:nil];
}


//取消发布
- (void)cancleFabuAction{
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    [self.HUD show:YES];
    

    NSDictionary *parm = @{@"id":self.sellID};
    NSString *urlStr   = [NSString stringWithFormat:@"%@/info/business-cancel",APIDev];
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:parm withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"cancle --- %@",object);
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            NSDictionary *infoDic = @{@"infoID":self.sellID};
            [[NSNotificationCenter defaultCenter] postNotificationName:@"cancleFabuSuccessful" object:infoDic];
            [self.navigationController popViewControllerAnimated:YES];
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


//再次发布
- (void)fabuAgainAction{
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    [self.HUD show:YES];
    
    
    NSDictionary *parm = @{@"info_id":self.sellID};
    NSLog(@"参数 ------ %@",parm);
    NSString *urlStr   = [NSString stringWithFormat:@"%@/info/business-create-again",APIDev];
    [AFNetManager requestWithType:HttpRequestTypePost withUrlString:urlStr withParaments:parm withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"fabu Again --- %@",object);
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            NSDictionary *infoDic = @{@"infoID":self.sellID};
            [[NSNotificationCenter defaultCenter] postNotificationName:@"fabuAgainSuccessful" object:infoDic];
            [self.navigationController popViewControllerAnimated:YES];
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
