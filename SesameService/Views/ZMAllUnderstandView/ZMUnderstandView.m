//
//  ZMUnderstandView.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/6.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMUnderstandView.h"
#import "ZMSelectImageCollectionViewCell.h"


@interface ZMUnderstandView ()

@property(nonatomic,strong)UIView  *topView;
@property(nonatomic,strong)UIView  *contentView;
@property(nonatomic,strong)UILabel *amountLabel;

@property(nonatomic,strong)UILabel *orLabel;
@end

@implementation ZMUnderstandView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    
        self.backgroundColor = [UIColor whiteColor];
        
        [self addUI];
    }
    return self;
}

- (void)addUI{
    
    //self.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+20);
    
    
    //top
    self.topView.layer.cornerRadius = SCREEN_WIDTH/375*4;
    self.topView.layer.borderWidth  = SCREEN_WIDTH/375*1;
    self.topView.layer.borderColor  = [UIColor colorWithHex:@"CCCCCC"].CGColor;
    self.topView.layer.masksToBounds= YES;
    [self addSubview:self.topView];
    
    //left
    [self.leftButtton setBackgroundColor:[UIColor colorWithHex:tonalColor]];
    self.leftButtton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self setButton:self.leftButtton
              title:@"向所有会员提问"
              color:[UIColor whiteColor] font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
                boo:NO];
    [self.topView addSubview:self.leftButtton];
    
    //right
    [self.rightButtton setBackgroundColor:[UIColor whiteColor]];
    self.rightButtton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self setButton:self.rightButtton
              title:@"向指定会员提问"
              color:[UIColor colorWithHex:@"231714"]
               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
                boo:NO];
    [self.topView addSubview:self.rightButtton];
    
    //or
    self.orLabel.layer.cornerRadius = SCREEN_WIDTH/375*4;
    self.orLabel.layer.borderWidth  = SCREEN_WIDTH/375*1;
    self.orLabel.layer.cornerRadius = SCREEN_WIDTH/375*12.5;
    self.orLabel.layer.borderColor  = [UIColor colorWithHex:@"CCCCCC"].CGColor;
    self.orLabel.layer.masksToBounds= YES;
    self.orLabel.backgroundColor = [UIColor whiteColor];
    [ZMLabelAttributeMange setLabel:self.orLabel
                               text:@"或"
                                hex:@"666666"
                      textAlignment:NSTextAlignmentCenter
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
    [self.topView addSubview:self.orLabel];
    
    //content
    self.contentView.layer.cornerRadius = SCREEN_WIDTH/375*4;
    self.contentView.layer.borderWidth  = SCREEN_WIDTH/375*1;
    self.contentView.layer.borderColor  = [UIColor colorWithHex:@"CCCCCC"].CGColor;
    self.contentView.userInteractionEnabled = YES;
    [self addSubview:self.contentView];
    
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
    //self.worldCountLabel.backgroundColor = [UIColor redColor];
    //self.contentView.backgroundColor = [UIColor yellowColor];
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
    self.amountTextField.keyboardType= UIKeyboardTypeNumberPad;
    self.amountTextField.placeholder = @"请输入悬赏金额（10-10000）";
    [self addSubview:self.amountTextField];
    
    
    
    
    //isPulic
    //self.isPublicView.backgroundColor = [UIColor yellowColor];
    [self addSubview:self.isPublicView];
    
    
    //self.isPublicTipImageView.backgroundColor = [UIColor redColor];
    self.isPublicTipImageView.image = [UIImage imageNamed:@"publicSelectImage"];
    [self.isPublicView addSubview:self.isPublicTipImageView];
    
    [ZMLabelAttributeMange setLabel:self.isPublicTipLabel
                               text:@"公开答案"
                                hex:@"000000"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    [self.isPublicView addSubview:self.isPublicTipLabel];
    
    
    /*
     [ZMLabelAttributeMange setLabel:self.isPublicBottomLabel
     text:@"提问可选公开或私密，公开提问的回答所有人都可以看到"
     hex:@"AAAAAA"
     textAlignment:NSTextAlignmentLeft
     font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
     [self.isPublicView addSubview:self.isPublicBottomLabel];
     
     
     */
    
    
    
    //release
    [self setButton:self.commitButtton
              title:@"发布打听"
              color:[UIColor colorWithHex:@"FFFFFF"]
               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*16]
                boo:NO];
    [self.commitButtton setBackgroundColor:[UIColor colorWithHex:tonalColor]];
    self.commitButtton.alpha                  = 0.6;
    self.commitButtton.userInteractionEnabled = NO;
    self.commitButtton.layer.cornerRadius = SCREEN_WIDTH/375*2;
    self.commitButtton.layer.masksToBounds= YES;
    [self addSubview:self.commitButtton];
}

- (void)setButton:(UIButton *)button title:(NSString *)title color:(UIColor *)textColor font:(UIFont *)textFond boo:(BOOL)islayer{
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    button.titleLabel.font    = textFond;
    if (islayer) {
        button.layer.borderColor  = [UIColor whiteColor].CGColor;
        button.layer.borderWidth  = SCREEN_WIDTH/375*1;
        
    }
    //button.layer.cornerRadius = SCREEN_WIDTH/375*4;
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





//top
-(UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                                SCREEN_WIDTH/375*64+SCREEN_WIDTH/375*14,
                                                                SCREEN_WIDTH-SCREEN_WIDTH/375*40,
                                                                SCREEN_WIDTH/375*40)];
    }
    return _topView;
}

-(UILabel *)orLabel{
    if (!_orLabel) {
        _orLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*40-SCREEN_WIDTH/375*25)/2,
                                                                 SCREEN_WIDTH/375*7.5,
                                                                 SCREEN_WIDTH/375*25,
                                                                 SCREEN_WIDTH/375*25)];
    }
    return _orLabel;
}

//left
-(UIButton *)leftButtton{
    if (!_leftButtton) {
        _leftButtton = [[UIButton alloc] initWithFrame:CGRectMake(0,
                                                                  0,
                                                                  (SCREEN_WIDTH-SCREEN_WIDTH/375*40)/2,
                                                                  SCREEN_WIDTH/375*40)];
        
    }
    return _leftButtton;
}


//right
-(UIButton *)rightButtton{
    if (!_rightButtton) {
        _rightButtton = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*40)/2,
                                                                  0,
                                                                   (SCREEN_WIDTH-SCREEN_WIDTH/375*40)/2,
                                                                   SCREEN_WIDTH/375*40)];
    }
    return _rightButtton;
}



//lazy
//content
-(UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                                CGRectGetMaxY(self.topView.frame)+SCREEN_WIDTH/375*13,
                                                                SCREEN_WIDTH-SCREEN_WIDTH/375*40,
                                                                (SCREEN_WIDTH-SCREEN_WIDTH/375*40)/355*203)];
    }
    return _contentView;
}


-(UILabel *)worldCountLabel{
    
    if (_worldCountLabel==nil) {
        _worldCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*40-SCREEN_WIDTH/375*15-100,
                                                                     (SCREEN_WIDTH-SCREEN_WIDTH/375*40)/355*203-SCREEN_WIDTH/375*16,
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
                                                                 SCREEN_WIDTH/375*22)];
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
                                                                    SCREEN_WIDTH/375*16+CGRectGetMaxY(self.isPublicView.frame),
                                                                    SCREEN_WIDTH-SCREEN_WIDTH/375*40,
                                                                    SCREEN_WIDTH/375*40)];
    }
    return _commitButtton;
}

@end
