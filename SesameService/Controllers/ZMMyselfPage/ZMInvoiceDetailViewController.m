//
//  ZMInvoiceDetailViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/24.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMInvoiceDetailViewController.h"
#import "ZMInvoiceDetailView.h"

#import "ZMMyInvoiceTableViewCell.h"
#import "ZMInvoiceDetailTableViewCell.h"

@interface ZMInvoiceDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)ZMInvoiceDetailView *invioceView;

@property(nonatomic,strong)NSArray *invoiceArray;
@end

@implementation ZMInvoiceDetailViewController

-(void)loadView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.invioceView = [[ZMInvoiceDetailView alloc] initWithFrame:SCREEN_BOUNDS];
    self.invioceView.invoiceTableView.delegate   = self;
    self.invioceView.invoiceTableView.dataSource = self;
    self.view       = self.invioceView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"发票详情";
    
    self.invoiceArray = @[@{@"left":@"发票抬头",@"right":@"个人"},
                          @{@"left":@"项目",@"right":@"信息费"},
                          @{@"left":@"邮寄地址",@"right":@"北京市海淀区知春路1号"},
                          @{@"left":@"挂号信单号",@"right":@"NF23867465144"},
                          @{@"left":@"邮政编码",@"right":@"100083"},
                          @{@"left":@"联系人姓名",@"right":@"百川"},
                          @{@"left":@"联系电话",@"right":@"158****6239"},
                          @{@"left":@"邮寄时间",@"right":@"2017-04-15"}];
}


#pragma mark - Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else{
        return self.invoiceArray.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        return SCREEN_WIDTH/375*95;
    }else{
        return SCREEN_WIDTH/375*59;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return SCREEN_WIDTH/375*13;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footView         = [[UIView alloc] init];
    footView.backgroundColor = [UIColor clearColor];
    return footView;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *invoiceIndentifire               = @"invoiceCell";
    static NSString *invoiceDetailIndentifire         = @"invoiceDetailCell";
    
    if (indexPath.section==0) {
        ZMMyInvoiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:invoiceIndentifire];
        if (!cell) {
            cell = [[ZMMyInvoiceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:invoiceIndentifire];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell setInvoiceIntro:nil];
        cell.line.alpha = 0;
        return cell;
    }else{

        NSDictionary *invoDetailDic = self.invoiceArray[indexPath.row];
        ZMInvoiceDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:invoiceDetailIndentifire];
        if (!cell) {
            cell = [[ZMInvoiceDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:invoiceDetailIndentifire];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (indexPath.row==self.invoiceArray.count-1) {
            cell.line.alpha = 0;
        }else{
            cell.line.alpha = 1;
        }
        [cell setInvoiceDetail:invoDetailDic];
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"invoice");
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
