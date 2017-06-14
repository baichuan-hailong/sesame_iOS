//
//  homeMenuBtnCell.m
//  SesameService
//
//  Created by 娄耀文 on 17/3/22.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "homeMenuBtnCell.h"

@implementation homeMenuBtnCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithHex:backColor];
        [self.contentView addSubview:self.backView];
        
        [self.backView addSubview:self.infoMoneyBtn];
        [self.backView addSubview:self.commissionBtn];
        [self.backView addSubview:self.marketingBtn];
        [self.backView addSubview:self.findBtn];
        [self.backView addSubview:self.guideBtn];
        [self.backView addSubview:self.serviceBtn];
        
    }
    return self;
}

- (UIView *)backView {
    
    if (_backView == nil) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/2.25)];
        _backView.backgroundColor = [UIColor whiteColor];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, _backView.height - 0.5, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = [UIColor colorWithHex:@"dddddd"];
        [_backView addSubview:line];
    }
    return _backView;
}

- (UIButton *)infoMoneyBtn {
    
    if (_infoMoneyBtn == nil) {
        _infoMoneyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _infoMoneyBtn.tag = 1;
        _infoMoneyBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH/3, self.backView.frame.size.height/2);
        _infoMoneyBtn.backgroundColor = [UIColor whiteColor];

        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((_infoMoneyBtn.frame.size.width - SCREEN_WIDTH/9.357)/2,
                                                                             SCREEN_WIDTH/25,
                                                                             SCREEN_WIDTH/9.357,
                                                                             SCREEN_WIDTH/9.357)];
        imgView.image = [UIImage imageNamed:@"home_赚信息费"];
        
        
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                        CGRectGetMaxY(imgView.frame) + SCREEN_WIDTH/75,
                                                                        SCREEN_WIDTH/3,
                                                                        SCREEN_WIDTH/31.25)];
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        titleLable.textColor = [UIColor colorWithHex:@"353846"];
        titleLable.text = @"赚信息费";
        
        [_infoMoneyBtn addSubview:imgView];
        [_infoMoneyBtn addSubview:titleLable];
    }
    return _infoMoneyBtn;
}


- (UIButton *)commissionBtn {
    
    if (_commissionBtn == nil) {
        _commissionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _commissionBtn.tag = 2;
        _commissionBtn.frame = CGRectMake(CGRectGetMaxX(self.infoMoneyBtn.frame), 0, SCREEN_WIDTH/3, self.backView.frame.size.height/2);
        _commissionBtn.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((_commissionBtn.frame.size.width - SCREEN_WIDTH/9.357)/2,
                                                                             SCREEN_WIDTH/25,
                                                                             SCREEN_WIDTH/9.357,
                                                                             SCREEN_WIDTH/9.357)];
        imgView.image = [UIImage imageNamed:@"home_赚佣金"];
        
        
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                        CGRectGetMaxY(imgView.frame) + SCREEN_WIDTH/75,
                                                                        SCREEN_WIDTH/3,
                                                                        SCREEN_WIDTH/31.25)];
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        titleLable.textColor = [UIColor colorWithHex:@"353846"];
        titleLable.text = @"赚佣金";
        
        [_commissionBtn addSubview:imgView];
        [_commissionBtn addSubview:titleLable];
    }
    return _commissionBtn;
}


- (UIButton *)marketingBtn {
    
    if (_marketingBtn == nil) {
        _marketingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _marketingBtn.tag = 3;
        _marketingBtn.frame = CGRectMake(CGRectGetMaxX(self.commissionBtn.frame), 0, SCREEN_WIDTH/3, self.backView.frame.size.height/2);
        _marketingBtn.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((_marketingBtn.frame.size.width - SCREEN_WIDTH/9.357)/2,
                                                                             SCREEN_WIDTH/25,
                                                                             SCREEN_WIDTH/9.357,
                                                                             SCREEN_WIDTH/9.357)];
        imgView.image = [UIImage imageNamed:@"home_赚推介费"];
        
        
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                        CGRectGetMaxY(imgView.frame) + SCREEN_WIDTH/75,
                                                                        SCREEN_WIDTH/3,
                                                                        SCREEN_WIDTH/31.25)];
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        titleLable.textColor = [UIColor colorWithHex:@"353846"];
        titleLable.text = @"赚推介费";
        
        [_marketingBtn addSubview:imgView];
        [_marketingBtn addSubview:titleLable];
    }
    return _marketingBtn;
}

- (UIButton *)findBtn {
    
    if (_findBtn == nil) {
        _findBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _findBtn.tag = 4;
        _findBtn.frame = CGRectMake(0, CGRectGetMaxY(self.infoMoneyBtn.frame) - SCREEN_WIDTH/75, SCREEN_WIDTH/3, self.backView.frame.size.height/2);
        _findBtn.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((_findBtn.frame.size.width - SCREEN_WIDTH/9.357)/2,
                                                                             SCREEN_WIDTH/25,
                                                                             SCREEN_WIDTH/9.357,
                                                                             SCREEN_WIDTH/9.357)];
        imgView.image = [UIImage imageNamed:@"home_包打听"];
        
        
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                        CGRectGetMaxY(imgView.frame) + SCREEN_WIDTH/75,
                                                                        SCREEN_WIDTH/3,
                                                                        SCREEN_WIDTH/31.25)];
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        titleLable.textColor = [UIColor colorWithHex:@"353846"];
        titleLable.text = @"包打听";
        
        [_findBtn addSubview:imgView];
        [_findBtn addSubview:titleLable];
    }
    return _findBtn;
}

- (UIButton *)guideBtn {
    
    if (_guideBtn == nil) {
        _guideBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _guideBtn.tag = 5;
        _guideBtn.frame = CGRectMake(CGRectGetMaxX(self.findBtn.frame), CGRectGetMaxY(self.infoMoneyBtn.frame) - SCREEN_WIDTH/75, SCREEN_WIDTH/3, self.backView.frame.size.height/2);
        _guideBtn.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((_guideBtn.frame.size.width - SCREEN_WIDTH/9.357)/2,
                                                                             SCREEN_WIDTH/25,
                                                                             SCREEN_WIDTH/9.357,
                                                                             SCREEN_WIDTH/9.357)];
        imgView.image = [UIImage imageNamed:@"home_新手指南"];
        
        
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                        CGRectGetMaxY(imgView.frame) + SCREEN_WIDTH/75,
                                                                        SCREEN_WIDTH/3,
                                                                        SCREEN_WIDTH/31.25)];
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        titleLable.textColor = [UIColor colorWithHex:@"353846"];
        titleLable.text = @"新手指南";
        
        [_guideBtn addSubview:imgView];
        [_guideBtn addSubview:titleLable];
    }
    return _guideBtn;
}

- (UIButton *)serviceBtn {
    
    if (_serviceBtn == nil) {
        _serviceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _serviceBtn.tag = 6;
        _serviceBtn.frame = CGRectMake(CGRectGetMaxX(self.guideBtn.frame), CGRectGetMaxY(self.infoMoneyBtn.frame) - SCREEN_WIDTH/75, SCREEN_WIDTH/3, self.backView.frame.size.height/2);
        _serviceBtn.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((_serviceBtn.frame.size.width - SCREEN_WIDTH/9.357)/2,
                                                                             SCREEN_WIDTH/25,
                                                                             SCREEN_WIDTH/9.357,
                                                                             SCREEN_WIDTH/9.357)];
        imgView.image = [UIImage imageNamed:@"home_在线客服"];
        
        
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                        CGRectGetMaxY(imgView.frame) + SCREEN_WIDTH/75,
                                                                        SCREEN_WIDTH/3,
                                                                        SCREEN_WIDTH/31.25)];
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        titleLable.textColor = [UIColor colorWithHex:@"353846"];
        titleLable.text = @"在线客服";
        
        [_serviceBtn addSubview:imgView];
        [_serviceBtn addSubview:titleLable];
    }
    return _serviceBtn;
}





@end
