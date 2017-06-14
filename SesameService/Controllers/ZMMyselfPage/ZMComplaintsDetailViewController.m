//
//  ZMComplaintsDetailViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/26.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMComplaintsDetailViewController.h"
#import "ZMComplaintsDetailView.h"

#import "ZMComplaintsDetailTopTableViewCell.h"
#import "ZMMySellSecondTableViewCell.h"
#import "ZMMyMoreTableViewCell.h"

@interface ZMComplaintsDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)ZMComplaintsDetailView *complaintsDetailView;
@property (nonatomic , strong) NSArray            *twoArray;
//@property (nonatomic , strong) NSArray            *moreArray;
@property (nonatomic , strong) MBProgressHUD      *HUD;
@end

@implementation ZMComplaintsDetailViewController

- (void)loadView {
    //change
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.complaintsDetailView   = [[ZMComplaintsDetailView alloc] initWithFrame:SCREEN_BOUNDS];
    self.view                    = self.complaintsDetailView;
    self.complaintsDetailView.complaintsDetailTableView.delegate   = self;
    self.complaintsDetailView.complaintsDetailTableView.dataSource = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    //fnishing pending
    if ([self.status isEqualToString:@"pending"]) {
        self.twoArray =       @[@{@"left":@"投诉时间",@"right":@"-- --"},
                                @{@"left":@"投诉说明",@"right":@"-- --"}];
    }else{
        self.twoArray =       @[@{@"left":@"投诉时间",@"right":@"-- --"},
                                @{@"left":@"投诉说明",@"right":@"-- --"},
                                @{@"left":@"处理结果",@"right":@"-- --"}];
    }
    
    
    
    //self.moreArray =      @[@{@"left":@"处理进度"}];
    
    
    [self evokeSouceData];
}


-(void)backAction{
    if (_isRootPop) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshComplainsListAc" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark - Load Data
- (void)evokeSouceData{
    
    
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    [self.HUD show:YES];
    
    NSDictionary *parm = @{@"id":self.feedID};
    NSString *urlStr   = [NSString stringWithFormat:@"%@/feedback/complaint-detail",APIDev];
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:parm withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"detail --- %@",object);
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            
            //top
            NSMutableDictionary *topDic = [NSMutableDictionary dictionaryWithDictionary:self.topDic];
            [topDic setObject:object[@"data"][@"status"] forKey:@"status"];
            [topDic setObject:object[@"data"][@"status_title"] forKey:@"status_title"];
            self.topDic = [NSDictionary dictionaryWithDictionary:topDic];
            
            
            NSString *time       = [NSString stringWithFormat:@"%@",object[@"data"][@"time"]];
            if (time.length==0||[time isEqualToString:@"(null)"]) {
                time = @"-- --";
            }
            
            NSString *content    = [NSString stringWithFormat:@"%@",object[@"data"][@"content"]];
            NSString *status    = [NSString stringWithFormat:@"%@",object[@"data"][@"status"]];
            if (content.length==0||[content isEqualToString:@"(null)"]) {
                content = @"-- --";
            }
            //fnishing pending
            if ([status isEqualToString:@"pending"]||[status isEqualToString:@"processing"]) {
                self.twoArray =       @[@{@"left":@"投诉时间",@"right":[self timeChange:time]},
                                        @{@"left":@"投诉说明",@"right":content}];
            }else{
                NSString *result    = [NSString stringWithFormat:@"%@",object[@"data"][@"result"]];
                if (result.length>0&&![result isEqualToString:@"(null)"]&&![result isEqualToString:@"<null>"]) {
                    
                    self.twoArray =       @[@{@"left":@"投诉时间",@"right":[self timeChange:time]},
                                            @{@"left":@"投诉说明",@"right":content},
                                            @{@"left":@"处理结果",@"right":result}];
                }
            }
        }else{
            [self showProgress:object[@"status"][@"message"]];
        }
        [self.complaintsDetailView.complaintsDetailTableView reloadData];
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==0) {
        return 1;
    }else{
        return self.twoArray.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        
        NSString *title  = [NSString stringWithFormat:@"%@",self.topDic[@"title"]];
        CGSize size = CGSizeMake(SCREEN_WIDTH-SCREEN_WIDTH/375*17.5-SCREEN_WIDTH/375*79, 0);
        CGSize autoSize = [[UILabel new] actualSizeOfLineSpaceLable:title
                                                            andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
                                                            andSize:size];
        
        return SCREEN_WIDTH/375*105+autoSize.height;
    }else if (indexPath.section==1){
        
        //auto
        NSDictionary *sellDetailDic = self.twoArray[indexPath.row];
        
        NSString *right = [NSString stringWithFormat:@"%@",sellDetailDic[@"right"]];
        CGSize size = CGSizeMake(SCREEN_WIDTH-SCREEN_WIDTH/375*150, 0);
        CGSize autoSize = [[UILabel new] actualSizeOfLineSpaceLable:right
                                                            andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
                                                            andSize:size];
        int heightAuto = (int)autoSize.height;
        return SCREEN_WIDTH/375*26+heightAuto;
    }else{
        return SCREEN_WIDTH/375*45;
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
    
    static NSString *topIndentifire      = @"topRecordCell";
    static NSString *secondIndentifire   = @"secondCell";
    
    
    if (indexPath.section==0) {
        ZMComplaintsDetailTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:topIndentifire];
        if (!cell) {
            cell = [[ZMComplaintsDetailTopTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:topIndentifire];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell setDetailTop:self.topDic];
        return cell;
    }else{
        NSDictionary *sellDetailDic = self.twoArray[indexPath.row];
        ZMMySellSecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:secondIndentifire];
        if (!cell) {
            cell = [[ZMMySellSecondTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:secondIndentifire];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell setInvoiceDetail:sellDetailDic];
        if (indexPath.row==self.twoArray.count-1) {
            cell.line.alpha = 0;
        }
        return cell;
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section==2) {
        NSLog(@"pro");
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
