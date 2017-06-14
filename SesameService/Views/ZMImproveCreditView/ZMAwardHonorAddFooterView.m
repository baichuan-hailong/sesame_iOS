//
//  ZMAwardHonorAddFooterView.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/31.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMAwardHonorAddFooterView.h"

@interface ZMAwardHonorAddFooterView ()
@property(nonatomic,strong)UIView *bodyView;
@end

@implementation ZMAwardHonorAddFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    self.backgroundColor = [UIColor colorWithHex:backGroundColor];
    
    self.bodyView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.bodyView];
    
    [ZMLabelAttributeMange setLabel:self.titleLabel
                               text:@"添加新的奖项"
                                hex:@"333333"
                      textAlignment:NSTextAlignmentCenter
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*16]];
    [self.bodyView addSubview:self.titleLabel];
    
    
    //name
    [ZMLabelAttributeMange setLabel:self.awardNameLabel
                               text:@"奖项名称"
                                hex:@"000000"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    [self.bodyView addSubview:self.awardNameLabel];
    
    [self text:self.awardNameTextField];
    [self.bodyView addSubview:self.awardNameTextField];
    
    //time
    [ZMLabelAttributeMange setLabel:self.awardTimeLabel
                               text:@"获奖时间"
                                hex:@"000000"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    [self.bodyView addSubview:self.awardTimeLabel];
    
    //[self text:self.awardTimeTextField];
    
    self.awardTimeTextField.textAlignment = NSTextAlignmentLeft;
    self.awardTimeTextField.textColor     = [UIColor colorWithHex:@"666666"];
    self.awardTimeTextField.font          = [UIFont systemFontOfSize:SCREEN_WIDTH/375*14];
    self.awardTimeTextField.layer.borderColor     = [UIColor colorWithHex:@"BCBCBC"].CGColor;
    self.awardTimeTextField.layer.borderWidth     = SCREEN_WIDTH/375*1;
    self.awardTimeTextField.layer.cornerRadius    = SCREEN_WIDTH/375*4;
    self.awardTimeTextField.userInteractionEnabled= YES;
    
    
    
    
    
    
    [self.bodyView addSubview:self.awardTimeTextField];
    
    //image
    [ZMLabelAttributeMange setLabel:self.awardImageLabel
                               text:@"上传奖项照片"
                                hex:@"000000"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    [self.bodyView addSubview:self.awardImageLabel];
    
    self.awardImageView.image = [UIImage imageNamed:@"awardHonorImage"];
    self.awardImageView.layer.cornerRadius = SCREEN_WIDTH/375*5;
    self.awardImageView.layer.masksToBounds= YES;
    self.awardImageView.userInteractionEnabled=YES;
    self.awardImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.bodyView addSubview:self.awardImageView];
    
    [self setButton:self.addBtn
              title:@"添加"
              color:[UIColor colorWithHex:@"FFFFFF"]
               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*16]
                boo:NO];
    self.addBtn.alpha = 0.6;
    self.addBtn.userInteractionEnabled = NO;
    [self.addBtn setBackgroundColor:[UIColor colorWithHex:tonalColor]];
    [self.bodyView addSubview:self.addBtn];
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
-(UIView *)bodyView{
    if (_bodyView==nil) {
        _bodyView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*0, SCREEN_WIDTH/375*14, SCREEN_WIDTH, SCREEN_WIDTH/375*489)];
    }
    return _bodyView;
}

-(UILabel *)titleLabel{
    if (_titleLabel==nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*0, SCREEN_WIDTH/375*12, SCREEN_WIDTH, SCREEN_WIDTH/375*22)];
    }
    return _titleLabel;
}

//name
-(UILabel *)awardNameLabel{
    if (_awardNameLabel==nil) {
        _awardNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20, SCREEN_WIDTH/375*54, SCREEN_WIDTH, SCREEN_WIDTH/375*17)];
    }
    return _awardNameLabel;
}

-(UITextField *)awardNameTextField{
    if (_awardNameTextField==nil) {
        _awardNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20, SCREEN_WIDTH/375*81, SCREEN_WIDTH-SCREEN_WIDTH/375*40, SCREEN_WIDTH/375*40)];
    }
    return _awardNameTextField;
}

//time
-(UILabel *)awardTimeLabel{
    if (_awardTimeLabel==nil) {
        _awardTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20, SCREEN_WIDTH/375*130, SCREEN_WIDTH, SCREEN_WIDTH/375*17)];
    }
    return _awardTimeLabel;
}

-(UILabel *)awardTimeTextField{
    if (_awardTimeTextField==nil) {
        _awardTimeTextField = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20, SCREEN_WIDTH/375*157, SCREEN_WIDTH-SCREEN_WIDTH/375*40, SCREEN_WIDTH/375*40)];
    }
    return _awardTimeTextField;
}

//image
-(UILabel *)awardImageLabel{
    if (_awardImageLabel==nil) {
        _awardImageLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20, SCREEN_WIDTH/375*205, SCREEN_WIDTH, SCREEN_WIDTH/375*17)];
    }
    return _awardImageLabel;
}

-(UIImageView *)awardImageView{
    if (_awardImageView==nil) {
        _awardImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20, SCREEN_WIDTH/375*233, SCREEN_WIDTH-SCREEN_WIDTH/375*40, (SCREEN_WIDTH-SCREEN_WIDTH/375*40)/335*180)];
    }
    return _awardImageView;
}

-(UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20, SCREEN_WIDTH/375*429, SCREEN_WIDTH-SCREEN_WIDTH/375*40, SCREEN_WIDTH/375*40)];
    }
    return _addBtn;
}

@end
