//
//  ZMOrderProgressViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/5/16.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMOrderProgressViewController.h"
#import "ZMOrderProgressView.h"

#import "ZMOrderProgressTableViewCell.h"

@interface ZMOrderProgressViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) ZMOrderProgressView  *orderProgressView;
@property (nonatomic , strong) MBProgressHUD        *HUD;
@property (nonatomic , strong) NSArray              *progressArray;
@end

@implementation ZMOrderProgressViewController

-(void)loadView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.orderProgressView = [[ZMOrderProgressView alloc] initWithFrame:SCREEN_BOUNDS];
    self.view = self.orderProgressView;
    
    self.orderProgressView.orderProgressTableView.delegate  = self;
    self.orderProgressView.orderProgressTableView.dataSource= self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"订单进度详情";
    
    if (_isYongjin) {
        //佣金
        if (_isleft) {
            //提交
            self.orderProgressView.ordProHeaderImageView.image = [UIImage imageNamed:@"yongjin_tijiaonew"];
        }else{
            //接单
            self.orderProgressView.ordProHeaderImageView.image = [UIImage imageNamed:@"yongjin_jiedan"];
        }
    }else{
        //推介
        if (_isleft) {
            //提交
            self.orderProgressView.ordProHeaderImageView.image = [UIImage imageNamed:@"tuijie_tijiao"];
        }else{
            //接单
            self.orderProgressView.ordProHeaderImageView.image = [UIImage imageNamed:@"tuijie_jiedan"];
        }
    }
    
    //self.orderProgressView.ordProHeaderImageView.backgroundColor = [UIColor redColor];
    self.orderProgressView.ordProHeaderImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    [self setMJRefreshConfig:self.orderProgressView.orderProgressTableView];
    [self.orderProgressView.orderProgressTableView.mj_header beginRefreshing];
}



#pragma mark - Load Data
- (void)evokeSouceData{
    
    
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    //[self.HUD show:YES];
    
    NSDictionary *parm = @{@"id":self.infoID};
    NSString *urlStr   = [NSString stringWithFormat:@"%@/info/process",APIDev];
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:parm withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"process --- %@",object);
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            //self.orderProgressView.orderProgressTableView.tableHeaderView = self.orderProgressView.ordProHeaderView;
            self.progressArray = [NSArray arrayWithArray:object[@"data"]];
            [self.orderProgressView.orderProgressTableView reloadData];
        }else{
            [self showProgress:object[@"status"][@"message"]];
        }
        [self.orderProgressView.orderProgressTableView.mj_header endRefreshing];
        //[self.HUD hide:YES];
    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
        [self.orderProgressView.orderProgressTableView.mj_header endRefreshing];
        //[self.HUD hide:YES];
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}



#pragma mark - Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.progressArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    /*
     NSDictionary *baseDic = self.sellArray[indexPath.row];
     NSString *right = [NSString stringWithFormat:@"%@",baseDic[@"right"]];
     CGSize size = CGSizeMake(SCREEN_WIDTH-SCREEN_WIDTH/375*150, 0);
     CGSize autoSize = [[UILabel new] actualSizeOfLineSpaceLable:right
     andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
     andSize:size];
     return SCREEN_WIDTH/375*26+autoSize.height;
     */
    
    return SCREEN_WIDTH/375*80;
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
    
    static NSString *orderProIndentifire             = @"orderProgressCell";
    
    NSDictionary *orProDic = self.progressArray[indexPath.row];
    
    ZMOrderProgressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:orderProIndentifire];
    if (!cell) {
        cell = [[ZMOrderProgressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderProIndentifire];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setOrProNote:orProDic];
    
    if (indexPath.row==self.progressArray.count-1) {
        cell.botLine.alpha = 0;
    }else{
        cell.botLine.alpha = 1;
    }
    
    if (indexPath.row==0) {
        cell.shutterView.alpha = 1;
    }else{
        cell.shutterView.alpha = 0;
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"click");
}



#pragma mark - MJRefresh
- (void)setMJRefreshConfig:(UITableView *)tableView{
    
    MJRefreshNormalHeader     *header;
    header = [MJRefreshNormalHeader     headerWithRefreshingTarget:self refreshingAction:@selector(evokeSouceData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    [header setTitle:@"下拉刷新"  forState:MJRefreshStateIdle];
    [header setTitle:@"释放更新"  forState:MJRefreshStatePulling];
    [header setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    tableView.mj_header = header;
    
    
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
