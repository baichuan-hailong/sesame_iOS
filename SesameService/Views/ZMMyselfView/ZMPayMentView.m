//
//  ZMPayMentView.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/28.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMPayMentView.h"

@interface ZMPayMentView ()
@property(nonatomic,strong)UIView *typeLine;
@property(nonatomic,strong)UIView *personLine;
@property(nonatomic,strong)UIView *accountLine;
@property(nonatomic,strong)UIView *telLine;
@end

@implementation ZMPayMentView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    self.backgroundColor = [UIColor whiteColor];
    
    
    
    [self setButton:self.changeButton title:@"修改" color:[UIColor colorWithHex:@"FFFFFF"] font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14] boo:YES];
    [self.changeButton setBackgroundColor:[UIColor colorWithHex:tonalColor]];
    [self addSubview:self.changeButton];
    
    
    //收款方式
    self.typeLine.backgroundColor = [UIColor colorWithHex:@"E7E7E7"];
    [self addSubview:self.typeLine];
    
    [ZMLabelAttributeMange setLabel:self.collectionTypeLabel
                               text:@"收款方式"
                                hex:@"999999"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    [self addSubview:self.collectionTypeLabel];
    
    [ZMLabelAttributeMange setLabel:self.collectionLabel
                               text:@"微信"
                                hex:@"333333"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    [self addSubview:self.collectionLabel];
    
    //收款人
    self.personLine.backgroundColor = [UIColor colorWithHex:@"E7E7E7"];
    [self addSubview:self.personLine];
    
    [ZMLabelAttributeMange setLabel:self.personLabel
                               text:@"收款人"
                                hex:@"999999"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    [self addSubview:self.personLabel];
    
    
    [ZMLabelAttributeMange setLabel:self.personContentLabel
                               text:@"安家万邦"
                                hex:@"333333"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    [self addSubview:self.personContentLabel];
    
    
    //账号
    self.accountLine.backgroundColor = [UIColor colorWithHex:@"E7E7E7"];
    [self addSubview:self.accountLine];
    
    [ZMLabelAttributeMange setLabel:self.accountLabel
                               text:@"微信号"
                                hex:@"999999"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    [self addSubview:self.accountLabel];
    
    [ZMLabelAttributeMange setLabel:self.accountContentLabel
                               text:@"www123"
                                hex:@"333333"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    [self addSubview:self.accountContentLabel];
    
    //手机号
    self.telLine.backgroundColor = [UIColor colorWithHex:@"E7E7E7"];
    [self addSubview:self.telLine];
    
    [ZMLabelAttributeMange setLabel:self.telLabel
                               text:@"手机号"
                                hex:@"999999"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    [self addSubview:self.telLabel];
    
    
    [ZMLabelAttributeMange setLabel:self.telContentLabel
                               text:@"13522857012"
                                hex:@"333333"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    [self addSubview:self.telContentLabel];
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

//lazy
-(UIButton *)changeButton{
    if (!_changeButton) {
        _changeButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20, SCREEN_WIDTH/375*64+SCREEN_WIDTH/375*246, SCREEN_WIDTH-SCREEN_WIDTH/375*40, SCREEN_WIDTH/375*40)];
    }
    return _changeButton;
}

//收款方式
-(UILabel *)collectionTypeLabel{
    if (_collectionTypeLabel==nil) {
        _collectionTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*21, SCREEN_WIDTH/375*64+SCREEN_WIDTH/375*48, SCREEN_WIDTH/375*60, SCREEN_WIDTH/375*20)];
    }
    return _collectionTypeLabel;
}

-(UILabel *)collectionLabel{
    if (_collectionLabel==nil) {
        _collectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*101, SCREEN_WIDTH/375*64+SCREEN_WIDTH/375*48, SCREEN_WIDTH-SCREEN_WIDTH/375*101, SCREEN_WIDTH/375*20)];
    }
    return _collectionLabel;
}

-(UIView *)typeLine{
    if (_typeLine==nil) {
        _typeLine = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*18, SCREEN_WIDTH/375*64+SCREEN_WIDTH/375*83, SCREEN_WIDTH-SCREEN_WIDTH/375*35, SCREEN_WIDTH/375*1)];
    }
    return _typeLine;
}

//收款人
-(UIView *)personLine{
    if (_personLine==nil) {
        _personLine = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*18, SCREEN_WIDTH/375*64+SCREEN_WIDTH/375*130, SCREEN_WIDTH-SCREEN_WIDTH/375*35, SCREEN_WIDTH/375*1)];
    }
    return _personLine;
}

-(UILabel *)personLabel{
    if (_personLabel==nil) {
        _personLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*21, SCREEN_WIDTH/375*64+SCREEN_WIDTH/375*98, SCREEN_WIDTH/375*60, SCREEN_WIDTH/375*20)];
    }
    return _personLabel;
}

-(UILabel *)personContentLabel{
    if (_personContentLabel==nil) {
        _personContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*101, SCREEN_WIDTH/375*64+SCREEN_WIDTH/375*98, SCREEN_WIDTH-SCREEN_WIDTH/375*101, SCREEN_WIDTH/375*20)];
    }
    return _personContentLabel;
}

//账号
-(UIView *)accountLine{
    if (_accountLine==nil) {
        _accountLine = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*18, SCREEN_WIDTH/375*64+SCREEN_WIDTH/375*177, SCREEN_WIDTH-SCREEN_WIDTH/375*35, SCREEN_WIDTH/375*1)];
    }
    return _accountLine;
}

-(UILabel *)accountLabel{
    if (_accountLabel==nil) {
        _accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*21, SCREEN_WIDTH/375*64+SCREEN_WIDTH/375*145, SCREEN_WIDTH/375*60, SCREEN_WIDTH/375*20)];
    }
    return _accountLabel;
}

-(UILabel *)accountContentLabel{
    if (_accountContentLabel==nil) {
        _accountContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*101, SCREEN_WIDTH/375*64+SCREEN_WIDTH/375*145, SCREEN_WIDTH-SCREEN_WIDTH/375*101, SCREEN_WIDTH/375*20)];
    }
    return _accountContentLabel;
}
//手机号
-(UIView *)telLine{
    if (_telLine==nil) {
        _telLine = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*18, SCREEN_WIDTH/375*64+SCREEN_WIDTH/375*225, SCREEN_WIDTH-SCREEN_WIDTH/375*35, SCREEN_WIDTH/375*1)];
    }
    return _telLine;
}


-(UILabel *)telLabel{
    if (_telLabel==nil) {
        _telLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*21, SCREEN_WIDTH/375*64+SCREEN_WIDTH/375*192, SCREEN_WIDTH/375*60, SCREEN_WIDTH/375*20)];
    }
    return _telLabel;
}

-(UILabel *)telContentLabel{
    if (_telContentLabel==nil) {
        _telContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*101, SCREEN_WIDTH/375*64+SCREEN_WIDTH/375*192, SCREEN_WIDTH-SCREEN_WIDTH/375*101, SCREEN_WIDTH/375*20)];
    }
    return _telContentLabel;
}


@end
