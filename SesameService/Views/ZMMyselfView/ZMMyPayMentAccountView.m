//
//  ZMMyPayMentAccountView.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/28.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMMyPayMentAccountView.h"

@interface ZMMyPayMentAccountView ()


@end

@implementation ZMMyPayMentAccountView

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
    
    /*
     //户名
     @property (nonatomic , strong) UILabel     *collectionTypeLabel;
     @property (nonatomic , strong) UITextField *collectionTypeView;
     
     
     //银行名称
     @property (nonatomic , strong) UILabel     *personRealNameLabel;
     @property (nonatomic , strong) UITextField *personRealNameTextField;
     
     //银行卡号
     @property (nonatomic , strong) UILabel     *accountLabel;
     @property (nonatomic , strong) UITextField *accountTextField;
     
     //开户行
     @property (nonatomic , strong) UILabel     *telLabel;
     @property (nonatomic , strong) UITextField *telTextField;
     */
    
    //户名
    [ZMLabelAttributeMange setLabel:self.collectionTypeLabel
                               text:@"户名"
                                hex:@"000000"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    [self addSubview:self.collectionTypeLabel];
    
    self.collectionTypeView.layer.borderWidth  = SCREEN_WIDTH/375*1;
    self.collectionTypeView.layer.borderColor  = [UIColor colorWithHex:@"BCBCBC"].CGColor;
    self.collectionTypeView.layer.cornerRadius = SCREEN_WIDTH/375*4;
    self.collectionTypeView.layer.masksToBounds= YES;
    
    [self text:self.collectionTypeView placeText:@"请输入真实姓名"];
    [self addSubview:self.collectionTypeView];
    

    //银行名称
    [ZMLabelAttributeMange setLabel:self.personRealNameLabel
                               text:@"银行名称"
                                hex:@"000000"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    [self addSubview:self.personRealNameLabel];
    
    [self text:self.personRealNameTextField placeText:@"请输入银行名称"];
    [self addSubview:self.personRealNameTextField];
    
    //银行卡号
    [ZMLabelAttributeMange setLabel:self.accountLabel
                               text:@"银行卡号"
                                hex:@"000000"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    [self addSubview:self.accountLabel];
    [self text:self.accountTextField placeText:@"请输入银行卡号"];
    [self addSubview:self.accountTextField];
    
    

    //开户行
    [ZMLabelAttributeMange setLabel:self.telLabel
                               text:@"开户行"
                                hex:@"000000"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    [self addSubview:self.telLabel];
    [self text:self.telTextField placeText:@"请输入开户行"];
    [self addSubview:self.telTextField];
    
    //tip
    [ZMLabelAttributeMange setLabel:self.tipLabel
                               text:@"* 开户行填写不正确,会造成打款失败!如您不清楚开户行信息,请拨打银行卡背面的客服热线查询。"
                                hex:@"3F3F3F"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
    self.tipLabel.numberOfLines = 0;
    [ZMLabelAttributeMange attributeLabel:self.tipLabel range:NSMakeRange(0, 1)];
    [self addSubview:self.tipLabel];
    
}


- (void)text:(UITextField *)textField placeText:(NSString *)placeText{
    
    textField.textAlignment = NSTextAlignmentLeft;
    textField.textColor     = [UIColor colorWithHex:@"666666"];
    textField.font          = [UIFont systemFontOfSize:SCREEN_WIDTH/375*14];
    
    textField.placeholder   = placeText;
    
    textField.layer.borderWidth = SCREEN_WIDTH/375*1;
    textField.layer.borderColor = [UIColor colorWithHex:@"BCBCBC"].CGColor;
    textField.layer.cornerRadius = SCREEN_WIDTH/375*4;
    
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
        button.layer.borderColor  = [UIColor whiteColor].CGColor;
        button.layer.borderWidth  = SCREEN_WIDTH/375*1;
        button.layer.cornerRadius = SCREEN_WIDTH/375*4;
    }
}



//收款方式

-(UILabel *)collectionTypeLabel{
    if (_collectionTypeLabel==nil) {
        _collectionTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                                         SCREEN_WIDTH/375*64+SCREEN_WIDTH/375*21,
                                                                         SCREEN_WIDTH/375*100,
                                                                         SCREEN_WIDTH/375*17)];
    }
    return _collectionTypeLabel;
}

-(UITextField *)collectionTypeView{
    if (_collectionTypeView==nil) {
        _collectionTypeView = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                                       SCREEN_WIDTH/375*64+SCREEN_WIDTH/375*49,
                                                                       SCREEN_WIDTH-SCREEN_WIDTH/375*40,
                                                                       SCREEN_WIDTH/375*40)];
    }
    return _collectionTypeView;
}




//收款人
-(UILabel *)personRealNameLabel{
    if (_personRealNameLabel==nil) {
        _personRealNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                                         SCREEN_WIDTH/375*64+SCREEN_WIDTH/375*96,
                                                                         SCREEN_WIDTH/375*100,
                                                                         SCREEN_WIDTH/375*17)];
    }
    return _personRealNameLabel;
}

-(UITextField *)personRealNameTextField{
    if (_personRealNameTextField==nil) {
        _personRealNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                                                 SCREEN_WIDTH/375*64+SCREEN_WIDTH/375*123,
                                                                                 SCREEN_WIDTH-SCREEN_WIDTH/375*40,
                                                                                 SCREEN_WIDTH/375*40)];
    }
    return _personRealNameTextField;
}

//账号
-(UILabel *)accountLabel{
    if (_accountLabel==nil) {
        _accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                                  SCREEN_WIDTH/375*64+SCREEN_WIDTH/375*171,
                                                                  SCREEN_WIDTH/375*100,
                                                                  SCREEN_WIDTH/375*17)];
    }
    return _accountLabel;
}

-(UITextField *)accountTextField{
    if (_accountTextField==nil) {
        _accountTextField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                                          SCREEN_WIDTH/375*64+SCREEN_WIDTH/375*198,
                                                                          SCREEN_WIDTH-SCREEN_WIDTH/375*40,
                                                                          SCREEN_WIDTH/375*40)];
    }
    return _accountTextField;
}



//手机号
-(UILabel *)telLabel{
    if (_telLabel==nil) {
        _telLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                              SCREEN_WIDTH/375*64+SCREEN_WIDTH/375*245,
                                                              SCREEN_WIDTH/375*100,
                                                              SCREEN_WIDTH/375*17)];
    }
    return _telLabel;
}

-(UITextField *)telTextField{
    if (_telTextField==nil) {
        _telTextField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                                      SCREEN_WIDTH/375*64+SCREEN_WIDTH/375*272,
                                                                      SCREEN_WIDTH-SCREEN_WIDTH/375*40,
                                                                      SCREEN_WIDTH/375*40)];
    }
    return _telTextField;
}


-(UILabel *)tipLabel{
    if (_tipLabel==nil) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                              CGRectGetMaxY(self.telTextField.frame)+SCREEN_WIDTH/375*8,
                                                              SCREEN_WIDTH-SCREEN_WIDTH/375*40,
                                                              SCREEN_WIDTH/375*36)];
    }
    return _tipLabel;
}


@end
