//
//  ZMEditDataView.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/23.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMEditDataView.h"



@interface ZMEditDataView ()
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *nickLabel;

@property(nonatomic,strong)UILabel *maleLabel;
@property(nonatomic,strong)UILabel *femaleLabel;

@property(nonatomic,strong)UIView  *contactView;
@property(nonatomic,strong)UILabel *contactLabel;

@property(nonatomic,strong)UILabel *telLabel;
@property(nonatomic,strong)UILabel *emailLabel;
@property(nonatomic,strong)UILabel *tipLabel;

@property(nonatomic,strong)UIView  *positionView;
@property(nonatomic,strong)UILabel *positionLabel;

@property(nonatomic,strong)UILabel *companyLabel;
@property(nonatomic,strong)UILabel *posLabel;
@property(nonatomic,strong)UILabel *cityLabel;

@property(nonatomic,strong)UIView  *mainSellView;
@property(nonatomic,strong)UILabel *mainSellLabel;
@property(nonatomic,strong)UILabel *mainTipLabel;





@end

@implementation ZMEditDataView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    
    self.backgroundColor = [UIColor whiteColor];
    
    [ZMLabelAttributeMange setLabel:self.nameLabel
                               text:@"姓名"
                                hex:@"333333"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    //[ZMLabelAttributeMange attributeLabel:self.nameLabel range:NSMakeRange(3, 1)];
    [self addSubview:self.nameLabel];
    
    
    [self text:self.nametextField];
    [self addSubview:self.nametextField];
    
    [ZMLabelAttributeMange setLabel:self.nickLabel
                               text:@"称呼 *"
                                hex:@"333333"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    [ZMLabelAttributeMange attributeLabel:self.nickLabel range:NSMakeRange(3, 1)];
    //[self addSubview:self.nickLabel];
    
    //先生
    //self.maleView.backgroundColor = [UIColor yellowColor];
    [self addSubview:self.maleView];
    
    self.maleImageView.image = [UIImage imageNamed:@"maleSelectedImage"];
    [self.maleView addSubview:self.maleImageView];
    
    [ZMLabelAttributeMange setLabel:self.maleLabel
                               text:@"先生"
                                hex:@"000000"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    [self.maleView addSubview:self.maleLabel];
    

    //女士
    //self.femaleView.backgroundColor = [UIColor yellowColor];
    [self addSubview:self.femaleView];
    
    self.femaleImageView.image = [UIImage imageNamed:@"maleNoSelectedImage"];
    [self.femaleView addSubview:self.femaleImageView];
    
    [ZMLabelAttributeMange setLabel:self.femaleLabel
                               text:@"女士"
                                hex:@"000000"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    [self.femaleView addSubview:self.femaleLabel];
    
    //联系方式
    self.contactView.backgroundColor = [UIColor colorWithHex:@"EAEAEA"];
    [self addSubview:self.contactView];
    
    [ZMLabelAttributeMange setLabel:self.contactLabel
                               text:@"联系方式"
                                hex:@"666666"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*13]];
    [self.contactView addSubview:self.contactLabel];
    
    //tel
    [ZMLabelAttributeMange setLabel:self.telLabel
                               text:@"电话"
                                hex:@"333333"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    //[ZMLabelAttributeMange attributeLabel:self.nickLabel range:NSMakeRange(3, 1)];
    [self addSubview:self.telLabel];
    
    [self text:self.telTextField];
    [self addSubview:self.telTextField];
    
    //email
    [ZMLabelAttributeMange setLabel:self.emailLabel
                               text:@"邮箱"
                                hex:@"333333"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    [self addSubview:self.emailLabel];
    
    [self text:self.emailTextField];
    [self addSubview:self.emailTextField];
    
    //tip
    [ZMLabelAttributeMange setLabel:self.tipLabel
                               text:@"*以上联系信息仅供平台联系使用，不会对外公布"
                                hex:@"999999"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
    [ZMLabelAttributeMange attributeLabel:self.tipLabel range:NSMakeRange(0, 1)];
    [self addSubview:self.tipLabel];
    
    //任职信息
    self.positionView.backgroundColor = [UIColor colorWithHex:@"EAEAEA"];
    [self addSubview:self.positionView];
    
    [ZMLabelAttributeMange setLabel:self.positionLabel
                               text:@"任职信息"
                                hex:@"666666"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*13]];
    [self.positionView addSubview:self.positionLabel];
    
    //company
    [ZMLabelAttributeMange setLabel:self.companyLabel
                               text:@"公司名称"
                                hex:@"333333"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    //[ZMLabelAttributeMange attributeLabel:self.companyLabel range:NSMakeRange(4, 1)];
    [self addSubview:self.companyLabel];
    
    [self text:self.companyTextField];
    [self addSubview:self.companyTextField];
    
    //position
    [ZMLabelAttributeMange setLabel:self.posLabel
                               text:@"现任职务"
                                hex:@"333333"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    //[ZMLabelAttributeMange attributeLabel:self.posLabel range:NSMakeRange(4, 1)];
    [self addSubview:self.posLabel];
    
    [self text:self.positionTextField];
    [self addSubview:self.positionTextField];
    
    //city
    [ZMLabelAttributeMange setLabel:self.cityLabel
                               text:@"所在城市"
                                hex:@"333333"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    [self addSubview:self.cityLabel];
    
    [self text:self.cityTextField];
    [self addSubview:self.cityTextField];
    
    //主营业务
    self.mainSellView.backgroundColor = [UIColor colorWithHex:@"EAEAEA"];
    [self addSubview:self.mainSellView];
    
    [ZMLabelAttributeMange setLabel:self.mainSellLabel
                               text:@"主营业务（以下最多可选择3项）"
                                hex:@"666666"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*13]];
    [self.mainSellView addSubview:self.mainSellLabel];
    
    [ZMLabelAttributeMange setLabel:self.mainTipLabel
                               text:@"点击选择：企业咨询、地产评估、招标代理"
                                hex:@"666666"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*13]];
    //[self addSubview:self.mainTipLabel];
    
    
    
    
    
    
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

//name
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
        _nametextField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20, CGRectGetMaxY(self.nameLabel.frame)+SCREEN_WIDTH/375*10, SCREEN_WIDTH-SCREEN_WIDTH/375*40, SCREEN_WIDTH/375*40)];
    }
    return _nametextField;
}

//nick
-(UILabel *)nickLabel{
    if (_nickLabel==nil) {
        _nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20, CGRectGetMaxY(self.nametextField.frame)+SCREEN_WIDTH/375*17, SCREEN_WIDTH/375*200, SCREEN_WIDTH/375*17)];
    }
    return _nickLabel;
}
//先生
-(UIView *)maleView{
    if (_maleView==nil) {
        _maleView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20, CGRectGetMaxY(self.nametextField.frame)+SCREEN_WIDTH/375*19, SCREEN_WIDTH/375*47, SCREEN_WIDTH/375*17)];
    }
    return _maleView;
}

-(UIImageView *)maleImageView{
    if (_maleImageView==nil) {
        _maleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/375*17.2, SCREEN_WIDTH/375*17.2)];
    }
    return _maleImageView;
}

-(UILabel *)maleLabel{
    if (_maleLabel==nil) {
        _maleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*21, 0, SCREEN_WIDTH/375*30, SCREEN_WIDTH/375*17)];
    }
    return _maleLabel;
}

//女士
-(UIView *)femaleView{
    if (_femaleView==nil) {
        _femaleView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*101, CGRectGetMaxY(self.nametextField.frame)+SCREEN_WIDTH/375*19, SCREEN_WIDTH/375*47, SCREEN_WIDTH/375*17)];
    }
    return _femaleView;
}
-(UIImageView *)femaleImageView{
    if (_femaleImageView==nil) {
        _femaleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/375*17.2, SCREEN_WIDTH/375*17.2)];
    }
    return _femaleImageView;
}

-(UILabel *)femaleLabel{
    if (_femaleLabel==nil) {
        _femaleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*21, 0, SCREEN_WIDTH/375*30, SCREEN_WIDTH/375*17)];
    }
    return _femaleLabel;
}

//联系方式
-(UIView *)contactView{
    if (_contactView==nil) {
        _contactView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.maleView.frame)+SCREEN_WIDTH/375*23, SCREEN_WIDTH, SCREEN_WIDTH/375*29.5)];
    }
    return _contactView;
}

-(UILabel *)contactLabel{
    if (_contactLabel==nil) {
        _contactLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20, 0, SCREEN_WIDTH/375*200, SCREEN_WIDTH/375*29.5)];
    }
    return _contactLabel;
}

//tel
-(UILabel *)telLabel{
    if (_telLabel==nil) {
        _telLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20, CGRectGetMaxY(self.contactView.frame)+SCREEN_WIDTH/375*18.5, SCREEN_WIDTH/375*200, SCREEN_WIDTH/375*17)];
    }
    return _telLabel;
}

-(UITextField *)telTextField{
    if (_telTextField==nil) {
        _telTextField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20, CGRectGetMaxY(self.telLabel.frame)+SCREEN_WIDTH/375*10, SCREEN_WIDTH-SCREEN_WIDTH/375*40, SCREEN_WIDTH/375*40)];
    }
    return _telTextField;
}

//email
-(UILabel *)emailLabel{
    if (_emailLabel==nil) {
        _emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20, CGRectGetMaxY(self.telTextField.frame)+SCREEN_WIDTH/375*8, SCREEN_WIDTH/375*200, SCREEN_WIDTH/375*17)];
    }
    return _emailLabel;
}

-(UITextField *)emailTextField{
    if (_emailTextField==nil) {
        _emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20, CGRectGetMaxY(self.emailLabel.frame)+SCREEN_WIDTH/375*10, SCREEN_WIDTH-SCREEN_WIDTH/375*40, SCREEN_WIDTH/375*40)];
    }
    return _emailTextField;
}

-(UILabel *)tipLabel{
    if (_tipLabel==nil) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20, CGRectGetMaxY(self.emailTextField.frame)+SCREEN_WIDTH/375*7, SCREEN_WIDTH, SCREEN_WIDTH/375*17)];
    }
    return _tipLabel;
}

//任职信息
-(UIView *)positionView{
    if (_positionView==nil) {
        _positionView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tipLabel.frame)+SCREEN_WIDTH/375*15, SCREEN_WIDTH, SCREEN_WIDTH/375*29.5)];
    }
    return _positionView;
}

-(UILabel *)positionLabel{
    if (_positionLabel==nil) {
        _positionLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20, 0, SCREEN_WIDTH/375*200, SCREEN_WIDTH/375*29.5)];
    }
    return _positionLabel;
}

//company
-(UILabel *)companyLabel{
    if (_companyLabel==nil) {
        _companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20, CGRectGetMaxY(self.positionView.frame)+SCREEN_WIDTH/375*18.5, SCREEN_WIDTH/375*200, SCREEN_WIDTH/375*17)];
    }
    return _companyLabel;
}

-(UITextField *)companyTextField{
    if (_companyTextField==nil) {
        _companyTextField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20, CGRectGetMaxY(self.companyLabel.frame)+SCREEN_WIDTH/375*10, SCREEN_WIDTH-SCREEN_WIDTH/375*40, SCREEN_WIDTH/375*40)];
    }
    return _companyTextField;
}

//poistion
-(UILabel *)posLabel{
    if (_posLabel==nil) {
        _posLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20, CGRectGetMaxY(self.companyTextField.frame)+SCREEN_WIDTH/375*8, SCREEN_WIDTH/375*200, SCREEN_WIDTH/375*17)];
    }
    return _posLabel;
}

-(UITextField *)positionTextField{
    if (_positionTextField==nil) {
        _positionTextField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20, CGRectGetMaxY(self.posLabel.frame)+SCREEN_WIDTH/375*10, SCREEN_WIDTH-SCREEN_WIDTH/375*40, SCREEN_WIDTH/375*40)];
    }
    return _positionTextField;
}

//city
-(UILabel *)cityLabel{
    if (_cityLabel==nil) {
        _cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20, CGRectGetMaxY(self.positionTextField.frame)+SCREEN_WIDTH/375*8, SCREEN_WIDTH/375*200, SCREEN_WIDTH/375*17)];
    }
    return _cityLabel;
}

-(UITextField *)cityTextField{
    if (_cityTextField==nil) {
        _cityTextField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20, CGRectGetMaxY(self.cityLabel.frame)+SCREEN_WIDTH/375*10, SCREEN_WIDTH-SCREEN_WIDTH/375*40, SCREEN_WIDTH/375*40)];
    }
    return _cityTextField;
}

//主营业务
-(UIView *)mainSellView{
    if (_mainSellView==nil) {
        _mainSellView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.cityTextField.frame)+SCREEN_WIDTH/375*15, SCREEN_WIDTH, SCREEN_WIDTH/375*29.5)];
    }
    return _mainSellView;
}

-(UILabel *)mainSellLabel{
    if (_mainSellLabel==nil) {
        _mainSellLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20, 0, SCREEN_WIDTH/375*200, SCREEN_WIDTH/375*29.5)];
    }
    return _mainSellLabel;
}

-(UILabel *)mainTipLabel{
    if (_mainTipLabel==nil) {
        _mainTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20, CGRectGetMaxY(self.mainSellView.frame)+SCREEN_WIDTH/375*13.5, SCREEN_WIDTH, SCREEN_WIDTH/375*20)];
    }
    return _mainTipLabel;
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
        

        _tagView.backgroundColor = [UIColor whiteColor];
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
