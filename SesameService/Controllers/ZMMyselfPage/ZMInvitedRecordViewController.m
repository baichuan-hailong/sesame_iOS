//
//  ZMInvitedRecordViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/26.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMInvitedRecordViewController.h"
#import "ZMInviteRecordView.h"

#import "ZMInviteRecordTableViewCell.h"
#import "ZMInviteRecordTypeTableViewCell.h"

@interface ZMInvitedRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger rightCurrentPage;
    NSInteger rightTotalCount;
}
@property (nonatomic , strong) ZMInviteRecordView *invitionRecordView;
@property (nonatomic , strong) MBProgressHUD      *HUD;
@property(nonatomic,strong)    NSMutableArray     *rightMutableArray;
@end

@implementation ZMInvitedRecordViewController

- (void)loadView {
    //change
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.invitionRecordView   = [[ZMInviteRecordView alloc] initWithFrame:SCREEN_BOUNDS];
    self.view                    = self.invitionRecordView;
    self.invitionRecordView.inviteRecordTableView.delegate   = self;
    self.invitionRecordView.inviteRecordTableView.dataSource = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"邀请记录";
    
    
    [self setMJRefreshConfig:self.invitionRecordView.inviteRecordTableView];
    
    [self.invitionRecordView.inviteRecordTableView.mj_header beginRefreshing];
}



#pragma mark - Load Data
- (void)evokeSouceData{

    rightCurrentPage = 1;
    NSDictionary *parm = @{@"page":@"1"};
    NSString *urlStr   = [NSString stringWithFormat:@"%@/user/invite-record",APIDev];
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:parm withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"invite-record--- %@",object);
        self.invitionRecordView.inviteRecordTableView.mj_footer.state = MJRefreshStateIdle;
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            [self.rightMutableArray removeAllObjects];
            self.rightMutableArray = [NSMutableArray arrayWithArray:object[@"data"][@"items"]];
            
            if (_rightMutableArray.count>0) {
                [self.invitionRecordView.inviteRecordTableView reloadData];
            }else{
                ZMEmptyView *emptyView = [[ZMEmptyView alloc] initWithFrame:SCREEN_BOUNDS];
                [emptyView setBottomTitle:@"暂无信息"];
                self.invitionRecordView.inviteRecordTableView.tableHeaderView = emptyView;
            }
            
            rightTotalCount = [[NSString stringWithFormat:@"%@",object[@"data"][@"total"]] integerValue];
            rightCurrentPage= 2;
        }else{
            [self showProgress:object[@"status"][@"message"]];
        }
        [self.invitionRecordView.inviteRecordTableView.mj_header endRefreshing];
    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
        [self.invitionRecordView.inviteRecordTableView.mj_header endRefreshing];
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}

- (void)evokeMoreSouceData{
    
    
    
    if (self.rightMutableArray.count<rightTotalCount) {
        
        
        NSString *currentPageStr = [NSString stringWithFormat:@"%ld",(long)rightCurrentPage];
        
        NSDictionary *parm = @{@"page":currentPageStr};
        NSString *urlStr   = [NSString stringWithFormat:@"%@/user/invite-record",APIDev];
        [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:parm withSuccessBlock:^(NSDictionary *object) {
            NSLog(@"invite-record--- %@",object);
            NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
            if ([stateStr isEqualToString:@"success"]) {
                [self.rightMutableArray addObjectsFromArray:object[@"data"][@"items"]];
                if (self.rightMutableArray.count<rightTotalCount) {
                    rightCurrentPage++;
                }
                [self.invitionRecordView.inviteRecordTableView reloadData];
            }else{
                [self showProgress:object[@"status"][@"message"]];
            }
            [self.invitionRecordView.inviteRecordTableView.mj_footer endRefreshing];
        } withFailureBlock:^(NSError *error) {
            [self.invitionRecordView.inviteRecordTableView.mj_footer endRefreshing];
            NSLog(@"%@",error);
        } progress:^(float progress) {
            NSLog(@"%f",progress);
        }];
    }else{
        self.invitionRecordView.inviteRecordTableView.mj_footer.state = MJRefreshStateNoMoreData;
    }
}




#pragma mark - Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.rightMutableArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.rightMutableArray[indexPath.section];
    NSString *type = [NSString stringWithFormat:@"%@",dic[@"type"]];
    if ([type integerValue]==0) {
        return SCREEN_WIDTH/375*110;
    }else{
        return SCREEN_WIDTH/375*136;
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
    
    static NSString *inviteRecordIndentifire             = @"inviteRecordCell";
    static NSString *inviteTypeRecordIndentifire         = @"inviteTypeRecordCell";
    
    NSDictionary *dic = self.rightMutableArray[indexPath.section];
    NSString *type = [NSString stringWithFormat:@"%@",dic[@"type"]];
    
    
    if ([type integerValue]==0) {
        ZMInviteRecordTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:inviteTypeRecordIndentifire];
        if (!cell) {
            cell = [[ZMInviteRecordTypeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:inviteTypeRecordIndentifire];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell setRecord:dic];
        return cell;
    }else{
        ZMInviteRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:inviteRecordIndentifire];
        if (!cell) {
            cell = [[ZMInviteRecordTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:inviteRecordIndentifire];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell setRecord:dic];
        return cell;
    }
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //NSLog(@"commission");
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
    
    
    
    MJRefreshBackNormalFooter *footer;
    footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(evokeMoreSouceData)];
    [footer setTitle:mj_footTitle forState:MJRefreshStateNoMoreData];
    tableView.mj_footer = footer;
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
