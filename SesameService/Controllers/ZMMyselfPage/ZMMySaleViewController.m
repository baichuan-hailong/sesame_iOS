//
//  ZMMySaleViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/23.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMMySaleViewController.h"
#import "ZMSaleView.h"
#import "ZMBusinessTableViewCell.h"

#import "ZMShareDetailViewController.h"

@interface ZMMySaleViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)ZMSaleView *saleView;
@end

@implementation ZMMySaleViewController
-(void)loadView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.saleView = [[ZMSaleView alloc] initWithFrame:SCREEN_BOUNDS];
    self.saleView.saleableView.delegate = self;
    self.saleView.saleableView.dataSource = self;
    self.view = self.saleView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我卖出的";
    self.view.backgroundColor = [UIColor colorWithHex:backGroundColor];
    
    [self souceData];
}


#pragma mark - Souce Data
- (void)souceData{
    //sender coder
    NSDictionary *parm = @{@"page":@"1"};
    NSString *urlStr   = [NSString stringWithFormat:@"%@/order/sell-lists",APIDev];
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:parm withSuccessBlock:^(NSDictionary *object){
        
        NSLog(@"%@",object);
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
