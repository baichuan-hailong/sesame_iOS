//
//  ZMComplaintViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/24.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMComplaintViewController.h"
#import "ZMComplaintView.h"
#import "ZMComplaintSuccessfulView.h"

#import "ZMComplaintsDetailViewController.h"

@interface ZMComplaintViewController ()<UITextViewDelegate>
@property(nonatomic,strong)ZMComplaintView           *complaintView;
@property(nonatomic,strong)ZMComplaintSuccessfulView *complaintSuccessfulView;
@property (nonatomic , strong)MBProgressHUD *HUD;
@property (nonatomic , copy)NSString *complaintID;
@end

@implementation ZMComplaintViewController

-(void)loadView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.complaintView           = [[ZMComplaintView alloc] initWithFrame:SCREEN_BOUNDS];
    self.complaintSuccessfulView = [[ZMComplaintSuccessfulView alloc] initWithFrame:SCREEN_BOUNDS];
    self.view          = self.complaintView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"发起投诉";
    
    [self addAction];
    
    [self.complaintView setTopDicView:self.infoDic];
}


- (void)addAction{
    UITapGestureRecognizer *viewTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapGRAction:)];
    [self.view addGestureRecognizer:viewTapGR];
    
    [self.complaintView.commitButton addTarget:self action:@selector(commitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.complaintView.suggestTextView.delegate = self;
    
    //successful
    [self.complaintSuccessfulView.checkBtn addTarget:self action:@selector(checkBtnClickAc:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.complaintSuccessfulView.bacBtn addTarget:self action:@selector(bacBtnClickAc:) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - successful
- (void)checkBtnClickAc:(UIButton *)sender{
    NSLog(@"check");
    
     ZMComplaintsDetailViewController *complaintsDetailVC = [[ZMComplaintsDetailViewController alloc] init];
     complaintsDetailVC.title = @"投诉详情";
     complaintsDetailVC.isRootPop = YES;
     complaintsDetailVC.feedID = self.complaintID;
     complaintsDetailVC.status = @"pending";
     NSMutableDictionary *topDic = [NSMutableDictionary dictionaryWithDictionary:self.infoDic];
    [topDic setObject:@"pending" forKey:@"status"];
    [topDic setObject:@"处理中" forKey:@"status_title"];
     complaintsDetailVC.topDic = topDic;
     [self.navigationController pushViewController:complaintsDetailVC animated:YES];
    /*
     {
     id = 3;
     "local_sn" = 201705071430354366;
     price = 100;
     result = "<null>";
     status = pending;
     "status_title" = "\U5904\U7406\U4e2d";
     time = 1494225790;
     title = 123456789012345678901234567890;
     "trade_time" = 1494138641;
     }
     */
}

- (void)bacBtnClickAc:(UIButton *)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - tap
- (void)viewTapGRAction:(UITapGestureRecognizer *)sender{
    //NSLog(@"tap");
    [self.view endEditing:YES];
    
    [UIView animateWithDuration:0.28 animations:^{
        self.complaintView.contentOffset = CGPointMake(0, SCREEN_WIDTH/375*0);
    }];
}

#pragma mark - commit
- (void)commitButtonClick{
    
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.18 animations:^{
        self.complaintView.contentOffset = CGPointMake(0, SCREEN_WIDTH/375*0);
    }];
    
    
    
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    [self.HUD show:YES];
    
    NSDictionary * praDic = @{@"info_id":self.infoID,
                              @"content":self.complaintView.suggestTextView.text};
    NSLog(@"praDic ----- %@",praDic);
    NSString *urlStr   = [NSString stringWithFormat:@"%@/feedback/create-complaint",APIDev];
    [AFNetManager requestWithType:HttpRequestTypePost withUrlString:urlStr withParaments:praDic withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"tousu --- %@",object);
        NSLog(@"%@",object[@"status"][@"message"]);
        
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            self.view          = self.complaintSuccessfulView;
            
            
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"complainAcSuccessful" object:object[@"data"]];
            
            self.complaintID = [NSString stringWithFormat:@"%@",object[@"data"][@"id"]];
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




#pragma mark - TextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    //NSLog(@"begin");
    [UIView animateWithDuration:0.28 animations:^{
       self.complaintView.contentOffset = CGPointMake(0, SCREEN_WIDTH/375*120);
    }];
}

-(void)textViewDidChange:(UITextView *)textView{
    
    if (self.complaintView.suggestTextView.text.length==0) {
        [self.complaintView.suggestTextView addSubview:self.complaintView.suggestPlaceHolderLabel];
    }else{
        [self.complaintView.suggestPlaceHolderLabel removeFromSuperview];
    }
    
    self.complaintView.worldCountLabel.text = [NSString stringWithFormat:@"%lu/300",(unsigned long)textView.text.length];
    NSString *textCodeString = [self.complaintView.suggestTextView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (textCodeString.length>0) {
        self.complaintView.commitButton.alpha = 1;
        self.complaintView.commitButton.userInteractionEnabled = YES;
    }else{
        self.complaintView.commitButton.alpha = 0.6;
        self.complaintView.commitButton.userInteractionEnabled = NO;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@""] && range.length > 0) {
        return YES;
    }
    else {
        if (textView.text.length - range.length + text.length > 300) {
            return NO;
        }
        else {
            return YES;
        }
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
