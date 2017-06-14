//
//  BFGuideView.m
//  biufang
//
//  Created by 杜海龙 on 16/10/9.
//  Copyright © 2016年 biufang. All rights reserved.
//

#import "BFGuideView.h"

@interface BFGuideView ()

@property (nonatomic , strong) UIImageView *pageOneImageView;
@property (nonatomic , strong) UIImageView *pageOneTipImageView;
@property (nonatomic , strong) UIView      *pageOneBottmView;
@property (nonatomic , strong) UIImageView *pageOnePointImageView;
@property (nonatomic , strong) UIImageView *pageOneDownTipImageView;
@property (nonatomic , strong) UIButton    *pageOneBtn;

@property (nonatomic , strong) UIImageView *pageTwoImageView;
@property (nonatomic , strong) UIImageView *pageTwoTipImageView;
@property (nonatomic , strong) UIView      *pageTwoBottmView;
@property (nonatomic , strong) UIImageView *pageTwoPointImageView;
@property (nonatomic , strong) UIImageView *pageTwoDownImageView;
@property (nonatomic , strong) UIImageView *pageTwoDownTipImageView;
@property (nonatomic , strong) UIButton    *pageTwoBtn;



@property (nonatomic , strong) UIImageView *pageThreeImageView;
@property (nonatomic , strong) UIImageView *pageThreeTipImageView;
@property (nonatomic , strong) UIView      *pageThreeBottmView;
@property (nonatomic , strong) UIImageView *pageThreePointImageView;
@property (nonatomic , strong) UIImageView *pageThreeDownTipImageView;
@end

@implementation BFGuideView

-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        [self addPages];
    }
    return self;
}


//load pages
- (void)addPages{
    
    self.backgroundColor = [UIColor whiteColor];
    self.contentSize = CGSizeMake(3*SCREEN_WIDTH, SCREEN_HEIGHT);
    self.showsHorizontalScrollIndicator = NO;
    self.pagingEnabled = YES;
    self.alwaysBounceHorizontal = NO;
    self.alwaysBounceVertical = NO;
    
    
    /*************************************111111*******************************************************/
    UIView *onePageView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                   0,
                                                                   SCREEN_WIDTH,
                                                                   SCREEN_HEIGHT)];
    onePageView.backgroundColor = [UIColor whiteColor];
    [self addSubview:onePageView];
    
    self.pageOneImageView.image = [UIImage imageNamed:@"pageOneTipText"];
    [onePageView addSubview:self.pageOneImageView];
    
    self.pageOneTipImageView.image = [UIImage imageNamed:@"pageOneImage"];
    [onePageView addSubview:self.pageOneTipImageView];
    
    self.pageOneBottmView.backgroundColor = [UIColor colorWithHex:tonalColor];
    [onePageView addSubview:self.pageOneBottmView];
    
    self.pageOnePointImageView.image = [UIImage imageNamed:@"pageOnePoint"];
    [self.pageOneBottmView addSubview:self.pageOnePointImageView];
    
    
    self.pageOneDownTipImageView.image = [UIImage imageNamed:@"pageOneBottomText"];
    [self.pageOneBottmView addSubview:self.pageOneDownTipImageView];
    
    
    //btn
    [self.pageOneBtn setImage:[UIImage imageNamed:@"pageOneBtn"] forState:UIControlStateNormal];
    [self.pageOneBottmView addSubview:self.pageOneBtn];
    
    
    [self.pageOneBtn addTarget:self action:@selector(pageOneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    /*************************************222222*******************************************************/
    UIView *twoPageView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH,
                                                                   0,
                                                                   SCREEN_WIDTH,
                                                                   SCREEN_HEIGHT)];
    twoPageView.backgroundColor = [UIColor whiteColor];
    [self addSubview:twoPageView];
    
    self.pageTwoImageView.image = [UIImage imageNamed:@"pageTwoTipText"];
    [twoPageView addSubview:self.pageTwoImageView];
    
    self.pageTwoTipImageView.image = [UIImage imageNamed:@"pageTwoImage"];
    [twoPageView addSubview:self.pageTwoTipImageView];
    
    self.pageTwoBottmView.backgroundColor = [UIColor colorWithHex:tonalColor];
    [twoPageView addSubview:self.pageTwoBottmView];
    
    
    self.pageTwoDownImageView.image = [UIImage imageNamed:@"pageTwoPoint"];
    [self.pageTwoBottmView addSubview:self.pageTwoDownImageView];
    
    
    self.pageTwoDownTipImageView.image = [UIImage imageNamed:@"pageTwoBottomText"];
    [self.pageTwoBottmView addSubview:self.pageTwoDownTipImageView];

    
    //btn
    [self.pageTwoBtn setImage:[UIImage imageNamed:@"pageTwoBtn"] forState:UIControlStateNormal];
    [self.pageTwoBottmView addSubview:self.pageTwoBtn];
    
    
    [self.pageTwoBtn addTarget:self action:@selector(pageTwoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    /*************************************333333*******************************************************/
    UIView *threePageView = [[UIView alloc] initWithFrame:CGRectMake(2*SCREEN_WIDTH,
                                                                     0,
                                                                     SCREEN_WIDTH,
                                                                     SCREEN_HEIGHT)];
    threePageView.backgroundColor = [UIColor whiteColor];
    [self addSubview:threePageView];
    
    
    self.pageThreeImageView.image = [UIImage imageNamed:@"pageThreeTipImage"];
    [threePageView addSubview:self.pageThreeImageView];
    
    self.pageThreeTipImageView.image = [UIImage imageNamed:@"pageThreeImage"];
    [threePageView addSubview:self.pageThreeTipImageView];
    
    self.pageThreeBottmView.backgroundColor = [UIColor colorWithHex:tonalColor];
    [threePageView addSubview:self.pageThreeBottmView];
    
    self.pageThreePointImageView.image = [UIImage imageNamed:@"pageThreePoint"];
    [self.pageThreeBottmView addSubview:self.pageThreePointImageView];
    
    
    self.pageThreeDownTipImageView.image = [UIImage imageNamed:@"pageThreeBottomText"];
    [self.pageThreeBottmView addSubview:self.pageThreeDownTipImageView];
    
    
    //btn
    [self.startButton setImage:[UIImage imageNamed:@"pageThreeBtn"] forState:UIControlStateNormal];
    [self.pageThreeBottmView addSubview:self.startButton];
    
}


- (void)pageOneBtnClick{
    NSLog(@"one click");
    [UIView animateWithDuration:0.28 animations:^{
        self.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
    }];
}

- (void)pageTwoBtnClick{
    NSLog(@"two click");
    [UIView animateWithDuration:0.28 animations:^{
        self.contentOffset = CGPointMake(2*SCREEN_WIDTH, 0);
    }];
}



/*************************************111111*******************************************************/
//tip 624x166
-(UIImageView *)pageOneImageView{

    if (_pageOneImageView==nil) {
        _pageOneImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*312)/2,
                                                              SCREEN_WIDTH/375*52,
                                                              SCREEN_WIDTH/375*312,
                                                              SCREEN_WIDTH/375*83)];
    }
    return _pageOneImageView;
}
//image 664x430
-(UIImageView *)pageOneTipImageView{
    
    if (_pageOneTipImageView==nil) {
        _pageOneTipImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*332)/2,
                                                                 CGRectGetMaxY(self.pageOneImageView.frame)+SCREEN_WIDTH/375*57,
                                                                 SCREEN_WIDTH/375*332,
                                                                 SCREEN_WIDTH/375*215)];
    }
    return _pageOneTipImageView;
}

//point 94x18
-(UIView *)pageOneBottmView{
    
    if (_pageOneBottmView==nil) {
        _pageOneBottmView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                               SCREEN_HEIGHT-SCREEN_WIDTH/375*199,
                                                               SCREEN_WIDTH,
                                                               SCREEN_WIDTH/375*199)];
    }
    return _pageOneBottmView;
}

//point 94x18
-(UIImageView *)pageOnePointImageView{
    
    if (_pageOnePointImageView==nil) {
        _pageOnePointImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*47)/2,
                                                                   SCREEN_WIDTH/375*19,
                                                                   SCREEN_WIDTH/375*47,
                                                                   SCREEN_WIDTH/375*9)];
    }
    return _pageOnePointImageView;
}


//bottom tipm   628x46
-(UIImageView *)pageOneDownTipImageView{
    
    if (_pageOneDownTipImageView==nil) {
        _pageOneDownTipImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*314)/2,
                                                                     SCREEN_WIDTH/375*54,
                                                                     SCREEN_WIDTH/375*314,
                                                                     SCREEN_WIDTH/375*23)];
    }
    return _pageOneDownTipImageView;
}


//btn 1   346x96
-(UIButton *)pageOneBtn{
    
    if (_pageOneBtn==nil) {
        _pageOneBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*173)/2,
                                                             SCREEN_WIDTH/375*109,
                                                             SCREEN_WIDTH/375*173,
                                                             SCREEN_WIDTH/375*48)];
    }
    return _pageOneBtn;
}



/*************************************222222*******************************************************/
//tip 530x166
-(UIImageView *)pageTwoImageView{
    
    if (_pageTwoImageView==nil) {
        _pageTwoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*265)/2,
                                                                          SCREEN_WIDTH/375*52,
                                                                          SCREEN_WIDTH/375*265,
                                                                          SCREEN_WIDTH/375*83)];
    }
    return _pageTwoImageView;
}

//iamge 664x452
-(UIImageView *)pageTwoTipImageView{
    
    if (_pageTwoTipImageView==nil) {
        _pageTwoTipImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*332)/2,
                                                             CGRectGetMaxY(self.pageTwoImageView.frame)+SCREEN_WIDTH/375*57,
                                                             SCREEN_WIDTH/375*332,
                                                             SCREEN_WIDTH/375*226)];
    }
    return _pageTwoTipImageView;
}


//point 94x18
-(UIView *)pageTwoBottmView{
    
    if (_pageTwoBottmView==nil) {
        _pageTwoBottmView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                     SCREEN_HEIGHT-SCREEN_WIDTH/375*199,
                                                                     SCREEN_WIDTH,
                                                                     SCREEN_WIDTH/375*199)];
    }
    return _pageTwoBottmView;
}


//point 94x18
-(UIImageView *)pageTwoDownImageView{
    
    if (_pageTwoDownImageView==nil) {
        _pageTwoDownImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*47)/2,
                                                                              SCREEN_WIDTH/375*19,
                                                                              SCREEN_WIDTH/375*47,
                                                                              SCREEN_WIDTH/375*9)];
    }
    return _pageTwoDownImageView;
}

//bottom tip 592x48
-(UIImageView *)pageTwoDownTipImageView{
    
    if (_pageTwoDownTipImageView==nil) {
        _pageTwoDownTipImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*296)/2,
                                                                                 SCREEN_WIDTH/375*52,
                                                                                 SCREEN_WIDTH/375*296,
                                                                                 SCREEN_WIDTH/375*24)];
    }
    return _pageTwoDownTipImageView;
}


//btn 1   346x96
-(UIButton *)pageTwoBtn{
    
    if (_pageTwoBtn==nil) {
        _pageTwoBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*173)/2,
                                                                 SCREEN_WIDTH/375*109,
                                                                 SCREEN_WIDTH/375*173,
                                                                 SCREEN_WIDTH/375*48)];
    }
    return _pageTwoBtn;
}



/*************************************333333*******************************************************/
//tip 418 134
-(UIImageView *)pageThreeImageView{
    
    if (_pageThreeImageView==nil) {
        _pageThreeImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*209)/2,
                                                                            SCREEN_WIDTH/375*61,
                                                                            SCREEN_WIDTH/375*209,
                                                                            SCREEN_WIDTH/375*67)];
    }
    return _pageThreeImageView;
}
//iamge 664x492
-(UIImageView *)pageThreeTipImageView{
    
    if (_pageThreeTipImageView==nil) {
        _pageThreeTipImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*332)/2,
                                                                   CGRectGetMaxY(self.pageThreeImageView.frame)+SCREEN_WIDTH/375*43,
                                                                   SCREEN_WIDTH/375*332,
                                                                   SCREEN_WIDTH/375*246)];
    }
    return _pageThreeTipImageView;
}



//point 94x18
-(UIView *)pageThreeBottmView{
    
    if (_pageThreeBottmView==nil) {
        _pageThreeBottmView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                     SCREEN_HEIGHT-SCREEN_WIDTH/375*199,
                                                                     SCREEN_WIDTH,
                                                                     SCREEN_WIDTH/375*199)];
    }
    return _pageThreeBottmView;
}


//point 94x18
-(UIImageView *)pageThreePointImageView{
    
    if (_pageThreePointImageView==nil) {
        _pageThreePointImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*47)/2,
                                                                              SCREEN_WIDTH/375*19,
                                                                              SCREEN_WIDTH/375*47,
                                                                              SCREEN_WIDTH/375*9)];
    }
    return _pageThreePointImageView;
}

//bottom tip 304x48
-(UIImageView *)pageThreeDownTipImageView{
    
    if (_pageThreeDownTipImageView==nil) {
        _pageThreeDownTipImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*152)/2,
                                                                                 SCREEN_WIDTH/375*52,
                                                                                 SCREEN_WIDTH/375*152,
                                                                                 SCREEN_WIDTH/375*24)];
    }
    return _pageThreeDownTipImageView;
}


//btn 1   346x96
-(UIButton *)startButton{
    
    if (_startButton==nil) {
        _startButton = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*173)/2,
                                                                 SCREEN_WIDTH/375*109,
                                                                 SCREEN_WIDTH/375*173,
                                                                 SCREEN_WIDTH/375*48)];
    }
    return _startButton;
}


@end
