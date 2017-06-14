//
//  ZMMyInvoiceViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/21.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMMyInvoiceViewController.h"
#import "ZMMyInvoiceView.h"
#import "ZMMyInvoiceTableViewCell.h"

#import "ZMInvoiceDetailViewController.h"
#import "ZMMakeInvoiceViewController.h"

@interface ZMMyInvoiceViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)ZMMyInvoiceView *invioceView;
@end

@implementation ZMMyInvoiceViewController

-(void)loadView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.invioceView = [[ZMMyInvoiceView alloc] initWithFrame:SCREEN_BOUNDS];
    self.invioceView.invoiceTableView.delegate   = self;
    self.invioceView.invoiceTableView.dataSource = self;
    self.view       = self.invioceView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的发票";
    
    [self rightButton];
}

- (void)rightButton{
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 80, 44)];
    [rightButton setTitle:@"开发票" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor colorWithHex:@"333333"] forState:UIControlStateNormal];
    [rightButton.titleLabel setFont:[UIFont systemFontOfSize:SCREEN_WIDTH/23.43]];
    rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightButton addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

#pragma mark - RightAction
- (void)rightBtnAction{
    //NSLog(@"开发票");
    ZMMakeInvoiceViewController *makeInvoiceVC = [[ZMMakeInvoiceViewController alloc] init];
    [self.navigationController pushViewController:makeInvoiceVC animated:YES];
}

#pragma mark - Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 12;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return SCREEN_WIDTH/375*95;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return SCREEN_WIDTH/375*20;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footView         = [[UIView alloc] init];
    footView.backgroundColor = [UIColor clearColor];
    return footView;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *invoiceIndentifire         = @"invoiceCell";
    
    
    ZMMyInvoiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:invoiceIndentifire];
    if (!cell) {
        cell = [[ZMMyInvoiceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:invoiceIndentifire];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell setInvoiceIntro:nil];
    
    if (indexPath.row==11) {
        cell.line.alpha = 0;
    }else{
        cell.line.alpha = 1;
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"invoice");
    ZMInvoiceDetailViewController *invoiceDetailVC = [[ZMInvoiceDetailViewController alloc] init];
    [self.navigationController pushViewController:invoiceDetailVC animated:YES];
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
