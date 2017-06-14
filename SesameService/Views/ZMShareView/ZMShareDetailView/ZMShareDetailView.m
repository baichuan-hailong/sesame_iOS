//
//  ZMShareDetailView.m
//  SesameService
//
//  Created by 娄耀文 on 17/3/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMShareDetailView.h"

@implementation ZMShareDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.detailTableView];
    [self addSubview:self.footView];
    [self.footView addSubview:self.serviceBtn];
    [self.footView addSubview:self.buyBtn];
    [self.footView addSubview:self.priceLable];

}

#pragma mark - getter
- (UITableView *)detailTableView {
    
    if (_detailTableView == nil) {
        _detailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                         64,
                                                                         SCREEN_WIDTH,
                                                                         SCREEN_HEIGHT - 64)
                                                style:UITableViewStyleGrouped];

        _detailTableView.backgroundColor = [UIColor colorWithHex:backColor];
        _detailTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _detailTableView.contentInset = UIEdgeInsetsMake(0, 0, SCREEN_WIDTH/6.25, 0);
        _detailTableView.showsVerticalScrollIndicator = NO;
    }
    return _detailTableView;
}


- (UIView *)footView {

    if (_footView == nil) {
        _footView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                             SCREEN_HEIGHT - SCREEN_WIDTH/7.65,
                                                             SCREEN_WIDTH,
                                                             SCREEN_WIDTH/7.65)];
        _footView.backgroundColor = [UIColor whiteColor];
        _footView.clipsToBounds = NO;
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = [UIColor colorWithHex:@"bbbbbb"];
        [_footView addSubview:line];
    }
    return _footView;
}

- (UIButton *)serviceBtn {
    
    if (_serviceBtn == nil) {
        _serviceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _serviceBtn.tag = 6;
        _serviceBtn.frame = CGRectMake(0,
                                       0.5,
                                       SCREEN_WIDTH/7.08,
                                       self.footView.height);
        _serviceBtn.backgroundColor = [UIColor whiteColor];
        
        UIImage *img = [UIImage imageNamed:@"share_service"];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((_serviceBtn.frame.size.width - img.size.width)/2,
                                                                             SCREEN_WIDTH/53.57,
                                                                             img.size.width,
                                                                             img.size.height)];
        imgView.image = img;
        
        
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                        imgView.bottom + SCREEN_WIDTH/75,
                                                                        _serviceBtn.width,
                                                                        SCREEN_WIDTH/37.5)];
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/37.5];
        titleLable.textColor = [UIColor colorWithHex:@"999999"];
        titleLable.text = @"客服";
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(_serviceBtn.width - 0.5,
                                                                0,
                                                                0.5,
                                                                _serviceBtn.height)];
        line.backgroundColor = [UIColor colorWithHex:@"d2d2d2"];
        
        [_serviceBtn addSubview:imgView];
        [_serviceBtn addSubview:titleLable];
        [_serviceBtn addSubview:line];
    }
    return _serviceBtn;
}

- (UIButton *)buyBtn {
    
    if (_buyBtn == nil) {
        _buyBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - SCREEN_WIDTH/3.23,
                                                             0,
                                                             SCREEN_WIDTH/3.23 + 2,
                                                             self.footView.height + 2)];
        [_buyBtn setBackgroundImage:[toolClass imageWithColor:[UIColor colorWithHex:tonalColor] size:_buyBtn.frame.size] forState:UIControlStateNormal];
        [_buyBtn setTitle:@"立即买走" forState:UIControlStateNormal];
        [_buyBtn.titleLabel setFont:[UIFont systemFontOfSize:SCREEN_WIDTH/26.78]];
        [_buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _buyBtn;
}

- (UILabel *)priceLable {

    if (_priceLable == nil) {
        _priceLable = [[UILabel alloc] initWithFrame:CGRectMake(self.buyBtn.left - 200 - SCREEN_WIDTH/18.75,
                                                               (self.footView.height - SCREEN_WIDTH/20.83)/2,
                                                                200,
                                                                SCREEN_WIDTH/20.83)];
        _priceLable.font = [UIFont fontWithName:@"Futura-MediumItalic" size:SCREEN_WIDTH/20.83];
        _priceLable.textColor = [UIColor colorWithHex:@"151515"];
        _priceLable.textAlignment = NSTextAlignmentRight;
    }
    return _priceLable;
}






@end
