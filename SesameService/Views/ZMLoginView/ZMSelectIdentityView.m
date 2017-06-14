//
//  ZMSelectIdentityView.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/30.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMSelectIdentityView.h"

@interface ZMSelectIdentityView ()
@property(nonatomic,strong)UILabel *tipLabel;
@property(nonatomic,strong)UILabel *topTipLabel;
@property(nonatomic,strong)UILabel *comLabel;
@property(nonatomic,strong)UILabel *perLabel;
@end

@implementation ZMSelectIdentityView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    self.backgroundColor = [UIColor whiteColor];
    
    self.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+1);
    
    
    [ZMLabelAttributeMange setLabel:self.tipLabel
                               text:@"欢迎来到芝麻商服！"
                                hex:@"333333"
                      textAlignment:NSTextAlignmentCenter
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*18]];
    [self addSubview:self.tipLabel];
    
    [ZMLabelAttributeMange setLabel:self.topTipLabel
                               text:@"为了更好的为您提供服务，请先选择会员身份"
                                hex:@"666666"
                      textAlignment:NSTextAlignmentCenter
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    [self addSubview:self.topTipLabel];
    
    //com
    [self.companyButton setBackgroundColor:[UIColor colorWithHex:tonalColor]];
    //[self.companyButton setImage:[UIImage imageNamed:@"companySelect"] forState:UIControlStateNormal];
    //[self.companyButton setBackgroundImage:[UIImage imageNamed:@"companyImageSe"]  forState:UIControlStateNormal];
    self.companyButton.layer.cornerRadius = SCREEN_WIDTH/375*40;
    [self addSubview:self.companyButton];
    
    
    [ZMLabelAttributeMange setLabel:self.comLabel
                               text:@"我是企业会员"
                                hex:@"999999"
                      textAlignment:NSTextAlignmentCenter
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    [self addSubview:self.comLabel];
    
    //per
    [self.personalButton setBackgroundColor:[UIColor colorWithHex:@"CCCCCC"]];
    //[self.personalButton setImage:[UIImage imageNamed:@"personNoselect"] forState:UIControlStateNormal];
    self.personalButton.layer.cornerRadius = SCREEN_WIDTH/375*40;
    [self addSubview:self.personalButton];
    
    
    [self.companyButton setBackgroundImage:[UIImage imageNamed:@"companySelect"] forState:UIControlStateNormal];
    [self.personalButton setBackgroundImage:[UIImage imageNamed:@"personNoselect"] forState:UIControlStateNormal];
    
    
    
    
    
    [ZMLabelAttributeMange setLabel:self.perLabel
                               text:@"我是个人会员"
                                hex:@"999999"
                      textAlignment:NSTextAlignmentCenter
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    [self addSubview:self.perLabel];
    
    
    
    //name
    [ZMLabelAttributeMange setLabel:self.nameLabel
                               text:@"企业名称"
                                hex:@"333333"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    [self addSubview:self.nameLabel];
    
    [self text:self.nametextField];
    self.nametextField.placeholder = @"请填写企业名称 ";
    [self addSubview:self.nametextField];
    
    
    
    
    //commit
    [self setButton:self.commitButton
              title:@"提交"
              color:[UIColor colorWithHex:@"FFFFFF"]
               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*16]
                boo:YES];
    [self.commitButton setBackgroundColor:[UIColor colorWithHex:tonalColor]];
    [self addSubview:self.commitButton];
}



- (void)text:(UITextField *)textField{
    textField.textAlignment = NSTextAlignmentLeft;
    textField.textColor     = [UIColor colorWithHex:@"666666"];
    textField.font          = [UIFont systemFontOfSize:SCREEN_WIDTH/375*14];
    textField.layer.borderColor = [UIColor colorWithHex:@"BCBCBC"].CGColor;
    textField.layer.borderWidth = SCREEN_WIDTH/375*1;
    textField.layer.cornerRadius= SCREEN_WIDTH/375*4;
    textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/375*13, SCREEN_WIDTH/375*40)];
    textField.leftView.backgroundColor = [UIColor clearColor];
    textField.leftViewMode = UITextFieldViewModeAlways;
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

-(UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*0,
                                                                 64+SCREEN_WIDTH/375*50,
                                                                 SCREEN_WIDTH,
                                                                 SCREEN_WIDTH/375*18)];
    }
    return _tipLabel;
}

-(UILabel *)topTipLabel{
    if (!_topTipLabel) {
        _topTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*0,
                                                                 64+SCREEN_WIDTH/375*78,
                                                                 SCREEN_WIDTH,
                                                                SCREEN_WIDTH/375*20)];
    }
    return _topTipLabel;
}


//lazy
-(UIButton *)companyButton{
    if (!_companyButton) {
        _companyButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*67,
                                                                    64+SCREEN_WIDTH/375*139,
                                                                    SCREEN_WIDTH/375*80,
                                                                    SCREEN_WIDTH/375*80)];
    }
    return _companyButton;
}

-(UILabel *)comLabel{
    if (!_comLabel) {
        _comLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*47,
                                                                 CGRectGetMaxY(self.companyButton.frame)+SCREEN_WIDTH/375*9,
                                                                 SCREEN_WIDTH/375*120,
                                                                 SCREEN_WIDTH/375*20)];
    }
    return _comLabel;
}


-(UIButton *)personalButton{
    if (!_personalButton) {
        _personalButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*67-SCREEN_WIDTH/375*80,
                                                                     64+SCREEN_WIDTH/375*139,
                                                                     SCREEN_WIDTH/375*80,
                                                                     SCREEN_WIDTH/375*80)];
    }
    return _personalButton;
}

-(UILabel *)perLabel{
    if (!_perLabel) {
        _perLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*87-SCREEN_WIDTH/375*80,
                                                              CGRectGetMaxY(self.personalButton.frame)+SCREEN_WIDTH/375*9,
                                                              SCREEN_WIDTH/375*120,
                                                              SCREEN_WIDTH/375*20)];
    }
    return _perLabel;
}



//name
-(UILabel *)nameLabel{
    if (_nameLabel==nil) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                               64+SCREEN_WIDTH/375*291,
                                                               SCREEN_WIDTH/375*200,
                                                               SCREEN_WIDTH/375*17)];
    }
    return _nameLabel;
}

-(UITextField *)nametextField{
    if (_nametextField==nil) {
        _nametextField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                                       CGRectGetMaxY(self.nameLabel.frame)+SCREEN_WIDTH/375*11,
                                                                       SCREEN_WIDTH-SCREEN_WIDTH/375*40,
                                                                       SCREEN_WIDTH/375*40)];
    }
    return _nametextField;
}



//commit
-(UIButton *)commitButton{
    if (!_commitButton) {
        _commitButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                                   64+SCREEN_WIDTH/375*389,
                                                                   SCREEN_WIDTH-SCREEN_WIDTH/375*40,
                                                                   SCREEN_WIDTH/375*40)];
    }
    return _commitButton;
}

@end
