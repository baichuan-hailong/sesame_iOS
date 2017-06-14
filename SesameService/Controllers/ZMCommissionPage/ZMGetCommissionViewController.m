//
//  ZMGetCommissionViewController.m
//  SesameService
//
//  Created by 娄耀文 on 17/4/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMGetCommissionViewController.h"
#import "ZMCommissionPublishViewController.h"

@interface ZMGetCommissionViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *mainScrollerView;

/** topView */
@property (nonatomic, strong) UIView        *topView;
@property (nonatomic, strong) UIScrollView  *menuScrollerView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIImageView   *backImage;
@property (nonatomic, strong) UIButton      *tipsBtn;
@property (nonatomic, strong) UIButton      *btn1;
@property (nonatomic, strong) UIButton      *btn2;
@property (nonatomic, strong) UIButton      *btn3;
@property (nonatomic, strong) UIButton      *btn4;
@property (nonatomic, strong) UIButton      *btn5;

/** footView */
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
@property (nonatomic, strong) UIButton     *callBtn;

@end

@implementation ZMGetCommissionViewController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithHex:backColor];
    self.title = @"赚佣金";
    
    if (_isFromHome) {
        [self popBackButton];
    } else {
        [self dismissBackButton];
    }
    
    [self.view addSubview:self.mainScrollerView];
    
    /** topView */
    [self.mainScrollerView addSubview:self.topView];
    [self.topView addSubview:self.backImage];
    [self.topView addSubview:self.menuScrollerView];
    [self.topView addSubview:self.pageControl];
    //[self.topView addSubview:self.tipsBtn];
    [self.menuScrollerView addSubview:self.btn1];
    [self.menuScrollerView addSubview:self.btn2];
    [self.menuScrollerView addSubview:self.btn3];
    [self.menuScrollerView addSubview:self.btn4];
    [self.menuScrollerView addSubview:self.btn5];
    
    
    /** footView */
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
    [self.mainScrollerView addSubview:self.callBtn];
    
    self.mainScrollerView.contentSize = CGSizeMake(SCREEN_WIDTH, self.callBtn.bottom + 20);
    
    //通知监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissAction) name:@"backToHome" object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

#pragma mark - customMethod
- (void)meneBtnAction:(UIButton *)sender {
    
    NSLog(@"menuBtn %ld",sender.tag);
    
    ZMCommissionPublishViewController *publishView = [[ZMCommissionPublishViewController alloc] init];
    [self.navigationController pushViewController:publishView animated:YES];
}

- (void)callAction {
    
    NSLog(@"拨打电话");
    NSMutableString* str = [[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"400-8319-003"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

- (void)moreAction {
    
    NSLog(@"更多");
    ZMCommissionPublishViewController *publishView = [[ZMCommissionPublishViewController alloc] init];
    [self.navigationController pushViewController:publishView animated:YES];
}


#pragma mark - getter
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

- (UIView *)topView {
    
    if (_topView == nil) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/1.03)];
    }
    return _topView;
}

- (UIImageView *)backImage {
    
    if (_backImage == nil) {
        _backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/1.03)];
        _backImage.image = [UIImage imageNamed:@"mm_赚佣金背景"];
    }
    return _backImage;
}

- (UIScrollView *)menuScrollerView {
    
    if (_menuScrollerView == nil) {
        _menuScrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                                           SCREEN_WIDTH/3.55,
                                                                           SCREEN_WIDTH,
                                                                           SCREEN_WIDTH/1.72)];
        _menuScrollerView.showsVerticalScrollIndicator   = FALSE;
        _menuScrollerView.showsHorizontalScrollIndicator = FALSE;
        _menuScrollerView.contentSize = CGSizeMake(SCREEN_WIDTH * 2, SCREEN_WIDTH/1.72);
        _menuScrollerView.pagingEnabled = YES;
        _menuScrollerView.delegate = self;
    }
    return _menuScrollerView;
}

- (UIPageControl *)pageControl {

    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.frame = CGRectMake((SCREEN_WIDTH - 50)/2,
                                        self.menuScrollerView.bottom + SCREEN_WIDTH/37.5,
                                        50,
                                        20);//指定位置大小
        _pageControl.numberOfPages = 2;//指定页面个数
        _pageControl.currentPage = 0; //指定pagecontroll的值，默认选中的小白点（第一个）
        //添加委托方法，当点击小白点就执行此方法
        
        //_pageControl.pageIndicatorTintColor = [UIColor whiteColor];       // 设置非选中页的圆点颜色
        //_pageControl.currentPageIndicatorTintColor = [UIColor colorWithHex:tonalColor]; // 设置选中页的圆点颜色
    }
    return _pageControl;
}



- (UIButton *)btn1 {
    
    if (_btn1 == nil) {
        _btn1 = [[UIButton alloc] initWithFrame:CGRectMake(self.menuScrollerView.centerX - SCREEN_WIDTH/2.5 - SCREEN_WIDTH/37.5,
                                                           0,
                                                           SCREEN_WIDTH/2.5,
                                                           (SCREEN_WIDTH/2.5)/1.5)];
        _btn1.tag = 1;
        [_btn1 addTarget:self action:@selector(meneBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _btn1.backgroundColor     = [UIColor whiteColor];
        _btn1.layer.cornerRadius  = 4;
        _btn1.layer.shadowColor   = [UIColor blackColor].CGColor;
        _btn1.layer.shadowOpacity = 0.6f;
        _btn1.layer.shadowRadius  = 4.f;
        _btn1.layer.shadowOffset  = CGSizeMake(1.6,1.6);
        
        UIImage *img = [UIImage imageNamed:@"mm_土地信息"];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((_btn1.width - img.size.width)/2,
                                                                             SCREEN_WIDTH/37.5,
                                                                             img.size.width,
                                                                             img.size.height)];
        imgView.image = img;
        [_btn1 addSubview:imgView];
        
        UILabel *tips1 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/26.78,
                                                                   imgView.bottom + SCREEN_WIDTH/37.5,
                                                                   _btn1.width - (SCREEN_WIDTH/26.78)*2,
                                                                   SCREEN_WIDTH/26.78)];
        tips1.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78];
        tips1.numberOfLines = 0;
        tips1.textAlignment = NSTextAlignmentCenter;
        tips1.textColor = [UIColor colorWithHex:@"666666"];
        tips1.text = @"有土地信息或资金,找下家";
        [tips1 sizeToFit];
        tips1.frame = CGRectMake(SCREEN_WIDTH/26.78,
                                 imgView.bottom + SCREEN_WIDTH/37.5,
                                 _btn1.width - (SCREEN_WIDTH/26.78) * 2,
                                 tips1.frame.size.height);
        [_btn1 addSubview:tips1];
    }
    return _btn1;
}

- (UIButton *)btn2 {
    
    if (_btn2 == nil) {
        _btn2 = [[UIButton alloc] initWithFrame:CGRectMake(self.menuScrollerView.centerX + SCREEN_WIDTH/37.5,
                                                           0,
                                                           SCREEN_WIDTH/2.5,
                                                           (SCREEN_WIDTH/2.5)/1.5)];
        _btn2.tag = 2;
        [_btn2 addTarget:self action:@selector(meneBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _btn2.backgroundColor     = [UIColor whiteColor];
        _btn2.layer.cornerRadius  = 4;
        _btn2.layer.shadowColor   = [UIColor blackColor].CGColor;
        _btn2.layer.shadowOpacity = 0.6f;
        _btn2.layer.shadowRadius  = 4.f;
        _btn2.layer.shadowOffset  = CGSizeMake(1.6,1.6);
        
        UIImage *img = [UIImage imageNamed:@"mm_资金"];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((_btn2.width - img.size.width)/2,
                                                                             SCREEN_WIDTH/37.5,
                                                                             img.size.width,
                                                                             img.size.height)];
        imgView.image = img;
        [_btn2 addSubview:imgView];
        
        UILabel *tips1 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/26.78,
                                                                   imgView.bottom + SCREEN_WIDTH/37.5,
                                                                   _btn2.width - (SCREEN_WIDTH/26.78)*2,
                                                                   SCREEN_WIDTH/26.78)];
        tips1.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78];
        tips1.numberOfLines = 0;
        tips1.textAlignment = NSTextAlignmentCenter;
        tips1.textColor = [UIColor colorWithHex:@"666666"];
        tips1.text = @"有建筑采购信息,找供应商";
        [tips1 sizeToFit];
        [_btn2 addSubview:tips1];
    }
    return _btn2;
}

- (UIButton *)btn3 {
    
    if (_btn3 == nil) {
        _btn3 = [[UIButton alloc] initWithFrame:CGRectMake(self.menuScrollerView.centerX - SCREEN_WIDTH/2.5 - SCREEN_WIDTH/37.5,
                                                           self.menuScrollerView.height - (SCREEN_WIDTH/2.5)/1.5,
                                                           SCREEN_WIDTH/2.5,
                                                           (SCREEN_WIDTH/2.5)/1.5)];
        _btn3.tag = 3;
        [_btn3 addTarget:self action:@selector(meneBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _btn3.backgroundColor     = [UIColor whiteColor];
        _btn3.layer.cornerRadius  = 4;
        _btn3.layer.shadowColor   = [UIColor blackColor].CGColor;
        _btn3.layer.shadowOpacity = 0.6f;
        _btn3.layer.shadowRadius  = 4.f;
        _btn3.layer.shadowOffset  = CGSizeMake(1.6,1.6);
        
        UIImage *img = [UIImage imageNamed:@"mm_建筑设计"];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((_btn3.width - img.size.width)/2,
                                                                             SCREEN_WIDTH/37.5,
                                                                             img.size.width,
                                                                             img.size.height)];
        imgView.image = img;
        [_btn3 addSubview:imgView];
        
        UILabel *tips1 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/26.78,
                                                                   imgView.bottom + SCREEN_WIDTH/37.5,
                                                                   _btn3.width - (SCREEN_WIDTH/26.78)*2,
                                                                   SCREEN_WIDTH/26.78)];
        tips1.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78];
        tips1.numberOfLines = 0;
        tips1.textAlignment = NSTextAlignmentCenter;
        tips1.textColor = [UIColor colorWithHex:@"666666"];
        tips1.text = @"有项目信息,找建筑设计";
        [tips1 sizeToFit];
        [_btn3 addSubview:tips1];
    }
    return _btn3;
}

- (UIButton *)btn4 {
    
    if (_btn4 == nil) {
        _btn4 = [[UIButton alloc] initWithFrame:CGRectMake(self.menuScrollerView.centerX + SCREEN_WIDTH/37.5,
                                                           self.menuScrollerView.height - (SCREEN_WIDTH/2.5)/1.5,
                                                           SCREEN_WIDTH/2.5,
                                                           (SCREEN_WIDTH/2.5)/1.5)];
        _btn4.tag = 4;
        [_btn4 addTarget:self action:@selector(meneBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _btn4.backgroundColor     = [UIColor whiteColor];
        _btn4.layer.cornerRadius  = 4;
        _btn4.layer.shadowColor   = [UIColor blackColor].CGColor;
        _btn4.layer.shadowOpacity = 0.6f;
        _btn4.layer.shadowRadius  = 4.f;
        _btn4.layer.shadowOffset  = CGSizeMake(1.6,1.6);
        
        UIImage *img = [UIImage imageNamed:@"mm_楼盘营销"];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((_btn4.width - img.size.width)/2,
                                                                             SCREEN_WIDTH/37.5,
                                                                             img.size.width,
                                                                             img.size.height)];
        imgView.image = img;
        [_btn4 addSubview:imgView];
        
        UILabel *tips1 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/26.78,
                                                                   imgView.bottom + SCREEN_WIDTH/37.5,
                                                                   _btn4.width - (SCREEN_WIDTH/26.78)*2,
                                                                   SCREEN_WIDTH/26.78)];
        tips1.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78];
        tips1.numberOfLines = 0;
        tips1.textAlignment = NSTextAlignmentCenter;
        tips1.textColor = [UIColor colorWithHex:@"666666"];
        tips1.text = @"有楼盘营销推广业务,找代理机构";
        [tips1 sizeToFit];
        [_btn4 addSubview:tips1];
    }
    return _btn4;
}

- (UIButton *)btn5 {
    
    if (_btn5 == nil) {
        _btn5 = [[UIButton alloc] initWithFrame:CGRectMake(self.menuScrollerView.centerX - SCREEN_WIDTH/2.5 - SCREEN_WIDTH/37.5 + SCREEN_WIDTH,
                                                           0,
                                                           SCREEN_WIDTH/2.5,
                                                           (SCREEN_WIDTH/2.5)/1.5)];
        _btn5.tag = 5;
        [_btn5 addTarget:self action:@selector(meneBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _btn5.backgroundColor     = [UIColor whiteColor];
        _btn5.layer.cornerRadius  = 4;
        _btn5.layer.shadowColor   = [UIColor blackColor].CGColor;
        _btn5.layer.shadowOpacity = 0.6f;
        _btn5.layer.shadowRadius  = 4.f;
        _btn5.layer.shadowOffset  = CGSizeMake(1.6,1.6);
        
        UIImage *img = [UIImage imageNamed:@"mm_更多信息"];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((_btn5.width - img.size.width)/2,
                                                                             SCREEN_WIDTH/37.5,
                                                                             img.size.width,
                                                                             img.size.height)];
        imgView.image = img;
        [_btn5 addSubview:imgView];
        
        UILabel *tips1 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/26.78,
                                                                   imgView.bottom + SCREEN_WIDTH/37.5,
                                                                   _btn5.width - (SCREEN_WIDTH/26.78)*2,
                                                                   SCREEN_WIDTH/26.78)];
        tips1.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78];
        tips1.numberOfLines = 0;
        tips1.textAlignment = NSTextAlignmentCenter;
        tips1.textColor = [UIColor colorWithHex:@"666666"];
        tips1.text = @"其他信息,找下家承接";
        [tips1 sizeToFit];
        tips1.frame = CGRectMake(SCREEN_WIDTH/26.78,
                                 imgView.bottom + SCREEN_WIDTH/37.5,
                                 _btn5.width - (SCREEN_WIDTH/26.78) * 2,
                                 tips1.frame.size.height);
        [_btn5 addSubview:tips1];
    }
    return _btn5;
}





- (UIButton *)tipsBtn {
    
    if (_tipsBtn == nil) {
        _tipsBtn = [[UIButton alloc] init];
        _tipsBtn.frame = CGRectMake((SCREEN_WIDTH - SCREEN_WIDTH/2)/2,
                                    self.menuScrollerView.top - 20 - SCREEN_WIDTH/18.75,
                                    SCREEN_WIDTH/2,
                                    20);
        [_tipsBtn addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchUpInside];
        
        [_tipsBtn setTitle:@"更多房地产业务 >" forState:UIControlStateNormal];
        [_tipsBtn.titleLabel setFont:[UIFont systemFontOfSize:SCREEN_WIDTH/26.78]];
        [_tipsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _tipsBtn;
}


/** footView */
- (UILabel *)titleLable {
    
    if (_titleLable == nil) {
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                self.topView.bottom + SCREEN_WIDTH/15,
                                                                SCREEN_WIDTH,
                                                                SCREEN_WIDTH/20.83)];
        _titleLable.font = [UIFont boldSystemFontOfSize:SCREEN_WIDTH/20.83];
        _titleLable.text = @"撮合业务签单，赚取佣金";
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
        
        UIImage *img = [UIImage imageNamed:@"mm_签署协议"];
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
        _tipsLable1.width = SCREEN_WIDTH/4.17;
        _tipsLable1.centerX = self.tipsImage1.centerX;
        _tipsLable1.y = self.tipsImage1.bottom + SCREEN_WIDTH/46.875;
        _tipsLable1.height = SCREEN_WIDTH/31.25;
        
        _tipsLable1.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        _tipsLable1.textAlignment = NSTextAlignmentCenter;
        _tipsLable1.textColor = [UIColor colorWithHex:@"666666"];
        _tipsLable1.text = @"提交信息";
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
        _tipsLable2.text = @"平台匹配优质企业签署居间协议";
        [_tipsLable2 sizeToFit];
    }
    return _tipsLable2;
}

- (UILabel *)tipsLable3 {
    
    if (_tipsLable3 == nil) {
        _tipsLable3 = [[UILabel alloc] init];
        _tipsLable3.width = SCREEN_WIDTH/4.17;
        _tipsLable3.centerX = self.tipsImage3.centerX;
        _tipsLable3.y = self.tipsImage3.bottom + SCREEN_WIDTH/46.875;
        
        _tipsLable3.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        _tipsLable3.numberOfLines = 0;
        _tipsLable3.textAlignment = NSTextAlignmentCenter;
        _tipsLable3.textColor = [UIColor colorWithHex:@"666666"];
        _tipsLable3.text = @"撮合业务签单获得佣金";
        [_tipsLable3 sizeToFit];
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
        _detailLable.textColor = [UIColor colorWithHex:@"888888"];
        _detailLable.text = @"会员提交信息，平台自动对接合格第三方接单，平台作为丙方参与以提供双方保障，平台开具合适发票，成交后用户获得佣金报酬。您有优质信息寻求接单方，您的关系到位，您不满足于卖信息而希望挣佣金，但陌生人相互不信任，熟人之间不好谈钱。这里解决对口资源有限，熟人之间不好谈钱的问题。";
        [UILabel changeLineSpaceForLabel:_detailLable WithSpace:5];
        [_detailLable sizeToFit];
    }
    return _detailLable;
}

- (UIButton *)callBtn {
    
    if (_callBtn == nil) {
        _callBtn = [[UIButton alloc] init];
        _callBtn.frame = CGRectMake((SCREEN_WIDTH - SCREEN_WIDTH/2.12)/2,
                                    self.detailLable.bottom + SCREEN_WIDTH/18.75,
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


#pragma mark - scrollerView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    //更新UIPageControl的当前页
    if (scrollView == self.menuScrollerView) {
        self.pageControl.currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
    }
}


#pragma mark - backConfig
//pop
- (void)popBackButton {
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 64, 64);
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
    [button addTarget:self action:@selector(dismissAction) forControlEvents:UIControlEventTouchUpInside];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)dismissAction {
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
