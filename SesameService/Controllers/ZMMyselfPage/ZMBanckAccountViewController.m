//
//  ZMBanckAccountViewController.m
//  SesameService
//
//  Created by 杜海龙 on 2017/5/28.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMBanckAccountViewController.h"
#import "ZMMyPayMentAccountView.h"


#import "ZMPayMentSuccessfulView.h"
#import "ZMPayMentSuccessfulTableViewCell.h"

@interface ZMBanckAccountViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)ZMMyPayMentAccountView *myPayMentAccountView;
@property (nonatomic,strong)MBProgressHUD    *HUD;

@property(nonatomic,strong)ZMPayMentSuccessfulView     *payMentSuccessfulView;
@property (nonatomic,strong)NSArray    *dataArr;
@end

@implementation ZMBanckAccountViewController


-(void)loadView{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.myPayMentAccountView = [[ZMMyPayMentAccountView alloc] initWithFrame:SCREEN_BOUNDS];
    self.view                 = self.myPayMentAccountView;
    
    self.payMentSuccessfulView = [[ZMPayMentSuccessfulView alloc] initWithFrame:SCREEN_BOUNDS];
    self.payMentSuccessfulView.succeTableView.delegate = self;
    self.payMentSuccessfulView.succeTableView.dataSource = self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHex:backGroundColor];
    self.title = @"收款账号";

    [self addAction];
    
    [self loadSouceData];
}


#pragma mark - Load Data
- (void)loadSouceData{
    
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    [self.HUD show:YES];
    
    NSString *urlStr   = [NSString stringWithFormat:@"%@/user/bank",APIDev];
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:nil withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"user ----------- bank --- %@",object);
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            NSDictionary *bankDic = object[@"data"];
            if (![bankDic isEqual:[NSNull null]]) {
                /*
                 @{@"person_name" : self.myPayMentAccountView.collectionTypeView.text,
                 @"bank_name"   : self.myPayMentAccountView.personRealNameTextField,
                 @"bank_card"   : self.myPayMentAccountView.accountTextField.text,
                 @"bank_address": self.myPayMentAccountView.telTextField.text};
                 self.myPayMentAccountView.collectionTypeView.userInteractionEnabled     = NO;
                 self.myPayMentAccountView.personRealNameTextField.userInteractionEnabled= NO;
                 self.myPayMentAccountView.accountTextField.userInteractionEnabled       = NO;
                 self.myPayMentAccountView.telTextField.userInteractionEnabled           = NO;
                 self.myPayMentAccountView.collectionTypeView.text     = [NSString stringWithFormat:@"%@",object[@"data"][@"person_name"]];
                 self.myPayMentAccountView.personRealNameTextField.text= [NSString stringWithFormat:@"%@",object[@"data"][@"bank_name"]];
                 self.myPayMentAccountView.accountTextField.text       = [NSString stringWithFormat:@"%@",object[@"data"][@"bank_card"]];
                 self.myPayMentAccountView.telTextField.text           = [NSString stringWithFormat:@"%@",object[@"data"][@"bank_address"]];
                 
                 
                 
                 */
                
                NSString *bank_card = [NSString stringWithFormat:@"%@",object[@"data"][@"bank_card"]];
                if (bank_card.length>8) {
                    
                    NSString *place=@"";
                    for (int i=0; i<bank_card.length-8; i++) {
                        place = [NSString stringWithFormat:@"%@*",place];
                    }
                    
                    bank_card = [bank_card stringByReplacingCharactersInRange:NSMakeRange(4, bank_card.length-8) withString:place];
                    
                }
                
                
                self.dataArr = @[@{@"left":@"户名",@"right":[NSString stringWithFormat:@"%@",object[@"data"][@"person_name"]]},
                                 @{@"left":@"银行名称",@"right":[NSString stringWithFormat:@"%@",object[@"data"][@"bank_name"]]},
                                 @{@"left":@"银行卡号",@"right":bank_card},
                                 @{@"left":@"开户行",@"right":[NSString stringWithFormat:@"%@",object[@"data"][@"bank_address"]]}];
                [self.view addSubview:self.payMentSuccessfulView];
                [self.payMentSuccessfulView.succeTableView reloadData];
            }else{
                [self rigAcBtn];
            }
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








- (void)addAction{
    UITapGestureRecognizer *viewTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(viewTapGRAction:)];
    [self.view addGestureRecognizer:viewTapGR];
    self.myPayMentAccountView.telTextField.delegate = self;
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.28 animations:^{
        self.myPayMentAccountView.contentOffset = CGPointMake(0, SCREEN_WIDTH/375*80);
    }];
    return YES;
}



- (void)rigAcBtn{
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 80, 44)];
    [rightButton setTitle:@"保存" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor colorWithHex:@"333333"] forState:UIControlStateNormal];
    [rightButton.titleLabel setFont:[UIFont systemFontOfSize:SCREEN_WIDTH/23.43]];
    rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightButton addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

- (void)rightBtnAction{
    
    NSLog(@"save");
    if (self.myPayMentAccountView.collectionTypeView.text.length>0&&
        self.myPayMentAccountView.personRealNameTextField.text.length>0&&
        self.myPayMentAccountView.accountTextField.text.length>0&&
        self.myPayMentAccountView.telTextField.text.length>0) {
        
        self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:self.HUD];
        [self.HUD show:YES];
        
        
        NSDictionary *pra = @{@"person_name" : self.myPayMentAccountView.collectionTypeView.text,
                              @"bank_name"   : self.myPayMentAccountView.personRealNameTextField.text,
                              @"bank_card"   : self.myPayMentAccountView.accountTextField.text,
                              @"bank_address": self.myPayMentAccountView.telTextField.text};
        
        NSLog(@"pra bank - %@",pra);
        
        NSString *urlStr   = [NSString stringWithFormat:@"%@/user/save-bank",APIDev];
        [AFNetManager requestWithType:HttpRequestTypePost withUrlString:urlStr withParaments:pra withSuccessBlock:^(NSDictionary *object) {
            NSLog(@"add user bank --- %@",object);
            
            NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
            if ([stateStr isEqualToString:@"success"]) {
                [self showProgress:@"保存成功！"];
                
                
                UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 80, 44)];
                self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
                
                
                NSString *bank_card = [NSString stringWithFormat:@"%@",self.myPayMentAccountView.accountTextField.text];
                if (bank_card.length>8) {
                    
                    NSString *place=@"";
                    for (int i=0; i<bank_card.length-8; i++) {
                        place = [NSString stringWithFormat:@"%@*",place];
                    }
                    bank_card = [bank_card stringByReplacingCharactersInRange:NSMakeRange(4, bank_card.length-8) withString:place];
                }
                
                
                 self.dataArr = @[@{@"left":@"户名",@"right":self.myPayMentAccountView.collectionTypeView.text},
                                 @{@"left":@"银行名称",@"right":self.myPayMentAccountView.personRealNameTextField.text},
                                 @{@"left":@"银行卡号",@"right":bank_card},
                                 @{@"left":@"开户行",@"right":self.myPayMentAccountView.telTextField.text}];

                [self.view addSubview:self.payMentSuccessfulView];
                [self.payMentSuccessfulView.succeTableView reloadData];
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
    }else{
        [self showProgress:@"请输入账号信息"];
    }
}



#pragma mark - UITableView Delegate & Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SCREEN_WIDTH/375*50;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIndentifire = @"cell";
    
    NSDictionary *counDic = self.dataArr[indexPath.row];
    ZMPayMentSuccessfulTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifire];
    if (!cell) {
        cell = [[ZMPayMentSuccessfulTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifire];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setAccont:counDic];
    if (indexPath.row==self.dataArr.count-1) {
        cell.line.alpha = 0;
    }else{
        cell.line.alpha = 1;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"DidSelect");
    
}





#pragma mark - tap
- (void)viewTapGRAction:(UITapGestureRecognizer *)sender{
    NSLog(@"tap");
    [UIView animateWithDuration:0.28 animations:^{
        self.myPayMentAccountView.contentOffset = CGPointMake(0, SCREEN_WIDTH/375*0);
    }];
    
    [self.view endEditing:YES];
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
