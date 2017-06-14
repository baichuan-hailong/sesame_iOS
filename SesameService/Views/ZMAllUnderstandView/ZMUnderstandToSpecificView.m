//
//  ZMUnderstandToSpecificView.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/5.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMUnderstandToSpecificView.h"
#import "ZMSelectImageCollectionViewCell.h"

@interface ZMUnderstandToSpecificView ()
@property(nonatomic,strong)UIView  *contentView;
@property(nonatomic,strong)UILabel *amountLabel;
@property(nonatomic,strong)UIView *memberView;
@end

@implementation ZMUnderstandToSpecificView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    
        self.backgroundColor = [UIColor whiteColor];
        
        [self addUI];
        
    }
    return self;
}


- (void)addUI{
    
    self.headerImageView.contentMode     = UIViewContentModeScaleAspectFill;
    [self addSubview:self.headerImageView];
    
    //state
    self.stateImageView.image           = [UIImage imageNamed:@"haveRenzhengImage"];
    self.stateImageView.contentMode     = UIViewContentModeScaleAspectFit;
    [self addSubview:self.stateImageView];
    
    
    //name
    [ZMLabelAttributeMange setLabel:self.nameLabel
                               text:@"--"
                                hex:@"333333"
                      textAlignment:NSTextAlignmentCenter
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*15]];
    [self addSubview:self.nameLabel];
    
    
    
    
    //member
    self.memberView.backgroundColor = [UIColor colorWithHex:@"F4F1E7"];
    self.memberView.layer.cornerRadius  = SCREEN_WIDTH/375*10;
    self.memberView.layer.masksToBounds = YES;
    [self addSubview:self.memberView];
    
    //jinpai
    self.memberShipImageView.image = [UIImage imageNamed:@"jinpaiImage"];
    self.memberShipImageView.contentMode     = UIViewContentModeScaleAspectFit;
    [self.memberView addSubview:self.memberShipImageView];
    
    [ZMLabelAttributeMange setLabel:self.memberLabel
                               text:@"---"
                                hex:@"666666"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*11]];
    [self.memberView addSubview:self.memberLabel];
    
    
    //exper
    [ZMLabelAttributeMange setLabel:self.experienceLabel
                               text:@"累计回答--次 - 赢得赏金--次"
                                hex:@"AAAAAA"
                      textAlignment:NSTextAlignmentCenter
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*10]];
    self.experienceLabel.layer.cornerRadius = SCREEN_WIDTH/375*8;
    self.experienceLabel.layer.borderWidth  = SCREEN_WIDTH/375*1;
    self.experienceLabel.layer.borderColor  = [UIColor colorWithHex:@"DDDDDD"].CGColor;
    [self addSubview:self.experienceLabel];
    
    
    
    
    
    //content
    self.contentView.layer.cornerRadius = SCREEN_WIDTH/375*4;
    self.contentView.layer.borderWidth  = SCREEN_WIDTH/375*1;
    self.contentView.layer.borderColor  = [UIColor colorWithHex:@"CCCCCC"].CGColor;
    //self.contentView.backgroundColor    = [UIColor redColor];
    [self addSubview:self.contentView];
    
    
    
    ///copy
    //place
    //self.suggestTextView.backgroundColor = [UIColor yellowColor];
    self.suggestTextView.font            = [UIFont fontWithName:@"Helvetica" size:SCREEN_WIDTH/375*14];
    [self.contentView addSubview:self.suggestTextView];
    //pl
    [ZMLabelAttributeMange setLabel:self.suggestPlaceHolderLabel
                               text:@"请输入您的问题内容，72小时内无人回答，将按原支付路径全额退款。"
                                hex:@"B2B2B2"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    self.suggestPlaceHolderLabel.numberOfLines = 0;
    [self.suggestTextView addSubview:self.suggestPlaceHolderLabel];
    
    //count
    [ZMLabelAttributeMange setLabel:self.worldCountLabel
                               text:@"0/300"
                                hex:@"999999"
                      textAlignment:NSTextAlignmentRight
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*10]];
    [self.contentView addSubview:self.worldCountLabel];
    
    //cell
    //self.shareCollectionView.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:self.shareCollectionView];
    
    
    //amount
    [ZMLabelAttributeMange setLabel:self.amountLabel
                               text:@"设置悬赏金额（元）"
                                hex:@"000000"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    [self addSubview:self.amountLabel];
    
    [self text:self.amountTextField];
    self.amountTextField.placeholder = @"请输入悬赏金额（10-10000）";
    self.amountTextField.keyboardType= UIKeyboardTypeNumberPad;
    [self addSubview:self.amountTextField];
    
    //isPulic
    //self.isPublicView.backgroundColor = [UIColor yellowColor];
    //[self addSubview:self.isPublicView];
    
    
    //self.isPublicTipImageView.backgroundColor = [UIColor redColor];
    self.isPublicTipImageView.image = [UIImage imageNamed:@"publicSelectImage"];
    [self.isPublicView addSubview:self.isPublicTipImageView];
    
    [ZMLabelAttributeMange setLabel:self.isPublicTipLabel
                               text:@"公开答案"
                                hex:@"000000"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    [self.isPublicView addSubview:self.isPublicTipLabel];
    
    [ZMLabelAttributeMange setLabel:self.isPublicBottomLabel
                               text:@"提问可选公开或私密，公开提问的回答所有人都可以看到"
                                hex:@"AAAAAA"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
    [self.isPublicView addSubview:self.isPublicBottomLabel];
    
    //release
    [self setButton:self.commitButtton
              title:@"发布打听"
              color:[UIColor colorWithHex:@"FFFFFF"]
               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*16]
                boo:NO];
    [self.commitButtton setBackgroundColor:[UIColor colorWithHex:tonalColor]];
    [self addSubview:self.commitButtton];
    
    self.commitButtton.alpha = 0.6;
    self.commitButtton.userInteractionEnabled = NO;
    
    
    
    //self.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+0.5);
    //self.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(self.commitButtton.frame)+SCREEN_WIDTH/375*20);
}


- (void)setTopPer:(NSDictionary *)topDic{

    
    NSString *avatar     = [NSString stringWithFormat:@"%@",topDic[@"avatar"]];
    NSString *auth       = [NSString stringWithFormat:@"%@",topDic[@"auth"]];
    NSString *level      = [NSString stringWithFormat:@"%@",topDic[@"level"]];
    //NSString *main_biz   = [NSString stringWithFormat:@"%@",topDic[@"main_biz"]];
    
   
    if (avatar.length>10) {
        
        [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:avatar]
                                placeholderImage:[UIImage imageNamed:@"placeHeaderImage"]];
        self.headerImageView .backgroundColor = [UIColor lightGrayColor];
    }else{
        self.headerImageView.image = [UIImage imageNamed:@"placeHeaderImage"];
        self.headerImageView .backgroundColor = [UIColor lightGrayColor];
    }
    
    
    if ([auth isEqualToString:@"unauthed"]) {
        self.stateImageView.alpha = 0;
    }else if ([auth isEqualToString:@"authed"]){
        self.stateImageView.alpha = 1;
    }
    
    
    if ([level isEqualToString:@"gold"]) {
        self.memberShipImageView.image = [UIImage imageNamed:@"jinpaiImage"];
        self.memberLabel.text          = @"金牌会员";
    }else if ([level isEqualToString:@"silver"]){
        self.memberShipImageView.image = [UIImage imageNamed:@"yinpaiImage"];
        self.memberLabel.text          = @"银牌会员";
    }else if ([level isEqualToString:@"copper"]){
        self.memberShipImageView.image = [UIImage imageNamed:@"tongpaiImage"];
        self.memberLabel.text          = @"铜牌会员";
    }else{
        self.memberShipImageView.alpha = 0;
        self.memberLabel.alpha         = 0;
        self.memberView.alpha          = 0;
    }
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@",topDic[@"person_name"]];
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
    button.layer.cornerRadius = SCREEN_WIDTH/375*4;
}


- (void)text:(UITextField *)textField{
    textField.textAlignment = NSTextAlignmentLeft;
    textField.textColor     = [UIColor colorWithHex:@"666666"];
    textField.font          = [UIFont systemFontOfSize:SCREEN_WIDTH/375*14];
    textField.layer.borderColor = [UIColor colorWithHex:@"CCCCCC"].CGColor;
    textField.layer.borderWidth = SCREEN_WIDTH/375*1;
    textField.layer.cornerRadius= SCREEN_WIDTH/375*4;
    textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/375*12, SCREEN_WIDTH/375*40)];
    textField.leftView.backgroundColor = [UIColor clearColor];
    textField.leftViewMode = UITextFieldViewModeAlways;
}




//lazy
-(UIImageView *)headerImageView{
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*65)/2,
                                                                         SCREEN_WIDTH/375*24+64,
                                                                         SCREEN_WIDTH/375*65,
                                                                         SCREEN_WIDTH/375*65)];
        _headerImageView.layer.cornerRadius = SCREEN_WIDTH/375*4;
        _headerImageView.layer.masksToBounds= YES;
    }
    return _headerImageView;
}

//state
-(UIImageView *)stateImageView{
    if (!_stateImageView) {
        _stateImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*65)/2+SCREEN_WIDTH/375*54,
                                                                        SCREEN_WIDTH/375*77+64,
                                                                        SCREEN_WIDTH/375*16,
                                                                        SCREEN_WIDTH/375*16)];
    }
    return _stateImageView;
}


//name
-(UILabel *)nameLabel{
    if (_nameLabel==nil) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*0,
                                                               SCREEN_WIDTH/375*99+64,
                                                               SCREEN_WIDTH,
                                                               SCREEN_WIDTH/375*21)];
    }
    return _nameLabel;
}


//member
-(UIView *)memberView{
    if (!_memberView) {
        _memberView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*84)/2,
                                                               SCREEN_WIDTH/375*132+64,
                                                               SCREEN_WIDTH/375*84,
                                                               SCREEN_WIDTH/375*23)];
    }
    return _memberView;
}

-(UILabel *)memberLabel{
    if (!_memberLabel) {
        _memberLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*31,
                                                                 SCREEN_WIDTH/375*0,
                                                                 SCREEN_WIDTH/375*50,
                                                                 SCREEN_WIDTH/375*23)];
    }
    return _memberLabel;
}


-(UIImageView *)memberShipImageView{
    
    if (_memberShipImageView==nil) {
        _memberShipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*12.3,
                                                             (SCREEN_WIDTH/375*23-SCREEN_WIDTH/375*11.4)/2,
                                                             SCREEN_WIDTH/375*14,
                                                             SCREEN_WIDTH/375*16)];
}
    return _memberShipImageView;
}







-(UILabel *)experienceLabel{
    if (!_experienceLabel) {
        _experienceLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*164)/2,
                                                                  64+SCREEN_WIDTH/375*168,
                                                                  SCREEN_WIDTH/375*164,
                                                                  SCREEN_WIDTH/375*17)];
    }
    return _experienceLabel;
}

//content
-(UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                                  64+SCREEN_WIDTH/375*201,
                                                                  SCREEN_WIDTH-SCREEN_WIDTH/375*40,
                                                                  (SCREEN_WIDTH-SCREEN_WIDTH/375*40)/335*203)];
    }
    return _contentView;
}


//////copy
-(UITextView *)suggestTextView{
    
    if (_suggestTextView==nil) {
        _suggestTextView=[[UITextView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*13,
                                                                      SCREEN_WIDTH/375*11,
                                                                      SCREEN_WIDTH-SCREEN_WIDTH/375*40-SCREEN_WIDTH/375*26,
                                                                      SCREEN_WIDTH/375*80)];
    }
    return _suggestTextView;
}

-(UILabel *)suggestPlaceHolderLabel{
    
    if (_suggestPlaceHolderLabel==nil) {
        _suggestPlaceHolderLabel =[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*4,
                                                                            SCREEN_WIDTH/375*6,
                                                                            self.suggestTextView.frame.size.width,
                                                                            SCREEN_WIDTH/375*34)];
    }
    return _suggestPlaceHolderLabel;
}

-(UILabel *)worldCountLabel{
    
    if (_worldCountLabel==nil) {
        _worldCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*40-SCREEN_WIDTH/375*15-100,
                                                                     (SCREEN_WIDTH-SCREEN_WIDTH/375*40)/335*203-SCREEN_WIDTH/375*19,
                                                                     100,
                                                                     SCREEN_WIDTH/375*12)];
    }
    return _worldCountLabel;
}

-(UICollectionView *)shareCollectionView{
    if (_shareCollectionView==nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing      = 0.0f; //上下
        layout.minimumInteritemSpacing = 0.0f; //左右
        
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        
        _shareCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*13,
                                                                                  SCREEN_WIDTH/375*114-SCREEN_WIDTH/375*20,
                                                                                  SCREEN_WIDTH-SCREEN_WIDTH/375*40-SCREEN_WIDTH/375*26,
                                                                                  SCREEN_WIDTH/375*80) collectionViewLayout:layout];
        _shareCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 15);
        _shareCollectionView.alwaysBounceVertical = YES;
        _shareCollectionView.scrollEnabled = NO;
        _shareCollectionView.backgroundColor = [UIColor whiteColor];
        [_shareCollectionView registerClass:[ZMSelectImageCollectionViewCell class] forCellWithReuseIdentifier:@"selectImageCollectionViewCell"];
        
    }
    return _shareCollectionView;
}
/////copy

//amount
-(UILabel *)amountLabel{
    if (!_amountLabel) {
        _amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*21,
                                                                  SCREEN_WIDTH/375*9+CGRectGetMaxY(self.contentView.frame),
                                                                  SCREEN_WIDTH,
                                                                  SCREEN_WIDTH/375*17)];
    }
    return _amountLabel;
}


-(UITextField *)amountTextField{
    if (!_amountTextField) {
        _amountTextField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                         SCREEN_WIDTH/375*10+CGRectGetMaxY(self.amountLabel.frame),
                                                         SCREEN_WIDTH-SCREEN_WIDTH/375*40,
                                                         SCREEN_WIDTH/375*40)];
    }
    return _amountTextField;
}

//public
-(UIView *)isPublicView{
    if (!_isPublicView) {
        _isPublicView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                                SCREEN_WIDTH/375*14+CGRectGetMaxY(self.amountTextField.frame),
                                                                SCREEN_WIDTH-SCREEN_WIDTH/375*40,
                                                                SCREEN_WIDTH/375*42)];
    }
    return _isPublicView;
}

-(UIImageView *)isPublicTipImageView{
    
    if (_isPublicTipImageView==nil) {
        _isPublicTipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*2,
                                                                             SCREEN_WIDTH/375*1,
                                                                             SCREEN_WIDTH/375*19,
                                                                             SCREEN_WIDTH/375*19)];
    }
    return _isPublicTipImageView;
}

-(UILabel *)isPublicTipLabel{
    if (!_isPublicTipLabel) {
        _isPublicTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*29,
                                                                 SCREEN_WIDTH/375*0,
                                                                 SCREEN_WIDTH/375*100,
                                                                 SCREEN_WIDTH/375*20)];
    }
    return _isPublicTipLabel;
}

-(UILabel *)isPublicBottomLabel{
    if (!_isPublicBottomLabel) {
        _isPublicBottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*0,
                                                                      SCREEN_WIDTH/375*25,
                                                                      SCREEN_WIDTH-SCREEN_WIDTH/375*40,
                                                                      SCREEN_WIDTH/375*17)];
    }
    return _isPublicBottomLabel;
}




-(UIButton *)commitButtton{
    if (!_commitButtton) {
        _commitButtton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                                 SCREEN_WIDTH/375*11+CGRectGetMaxY(self.amountTextField.frame),
                                                                 SCREEN_WIDTH-SCREEN_WIDTH/375*40,
                                                                 SCREEN_WIDTH/375*40)];
    }
    return _commitButtton;
}

@end
