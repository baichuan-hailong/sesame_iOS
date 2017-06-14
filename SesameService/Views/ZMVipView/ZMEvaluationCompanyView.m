//
//  ZMEvaluationCompanyView.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMEvaluationCompanyView.h"

@interface ZMEvaluationCompanyView ()
@property(nonatomic,strong)UIView *contentView;
@end

@implementation ZMEvaluationCompanyView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.contentSize     = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-63);
    self.showsHorizontalScrollIndicator = NO;
    
    
    //image
    self.companyImageView.layer.cornerRadius = SCREEN_WIDTH/375*5;
    self.companyImageView.layer.masksToBounds= YES;
    self.companyImageView.backgroundColor = [UIColor redColor];
    [self addSubview:self.companyImageView];
    
    //level
    self.companyLevelImageView.layer.cornerRadius = SCREEN_WIDTH/375*8;
    self.companyLevelImageView.layer.masksToBounds= YES;
    self.companyLevelImageView.image = [UIImage imageNamed:@"vhuiyuan"];
    [self addSubview:self.companyLevelImageView];
    
    //company
    [ZMLabelAttributeMange setLabel:self.companyNameLabel
                               text:@"北京安家万邦传媒科技股份有限公司"
                                hex:@"333333"
                      textAlignment:NSTextAlignmentCenter
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*15]];
    [self addSubview:self.companyNameLabel];
    
    //tip
    [ZMLabelAttributeMange setLabel:self.tipLabel
                               text:@"表个态吧："
                                hex:@"666666"
                      textAlignment:NSTextAlignmentCenter
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    [self addSubview:self.tipLabel];
    
    //stars
    self.starArray = [NSMutableArray array];
    
    
    for (int i=0; i<5; i++) {
        UIButton *starImageView = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/375*20)*i+(SCREEN_WIDTH/375*5)*i,
                                                                                   SCREEN_WIDTH/375*0,
                                                                                   SCREEN_WIDTH/375*20,
                                                                                   SCREEN_WIDTH/375*19)];
        //starImageView.backgroundColor = [UIColor yellowColor];
        [starImageView setImage:[UIImage imageNamed:@"evaluationCompanyNoSelect"] forState:UIControlStateNormal];
        
        [self.starArray addObject:starImageView];
        [self.startView addSubview:starImageView];
    }
    
    self.startView.userInteractionEnabled = YES;
    //self.startView.backgroundColor = [UIColor redColor];
    [self addSubview:self.startView];
    
    
    //content
    self.contentView.layer.cornerRadius = SCREEN_WIDTH/375*4;
    self.contentView.layer.borderColor  = [UIColor colorWithHex:@"CFCFCF"].CGColor;
    self.contentView.layer.borderWidth  = SCREEN_WIDTH/375*1;
    self.contentView.layer.masksToBounds= YES;
    self.contentView.userInteractionEnabled=YES;
    [self addSubview:self.contentView];
    
    
    //self.evaluationTextView.backgroundColor = [UIColor lightGrayColor];
    self.evaluationTextView.font = [UIFont fontWithName:@"Helvetica" size:14.f];
    [self.contentView addSubview:self.evaluationTextView];
    
    //place
    [ZMLabelAttributeMange setLabel:self.evaluationPlaceHolderLabel
                               text:@"写下更多评价"
                                hex:@"CCCCCC"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    [self.evaluationTextView addSubview:self.evaluationPlaceHolderLabel];
    
    //commit
    [self setButton:self.commitButton title:@"提交" color:[UIColor colorWithHex:@"FFFFFF"] font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14] boo:YES];
    self.commitButton.alpha = 0.6;
    self.commitButton.userInteractionEnabled = NO;
    [self.commitButton setBackgroundColor:[UIColor colorWithHex:tonalColor]];
    [self addSubview:self.commitButton];
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

- (void)setlabel:(UILabel *)label title:(NSString *)title color:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)textFond{
    
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    label.font = textFond;
    label.text = title;
    
    label.layer.borderColor  = [UIColor colorWithHex:@"AAAAAA"].CGColor;
    label.layer.borderWidth  = SCREEN_WIDTH/375*0.5;
    label.layer.cornerRadius = SCREEN_WIDTH/375*8;
}



//lazy
-(UIImageView *)companyImageView{
    if (!_companyImageView) {
        _companyImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*70)/2, SCREEN_WIDTH/375*21+SCREEN_WIDTH/375*64, SCREEN_WIDTH/375*70, SCREEN_WIDTH/375*70)];
    }
    return _companyImageView;
}

//level
-(UIImageView *)companyLevelImageView{
    if (!_companyLevelImageView) {
        _companyLevelImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*70)/2+SCREEN_WIDTH/375*62, SCREEN_WIDTH/375*21+SCREEN_WIDTH/375*64+SCREEN_WIDTH/375*62, SCREEN_WIDTH/375*16, SCREEN_WIDTH/375*16)];
    }
    return _companyLevelImageView;
}

-(UILabel *)companyNameLabel{
    if (!_companyNameLabel) {
        _companyNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_WIDTH/375*107+SCREEN_WIDTH/375*64, SCREEN_WIDTH, SCREEN_WIDTH/375*21)];
    }
    return _companyNameLabel;
}

//tip
-(UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*91,
                                                              SCREEN_WIDTH/375*156+SCREEN_WIDTH/375*64,
                                                              SCREEN_WIDTH/375*75.8,
                                                              SCREEN_WIDTH/375*19)];
    }
    return _tipLabel;
}

//starts
-(UIView *)startView{
    if (!_startView) {
        _startView = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*166.8,
                                                               SCREEN_WIDTH/375*156+SCREEN_WIDTH/375*64,
                                                               SCREEN_WIDTH/375*150,
                                                               SCREEN_WIDTH/375*19)];
    }
    return _startView;
}

//content
-(UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20, SCREEN_WIDTH/375*206+SCREEN_WIDTH/375*64, SCREEN_WIDTH-SCREEN_WIDTH/375*40, (SCREEN_WIDTH-SCREEN_WIDTH/375*40)/335*160)];
    }
    return _contentView;
}

-(UITextView *)evaluationTextView{
    if (!_evaluationTextView) {
        _evaluationTextView = [[UITextView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*10, SCREEN_WIDTH/375*6, SCREEN_WIDTH-SCREEN_WIDTH/375*40-SCREEN_WIDTH/375*24, (SCREEN_WIDTH-SCREEN_WIDTH/375*40)/335*160-SCREEN_WIDTH/375*20)];
    }
    return _evaluationTextView;
}

-(UILabel *)evaluationPlaceHolderLabel{
    
    if (_evaluationPlaceHolderLabel==nil) {
        _evaluationPlaceHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*4, SCREEN_WIDTH/375*8, self.evaluationTextView.frame.size.width, SCREEN_WIDTH/375*17)];
    }
    return _evaluationPlaceHolderLabel;
}


//commit
-(UIButton *)commitButton{
    if (!_commitButton) {
        _commitButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20, SCREEN_WIDTH/375*387+SCREEN_WIDTH/375*64, SCREEN_WIDTH-SCREEN_WIDTH/375*40, SCREEN_WIDTH/375*40)];
    }
    return _commitButton;
}

@end
