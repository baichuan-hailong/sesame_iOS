//
//  ZMMyDelegateViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/23.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMMyDelegateViewController.h"
#import "ZMMyDelegateView.h"
#import "ZMAgentViewCell.h"

#import "ZMAgentDetailViewController.h"

@interface ZMMyDelegateViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)ZMMyDelegateView *myDelegateView;
@end

@implementation ZMMyDelegateViewController
-(void)loadView{
    self.automaticallyAdjustsScrollViewInsets         = NO;
    self.myDelegateView = [[ZMMyDelegateView alloc] initWithFrame:SCREEN_BOUNDS];
    self.myDelegateView.myDelegateTableView.delegate  = self;
    self.myDelegateView.myDelegateTableView.dataSource= self;
    self.view = self.myDelegateView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的代理";
    
    [self souceData];
}



#pragma mark - Souce Data
- (void)souceData{
    //sender coder
    NSDictionary *parm = @{@"page":@"1"};
    NSString *urlStr   = [NSString stringWithFormat:@"%@/agent/my-publish-lists",APIDev];
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:parm withSuccessBlock:^(NSDictionary *object){
        
        NSLog(@"agent --- %@",object);
        NSLog(@"%@",object[@"status"][@"message"]);
        
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            
        }else{
            
        }
    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}


#pragma mark - UITableView Delegate & Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SCREEN_WIDTH/2.35 + 12;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return SCREEN_WIDTH/375*49;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *headerView         = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIndentifire = @"cell";
    ZMAgentViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifire];
    if (!cell) {
        cell = [[ZMAgentViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifire];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setValueWithDic:nil];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //NSLog(@"DidSelect");
    
    ZMAgentDetailViewController *agentDetailVC = [[ZMAgentDetailViewController alloc] init];
    [self.navigationController pushViewController:agentDetailVC animated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
