//
//  ZMBaseCompanyInfoView.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMBaseCompanyInfoView.h"

@interface ZMBaseCompanyInfoView ()

@end

@implementation ZMBaseCompanyInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)addUI{
    //企业名称
    [ZMLabelAttributeMange setLabel:self.nameLabel
                               text:@"企业名称 "
                                hex:@"333333"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    //[ZMLabelAttributeMange attributeLabel:self.nameLabel range:NSMakeRange(3, 1)];
    [self addSubview:self.nameLabel];
    
    [self text:self.nametextField];
    [self addSubview:self.nametextField];
    
    
    //公司性质
    [ZMLabelAttributeMange setLabel:self.xingzhiLabel
                               text:@"公司性质"
                                hex:@"333333"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    //[ZMLabelAttributeMange attributeLabel:self.nameLabel range:NSMakeRange(3, 1)];
    [self addSubview:self.xingzhiLabel];
    
    [self text:self.companyXingzhitextField];
    [self addSubview:self.companyXingzhitextField];
    
    
    //所在城市
    [ZMLabelAttributeMange setLabel:self.cityLabel
                               text:@"所在城市"
                                hex:@"333333"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    //[ZMLabelAttributeMange attributeLabel:self.nameLabel range:NSMakeRange(3, 1)];
    [self addSubview:self.cityLabel];
    
    [self text:self.citytextField];
    [self addSubview:self.citytextField];
    
    
    //联系人信息
    self.contactView.backgroundColor = [UIColor colorWithHex:@"EAEAEA"];
    [self addSubview:self.contactView];
    
    [ZMLabelAttributeMange setLabel:self.contactLabel
                               text:@"联系人信息"
                                hex:@"666666"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*13]];
    [self.contactView addSubview:self.contactLabel];
    
    //name
    [ZMLabelAttributeMange setLabel:self.contactNameLabel
                               text:@"姓名"
                                hex:@"333333"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    //[ZMLabelAttributeMange attributeLabel:self.nameLabel range:NSMakeRange(3, 1)];
    [self addSubview:self.contactNameLabel];
    
    [self text:self.contactNameextField];
    [self addSubview:self.contactNameextField];
    
    //positon
    [ZMLabelAttributeMange setLabel:self.positionLabel
                               text:@"职务"
                                hex:@"333333"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    //[ZMLabelAttributeMange attributeLabel:self.nameLabel range:NSMakeRange(3, 1)];
    [self addSubview:self.positionLabel];
    
    [self text:self.positionTextField];
    [self addSubview:self.positionTextField];
    
    //tel
    [ZMLabelAttributeMange setLabel:self.telLabel
                               text:@"电话"
                                hex:@"333333"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    //[ZMLabelAttributeMange attributeLabel:self.nameLabel range:NSMakeRange(3, 1)];
    [self addSubview:self.telLabel];
    
    [self text:self.telTextField];
    [self addSubview:self.telTextField];
    
    
    
    
    //主营业务
    self.mainSellView.backgroundColor = [UIColor colorWithHex:@"EAEAEA"];
    [self addSubview:self.mainSellView];
    
    [ZMLabelAttributeMange setLabel:self.mainSellLabel
                               text:@"主营业务（以下最多可选择3项）"
                                hex:@"666666"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*13]];
    [self.mainSellView addSubview:self.mainSellLabel];
    

    self.tagBackView.backgroundColor = [UIColor colorWithHex:backGroundColor];
    self.tagBackView.layer.cornerRadius = SCREEN_WIDTH/375*5;
    //[self addSubview:self.tagBackView];
    
    //self.tagView.backgroundColor = [UIColor colorWithHex:backGroundColor];
    [self addSubview:self.tagView];
    
    
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    /** 选择器 */
    [keyWindow addSubview:self.pickerView];
    [self.pickerView addSubview:self.infoPicker];
    [self.pickerView addSubview:self.confirmBtn];
    [self.pickerView addSubview:self.cancelBtn];
    
    

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
//企业名称
-(UILabel *)nameLabel{
    if (_nameLabel==nil) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                               64+SCREEN_WIDTH/375*21,
                                                               SCREEN_WIDTH/375*200,
                                                               SCREEN_WIDTH/375*17)];
    }
    return _nameLabel;
}

-(UITextField *)nametextField{
    if (_nametextField==nil) {
        _nametextField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                       CGRectGetMaxY(self.nameLabel.frame)+SCREEN_WIDTH/375*10,
                                       SCREEN_WIDTH-SCREEN_WIDTH/375*40,
                                       SCREEN_WIDTH/375*40)];
}
    return _nametextField;
}
//公司性质
-(UILabel *)xingzhiLabel{
    if (_xingzhiLabel==nil) {
        _xingzhiLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                       CGRectGetMaxY(self.nametextField.frame)+SCREEN_WIDTH/375*10,
                                       SCREEN_WIDTH/375*200,
                                       SCREEN_WIDTH/375*17)];
}
    return _xingzhiLabel;
}

-(UITextField *)companyXingzhitextField{
    if (_companyXingzhitextField==nil) {
        _companyXingzhitextField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                       CGRectGetMaxY(self.xingzhiLabel.frame)+SCREEN_WIDTH/375*10,
                                       SCREEN_WIDTH-SCREEN_WIDTH/375*40,
                                       SCREEN_WIDTH/375*40)];
    }
    return _companyXingzhitextField;
}
//所在城市
-(UILabel *)cityLabel{
    if (_cityLabel==nil) {
        _cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                                  CGRectGetMaxY(self.companyXingzhitextField.frame)+SCREEN_WIDTH/375*10,
                                                                  SCREEN_WIDTH/375*200,
                                                                  SCREEN_WIDTH/375*17)];
    }
    return _cityLabel;
}

-(UITextField *)citytextField{
    if (_citytextField==nil) {
        _citytextField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                                                 CGRectGetMaxY(self.cityLabel.frame)+SCREEN_WIDTH/375*10,
                                                                                 SCREEN_WIDTH-SCREEN_WIDTH/375*40,
                                                                                 SCREEN_WIDTH/375*40)];
    }
    return _citytextField;
}



//联系人信息
-(UIView *)contactView{
    if (_contactView==nil) {
        _contactView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                         CGRectGetMaxY(self.citytextField.frame)+SCREEN_WIDTH/375*15,
                                        SCREEN_WIDTH,
                                        SCREEN_WIDTH/375*29.5)];
    }
    return _contactView;
}

-(UILabel *)contactLabel{
    if (_contactLabel==nil) {
        _contactLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                                  0,
                                                                  SCREEN_WIDTH/375*200,
                                                                  SCREEN_WIDTH/375*29.5)];
    }
    return _contactLabel;
}

//company
-(UILabel *)contactNameLabel{
    if (_contactNameLabel==nil) {
        _contactNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                          CGRectGetMaxY(self.contactView.frame)+SCREEN_WIDTH/375*18.5,
                                          SCREEN_WIDTH/375*200,
                                          SCREEN_WIDTH/375*17)];
    }
    return _contactNameLabel;
}

-(UITextField *)contactNameextField{
    if (_contactNameextField==nil) {
        _contactNameextField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                 CGRectGetMaxY(self.contactNameLabel.frame)+SCREEN_WIDTH/375*10,
                                 SCREEN_WIDTH-SCREEN_WIDTH/375*40,
                                 SCREEN_WIDTH/375*40)];
    }
    return _contactNameextField;
}

//poistion
-(UILabel *)positionLabel{
    if (_positionLabel==nil) {
        _positionLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                           CGRectGetMaxY(self.contactNameextField.frame)+SCREEN_WIDTH/375*8,
                                           SCREEN_WIDTH/375*200,
                                           SCREEN_WIDTH/375*17)];
    }
    return _positionLabel;
}

-(UITextField *)positionTextField{
    if (_positionTextField==nil) {
        _positionTextField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                           CGRectGetMaxY(self.positionLabel.frame)+SCREEN_WIDTH/375*10,
                                           SCREEN_WIDTH-SCREEN_WIDTH/375*40,
                                           SCREEN_WIDTH/375*40)];
    }
    return _positionTextField;
}

//city
-(UILabel *)telLabel{
    if (_telLabel==nil) {
        _telLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                      CGRectGetMaxY(self.positionTextField.frame)+SCREEN_WIDTH/375*8,
                                      SCREEN_WIDTH/375*200,
                                      SCREEN_WIDTH/375*17)];
    }
    return _telLabel;
}

-(UITextField *)telTextField{
    if (_telTextField==nil) {
        _telTextField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                  CGRectGetMaxY(self.telLabel.frame)+SCREEN_WIDTH/375*10,
                                  SCREEN_WIDTH-SCREEN_WIDTH/375*40,
                                  SCREEN_WIDTH/375*40)];
    }
    return _telTextField;
}



//主营业务
-(UIView *)mainSellView{
    if (_mainSellView==nil) {
        _mainSellView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                     CGRectGetMaxY(self.telTextField.frame)+SCREEN_WIDTH/375*23,
                                     SCREEN_WIDTH,
                                     SCREEN_WIDTH/375*29.5)];
    }
    return _mainSellView;
}

-(UILabel *)mainSellLabel{
    if (_mainSellLabel==nil) {
        _mainSellLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                                   0,
                                                                   SCREEN_WIDTH/375*200,
                                                                   SCREEN_WIDTH/375*29.5)];
    }
    return _mainSellLabel;
}
//tag back
- (UIView *)tagBackView {
    
    if (_tagBackView == nil) {
        _tagBackView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                                CGRectGetMaxY(self.mainSellView.frame)+SCREEN_WIDTH/375*20,
                                                                SCREEN_WIDTH-SCREEN_WIDTH/375*40,
                                                                SCREEN_WIDTH/375*147)];
        
        
    }
    return _tagBackView;
}


- (TTGTextTagCollectionView *)tagView {
    
    if (_tagView == nil) {
        _tagView = [[TTGTextTagCollectionView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                                              CGRectGetMaxY(self.mainSellView.frame)+SCREEN_WIDTH/375*20,
                                                                              SCREEN_WIDTH-SCREEN_WIDTH/375*40,
                                                                              SCREEN_WIDTH/375*147)];
        
        /** config */
        _tagView.defaultConfig.tagTextFont          = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        _tagView.defaultConfig.tagTextColor         = [UIColor colorWithHex:@"999999"];
        _tagView.defaultConfig.tagSelectedTextColor = [UIColor colorWithHex:@"ffffff"];
        _tagView.defaultConfig.tagBackgroundColor   = [UIColor whiteColor];
        _tagView.defaultConfig.tagSelectedBackgroundColor = [UIColor colorWithHex:tonalColor];
        _tagView.defaultConfig.tagCornerRadius      = 4;
        _tagView.defaultConfig.tagSelectedCornerRadius = 4;
        _tagView.defaultConfig.tagBorderWidth       = 1;
        _tagView.defaultConfig.tagSelectedBorderWidth = 1;
        _tagView.defaultConfig.tagBorderColor       = [UIColor colorWithHex:@"999999"];
        _tagView.defaultConfig.tagSelectedBorderColor = [UIColor colorWithHex:tonalColor];
        _tagView.defaultConfig.tagShadowColor       = [UIColor whiteColor];
        _tagView.defaultConfig.tagShadowOffset      = CGSizeMake(0, 0);
        _tagView.defaultConfig.tagShadowRadius      = 0;
        _tagView.defaultConfig.tagShadowOpacity     = 0;
        _tagView.defaultConfig.tagExtraSpace        = CGSizeMake(18, 15);
        _tagView.verticalSpacing = SCREEN_WIDTH/37.5;
        
        //_tagView.backgroundColor = [UIColor redColor];
    }
    return _tagView;
}







/** pickerView */
- (UIView *)pickerView {
    
    if (_pickerView == nil) {
        _pickerView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT , SCREEN_WIDTH, 240)];
        _pickerView.backgroundColor = [UIColor whiteColor];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = [UIColor colorWithHex:@"bbbbbb"];
        [_pickerView addSubview:line];
    }
    [self infoPicker];
    return _pickerView;
}

- (UIPickerView *)infoPicker {
    
    if (_infoPicker == nil) {
        _infoPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40 , SCREEN_WIDTH, 200)];
        _infoPicker.backgroundColor = [UIColor whiteColor];
        _infoPicker.layer.masksToBounds = NO;
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = [UIColor colorWithHex:@"bbbbbb"];
        [_infoPicker addSubview:line];
    }
    [_infoPicker reloadAllComponents];
    return _infoPicker;
}

- (UIButton *)confirmBtn {
    
    if (_confirmBtn == nil) {
        /** 确认 */
        _confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60,0,60,40)];
        [_confirmBtn.titleLabel setFont:[UIFont systemFontOfSize:SCREEN_WIDTH/26.78]];
        [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor colorWithHex:@"2E6EFA"] forState:UIControlStateNormal];
    }
    return _confirmBtn;
}

- (UIButton *)cancelBtn {
    
    if (_cancelBtn == nil) {
        /** 取消 */
        _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0,60,40)];
        [_cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:SCREEN_WIDTH/26.78]];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor colorWithHex:@"2E6EFA"] forState:UIControlStateNormal];
    }
    return _cancelBtn;
}


@end
