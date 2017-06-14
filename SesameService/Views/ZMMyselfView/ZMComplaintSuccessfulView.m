
//
//  ZMComplaintSuccessfulView.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/26.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMComplaintSuccessfulView.h"

@interface ZMComplaintSuccessfulView ()

@property(nonatomic,strong)UIView  *succeView;
@end

@implementation ZMComplaintSuccessfulView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHex:backGroundColor];
        [self addUI];
    }
    return self;
}

- (void)addUI{
    
    self.contentSize     = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+1);
    //self.showsHorizontalScrollIndicator = NO;
    
    self.succeView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.succeView];
    
    //complaintSuccessful
    self.stateImageView.image = [UIImage imageNamed:@"complaintSuccessful"];
    [self.succeView addSubview:self.stateImageView];
    
    
    
    //title
    [ZMLabelAttributeMange setLabel:self.successfulLabel
                               text:@"提交成功"
                                hex:@"030303"
                      textAlignment:NSTextAlignmentCenter
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*17]];
    [self.succeView addSubview:self.successfulLabel];
    
    //tip
    [ZMLabelAttributeMange setLabel:self.tipLabel
                               text:@"我们将尽快处理您的投诉"
                                hex:@"666666"
                      textAlignment:NSTextAlignmentCenter
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    [self.succeView addSubview:self.tipLabel];
    

    
    //check
    [self setButton:self.checkBtn
              title:@"查看详情"
              color:[UIColor colorWithHex:@"FFFFFF"]
               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
                boo:YES];
    [self.checkBtn setBackgroundColor:[UIColor colorWithHex:tonalColor]];
    [self.succeView addSubview:self.checkBtn];
    
    
    //bac
    [self setButton:self.bacBtn
              title:@"返回会员中心"
              color:[UIColor colorWithHex:tonalColor]
               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
                boo:YES];
    [self.bacBtn setBackgroundColor:[UIColor whiteColor]];
    self.bacBtn.layer.borderColor  = [UIColor colorWithHex:tonalColor].CGColor;
    self.bacBtn.layer.borderWidth  = SCREEN_WIDTH/375*1;
    [self.succeView addSubview:self.bacBtn];
    
}


- (void)setButton:(UIButton *)button title:(NSString *)title color:(UIColor *)textColor font:(UIFont *)textFond boo:(BOOL)islayer{
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    button.titleLabel.font    = textFond;
    if (islayer) {
        //button.layer.borderColor  = [UIColor whiteColor].CGColor;
        //button.layer.borderWidth  = SCREEN_WIDTH/375*1;
        button.layer.cornerRadius = SCREEN_WIDTH/375*4;
    }
}


-(UIView *)succeView{
    if (_succeView==nil) {
        _succeView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*0,
                                                            64,
                                                            SCREEN_WIDTH,
                                                            SCREEN_HEIGHT)];
    }
    return _succeView;
}

//state
-(UIImageView *)stateImageView{
    if (_stateImageView==nil) {
        _stateImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*44)/2,
                                                                SCREEN_WIDTH/375*67,
                                                                SCREEN_WIDTH/375*44,
                                                                SCREEN_WIDTH/375*48)];
    }
    return _stateImageView;
}

//succ
-(UILabel *)successfulLabel{
    if (_successfulLabel==nil) {
        _successfulLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*100)/2,
                                                              CGRectGetMaxY(self.stateImageView.frame)+SCREEN_WIDTH/375*21,
                                                              SCREEN_WIDTH/375*100,
                                                              SCREEN_WIDTH/375*18)];
    }
    return _successfulLabel;
}

//tip
-(UILabel *)tipLabel{
    if (_tipLabel==nil) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*200)/2,
                                                                 CGRectGetMaxY(self.successfulLabel.frame)+SCREEN_WIDTH/375*8,
                                                                 SCREEN_WIDTH/375*200,
                                                                 SCREEN_WIDTH/375*20)];
    }
    return _tipLabel;
}

//tel
-(UILabel *)telLabel{
    if (_telLabel==nil) {
        _telLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*177)/2,
                                                                SCREEN_HEIGHT-SCREEN_WIDTH/375*22-SCREEN_WIDTH/375*30,
                                                                SCREEN_WIDTH/375*177,
                                                                SCREEN_WIDTH/375*30)];
    }
    return _telLabel;
}



//check
-(UIButton *)checkBtn{
    if (!_checkBtn) {
         _checkBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*33,
                                                                   CGRectGetMaxY(self.tipLabel.frame)+SCREEN_WIDTH/375*38,
                                                                   SCREEN_WIDTH-SCREEN_WIDTH/375*66,
                                                                   SCREEN_WIDTH/375*40)];
    }
    return _checkBtn;
}

//back
-(UIButton *)bacBtn{
    if (!_bacBtn) {
        _bacBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*33,
                                                               CGRectGetMaxY(self.checkBtn.frame)+SCREEN_WIDTH/375*20,
                                                               SCREEN_WIDTH-SCREEN_WIDTH/375*66,
                                                               SCREEN_WIDTH/375*40)];
    }
    return _bacBtn;
}

@end
