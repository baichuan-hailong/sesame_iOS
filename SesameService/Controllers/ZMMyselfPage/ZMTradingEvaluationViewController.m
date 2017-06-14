//
//  ZMTradingEvaluationViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMTradingEvaluationViewController.h"
#import "ZMTradingEvaluationView.h"

#import "ZMTradingEvaluationTopTableViewCell.h"
#import "ZMTradingEvaluationLevelTableViewCell.h"
#import "ZMTradingEvaluationStarsTableViewCell.h"

@interface ZMTradingEvaluationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)ZMTradingEvaluationView *tradingEvaluationView;

@property(nonatomic,strong)NSDictionary     *contentDic;
@property (nonatomic , strong)MBProgressHUD *HUD;
@end

@implementation ZMTradingEvaluationViewController

- (void)loadView {
    //change
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tradingEvaluationView    = [[ZMTradingEvaluationView alloc] initWithFrame:SCREEN_BOUNDS];
    self.view                                 = self.tradingEvaluationView;
    self.tradingEvaluationView.tradingEvaluationTableView.delegate   = self;
    self.tradingEvaluationView.tradingEvaluationTableView.dataSource = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"交易评价";
    
    
    [self evokeSouceData];
}




#pragma mark - Load Data
- (void)evokeSouceData{
    
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    [self.HUD show:YES];
    
    NSDictionary *parm = @{@"id":self.infoID};
    NSString *urlStr   = [NSString stringWithFormat:@"%@/info/evaluate-detail",APIDev];
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:parm withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"tradingEvaInfo --- %@",object);
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            
            NSDictionary *dataDic =object[@"data"];
            if (![dataDic isEqual:[NSNull null]]) {
                self.contentDic = [NSDictionary dictionaryWithDictionary:object[@"data"]];
            }
        }else{
            [self showProgress:object[@"status"][@"message"]];
        }
        [self.tradingEvaluationView.tradingEvaluationTableView reloadData];
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
    if (_isSell) {
        return 2;
    }else{
        return 3;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_isSell) {
        if (indexPath.section==0) {
            return SCREEN_WIDTH/375*102;
        }else{
            NSString *content = [NSString stringWithFormat:@"%@",self.contentDic[@"content"]];
            CGSize   size      = CGSizeMake(SCREEN_WIDTH-SCREEN_WIDTH/375*19.5-SCREEN_WIDTH/375*15, 0);
            
            CGSize autoSize = [[UILabel new] actualSizeOfLineSpaceLable:[NSString stringWithFormat:@"%@",content]
                                                                andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/375*16]
                                                                andSize:size];
            return SCREEN_WIDTH/375*237-SCREEN_WIDTH/375*48+autoSize.height;
        }
    }else{
        if (indexPath.section==0) {
            
            
            NSString *title       = [NSString stringWithFormat:@"%@",self.buyTipDic[@"title"]];
            CGSize   size      = CGSizeMake(SCREEN_WIDTH-SCREEN_WIDTH/375*17.5-SCREEN_WIDTH/375*79, 0);
            CGSize  autoSize = [[UILabel new] actualSizeOfLineSpaceLable:[NSString stringWithFormat:@"%@",title]
                                                                 andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
                                                                 andSize:size];
            int height = (int)autoSize.height+1;
            return SCREEN_WIDTH/375*100+height;
            
        }else if (indexPath.section==1){
            return SCREEN_WIDTH/375*102;
        }else{
            NSString *content = [NSString stringWithFormat:@"%@",self.contentDic[@"content"]];
            CGSize   size      = CGSizeMake(SCREEN_WIDTH-SCREEN_WIDTH/375*19.5-SCREEN_WIDTH/375*15, 0);
            
            CGSize autoSize = [[UILabel new] actualSizeOfLineSpaceLable:[NSString stringWithFormat:@"%@",content]
                                                                andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/375*16]
                                                                andSize:size];
            return SCREEN_WIDTH/375*237-SCREEN_WIDTH/375*48+autoSize.height;
        }
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
    
    static NSString *selllevelIndentifire       = @"selllevelCell";
    static NSString *sellstarIndentifire        = @"sellstarCell";
    
    
    static NSString *buyTopIndentifire          = @"buyToponeCell";
    static NSString *buylevelIndentifire        = @"buyleveloneCell";
    static NSString *buystarIndentifire         = @"buystaroneCell";
    
    
    
    if (_isSell) {
        if (indexPath.section==0) {
            ZMTradingEvaluationLevelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:selllevelIndentifire];
            if (!cell) {
                cell = [[ZMTradingEvaluationLevelTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:selllevelIndentifire];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            [cell setEvaluationLevel:self.contentDic];
            return cell;
        }else{
            ZMTradingEvaluationStarsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sellstarIndentifire];
            if (!cell) {
                cell = [[ZMTradingEvaluationStarsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sellstarIndentifire];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            [cell setEvaluationStars:self.contentDic];
            return cell;
        }
    }else{
        if (indexPath.section==0) {
            ZMTradingEvaluationTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:buyTopIndentifire];
            if (!cell) {
                cell = [[ZMTradingEvaluationTopTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:buyTopIndentifire];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            [cell setTradingEvaTop:self.buyTipDic];
            return cell;
        }else if (indexPath.section==1){
            
            ZMTradingEvaluationLevelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:buylevelIndentifire];
            if (!cell) {
                cell = [[ZMTradingEvaluationLevelTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:buylevelIndentifire];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            [cell setEvaluationLevel:self.contentDic];
            return cell;
        }else{
            
            ZMTradingEvaluationStarsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:buystarIndentifire];
            if (!cell) {
                cell = [[ZMTradingEvaluationStarsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:buystarIndentifire];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            [cell setEvaluationStars:self.contentDic];
            return cell;
        }
    }
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"trEva");
    
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
