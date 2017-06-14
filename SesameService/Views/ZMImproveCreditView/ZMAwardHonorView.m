//
//  ZMAwardHonorView.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/30.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMAwardHonorView.h"

@interface ZMAwardHonorView ()

@end

@implementation ZMAwardHonorView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    
    
    
    self.backgroundColor                     = [UIColor colorWithHex:backGroundColor];
    self.awardHonorTableView.backgroundColor = [UIColor colorWithHex:backGroundColor];
    self.awardHonorTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    self.awardHonorTableView.showsVerticalScrollIndicator = NO;
    [self addSubview:self.awardHonorTableView];
    
    
    
    self.topView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.topView];
    
    
    [self.topView addSubview:self.cancleBtn];
    [self.topView addSubview:self.sureBtn];
    
    self.cancleBtn.backgroundColor= [UIColor whiteColor];
    self.sureBtn.backgroundColor  = [UIColor whiteColor];
    
    self.myDatePicker.backgroundColor = [UIColor whiteColor];
    [self.topView addSubview:self.myDatePicker];
    
    
    [self setButton:self.cancleBtn
              title:@"取消"
              color:[UIColor blueColor]
               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    [self setButton:self.sureBtn
              title:@"确定"
              color:[UIColor blueColor]
               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
}


- (void)setButton:(UIButton *)button title:(NSString *)title color:(UIColor *)textColor font:(UIFont *)textFond{
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    button.titleLabel.font    = textFond;

}


-(UIView *)topView{
    if (_topView==nil) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                               SCREEN_HEIGHT,
                                               SCREEN_WIDTH,
                                               SCREEN_WIDTH/375*200+SCREEN_WIDTH/375*25)];
    }
    return _topView;
}

-(UIButton *)cancleBtn{
    if (_cancleBtn==nil) {
        _cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,
                                                            0,
                                                            SCREEN_WIDTH/375*80,
                                                            SCREEN_WIDTH/375*25)];
    }
    return _cancleBtn;
}

-(UIButton *)sureBtn{
    if (_sureBtn==nil) {
        _sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*80,
                                                            0,
                                                            SCREEN_WIDTH/375*80,
                                                            SCREEN_WIDTH/375*25)];
    }
    return _sureBtn;
}



-(UIDatePicker *)myDatePicker{
    if (_myDatePicker==nil) {
        _myDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0,
                                                       SCREEN_WIDTH/375*25,
                                                       SCREEN_WIDTH,
                                                       SCREEN_WIDTH/375*200)];
        //_myDatePicker.minimumDate= [NSDate dateWithTimeInterval:-6*24*60*60 sinceDate:[NSDate date]];//7agao
        _myDatePicker.maximumDate= [NSDate date];//today
    }
    return _myDatePicker;
}

-(UITableView *)awardHonorTableView{
    
    if (_awardHonorTableView==nil) {
        _awardHonorTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                             64,
                                                                             SCREEN_WIDTH,
                                                                             SCREEN_HEIGHT-64)];
    }
    return _awardHonorTableView;
}

@end
