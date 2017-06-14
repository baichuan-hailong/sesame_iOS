//
//  ZMEvaluationCompanyViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMEvaluationCompanyViewController.h"
#import "ZMEvaluationCompanyView.h"

@interface ZMEvaluationCompanyViewController ()<UITextViewDelegate>
{
    NSInteger starCount;
}
@property (nonatomic,strong)ZMEvaluationCompanyView *evaluationCompanyView;
@end

@implementation ZMEvaluationCompanyViewController

-(void)loadView{
    self.evaluationCompanyView = [[ZMEvaluationCompanyView alloc] initWithFrame:SCREEN_BOUNDS];
    self.evaluationCompanyView.evaluationTextView.delegate = self;
    self.view = self.evaluationCompanyView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评价企业";
    
    for (NSInteger i=0; i<self.evaluationCompanyView.starArray.count; i++) {
        UIButton *starButton      = self.evaluationCompanyView.starArray[i];
        starButton.tag            = 1314+i+1;
        //starButton.backgroundColor= [UIColor yellowColor];
        [starButton addTarget:self action:@selector(starBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self addAction];
}

- (void)addAction{
    
    UITapGestureRecognizer *viewTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapGRAction:)];
    [self.view addGestureRecognizer:viewTapGR];
}

#pragma mark - star tap
- (void)starBtnAction:(UIButton *)sender{
    
    starCount = sender.tag-1314;
    NSLog(@"star count --- %ld",starCount);
    
    [self.view endEditing:YES];
    
    for (NSInteger i=0; i<sender.tag-1314; i++) {
        UIButton *starButton      = self.evaluationCompanyView.starArray[i];
        [starButton setImage:[UIImage imageNamed:@"evaluationCompanySelect"] forState:UIControlStateNormal];
        
       }
    
    for (NSInteger i=sender.tag-1314; i<5; i++) {
        UIButton *starButton      = self.evaluationCompanyView.starArray[i];
        [starButton setImage:[UIImage imageNamed:@"evaluationCompanyNoSelect"] forState:UIControlStateNormal];
        
    }
    
}



#pragma mark - tap
- (void)viewTapGRAction:(UITapGestureRecognizer *)sender{
    //NSLog(@"tap");
    [self.view endEditing:YES];
}


#pragma mark - TextView Delegate

-(void)textViewDidChange:(UITextView *)textView{
    
    if (self.evaluationCompanyView.evaluationTextView.text.length==0) {
        [self.evaluationCompanyView.evaluationTextView addSubview:self.evaluationCompanyView.evaluationPlaceHolderLabel];
    }else{
        [self.evaluationCompanyView.evaluationPlaceHolderLabel removeFromSuperview];
    }
    
    //TextView字符
    NSString *textCodeString = [self.evaluationCompanyView.evaluationTextView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (textCodeString.length>0) {
        self.evaluationCompanyView.commitButton.alpha = 1;
        self.evaluationCompanyView.commitButton.userInteractionEnabled = YES;
    }else{
        self.evaluationCompanyView.commitButton.alpha = 0.6;
        self.evaluationCompanyView.commitButton.userInteractionEnabled = NO;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@""] && range.length > 0) {
        //delete security
        return YES;
    }
    else{
        if (textView.text.length - range.length + text.length > 100000) {
            return NO;
        }
        else {
            return YES;
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
