//
//  ZMCompanyAuthView.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/28.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMCompanyAuthView.h"

@implementation ZMCompanyAuthView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    self.backgroundColor = [UIColor whiteColor];
    
    self.contentSize     = CGSizeMake(SCREEN_WIDTH,SCREEN_HEIGHT+1);
    
    //name
    [ZMLabelAttributeMange setLabel:self.companyLabel
                               text:@"企业名称"
                                hex:@"000000"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    [self addSubview:self.companyLabel];
    
    [self text:self.companyTextField];
    //self.nameTextField.placeholder = @"";
    [self addSubview:self.companyTextField];
    

    //on
    [ZMLabelAttributeMange setLabel:self.cardIDOnLabel
                               text:@"营业执照"
                                hex:@"000000"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    [self addSubview:self.cardIDOnLabel];
    
    self.cardIDOnImageView.image = [UIImage imageNamed:@"yingyezhizhaoImage"];
    self.cardIDOnImageView.layer.cornerRadius = SCREEN_WIDTH/375*5;
    self.cardIDOnImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.cardIDOnImageView.layer.masksToBounds= YES;
    self.cardIDOnImageView.userInteractionEnabled=YES;
    [self addSubview:self.cardIDOnImageView];
    
    
    [self setButton:self.commitBtn
              title:@"提交认证"
              color:[UIColor colorWithHex:@"FFFFFF"]
               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*16]
                boo:NO];
    [self.commitBtn setBackgroundColor:[UIColor colorWithHex:tonalColor]];
    self.commitBtn.alpha                  = 0.6;
    self.commitBtn.userInteractionEnabled = NO;
    [self addSubview:self.commitBtn];
    
}

- (void)setButton:(UIButton *)button title:(NSString *)title color:(UIColor *)textColor font:(UIFont *)textFond boo:(BOOL)islayer{
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    button.titleLabel.font    = textFond;
    
    button.layer.cornerRadius = SCREEN_WIDTH/375*4;
    if (islayer) {
        button.layer.borderColor  = [UIColor whiteColor].CGColor;
        button.layer.borderWidth  = SCREEN_WIDTH/375*1;
        button.layer.cornerRadius = SCREEN_WIDTH/375*4;
    }
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

//lazy
//name
-(UILabel *)companyLabel{
    if (_companyLabel==nil) {
        _companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                              64+SCREEN_WIDTH/375*21,
                                              SCREEN_WIDTH/375*200,
                                              SCREEN_WIDTH/375*17)];
    }
    return _companyLabel;
}

-(UITextField *)companyTextField{
    if (_companyTextField==nil) {
        _companyTextField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                      CGRectGetMaxY(self.companyLabel.frame)+SCREEN_WIDTH/375*10,
                                      SCREEN_WIDTH-SCREEN_WIDTH/375*40,
                                      SCREEN_WIDTH/375*40)];
    }
    return _companyTextField;
}



//on
-(UILabel *)cardIDOnLabel{
    if (_cardIDOnLabel==nil) {
        _cardIDOnLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                           CGRectGetMaxY(self.companyTextField.frame)+SCREEN_WIDTH/375*10,
                                           SCREEN_WIDTH/375*200,
                                           SCREEN_WIDTH/375*17)];
    }
    return _cardIDOnLabel;
}

-(UIImageView *)cardIDOnImageView{
    if (_cardIDOnImageView==nil) {
        _cardIDOnImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                   CGRectGetMaxY(self.cardIDOnLabel.frame)+SCREEN_WIDTH/375*13,
                                   SCREEN_WIDTH-SCREEN_WIDTH/375*40,
                                   (SCREEN_WIDTH-SCREEN_WIDTH/375*40)/335*180)];
    }
    return _cardIDOnImageView;
}


-(UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                            CGRectGetMaxY(self.cardIDOnImageView.frame)+SCREEN_WIDTH/375*20,
                            SCREEN_WIDTH-SCREEN_WIDTH/375*40,
                            SCREEN_WIDTH/375*40)];
    }
    return _commitBtn;
}



@end
