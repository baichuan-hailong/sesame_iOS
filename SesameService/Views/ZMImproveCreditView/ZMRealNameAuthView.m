//
//  ZMRealNameAuthView.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/30.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMRealNameAuthView.h"

@implementation ZMRealNameAuthView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    self.backgroundColor = [UIColor whiteColor];

    
    //name
    [ZMLabelAttributeMange setLabel:self.nameLabel
                               text:@"姓名"
                                hex:@"000000"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    [self addSubview:self.nameLabel];
    
    [self text:self.nameTextField];
    self.nameTextField.placeholder = @"请输入您的真实姓名";
    [self addSubview:self.nameTextField];
    
    //ID
    [ZMLabelAttributeMange setLabel:self.cardIDLabel
                               text:@"身份证号"
                                hex:@"000000"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    [self addSubview:self.cardIDLabel];
    
    [self text:self.cardIDTextField];
    self.cardIDTextField.placeholder = @"请输入您的身份证号";
    [self addSubview:self.cardIDTextField];
    
    
    //on
    [ZMLabelAttributeMange setLabel:self.cardIDOnLabel
                               text:@"身份证正面照片"
                                hex:@"000000"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    [self addSubview:self.cardIDOnLabel];
    
    self.cardIDOnImageView.image = [UIImage imageNamed:@"cardIDOnnImage"];
    self.cardIDOnImageView.layer.cornerRadius = SCREEN_WIDTH/375*5;
    self.cardIDOnImageView.layer.masksToBounds= YES;
    self.cardIDOnImageView.userInteractionEnabled=YES;
    self.cardIDOnImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.cardIDOnImageView];
    
    //off
    [ZMLabelAttributeMange setLabel:self.cardIDOffLabel
                               text:@"身份证背面照片"
                                hex:@"000000"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    [self addSubview:self.cardIDOffLabel];
    
    self.cardIDOffImageView.image = [UIImage imageNamed:@"cardIDOnImage"];
    self.cardIDOffImageView.layer.cornerRadius = SCREEN_WIDTH/375*5;
    self.cardIDOffImageView.layer.masksToBounds= YES;
    self.cardIDOffImageView.userInteractionEnabled=YES;
    self.cardIDOffImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.cardIDOffImageView];
    
    [self setButton:self.commitBtn
              title:@"提交认证"
              color:[UIColor colorWithHex:@"FFFFFF"]
               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*16]
                boo:NO];
    self.commitBtn.alpha = 0.6;
    self.commitBtn.userInteractionEnabled = NO;
    [self.commitBtn setBackgroundColor:[UIColor colorWithHex:tonalColor]];
    [self addSubview:self.commitBtn];
    
    //tip
    [ZMLabelAttributeMange setLabel:self.tipLabel
                               text:@"* 我们保证不会以任何方式透露您的个人信息"
                                hex:@"3F3F3F"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
    [ZMLabelAttributeMange attributeLabel:self.tipLabel range:NSMakeRange(0, 1)];
    [self addSubview:self.tipLabel];
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
-(UILabel *)nameLabel{
    if (_nameLabel==nil) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20, SCREEN_WIDTH/375*64+SCREEN_WIDTH/375*21, SCREEN_WIDTH/375*200, SCREEN_WIDTH/375*17)];
    }
    return _nameLabel;
}

-(UITextField *)nameTextField{
    if (_nameTextField==nil) {
        _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20, SCREEN_WIDTH/375*64+SCREEN_WIDTH/375*48, SCREEN_WIDTH-SCREEN_WIDTH/375*40, SCREEN_WIDTH/375*40)];
    }
    return _nameTextField;
}

//ID
-(UILabel *)cardIDLabel{
    if (_cardIDLabel==nil) {
        _cardIDLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20, SCREEN_WIDTH/375*64+SCREEN_WIDTH/375*97, SCREEN_WIDTH/375*200, SCREEN_WIDTH/375*17)];
    }
    return _cardIDLabel;
}

-(UITextField *)cardIDTextField{
    if (_cardIDTextField==nil) {
        _cardIDTextField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20, SCREEN_WIDTH/375*64+SCREEN_WIDTH/375*124, SCREEN_WIDTH-SCREEN_WIDTH/375*40, SCREEN_WIDTH/375*40)];
    }
    return _cardIDTextField;
}

//on
-(UILabel *)cardIDOnLabel{
    if (_cardIDOnLabel==nil) {
        _cardIDOnLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20, SCREEN_WIDTH/375*64+SCREEN_WIDTH/375*173, SCREEN_WIDTH/375*200, SCREEN_WIDTH/375*17)];
    }
    return _cardIDOnLabel;
}

-(UIImageView *)cardIDOnImageView{
    if (_cardIDOnImageView==nil) {
        _cardIDOnImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20, SCREEN_WIDTH/375*64+SCREEN_WIDTH/375*203, SCREEN_WIDTH-SCREEN_WIDTH/375*40, (SCREEN_WIDTH-SCREEN_WIDTH/375*40)/335*180)];
    }
    return _cardIDOnImageView;
}

//off
-(UILabel *)cardIDOffLabel{
    if (_cardIDOffLabel==nil) {
        _cardIDOffLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20, SCREEN_WIDTH/375*394+SCREEN_WIDTH/375*64, SCREEN_WIDTH/375*200, SCREEN_WIDTH/375*17)];
    }
    return _cardIDOffLabel;
}

-(UIImageView *)cardIDOffImageView{
    if (_cardIDOffImageView==nil) {
        _cardIDOffImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20, SCREEN_WIDTH/375*64+SCREEN_WIDTH/375*424, SCREEN_WIDTH-SCREEN_WIDTH/375*40, (SCREEN_WIDTH-SCREEN_WIDTH/375*40)/335*180)];
    }
    return _cardIDOffImageView;
}

-(UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                                SCREEN_WIDTH/375*624+SCREEN_WIDTH/375*64,
                                                                SCREEN_WIDTH-SCREEN_WIDTH/375*40,
                                                                SCREEN_WIDTH/375*40)];
    }
    return _commitBtn;
}

//tip
-(UILabel *)tipLabel{
    if (_tipLabel==nil) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                              SCREEN_WIDTH/375*673+SCREEN_WIDTH/375*64,
                                                              SCREEN_WIDTH/375*300,
                                                              SCREEN_WIDTH/375*17)];
    }
    return _tipLabel;
}

@end
