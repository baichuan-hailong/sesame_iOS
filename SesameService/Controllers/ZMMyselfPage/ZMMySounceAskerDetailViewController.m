//
//  ZMMySounceAskerDetailViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/5/9.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMMySounceAskerDetailViewController.h"
#import "ZMMySounceAskerDetailView.h"

#import "ZMSounceLeftTableViewCell.h"
#import "ZMSounceLeftDetailTableViewCell.h"

#import "ZMAimAnswererInfoTableViewCell.h"
#import "ZMAllUnderStandAnswerCell.h"


@interface ZMMySounceAskerDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)ZMMySounceAskerDetailView *sounceDetailView;

@property (nonatomic , strong)MBProgressHUD *HUD;
@property (nonatomic , strong)NSDictionary  *sourceDic;
@property (nonatomic , strong)NSDictionary  *aim_answerer_infoDic;
@property (nonatomic , strong)NSArray       *answer_lists;

@end

@implementation ZMMySounceAskerDetailViewController
-(void)loadView{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.sounceDetailView = [[ZMMySounceAskerDetailView alloc] initWithFrame:SCREEN_BOUNDS];
    self.sounceDetailView.sounceDetailableView.delegate = self;
    self.sounceDetailView.sounceDetailableView.dataSource=self;
    self.view = self.sounceDetailView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的打听";
    
    [self sourceData];
    
    //bug
    self.aim_answerer_infoDic = (NSDictionary *)[NSNull null];
    
}



#pragma mark - Load Detail
- (void)sourceData{
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    [self.HUD show:YES];
    
    
    NSDictionary *par = @{@"id":[NSString stringWithFormat:@"%@",self.askDic[@"id"]]};
    NSString *urlStr   = [NSString stringWithFormat:@"%@/question/my-publish-detail",APIDev];
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:par withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"my-publish-detail --- %@",object);
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            self.sourceDic = [NSDictionary dictionaryWithDictionary:object[@"data"]];
            
            self.aim_answerer_infoDic = self.sourceDic[@"aim_answerer_info"];
            NSLog(@"aim_answerer_info ----------------------------------- %@",self.aim_answerer_infoDic);
            if ([self.aim_answerer_infoDic isEqual:[NSNull null]]) {
                NSLog(@"kong");
            }else{
                NSLog(@"yes");
            }

            //answer_lists
            self.answer_lists = [NSArray arrayWithArray:self.sourceDic[@"answer_lists"]];
            
            NSLog(@"answer_lists -------------- %@",self.answer_lists);
            
            
            NSString *is_can_choice = [NSString stringWithFormat:@"%@",self.sourceDic[@"is_can_choice"]];
            [self canChoice:[is_can_choice integerValue]];
            
            
            [self.sounceDetailView.sounceDetailableView reloadData];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if (section==0) {
        return 1;
    }else{
        
        if (![self.aim_answerer_infoDic isEqual:[NSNull null]]&&self.answer_lists.count==0) {
            //指定人Cell
            //10
            return 1;
        }else{
            //答案Cell
            //26
            return self.answer_lists.count;
        }
    }
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        NSString *note = [NSString stringWithFormat:@"%@",self.sourceDic[@"note"]];
        if (note.length>0&&![note isEqualToString:@"(null)"]) {
           return SCREEN_WIDTH/375*150;
        }else{
           return SCREEN_WIDTH/375*130;
        }
    }else{
        if (![self.aim_answerer_infoDic isEqual:[NSNull null]]&&self.answer_lists.count==0) {
            //指定人Cell
            //26
            return SCREEN_WIDTH/375*70;
        }else{
            //答案Cell
            //10
            //return SCREEN_WIDTH/375*137;
            NSDictionary *answerDic = [self.answer_lists objectAt:indexPath.row];
            if ([[NSString stringWithFormat:@"%@",answerDic[@"audio"]] isEqualToString:@""]) {
                /** 文字 */
                CGSize   size = CGSizeMake(SCREEN_WIDTH - SCREEN_WIDTH/12.5, 0);
                CGSize   autoSize = [[UILabel new] actualSizeOfLable:[NSString stringWithFormat:@"%@",answerDic[@"answer"]]
                                                             andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/28.85]
                                                             andSize:size];
                
                return SCREEN_WIDTH/6.81 + autoSize.height/* 文字 */ + 0/* 获得赏金 */;
            } else {
                /** 语音 */
                
                return SCREEN_WIDTH/6.81 + SCREEN_WIDTH/8.15/* 语音 */ + 0/* 获得赏金 */;
            }
        }
        
    }
}


/**********footer**********/
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        
        if ([self.aim_answerer_infoDic isEqual:[NSNull null]]) {
            return SCREEN_WIDTH/375*10;
        }else{
            return SCREEN_WIDTH/375*26;
        }
        
    }else{
        return SCREEN_WIDTH/375*0.1;
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section==0) {
        if ([self.aim_answerer_infoDic isEqual:[NSNull null]]) {
            UIView *footView         = [[UIView alloc] init];
            footView.backgroundColor = [UIColor clearColor];
            return footView;
        }else{
            //已指定回答人 26
            UIView *footView         = [[UIView alloc] init];
            footView.backgroundColor = [UIColor clearColor];
            UILabel *tipLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*19,
                                                                          SCREEN_WIDTH/375*0,
                                                                          SCREEN_WIDTH/375*100,
                                                                          SCREEN_WIDTH/375*26)];
            [ZMLabelAttributeMange setLabel:tipLable
                                       text:@"已指定回答人"
                                        hex:@"666666"
                              textAlignment:NSTextAlignmentLeft
                                       font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
            [footView addSubview:tipLable];
            return footView;
        }
        
    }else{
        UIView *footView         = [[UIView alloc] init];
        footView.backgroundColor = [UIColor clearColor];
        return footView;
    }
}

/**********header**********/
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return SCREEN_WIDTH/375*0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *footView         = [[UIView alloc] init];
    footView.backgroundColor = [UIColor clearColor];
    return footView;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *topIndentifire         = @"topSelectCell";
    static NSString *topDetailIndentifire   = @"topDetailSelectCell";
    
    static NSString *aimAnswertIndentifire  = @"aimAnswerSelectCell";
    static NSString *answertIndentifire     = @"answerSelectCell";
    
    if (indexPath.section==0) {
        NSString *note = [NSString stringWithFormat:@"%@",self.sourceDic[@"note"]];
        if (note.length>0&&![note isEqualToString:@"(null)"]) {
            ZMSounceLeftDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:topDetailIndentifire];
            if (!cell) {
                cell = [[ZMSounceLeftDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:topDetailIndentifire];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.bottomButton.alpha = 0;
            [cell setMyAsk:self.sourceDic];
            return cell;
        }else{
            ZMSounceLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:topIndentifire];
            if (!cell) {
                cell = [[ZMSounceLeftTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:topIndentifire];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.bottomButton.alpha = 0;
            [cell setMyAsk:self.sourceDic];
            return cell;
        }
    }else{
        
        
        
        if (![self.aim_answerer_infoDic isEqual:[NSNull null]]&&self.answer_lists.count==0) {
            //指定人Cell
            //10
            ZMAimAnswererInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:aimAnswertIndentifire];
            if (!cell) {
                cell = [[ZMAimAnswererInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:aimAnswertIndentifire];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            [cell setValueWithDic:self.aim_answerer_infoDic];
            return cell;
        }else{
            //答案Cell
            //26
            NSDictionary *ansDic = self.answer_lists[indexPath.row];
            ZMAllUnderStandAnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:answertIndentifire];
            if (!cell) {
                cell = [[ZMAllUnderStandAnswerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:answertIndentifire];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            [cell setValueWithDic:ansDic];
            return cell;
        }
    }
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"click");
}



#pragma mark - is_can_choice
- (void)canChoice:(NSInteger)is_can_choice{
    
    if (is_can_choice==1) {
        self.sounceDetailView.makeView.alpha = 1;
        self.sounceDetailView.makeBtn.alpha  = 1;
        self.sounceDetailView.sounceDetailableView.frame = CGRectMake(0,
                                                                      64,
                                                                      SCREEN_WIDTH,
                                                                      SCREEN_HEIGHT-64-SCREEN_WIDTH/375*70);
    }else{
        self.sounceDetailView.makeView.alpha = 0;
        self.sounceDetailView.makeBtn.alpha  = 0;
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
