//
//  ZMStudyCreditView.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/28.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMStudyCreditView.h"

@interface ZMStudyCreditView ()
@property (nonatomic , strong) UIView      *bodyView;
@property (nonatomic , strong) UILabel     *tipLabel;
@property (nonatomic , strong) UIImageView *creditImageView;
@property (nonatomic , strong) UILabel     *bottomLabel;
@property (nonatomic , strong) UIView      *tipline;
@property (nonatomic , strong) UIButton    *knowButton;
@end

@implementation ZMStudyCreditView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.7;
    }
    return self;
}


-(void)evokeCard{
    
    self.bodyView.backgroundColor     = [UIColor colorWithHex:@"FFFFFF"];
    self.bodyView.layer.cornerRadius  = SCREEN_WIDTH/375*12;
    self.bodyView.layer.masksToBounds = YES;
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    [keyWindow addSubview:self.bodyView];
    
    
    [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.bodyView.frame      = CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*300)/2,
                                              SCREEN_WIDTH/375*159+SCREEN_WIDTH/375*30,
                                              SCREEN_WIDTH/375*300,
                                              SCREEN_WIDTH/375*332);
    } completion:nil];
    
    [self.bodyView addSubview:self.tipline];
    
    
    [ZMLabelAttributeMange setLabel:self.tipLabel
                               text:@"什么是信用分？"
                                hex:@"030303"
                      textAlignment:NSTextAlignmentCenter
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*17]];
    [self.bodyView addSubview:self.tipLabel];
    
    
    
    self.creditImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.creditImageView.image       = [UIImage imageNamed:@"personalCredit"];
    //self.creditImageView.image       = [UIImage imageNamed:@"companyCredit"];
    [self.bodyView addSubview:self.creditImageView];
    
    [ZMLabelAttributeMange setLabel:self.bottomLabel
                               text:@"信用分是通过对会员以上五大维度数据进行综合处理与评估，客观呈现会员信用状况的分值。分值越高代表信用越好，可享受更多会员权益。"
                                hex:@"666666"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
    self.bottomLabel.numberOfLines = 0;
    [UILabel changeLineSpaceForLabel:self.bottomLabel WithSpace:SCREEN_WIDTH/375*3];
    [self.bodyView addSubview:self.bottomLabel];
    
    [self setButton:self.knowButton title:@"我知道了" color:[UIColor colorWithHex:@"70AEFF"] font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14] boo:NO];
    [self.bodyView addSubview:self.knowButton];
    
    [self.knowButton addTarget:self action:@selector(knowButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)knowButtonClickAction:(UIButton *)sender{
    
    self.bodyView.frame      = CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*300)/2,
                                          SCREEN_WIDTH/375*159,
                                          SCREEN_WIDTH/375*300,
                                          SCREEN_WIDTH/375*332);
    
    [UIView animateWithDuration:0.38 animations:^{
        [self removeFromSuperview];
        [self.bodyView removeFromSuperview];
    }];
}


- (void)setButton:(UIButton *)button title:(NSString *)title color:(UIColor *)textColor font:(UIFont *)textFond boo:(BOOL)islayer{
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    button.titleLabel.font    = textFond;
    if (islayer) {
        button.layer.borderColor  = [UIColor whiteColor].CGColor;
        button.layer.borderWidth  = SCREEN_WIDTH/375*1;
        button.layer.cornerRadius = SCREEN_WIDTH/375*4;
    }
}



//touch
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch            = [touches anyObject];
    CGPoint currentPosition   = [touch locationInView:self];
    CGFloat currentY          = currentPosition.y;
    if (currentY<SCREEN_WIDTH/375*159||currentY>SCREEN_WIDTH/375*491){
        /*
         self.bodyView.frame      = CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*300)/2,
         SCREEN_WIDTH/375*159,
         SCREEN_WIDTH/375*300,
         SCREEN_WIDTH/375*332);
         
         [UIView animateWithDuration:0.38 animations:^{
         [self removeFromSuperview];
         [self.bodyView removeFromSuperview];
         }];
         */
    }
}



//lazy
-(UIView *)bodyView{
    if (_bodyView==nil) {
        _bodyView = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*300)/2,
                                                            SCREEN_WIDTH/375*159,
                                                            SCREEN_WIDTH/375*300,
                                                            SCREEN_WIDTH/375*332)];
        _bodyView.backgroundColor     = [UIColor colorWithHex:@"FFFFFF"];
    }
    return _bodyView;
}

-(UIView *)tipline{
    if (_tipline==nil) {
        _tipline = [[UIView alloc]initWithFrame:CGRectMake(0,
                                                            SCREEN_WIDTH/375*291,
                                                            SCREEN_WIDTH/375*300,
                                                            SCREEN_WIDTH/375*0.5)];
        _tipline.backgroundColor     = [UIColor colorWithHex:@"CCCCCC"];
    }
    return _tipline;
}

-(UILabel *)tipLabel{
    if (_tipLabel==nil) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                              SCREEN_WIDTH/375*34,
                                                              SCREEN_WIDTH/375*300,
                                                              SCREEN_WIDTH/375*17)];
    }
    return _tipLabel;
}

-(UIImageView *)creditImageView{
    if (_creditImageView==nil) {
        _creditImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*56,
                                                              SCREEN_WIDTH/375*81,
                                                              SCREEN_WIDTH/375*186,
                                                              SCREEN_WIDTH/375*112)];
    }
    return _creditImageView;
}

-(UILabel *)bottomLabel{
    if (_bottomLabel==nil) {
        _bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                              SCREEN_WIDTH/375*210,
                                                              SCREEN_WIDTH/375*300-SCREEN_WIDTH/375*40,
                                                              SCREEN_WIDTH/375*60)];
    }
    return _bottomLabel;
}

-(UIButton *)knowButton{
    if (_knowButton==nil) {
        _knowButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*0,
                                                                SCREEN_WIDTH/375*292,
                                                                SCREEN_WIDTH/375*300,
                                                                SCREEN_WIDTH/375*40)];
    }
    return _knowButton;
}

@end
