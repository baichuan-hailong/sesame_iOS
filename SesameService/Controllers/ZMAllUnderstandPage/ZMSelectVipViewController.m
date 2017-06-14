//
//  ZMSelectVipViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/13.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMSelectVipViewController.h"
#import "ZMSelectVipView.h"
#import "ZMSelectVipTableViewCell.h"

@interface ZMSelectVipViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSInteger rightCurrentPage;
    NSInteger rightTotalCount;
}
@property(nonatomic,strong)ZMSelectVipView *selectVipView;
@property(nonatomic,strong)NSMutableArray  *rightMutableArray;
@end

@implementation ZMSelectVipViewController

-(void)loadView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.selectVipView = [[ZMSelectVipView alloc] initWithFrame:SCREEN_BOUNDS];
    self.selectVipView.selectVipTableView.delegate  = self;
    self.selectVipView.selectVipTableView.dataSource= self;
    self.view          = self.selectVipView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"选择指定会员";
    
    [self setMJRefreshConfig:self.selectVipView.selectVipTableView];
    [self.selectVipView.selectVipTableView.mj_header beginRefreshing];
}

#pragma mark - Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.rightMutableArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREEN_WIDTH/375*83;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *selectVip        = @"selectVipCell";
    
    NSDictionary *vipDic = self.rightMutableArray[indexPath.row];
    
    ZMSelectVipTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:selectVip];
    if (!cell) {
        cell = [[ZMSelectVipTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:selectVip];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setVip:vipDic];
    if (indexPath.row==self.rightMutableArray.count-1) {
        cell.line.alpha = 0;
    }else{
        cell.line.alpha = 1;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",(long)indexPath.row);
    
    NSDictionary *vipDic = self.rightMutableArray[indexPath.row];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:HaveSelectNoti object:vipDic];
    
    [self.navigationController popViewControllerAnimated:YES];
}





#pragma mark - Load Souce
- (void)evokeSouceData{
    rightCurrentPage = 1;
    
    NSDictionary *parm = @{@"page":@"1"};
    NSString *urlStr   = [NSString stringWithFormat:@"%@/question/user-lists",APIDev];
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:parm withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"right --- %@",object);
        //NSLog(@"%@",object[@"status"][@"message"]);
        
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            [self.rightMutableArray removeAllObjects];
            self.rightMutableArray = [NSMutableArray arrayWithArray:object[@"data"][@"items"]];
            
            if (self.rightMutableArray.count>0) {
                [self.selectVipView.selectVipTableView reloadData];
            }else{
                ZMEmptyView *emptyView = [[ZMEmptyView alloc] initWithFrame:SCREEN_BOUNDS];
                self.selectVipView.selectVipTableView.tableHeaderView = emptyView;
            }
            
            rightTotalCount = [[NSString stringWithFormat:@"%@",object[@"data"][@"total"]] integerValue];
            rightCurrentPage= 2;
        }else{
            
        }
        [self.selectVipView.selectVipTableView.mj_header endRefreshing];
    } withFailureBlock:^(NSError *error) {
        [self.selectVipView.selectVipTableView.mj_header endRefreshing];
        NSLog(@"%@",error);
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
    
}

- (void)loadMoreSouceData{
    if (self.rightMutableArray.count<rightTotalCount) {
        NSString *currentPageStr = [NSString stringWithFormat:@"%ld",(long)rightCurrentPage];
        
        NSDictionary *parm = @{@"page":currentPageStr};
        
        NSString *urlStr   = [NSString stringWithFormat:@"%@/question/user-lists",APIDev];
        [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:parm withSuccessBlock:^(NSDictionary *object) {
            NSLog(@"%@",object);
            //NSLog(@"%@",object[@"status"][@"message"]);
            
            NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
            if ([stateStr isEqualToString:@"success"]) {
                
                
                [self.rightMutableArray addObjectsFromArray:object[@"data"][@"items"]];
                if (self.rightMutableArray.count<rightTotalCount) {
                    rightCurrentPage++;
                }
                [self.selectVipView.selectVipTableView reloadData];
                
            }
            [self.selectVipView.selectVipTableView.mj_footer endRefreshing];
        } withFailureBlock:^(NSError *error) {
            [self.selectVipView.selectVipTableView.mj_footer endRefreshing];
            NSLog(@"%@",error);
        } progress:^(float progress) {
            NSLog(@"%f",progress);
        }];
    }else{
        [self.selectVipView.selectVipTableView.mj_footer endRefreshing];
    }
    
}



- (void)setMJRefreshConfig:(UITableView *)tableView{
    
    MJRefreshNormalHeader     *header;
    header = [MJRefreshNormalHeader     headerWithRefreshingTarget:self refreshingAction:@selector(evokeSouceData)];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    [header setTitle:@"下拉刷新"  forState:MJRefreshStateIdle];
    [header setTitle:@"释放更新"  forState:MJRefreshStatePulling];
    [header setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    tableView.mj_header = header;
    
    
    
    MJRefreshBackNormalFooter *footer;
    footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreSouceData)];
    tableView.mj_footer = footer;
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
