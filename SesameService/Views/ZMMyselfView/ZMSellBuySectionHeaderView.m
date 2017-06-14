//
//  ZMSellBuySectionHeaderView.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/24.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMSellBuySectionHeaderView.h"

@implementation ZMSellBuySectionHeaderView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addUI];
    }
    return self;
}

- (void)addUI{
    
    //title
    [ZMLabelAttributeMange setLabel:self.titleLabel
                               text:@"---"
                                hex:@"333333"
                      textAlignment:NSTextAlignmentCenter
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*16]];
    [self addSubview:self.titleLabel];
    
    [self.changeBtn setImage:[UIImage imageNamed:@"newbianjiImage"] forState:UIControlStateNormal];
    //self.changeBtn.backgroundColor = [UIColor redColor];
    self.changeBtn.alpha = 0;
    [self addSubview:self.changeBtn];
}


- (void)settitle:(NSString *)title{
    self.titleLabel.text = title;
}

-(UILabel *)titleLabel{
    if (_titleLabel==nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*150)/2,
                                                                SCREEN_WIDTH/375*12,
                                                                SCREEN_WIDTH/375*150,
                                                                SCREEN_WIDTH/375*22)];
    }
    return _titleLabel;
}

//45
-(UIButton *)changeBtn{
    if (_changeBtn==nil) {
        _changeBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*17-SCREEN_WIDTH/375*20,
                                                                SCREEN_WIDTH/375*14,
                                                                SCREEN_WIDTH/375*17,
                                                                SCREEN_WIDTH/375*17)];
    }
    return _changeBtn;
}

@end
