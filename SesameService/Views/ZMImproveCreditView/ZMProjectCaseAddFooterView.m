//
//  ZMProjectCaseAddFooterView.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/31.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMProjectCaseAddFooterView.h"

@interface ZMProjectCaseAddFooterView ()
@property(nonatomic,strong)UIView *bodyView;
@end

@implementation ZMProjectCaseAddFooterView

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
                               text:@"添加新的案例"
                                hex:@"333333"
                      textAlignment:NSTextAlignmentCenter
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*16]];
    [self.bodyView addSubview:self.titleLabel];
    
    
    //kehu
    [ZMLabelAttributeMange setLabel:self.kehuLabel
                               text:@"客户名称"
                                hex:@"000000"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    //[self.bodyView addSubview:self.kehuLabel];
    
    [self text:self.kehuTextField];
    //[self.bodyView addSubview:self.kehuTextField];
    
    //project
    [ZMLabelAttributeMange setLabel:self.projectLabel
                               text:@"项目名称"
                                hex:@"000000"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    [self.bodyView addSubview:self.projectLabel];
    
    [self text:self.projectTextField];
    [self.bodyView addSubview:self.projectTextField];
    
    //time
    [ZMLabelAttributeMange setLabel:self.timeLabel
                               text:@"项目时间"
                                hex:@"000000"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    [self.bodyView addSubview:self.timeLabel];
    
    [self textLa:self.timeTextField];
    [self.bodyView addSubview:self.timeTextField];
    
    [self setButton:self.addBtn
              title:@"添加"
              color:[UIColor colorWithHex:@"FFFFFF"]
               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*16]
                boo:NO];
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

- (void)textLa:(UILabel *)textField{
    textField.textAlignment = NSTextAlignmentLeft;
    textField.textColor     = [UIColor colorWithHex:@"666666"];
    textField.font          = [UIFont systemFontOfSize:SCREEN_WIDTH/375*14];
    textField.layer.borderColor = [UIColor colorWithHex:@"BCBCBC"].CGColor;
    textField.layer.borderWidth = SCREEN_WIDTH/375*1;
    textField.layer.cornerRadius= SCREEN_WIDTH/375*4;
    
}

//lazy
-(UIView *)bodyView{
    if (_bodyView==nil) {
        _bodyView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*0,
                                                             SCREEN_WIDTH/375*14,
                                                             SCREEN_WIDTH,
                                                             SCREEN_WIDTH/375*303)];
    }
    return _bodyView;
}

-(UILabel *)titleLabel{
    if (_titleLabel==nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*0,
                                                                SCREEN_WIDTH/375*26,
                                                                SCREEN_WIDTH,
                                                                SCREEN_WIDTH/375*22)];
    }
    return _titleLabel;
}

//kehu
-(UILabel *)kehuLabel{
    if (_kehuLabel==nil) {
        _kehuLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                               SCREEN_WIDTH/375*55,
                                                               SCREEN_WIDTH,
                                                               SCREEN_WIDTH/375*17)];
    }
    return _kehuLabel;
}

-(UITextField *)kehuTextField{
    if (_kehuTextField==nil) {
        _kehuTextField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                                       SCREEN_WIDTH/375*96,
                                                                       SCREEN_WIDTH-SCREEN_WIDTH/375*40,
                                                                       SCREEN_WIDTH/375*40)];
    }
    return _kehuTextField;
}

//project
-(UILabel *)projectLabel{
    if (_projectLabel==nil) {
        _projectLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                                  SCREEN_WIDTH/375*55,
                                                                  SCREEN_WIDTH,
                                                                  SCREEN_WIDTH/375*17)];
    }
    return _projectLabel;
}

-(UITextField *)projectTextField{
    if (_projectTextField==nil) {
        _projectTextField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                                          SCREEN_WIDTH/375*96,
                                                                          SCREEN_WIDTH-SCREEN_WIDTH/375*40,
                                                                          SCREEN_WIDTH/375*40)];
    }
    return _projectTextField;
}

//time
-(UILabel *)timeLabel{
    if (_timeLabel==nil) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                               SCREEN_WIDTH/375*145,
                                                               SCREEN_WIDTH,
                                                               SCREEN_WIDTH/375*17)];
    }
    return _timeLabel;
}

-(UILabel *)timeTextField{
    if (_timeTextField==nil) {
        _timeTextField = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                                       SCREEN_WIDTH/375*172,
                                                                       SCREEN_WIDTH-SCREEN_WIDTH/375*40,
                                                                       SCREEN_WIDTH/375*40)];
    }
    return _timeTextField;
}

-(UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                             SCREEN_WIDTH/375*232,
                                                             SCREEN_WIDTH-SCREEN_WIDTH/375*40,
                                                             SCREEN_WIDTH/375*40)];
    }
    return _addBtn;
}
@end
