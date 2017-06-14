//
//  ZMAgentPublishViewController.m
//  SesameService
//
//  Created by 娄耀文 on 17/4/6.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMAgentPublishViewController.h"
#import "ZMAgentPublishView.h"

@interface ZMAgentPublishViewController () <UITextFieldDelegate,
                                            UITextViewDelegate>

@property (nonatomic, strong) ZMAgentPublishView *currentView;

@end

@implementation ZMAgentPublishViewController

- (void)loadView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.currentView = [[ZMAgentPublishView alloc] initWithFrame:SCREEN_BOUNDS];
    self.view        = self.currentView;
    
    self.currentView.titleText.delegate     = self;
    self.currentView.areaText.delegate      = self;
    self.currentView.moneyText.delegate     = self;
    self.currentView.describeTextView.delegate = self;
    self.currentView.connectText.delegate      = self;
    self.currentView.phoneText.delegate     = self;
    [self.currentView.submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self leftButton];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEdit)];
    [self.view addGestureRecognizer:tapGes];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布代理";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


- (void)leftButton {
    
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 15, 64, 40);
    [button addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = item;
    
}

- (void)backAction:(UIButton *)sender{
    
    if (_isFromHome) {
        [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - textFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [UIView animateWithDuration:0.38 animations:^{
        
    } completion:^(BOOL finished) {
        
    }];
}

//限制输入字符数不能大于15个
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location >= 30){
        
        return NO;
    } else {
        
        return YES;
    }
}


#pragma mark - textViewDelegate
//监听输入结束后的内容
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    return YES;
}

//监听正在输入的内容
-(void)textViewDidChange:(UITextView *)textView {
    
    NSLog(@"%@",textView.text);
}



#pragma mark - customMethod
- (void)endEdit {
    
    /** 收回键盘 */
    [self.view endEditing:YES];
}

- (void)submitAction {
    
    NSLog(@"发布代理");
}










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
