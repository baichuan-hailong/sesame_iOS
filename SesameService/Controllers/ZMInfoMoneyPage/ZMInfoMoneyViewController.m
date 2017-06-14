//
//  ZMInfoMoneyViewController.m
//  SesameService
//
//  Created by 娄耀文 on 17/4/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMInfoMoneyViewController.h"
#import "ZMInfoMoneyPublishViewController.h"

@interface ZMInfoMoneyViewController ()

@property (nonatomic, strong) UIScrollView *mainScrollerView;
@property (nonatomic, strong) UILabel      *titleLable;
@property (nonatomic, strong) UILabel      *one_Lable;
@property (nonatomic, strong) UILabel      *two_Lable;
@property (nonatomic, strong) UILabel      *three_Lable;
@property (nonatomic, strong) UIView       *line1;
@property (nonatomic, strong) UIView       *line2;

@property (nonatomic, strong) UIImageView  *tipsImage1;
@property (nonatomic, strong) UIImageView  *tipsImage2;
@property (nonatomic, strong) UIImageView  *tipsImage3;
@property (nonatomic, strong) UILabel      *tipsLable1;
@property (nonatomic, strong) UILabel      *tipsLable2;
@property (nonatomic, strong) UILabel      *tipsLable3;
@property (nonatomic, strong) UILabel      *detailLable;
@property (nonatomic, strong) UIButton     *nextBtn;
@property (nonatomic, strong) UIButton     *callBtn;

@end

@implementation ZMInfoMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithHex:backColor];
    self.title = @"赚信息费";
    
//    if (_isFromHome) {
//        [self popBackButton];
//    } else {
//        [self dismissBackButton];
//    }
    if ([_from isEqualToString:@"home"]) {
        [self popBackButton];
    } else if ([_from isEqualToString:@"publish"]) {
        [self dismissBackButton];
    } else if ([_from isEqualToString:@"business"]) {
        [self dismissBackButton];
    }
    
    [self.view addSubview:self.mainScrollerView];
    [self.mainScrollerView addSubview:self.titleLable];
    [self.mainScrollerView addSubview:self.one_Lable];
    [self.mainScrollerView addSubview:self.two_Lable];
    [self.mainScrollerView addSubview:self.three_Lable];
    [self.mainScrollerView addSubview:self.line1];
    [self.mainScrollerView addSubview:self.line2];
    [self.mainScrollerView addSubview:self.tipsImage1];
    [self.mainScrollerView addSubview:self.tipsImage2];
    [self.mainScrollerView addSubview:self.tipsImage3];
    [self.mainScrollerView addSubview:self.tipsLable1];
    [self.mainScrollerView addSubview:self.tipsLable2];
    [self.mainScrollerView addSubview:self.tipsLable3];
    [self.mainScrollerView addSubview:self.detailLable];
    [self.mainScrollerView addSubview:self.nextBtn];
    [self.mainScrollerView addSubview:self.callBtn];
    
    self.mainScrollerView.delaysContentTouches = NO;
    for (UIView *currentView in self.mainScrollerView.subviews) {
        
        if([currentView isKindOfClass:[UIScrollView class]]) {
            
            ((UIScrollView *)currentView).delaysContentTouches = NO;
            break;
        }
    }
    self.mainScrollerView.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(self.callBtn.frame) + 25);
    
    //通知监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissAction) name:@"backToHome" object:nil];
}

- (void)callAction {
    
    NSLog(@"拨打电话");
    NSMutableString* str = [[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"400-8319-003"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

- (void)nextAction {

    NSLog(@"下一步");
    ZMInfoMoneyPublishViewController *publishView = [[ZMInfoMoneyPublishViewController alloc] init];
    [self.navigationController pushViewController:publishView animated:YES];
}



#pragma maek - getter
- (UIScrollView *)mainScrollerView {
    
    if (_mainScrollerView == nil) {
        _mainScrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                                           64,
                                                                           SCREEN_WIDTH,
                                                                           SCREEN_HEIGHT - 64)];
        _mainScrollerView.backgroundColor = [UIColor whiteColor];
        _mainScrollerView.showsVerticalScrollIndicator   = FALSE;
        _mainScrollerView.showsHorizontalScrollIndicator = FALSE;
    }
    return _mainScrollerView;
}

- (UILabel *)titleLable {
    
    if (_titleLable == nil) {
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                SCREEN_WIDTH/4.8,
                                                                SCREEN_WIDTH,
                                                                SCREEN_WIDTH/20.83)];
        _titleLable.font = [UIFont boldSystemFontOfSize:SCREEN_WIDTH/20.83];
        _titleLable.text = @"信息能换钱";
        _titleLable.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLable;
}

- (UILabel *)one_Lable {
    
    if (_one_Lable == nil) {
        _one_Lable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/7.8,
                                                               self.titleLable.bottom + SCREEN_WIDTH/15,
                                                               SCREEN_WIDTH/15,
                                                               SCREEN_WIDTH/15)];
        _one_Lable.backgroundColor = [UIColor colorWithHex:tonalColor];
        _one_Lable.textColor = [UIColor whiteColor];
        _one_Lable.textAlignment = NSTextAlignmentCenter;
        _one_Lable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:6];
        _one_Lable.text = @"1";
        
        _one_Lable.layer.masksToBounds = YES;
        _one_Lable.layer.cornerRadius = SCREEN_WIDTH/30;
    }
    return _one_Lable;
}

- (UILabel *)two_Lable {
    
    if (_two_Lable == nil) {
        _two_Lable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - (SCREEN_WIDTH/15)/2,
                                                               self.titleLable.bottom + SCREEN_WIDTH/15,
                                                               SCREEN_WIDTH/15,
                                                               SCREEN_WIDTH/15)];
        _two_Lable.backgroundColor = [UIColor colorWithHex:tonalColor];
        _two_Lable.textColor = [UIColor whiteColor];
        _two_Lable.textAlignment = NSTextAlignmentCenter;
        _two_Lable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:6];
        _two_Lable.text = @"2";
        
        _two_Lable.layer.masksToBounds = YES;
        _two_Lable.layer.cornerRadius = SCREEN_WIDTH/30;
    }
    return _two_Lable;
}

- (UILabel *)three_Lable {
    
    if (_three_Lable == nil) {
        _three_Lable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - SCREEN_WIDTH/7.8 - SCREEN_WIDTH/15,
                                                                 self.titleLable.bottom + SCREEN_WIDTH/15,
                                                                 SCREEN_WIDTH/15,
                                                                 SCREEN_WIDTH/15)];
        _three_Lable.backgroundColor = [UIColor colorWithHex:tonalColor];
        _three_Lable.textColor = [UIColor whiteColor];
        _three_Lable.textAlignment = NSTextAlignmentCenter;
        _three_Lable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:6];
        _three_Lable.text = @"3";
        
        _three_Lable.layer.masksToBounds = YES;
        _three_Lable.layer.cornerRadius = SCREEN_WIDTH/30;
    }
    return _three_Lable;
}

- (UIView *)line1 {
    
    if (_line1 == nil) {
        _line1 = [[UIView alloc] init];
        
        _line1.width   = SCREEN_WIDTH/12.5;
        _line1.height  = 1;
        _line1.centerX = SCREEN_WIDTH/3;
        _line1.centerY = self.two_Lable.centerY;
        
        _line1.backgroundColor = [UIColor colorWithHex:@"979797"];
    }
    return _line1;
}

- (UIView *)line2 {
    
    if (_line2 == nil) {
        _line2 = [[UIView alloc] init];
        
        _line2.width   = SCREEN_WIDTH/12.5;
        _line2.height  = 1;
        _line2.centerX = (SCREEN_WIDTH/3)*2;
        _line2.centerY = self.two_Lable.centerY;
        _line2.backgroundColor = [UIColor colorWithHex:@"979797"];
    }
    return _line2;
}

- (UIImageView *)tipsImage1 {
    
    if (_tipsImage1 == nil) {
        _tipsImage1 = [[UIImageView alloc] init];
        
        UIImage *img = [UIImage imageNamed:@"mm_提交信息"];
        _tipsImage1.image = img;
        
        _tipsImage1.width  = img.size.width;
        _tipsImage1.height = img.size.height;
        _tipsImage1.centerX = self.one_Lable.centerX;
        _tipsImage1.y       = self.one_Lable.bottom + SCREEN_WIDTH/19.73;
        
    }
    return _tipsImage1;
}

- (UIImageView *)tipsImage2 {
    
    if (_tipsImage2 == nil) {
        _tipsImage2 = [[UIImageView alloc] init];
        
        UIImage *img = [UIImage imageNamed:@"mm_购买信息"];
        _tipsImage2.image = img;
        
        _tipsImage2.width  = img.size.width;
        _tipsImage2.height = img.size.height;
        _tipsImage2.centerX = self.two_Lable.centerX;
        _tipsImage2.y       = self.two_Lable.bottom + SCREEN_WIDTH/19.73;
        
    }
    return _tipsImage2;
}

- (UIImageView *)tipsImage3 {
    
    if (_tipsImage3 == nil) {
        _tipsImage3 = [[UIImageView alloc] init];
        
        UIImage *img = [UIImage imageNamed:@"mm_获得佣金"];
        _tipsImage3.image = img;
        
        _tipsImage3.width  = img.size.width;
        _tipsImage3.height = img.size.height;
        _tipsImage3.centerX = self.three_Lable.centerX;
        _tipsImage3.y       = self.three_Lable.bottom + SCREEN_WIDTH/19.73;
        
    }
    return _tipsImage3;
}

- (UILabel *)tipsLable1 {
    
    if (_tipsLable1 == nil) {
        _tipsLable1 = [[UILabel alloc] init];
        _tipsLable1.width   = SCREEN_WIDTH/4.17;
        _tipsLable1.height  = SCREEN_WIDTH/31.25;
        _tipsLable1.centerX = self.tipsImage1.centerX;
        _tipsLable1.y = self.tipsImage1.bottom + SCREEN_WIDTH/46.875;
        
        _tipsLable1.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        _tipsLable1.numberOfLines = 0;
        _tipsLable1.textAlignment = NSTextAlignmentCenter;
        _tipsLable1.textColor = [UIColor colorWithHex:@"666666"];
        _tipsLable1.text = @"发布信息";
    }
    return _tipsLable1;
}

- (UILabel *)tipsLable2 {
    
    if (_tipsLable2 == nil) {
        _tipsLable2 = [[UILabel alloc] init];
        _tipsLable2.width = SCREEN_WIDTH/4.17;
        _tipsLable2.centerX = self.tipsImage2.centerX;
        _tipsLable2.y = self.tipsImage2.bottom + SCREEN_WIDTH/46.875;
        
        _tipsLable2.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        _tipsLable2.numberOfLines = 0;
        _tipsLable2.textAlignment = NSTextAlignmentCenter;
        _tipsLable2.textColor = [UIColor colorWithHex:@"666666"];
        _tipsLable2.text = @"其他会员购买您的信息";
        [_tipsLable2 sizeToFit];
    }
    return _tipsLable2;
}

- (UILabel *)tipsLable3 {
    
    if (_tipsLable3 == nil) {
        _tipsLable3 = [[UILabel alloc] init];
        _tipsLable3.width   = SCREEN_WIDTH/4.17;
        _tipsLable3.height  = SCREEN_WIDTH/31.25;
        _tipsLable3.centerX = self.tipsImage3.centerX;
        _tipsLable3.y = self.tipsImage3.bottom + SCREEN_WIDTH/46.875;
        
        _tipsLable3.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        _tipsLable3.numberOfLines = 0;
        _tipsLable3.textAlignment = NSTextAlignmentCenter;
        _tipsLable3.textColor = [UIColor colorWithHex:@"666666"];
        _tipsLable3.text = @"获得信息费";
    }
    return _tipsLable3;
}

- (UILabel *)detailLable {
    
    if (_detailLable == nil) {
        _detailLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/12.5,
                                                                 self.tipsLable2.bottom + SCREEN_WIDTH/15,
                                                                 SCREEN_WIDTH - SCREEN_WIDTH/6.25,
                                                                 0)];
        
        _detailLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78];
        _detailLable.numberOfLines = 0;
        _detailLable.textAlignment = NSTextAlignmentLeft;
        _detailLable.textColor = [UIColor colorWithHex:@"999999"];
        _detailLable.text = @"您在工作生活中，与朋友交往中，获得的大量信息对自己无用，却是别人的“主营业务”，这里为您解决商务信息闲置问题！您将信息提交给平台，平台系统自动生成信息交易价格，实现商务信息线上交易转让。";
        [UILabel changeLineSpaceForLabel:_detailLable WithSpace:5];
        [_detailLable sizeToFit];
    }
    return _detailLable;
}

/** 下一步 */
- (UIButton *)nextBtn {
    
    if (_nextBtn == nil) {
        _nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/18.75,
                                                              CGRectGetMaxY(self.detailLable.frame) + SCREEN_WIDTH/9.87,
                                                              SCREEN_WIDTH - SCREEN_WIDTH/9.375,
                                                              SCREEN_WIDTH/9.375)];
        [_nextBtn addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
        [_nextBtn.titleLabel setFont:[UIFont systemFontOfSize:SCREEN_WIDTH/26.78]];
        [_nextBtn setTitle:@"立即发布" forState:UIControlStateNormal];
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _nextBtn.layer.cornerRadius = 4;
        _nextBtn.layer.masksToBounds = YES;
        [_nextBtn setBackgroundImage:[toolClass imageWithColor:[UIColor colorWithHex:tonalColor] size:_nextBtn.frame.size] forState:UIControlStateNormal];
    }
    return _nextBtn;
}

- (UIButton *)callBtn {
    
    if (_callBtn == nil) {
        _callBtn = [[UIButton alloc] init];
        _callBtn.frame = CGRectMake((SCREEN_WIDTH - SCREEN_WIDTH/2.12)/2,
                                    self.mainScrollerView.bottom - SCREEN_WIDTH/18.75 - (SCREEN_WIDTH/2.12)/5.9 - 64,
                                    SCREEN_WIDTH/2.12,
                                    (SCREEN_WIDTH/2.12)/5.9);
        [_callBtn addTarget:self action:@selector(callAction) forControlEvents:UIControlEventTouchUpInside];
        [_callBtn setBackgroundImage:[toolClass imageWithColor:[UIColor whiteColor] size:_callBtn.frame.size]
                            forState:UIControlStateNormal];
        [_callBtn setBackgroundImage:[toolClass imageWithColor:[UIColor colorWithHex:backColor] size:_callBtn.frame.size]
                            forState:UIControlStateHighlighted];
        
        _callBtn.layer.borderWidth   = 0.5;
        _callBtn.layer.borderColor   = [UIColor colorWithHex:@"979797"].CGColor;
        _callBtn.layer.masksToBounds = YES;
        _callBtn.layer.cornerRadius  = (SCREEN_WIDTH/2.12)/11.8;
        [_callBtn setTitle:@"客服电话：400-831-9003" forState:UIControlStateNormal];
        [_callBtn.titleLabel setFont:[UIFont systemFontOfSize:SCREEN_WIDTH/31.25]];
        [_callBtn setTitleColor:[UIColor colorWithHex:@"979797"] forState:UIControlStateNormal];
    }
    return _callBtn;
}

#pragma mark - backConfig
//pop
- (void)popBackButton {
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    button.frame=CGRectMake(0, 0, 64, 64);
    [button addTarget:self action:@selector(popAction) forControlEvents:UIControlEventTouchUpInside];
    button.imageEdgeInsets = UIEdgeInsetsMake(0,-50, 0, 10);
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem=item;
}

- (void)popAction {
    [self.navigationController popViewControllerAnimated:YES];
}

//dismiss
- (void)dismissBackButton {
    
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 15, 64, 40);
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
    [button addTarget:self action:@selector(dismissAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)dismissAction {
    
    if ([_from isEqualToString:@"publish"]) {
        [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    } else if ([_from isEqualToString:@"business"]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
