//
//  ZMBuyingBusinessViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/23.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMBuyingBusinessViewController.h"
#import "ZMBuyingBusinessView.h"
#import "ZMBusinessTableViewCell.h"

#import "ZMShareDetailViewController.h"

@interface ZMBuyingBusinessViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)ZMBuyingBusinessView *buyingBusinessView;
@end

@implementation ZMBuyingBusinessViewController
-(void)loadView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.buyingBusinessView = [[ZMBuyingBusinessView alloc] initWithFrame:SCREEN_BOUNDS];
    self.buyingBusinessView.buyingBusinessTableView.delegate = self;
    self.buyingBusinessView.buyingBusinessTableView.dataSource = self;
    self.view = self.buyingBusinessView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我购买的";
    self.view.backgroundColor = [UIColor colorWithHex:backGroundColor];
    
    [self souceData];
}

#pragma mark - Souce Data
- (void)souceData{
    //sender coder
    NSDictionary *parm = @{@"page":@"1"};
    NSString *urlStr   = [NSString stringWithFormat:@"%@/order/buy-lists",APIDev];
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:parm withSuccessBlock:^(NSDictionary *object){
        
        NSLog(@"buy --- %@",object);
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



#pragma mark - Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 6;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return SCREEN_WIDTH/375*21;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footView = [[UIView alloc] init];
    footView.backgroundColor = [UIColor clearColor];
    return footView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return SCREEN_WIDTH/375*180;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIndentifire = @"releaseCell";
    ZMBusinessTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifire];
    if (!cell) {
        cell = [[ZMBusinessTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifire];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //NSLog(@"didSelected");
    ZMShareDetailViewController *shareDetailVC = [[ZMShareDetailViewController alloc] init];
    [self.navigationController pushViewController:shareDetailVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
