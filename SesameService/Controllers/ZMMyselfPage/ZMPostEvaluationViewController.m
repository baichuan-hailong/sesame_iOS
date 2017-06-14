//
//  ZMPostEvaluationViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/26.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMPostEvaluationViewController.h"
#import "ZMPostEvaluationView.h"

#import "ZMTradingEvaluationView.h"

#import "ZMTradingEvaluationTopTableViewCell.h"
#import "ZMTradingEvaluationLevelTableViewCell.h"
#import "ZMTradingEvaluationStarsTableViewCell.h"

@interface ZMPostEvaluationViewController ()<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSInteger xinxiInt;
    NSInteger guanxiInt;
    NSInteger jiageInt;
    NSInteger xiangmuInt;
}
@property(nonatomic,strong)ZMPostEvaluationView    *postEvaluatinView;
@property(nonatomic,copy)NSString           *level;
@property (nonatomic , strong)MBProgressHUD *HUD;

@property(nonatomic,strong)ZMTradingEvaluationView *tradingEvaluationView;
@property(nonatomic,strong)NSDictionary            *contentDic;
@end

@implementation ZMPostEvaluationViewController

-(void)loadView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.postEvaluatinView = [[ZMPostEvaluationView alloc] initWithFrame:SCREEN_BOUNDS];
    self.view              = self.postEvaluatinView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.view.backgroundColor = [UIColor whiteColor];
    self.title                = @"发布评价";
    
    [self addAction];
    
    self.level = @"good";
}

- (void)addAction{
    
    self.postEvaluatinView.suggestTextView.delegate = self;
    
    UITapGestureRecognizer *viewTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(viewTapGRAction:)];
    [self.view addGestureRecognizer:viewTapGR];
    
    
    [self.postEvaluatinView.goodBtn addTarget:self
                                       action:@selector(goodBtnClick)
                             forControlEvents:UIControlEventTouchUpInside];
    
    [self.postEvaluatinView.zhongpingBtn addTarget:self
                                            action:@selector(zhongBtnClick)
                                  forControlEvents:UIControlEventTouchUpInside];
    
    [self.postEvaluatinView.chapingBtn addTarget:self
                                          action:@selector(chaBtnClick)
                                forControlEvents:UIControlEventTouchUpInside];

    [self.postEvaluatinView.commitButton addTarget:self
                                            action:@selector(commitBtnClick:)
                                  forControlEvents:UIControlEventTouchUpInside];

    
    //信息
    for (NSInteger i=0; i<self.postEvaluatinView.starxinxiArray.count; i++) {
        UIButton *starButton      = self.postEvaluatinView.starxinxiArray[i];
        starButton.tag            = 314+i+1;
        [starButton addTarget:self action:@selector(starxinxiBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    //关系
    for (NSInteger i=0; i<self.postEvaluatinView.starguanxiArray.count; i++) {
        UIButton *starButton      = self.postEvaluatinView.starguanxiArray[i];
        starButton.tag            = 414+i+1;
        [starButton addTarget:self action:@selector(starguanxiBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    //价格
    for (NSInteger i=0; i<self.postEvaluatinView.starjiageArray.count; i++) {
        UIButton *starButton      = self.postEvaluatinView.starjiageArray[i];
        starButton.tag            = 514+i+1;
        [starButton addTarget:self action:@selector(starjiageBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    //项目
    for (NSInteger i=0; i<self.postEvaluatinView.starxiangmuArray.count; i++) {
        UIButton *starButton      = self.postEvaluatinView.starxiangmuArray[i];
        starButton.tag            = 614+i+1;
        [starButton addTarget:self action:@selector(starxinagmuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}



#pragma mark - 信息
- (void)starxinxiBtnAction:(UIButton *)sender{
    [self.view endEditing:YES];
    NSLog(@"star count --- %ld",sender.tag-314);
    xinxiInt = sender.tag-314;
    for (NSInteger i=0; i<sender.tag-314; i++) {
        UIButton *starButton      = self.postEvaluatinView.starxinxiArray[i];
        [starButton setImage:[UIImage imageNamed:@"evaluationCompanySelect"] forState:UIControlStateNormal];
    }
    for (NSInteger i=sender.tag-314; i<5; i++) {
        UIButton *starButton      = self.postEvaluatinView.starxinxiArray[i];
        [starButton setImage:[UIImage imageNamed:@"evaluationCompanyNoSelect"] forState:UIControlStateNormal];
    }
    [self checkBtn];
}
#pragma mark - 关系
- (void)starguanxiBtnAction:(UIButton *)sender{
    [self.view endEditing:YES];
    NSLog(@"star count --- %ld",sender.tag-414);
    guanxiInt = sender.tag-414;
    for (NSInteger i=0; i<sender.tag-414; i++) {
        UIButton *starButton      = self.postEvaluatinView.starguanxiArray[i];
        [starButton setImage:[UIImage imageNamed:@"evaluationCompanySelect"] forState:UIControlStateNormal];
    }
    for (NSInteger i=sender.tag-414; i<5; i++) {
        UIButton *starButton      = self.postEvaluatinView.starguanxiArray[i];
        [starButton setImage:[UIImage imageNamed:@"evaluationCompanyNoSelect"] forState:UIControlStateNormal];
    }
    [self checkBtn];
}

#pragma mark - 价格
- (void)starjiageBtnAction:(UIButton *)sender{
    [self.view endEditing:YES];
    NSLog(@"star count --- %ld",sender.tag-514);
    jiageInt = sender.tag-514;
    for (NSInteger i=0; i<sender.tag-514; i++) {
        UIButton *starButton      = self.postEvaluatinView.starjiageArray[i];
        [starButton setImage:[UIImage imageNamed:@"evaluationCompanySelect"] forState:UIControlStateNormal];
    }
    for (NSInteger i=sender.tag-514; i<5; i++) {
        UIButton *starButton      = self.postEvaluatinView.starjiageArray[i];
        [starButton setImage:[UIImage imageNamed:@"evaluationCompanyNoSelect"] forState:UIControlStateNormal];
    }
    [self checkBtn];
}

#pragma mark - 项目
- (void)starxinagmuBtnAction:(UIButton *)sender{
    [self.view endEditing:YES];
    NSLog(@"star count --- %ld",sender.tag-614);
    xiangmuInt = sender.tag-614;
    for (NSInteger i=0; i<sender.tag-614; i++) {
        UIButton *starButton      = self.postEvaluatinView.starxiangmuArray[i];
        [starButton setImage:[UIImage imageNamed:@"evaluationCompanySelect"] forState:UIControlStateNormal];
    }
    for (NSInteger i=sender.tag-614; i<5; i++) {
        UIButton *starButton      = self.postEvaluatinView.starxiangmuArray[i];
        [starButton setImage:[UIImage imageNamed:@"evaluationCompanyNoSelect"] forState:UIControlStateNormal];
    }
    
    [self checkBtn];
}


- (void)checkBtn{
    
    if (xinxiInt>0&&guanxiInt>0&&jiageInt>0&&xiangmuInt>0) {
        self.postEvaluatinView.commitButton.alpha = 1;
        self.postEvaluatinView.commitButton.userInteractionEnabled = YES;
    }else{
        self.postEvaluatinView.commitButton.alpha = 1;
        self.postEvaluatinView.commitButton.userInteractionEnabled = YES;
    }
}


#pragma mark - 评价
- (void)goodBtnClick{
    
    NSLog(@"good");
    self.level = @"good";
    [self.postEvaluatinView.goodBtn setLeftImage:[UIImage imageNamed:@"haopingselect"]
                                         rightLa:@"好评"
                                        rightHex:tonalColor];
    [self.postEvaluatinView.zhongpingBtn setLeftImage:[UIImage imageNamed:@"zhongpingnosel"]
                                              rightLa:@"中评"
                                             rightHex:@"CCCCCC"];
    [self.postEvaluatinView.chapingBtn setLeftImage:[UIImage imageNamed:@"chapingsel"]
                                            rightLa:@"差评"
                                           rightHex:@"CCCCCC"];
}

- (void)zhongBtnClick{
    
    NSLog(@"zhong");
    self.level = @"middle";
    [self.postEvaluatinView.goodBtn setLeftImage:[UIImage imageNamed:@"haopingnosel"]
                                         rightLa:@"好评"
                                        rightHex:@"CCCCCC"];
    [self.postEvaluatinView.zhongpingBtn setLeftImage:[UIImage imageNamed:@"zhongpingselect"]
                                              rightLa:@"中评"
                                             rightHex:tonalColor];
    [self.postEvaluatinView.chapingBtn setLeftImage:[UIImage imageNamed:@"chapingsel"]
                                            rightLa:@"差评"
                                           rightHex:@"CCCCCC"];
}

- (void)chaBtnClick{
    
    NSLog(@"cha");
    self.level = @"bad";
    [self.postEvaluatinView.goodBtn setLeftImage:[UIImage imageNamed:@"haopingnosel"]
                                         rightLa:@"好评"
                                        rightHex:@"CCCCCC"];
    [self.postEvaluatinView.zhongpingBtn setLeftImage:[UIImage imageNamed:@"zhongpingnosel"]
                                              rightLa:@"中评"
                                             rightHex:@"CCCCCC"];
    [self.postEvaluatinView.chapingBtn setLeftImage:[UIImage imageNamed:@"chapingnoselect"]
                                            rightLa:@"差评"
                                           rightHex:tonalColor];
}

#pragma mark - tap
- (void)viewTapGRAction:(UITapGestureRecognizer *)sender{
    //NSLog(@"tap");
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.28 animations:^{
        self.postEvaluatinView.contentOffset = CGPointMake(0, SCREEN_WIDTH/375*0);
    }];
    
}

#pragma mark - 发布
- (void)commitBtnClick:(UIButton *)sender{
    //NSLog(@"commit");
    //NSLog(@"%@",self.level);
    //NSLog(@"xixi--%ld guanxi--%ld jiage--%ld xiangmu--%ld",(long)xinxiInt,guanxiInt,jiageInt,xiangmuInt);
    [UIView animateWithDuration:0.28 animations:^{
        self.postEvaluatinView.contentOffset = CGPointMake(0, SCREEN_WIDTH/375*0);
    }];
    
    
    if (xinxiInt>0&&guanxiInt>0&&jiageInt>0&&xiangmuInt>0) {
        self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:self.HUD];
        [self.HUD show:YES];
        
        NSDictionary *praDic;
        if (self.postEvaluatinView.suggestTextView.text.length>0) {
            praDic = @{@"info_id":self.infoID,
                       @"level":self.level,
                       @"reliable":[NSString stringWithFormat:@"%ld",xinxiInt],
                       @"relation":[NSString stringWithFormat:@"%ld",guanxiInt],
                       @"price":[NSString stringWithFormat:@"%ld",jiageInt],
                       @"project":[NSString stringWithFormat:@"%ld",xiangmuInt],
                       @"content":self.postEvaluatinView.suggestTextView.text};
        }else{
            praDic = @{@"info_id":self.infoID,
                       @"level":self.level,
                       @"reliable":[NSString stringWithFormat:@"%ld",xinxiInt],
                       @"relation":[NSString stringWithFormat:@"%ld",guanxiInt],
                       @"price":[NSString stringWithFormat:@"%ld",jiageInt],
                       @"project":[NSString stringWithFormat:@"%ld",xiangmuInt]};
        }
        NSLog(@"praDic ----- %@",praDic);
        
        /*
         data =     {
         content = 100;
         id = 42;
         "info_id" = 354;
         level = good;
         price = 5;
         project = 2;
         relation = 5;
         reliable = 5;
         time = 1495100607;
         "user_id" = 10167;
         }
         */
        
        NSString *urlStr   = [NSString stringWithFormat:@"%@/info/evaluate",APIDev];
        [AFNetManager requestWithType:HttpRequestTypePost withUrlString:urlStr withParaments:praDic withSuccessBlock:^(NSDictionary *object) {
            NSLog(@"sell --- %@",object);
            NSLog(@"%@",object[@"status"][@"message"]);
            
            NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
            if ([stateStr isEqualToString:@"success"]) {
                NSDictionary *infoDic = @{@"infoID":self.infoID};
                [[NSNotificationCenter defaultCenter] postNotificationName:@"postEvaluationSuccessful" object:infoDic];
                //[self.navigationController popViewControllerAnimated:YES];
                
                
                NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:praDic];
                [tempDic setObject:[self timestamp] forKey:@"time"];
                
                self.contentDic = tempDic;
                [self showEvaluAC];
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
    }else{
        [self popTipAc];
    }
}

#pragma mark - pop tip
- (void)popTipAc{
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:nil
                                                                         message:@"您还没完成打分"
                                                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction        = [UIAlertAction actionWithTitle:@"确定"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction *action) {
                                                            }];
    
    
    //[okAction setValue:[UIColor colorWithHex:@"000000"] forKey:@"titleTextColor"];
    [alertDialog addAction:okAction];
    [self presentViewController:alertDialog animated:YES completion:nil];
    
    NSLog(@"out present");
}

#pragma mark - TextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    //NSLog(@"begin");
    
    [UIView animateWithDuration:0.28 animations:^{
        self.postEvaluatinView.contentOffset = CGPointMake(0, SCREEN_WIDTH/375*280);
    }];
}

-(void)textViewDidChange:(UITextView *)textView{
    
    [self checkBtn];
    
    if (self.postEvaluatinView.suggestTextView.text.length==0) {
        [self.postEvaluatinView.suggestTextView addSubview:self.postEvaluatinView.suggestPlaceHolderLabel];
    }else{
        [self.postEvaluatinView.suggestPlaceHolderLabel removeFromSuperview];
    }
    
    self.postEvaluatinView.worldCountLabel.text = [NSString stringWithFormat:@"%lu/300",(unsigned long)textView.text.length];
    NSString *textCodeString = [self.postEvaluatinView.suggestTextView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (textCodeString.length>0) {
        self.postEvaluatinView.commitButton.alpha = 1;
        self.postEvaluatinView.commitButton.userInteractionEnabled = YES;
    }else{
        self.postEvaluatinView.commitButton.alpha = 0.6;
        self.postEvaluatinView.commitButton.userInteractionEnabled = NO;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@""] && range.length > 0) {
        return YES;
    }
    else {
        if (textView.text.length - range.length + text.length > 300) {
            return NO;
        }
        else {
            return YES;
        }
    }
}




#pragma mark - Show 评价
- (void)showEvaluAC{
    self.tradingEvaluationView    = [[ZMTradingEvaluationView alloc] initWithFrame:SCREEN_BOUNDS];
    self.view                                 = self.tradingEvaluationView;
    self.tradingEvaluationView.tradingEvaluationTableView.delegate   = self;
    self.tradingEvaluationView.tradingEvaluationTableView.dataSource = self;
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
            return SCREEN_WIDTH/375*120;
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

//current system timeCode
- (NSString *)timestamp{
    NSTimeInterval a=[[NSDate date] timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.f", a];//转为字符型
    return timeString;
}

@end
