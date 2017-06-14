//
//  ZMPostEvaluationView.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/26.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMPostEvaluationView.h"

@interface ZMPostEvaluationView ()
@property(nonatomic,strong)UIView  *topView;
@property(nonatomic,strong)UIView  *line;
@property(nonatomic,strong)UIView  *bottomView;

@property(nonatomic,strong)UIView  *suggestView;

@property(nonatomic,strong)UIImageView  *tipImageView;
@property(nonatomic,strong)UILabel  *tipLabel;
//信息
@property(nonatomic,strong)UILabel  *tipxinxiLabel;
//关系
@property(nonatomic,strong)UILabel  *tipguanxiLabel;
//价格
@property(nonatomic,strong)UILabel  *tipjiageLabel;
//项目
@property(nonatomic,strong)UILabel  *tipxiangmuLabel;
@end

@implementation ZMPostEvaluationView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHex:backGroundColor];
        [self addUI];
    }
    return self;
}

- (void)addUI{
    
    self.contentSize     = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+1);
    //self.showsHorizontalScrollIndicator = NO;
    
    
    //top
    self.topView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.topView];
    
    //line
    self.line.backgroundColor = [UIColor colorWithHex:@"DDDDDD"];
    [self.topView addSubview:self.line];
    
    
    
    //suggest view
    self.suggestView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.suggestView];
    
    //textView
    self.suggestTextView.font = [UIFont fontWithName:@"Helvetica" size:SCREEN_WIDTH/375*14];
    //self.suggestTextView.backgroundColor = [UIColor redColor];
    [self.suggestView addSubview:self.suggestTextView];
    
    
    self.suggestPlaceHolderLabel.font = [UIFont fontWithName:@"Helvetica" size:SCREEN_WIDTH/375*14];
    self.suggestPlaceHolderLabel.text=@"写下更多评论吧！";
    self.suggestPlaceHolderLabel.textColor=[UIColor colorWithHex:@"CCCCCC"];
    //self.suggestPlaceHolderLabel.backgroundColor = [UIColor orangeColor];
    [self.suggestTextView addSubview:self.suggestPlaceHolderLabel];
    
    
    self.worldCountLabel.textAlignment = NSTextAlignmentRight;
    self.worldCountLabel.text = @"0/300";
    self.worldCountLabel.font = [UIFont systemFontOfSize:SCREEN_WIDTH/375*14];
    self.worldCountLabel.textColor = [UIColor colorWithHex:@"CCCCCC"];
    //self.worldCountLabel.backgroundColor = [UIColor orangeColor];
    [self.suggestView addSubview:self.worldCountLabel];
    
    
    //good
    [self.goodBtn setLeftImage:[UIImage imageNamed:@"haopingselect"] rightLa:@"好评" rightHex:tonalColor];
    //self.goodBtn.backgroundColor = [UIColor redColor];
    [self.topView addSubview:self.goodBtn];
    
    //zhong
    [self.zhongpingBtn setLeftImage:[UIImage imageNamed:@"zhongpingnosel"] rightLa:@"中评" rightHex:@"CCCCCC"];
    [self.topView addSubview:self.zhongpingBtn];
    
    //cha
    [self.chapingBtn setLeftImage:[UIImage imageNamed:@"chapingsel"] rightLa:@"差评" rightHex:@"CCCCCC"];
    [self.topView addSubview:self.chapingBtn];
    
    //bottom
    //self.bottomView.backgroundColor = [UIColor orangeColor];
    [self.topView addSubview:self.bottomView];
    
    
    
    //buypingjiaTipImg
    self.tipImageView.image = [UIImage imageNamed:@"buypingjiaTipImg"];
    [self.bottomView addSubview:self.tipImageView];
    
    [ZMLabelAttributeMange setLabel:self.tipLabel
                               text:@"购买评分"
                                hex:@"333333"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    //self.tipLabel.backgroundColor = [UIColor redColor];
    [self.bottomView addSubview:self.tipLabel];
    
    
    //信息
    [ZMLabelAttributeMange setLabel:self.tipxinxiLabel
                               text:@"信息可靠"
                                hex:@"666666"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    //self.tipxinxiLabel.backgroundColor = [UIColor redColor];
    [self.bottomView addSubview:self.tipxinxiLabel];
    
    
    //self.startxinxiView.backgroundColor = [UIColor redColor];
    self.startxinxiView.userInteractionEnabled = YES;
    [self.bottomView addSubview:self.startxinxiView];
    
    self.starxinxiArray = [NSMutableArray array];
    for (int i=0; i<5; i++) {
        UIButton *starImageView = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/375*19.2)*i+(SCREEN_WIDTH/375*18.2)*i,
                                                                             SCREEN_WIDTH/375*0,
                                                                             SCREEN_WIDTH/375*19.2,
                                                                             SCREEN_WIDTH/375*18.4)];
        //starImageView.backgroundColor = [UIColor yellowColor];
        [starImageView setImage:[UIImage imageNamed:@"evaluationCompanyNoSelect"] forState:UIControlStateNormal];
        
        [self.starxinxiArray addObject:starImageView];
        [self.startxinxiView addSubview:starImageView];
    }
    
    //关系
    [ZMLabelAttributeMange setLabel:self.tipguanxiLabel
                               text:@"关系到位"
                                hex:@"666666"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    //self.tipguanxiLabel.backgroundColor = [UIColor redColor];
    [self.bottomView addSubview:self.tipguanxiLabel];
    
    
    //self.startgaunxiView.backgroundColor = [UIColor redColor];
    self.startgaunxiView.userInteractionEnabled = YES;
    [self.bottomView addSubview:self.startgaunxiView];
    
    self.starguanxiArray = [NSMutableArray array];
    for (int i=0; i<5; i++) {
        UIButton *starImageView = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/375*19.2)*i+(SCREEN_WIDTH/375*18.2)*i,
                                                                             SCREEN_WIDTH/375*0,
                                                                             SCREEN_WIDTH/375*19.2,
                                                                             SCREEN_WIDTH/375*18.4)];
        //starImageView.backgroundColor = [UIColor yellowColor];
        [starImageView setImage:[UIImage imageNamed:@"evaluationCompanyNoSelect"] forState:UIControlStateNormal];
        
        [self.starguanxiArray addObject:starImageView];
        [self.startgaunxiView addSubview:starImageView];
    }
    
    
    //价格
    [ZMLabelAttributeMange setLabel:self.tipjiageLabel
                               text:@"价格合理"
                                hex:@"666666"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    //self.tipjiageLabel.backgroundColor = [UIColor redColor];
    [self.bottomView addSubview:self.tipjiageLabel];
    
    
    //self.startgaunxiView.backgroundColor = [UIColor redColor];
    self.startjiageView.userInteractionEnabled = YES;
    [self.bottomView addSubview:self.startjiageView];
    
    self.starjiageArray = [NSMutableArray array];
    for (int i=0; i<5; i++) {
        UIButton *starImageView = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/375*19.2)*i+(SCREEN_WIDTH/375*18.2)*i,
                                                                             SCREEN_WIDTH/375*0,
                                                                             SCREEN_WIDTH/375*19.2,
                                                                             SCREEN_WIDTH/375*18.4)];
        //starImageView.backgroundColor = [UIColor yellowColor];
        [starImageView setImage:[UIImage imageNamed:@"evaluationCompanyNoSelect"] forState:UIControlStateNormal];
        
        [self.starjiageArray addObject:starImageView];
        [self.startjiageView addSubview:starImageView];
    }
    
    
    //项目
    [ZMLabelAttributeMange setLabel:self.tipxiangmuLabel
                               text:@"项目价值"
                                hex:@"666666"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    //self.tipxiangmuLabel.backgroundColor = [UIColor redColor];
    [self.bottomView addSubview:self.tipxiangmuLabel];
    
    
    //self.startgaunxiView.backgroundColor = [UIColor redColor];
    self.startxiangmuView.userInteractionEnabled = YES;
    [self.bottomView addSubview:self.startxiangmuView];
    
    self.starxiangmuArray = [NSMutableArray array];
    for (int i=0; i<5; i++) {
        UIButton *starImageView = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/375*19.2)*i+(SCREEN_WIDTH/375*18.2)*i,
                                                                             SCREEN_WIDTH/375*0,
                                                                             SCREEN_WIDTH/375*19.2,
                                                                             SCREEN_WIDTH/375*18.4)];
        //starImageView.backgroundColor = [UIColor yellowColor];
        [starImageView setImage:[UIImage imageNamed:@"evaluationCompanyNoSelect"] forState:UIControlStateNormal];
        
        [self.starxiangmuArray addObject:starImageView];
        [self.startxiangmuView addSubview:starImageView];
    }
    
    
    
    
    
    //commit
    [self setButton:self.commitButton
              title:@"发布"
              color:[UIColor colorWithHex:@"FFFFFF"]
               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*16]
                boo:YES];
    [self.commitButton setBackgroundColor:[UIColor colorWithHex:tonalColor]];
    self.commitButton.alpha = 1;
    self.commitButton.userInteractionEnabled = YES;
    [self addSubview:self.commitButton];

}


- (void)setButton:(UIButton *)button title:(NSString *)title color:(UIColor *)textColor font:(UIFont *)textFond boo:(BOOL)islayer{
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    button.titleLabel.font    = textFond;
    if (islayer) {
        //button.layer.borderColor  = [UIColor whiteColor].CGColor;
        //button.layer.borderWidth  = SCREEN_WIDTH/375*1;
        button.layer.cornerRadius = SCREEN_WIDTH/375*4;
    }
}


//top
-(UIView *)topView{
    if (_topView==nil) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*0,
                                                            64,
                                                            SCREEN_WIDTH,
                                                            SCREEN_WIDTH/375*58+SCREEN_WIDTH/375*221)];
    }
    return _topView;
}

-(UIView *)line{
    if (_line==nil) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                         SCREEN_WIDTH/375*58,
                                                         SCREEN_WIDTH,
                                                         SCREEN_WIDTH/375*0.5)];
    }
    return _line;
}


//bottom
-(UIView *)bottomView{
    if (_bottomView==nil) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                               CGRectGetMaxY(self.line.frame)+SCREEN_WIDTH/375*0,
                                                               SCREEN_WIDTH,
                                                               SCREEN_WIDTH/375*221)];
        
    }
    return _bottomView;
}








//lazy
-(UIView *)suggestView{
    if (_suggestView==nil) {
        _suggestView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*0,
                                          CGRectGetMaxY(self.topView.frame)+SCREEN_WIDTH/375*14,
                                          SCREEN_WIDTH,
                                          SCREEN_WIDTH/375*185)];
    }
    return _suggestView;
}

-(UITextView *)suggestTextView{
    
    if (_suggestTextView==nil) {
        _suggestTextView=[[UITextView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                          SCREEN_WIDTH/375*10,
                                                          SCREEN_WIDTH-SCREEN_WIDTH/375*40,
                                                          SCREEN_WIDTH/375*157)];
    }
    return _suggestTextView;
}

-(UILabel *)suggestPlaceHolderLabel{
    
    if (_suggestPlaceHolderLabel==nil) {
        _suggestPlaceHolderLabel =[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*4,
                                                            SCREEN_WIDTH/375*7,
                                                            self.suggestTextView.frame.size.width,
                                                            SCREEN_WIDTH/375*17)];
    }
    return _suggestPlaceHolderLabel;
}

-(UILabel *)worldCountLabel{
    
    if (_worldCountLabel==nil) {
        _worldCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*20-SCREEN_WIDTH/375*8-100,
                                             SCREEN_WIDTH/375*153,
                                             100,
                                             SCREEN_WIDTH/375*14)];
    }
    return _worldCountLabel;
}


//good
-(ZMEvaluationView *)goodBtn{
    if (_goodBtn==nil) {
        _goodBtn = [[ZMEvaluationView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*22,
                                                                      SCREEN_WIDTH/375*17,
                                                                      SCREEN_WIDTH/375*80,
                                                                      SCREEN_WIDTH/375*24)];
    }
    return _goodBtn;
}
//zhong
-(ZMEvaluationView *)zhongpingBtn{
    if (_zhongpingBtn==nil) {
        _zhongpingBtn = [[ZMEvaluationView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*127,
                                                                      SCREEN_WIDTH/375*17,
                                                                      SCREEN_WIDTH/375*80,
                                                                      SCREEN_WIDTH/375*24)];
    }
    return _zhongpingBtn;
}
//cha
-(ZMEvaluationView *)chapingBtn{
    if (_chapingBtn==nil) {
        _chapingBtn = [[ZMEvaluationView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*232,
                                                                      SCREEN_WIDTH/375*17,
                                                                      SCREEN_WIDTH/375*80,
                                                                      SCREEN_WIDTH/375*24)];
    }
    return _chapingBtn;
}



//tip
-(UIImageView *)tipImageView{
    if (_tipImageView==nil) {
        _tipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*25,
                                                               SCREEN_WIDTH/375*16,
                                                               SCREEN_WIDTH/375*20,
                                                               SCREEN_WIDTH/375*20)];
        
    }
    return _tipImageView;
}

-(UILabel *)tipLabel{
    
    if (_tipLabel==nil) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*56,
                                                                     SCREEN_WIDTH/375*18,
                                                                     SCREEN_WIDTH/375*100,
                                                                     SCREEN_WIDTH/375*20)];
    }
    return _tipLabel;
}


//信息
-(UIView *)startxinxiView{
    if (!_startxinxiView) {
        _startxinxiView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*92.8,
                                                               SCREEN_WIDTH/375*57.1,
                                                               SCREEN_WIDTH/375*180,
                                                               SCREEN_WIDTH/375*18.4)];
    }
    return _startxinxiView;
}

-(UILabel *)tipxinxiLabel{
    if (_tipxinxiLabel==nil) {
        _tipxinxiLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*23,
                                                              SCREEN_WIDTH/375*57.1-SCREEN_WIDTH/375*0.8,
                                                              SCREEN_WIDTH/375*65,
                                                              SCREEN_WIDTH/375*20)];
    }
    return _tipxinxiLabel;
}

//关系
-(UIView *)startgaunxiView{
    if (!_startgaunxiView) {
        _startgaunxiView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*92.8,
                                                                    SCREEN_WIDTH/375*95.1,
                                                                    SCREEN_WIDTH/375*180,
                                                                    SCREEN_WIDTH/375*18.4)];
    }
    return _startgaunxiView;
}

-(UILabel *)tipguanxiLabel{
    if (_tipguanxiLabel==nil) {
        _tipguanxiLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*23,
                                                                   SCREEN_WIDTH/375*95.1-SCREEN_WIDTH/375*0.8,
                                                                   SCREEN_WIDTH/375*65,
                                                                   SCREEN_WIDTH/375*20)];
    }
    return _tipguanxiLabel;
}

//价格
-(UIView *)startjiageView{
    if (!_startjiageView) {
        _startjiageView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*92.8,
                                                                    SCREEN_WIDTH/375*133.1,
                                                                    SCREEN_WIDTH/375*180,
                                                                    SCREEN_WIDTH/375*18.4)];
    }
    return _startjiageView;
}

-(UILabel *)tipjiageLabel{
    if (_tipjiageLabel==nil) {
        _tipjiageLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*23,
                                                                    SCREEN_WIDTH/375*133.1-SCREEN_WIDTH/375*0.8,
                                                                    SCREEN_WIDTH/375*65,
                                                                    SCREEN_WIDTH/375*20)];
    }
    return _tipjiageLabel;
}

//项目
-(UIView *)startxiangmuView{
    if (!_startxiangmuView) {
        _startxiangmuView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*92.8,
                                                                    SCREEN_WIDTH/375*171.1,
                                                                    SCREEN_WIDTH/375*180,
                                                                    SCREEN_WIDTH/375*18.4)];
    }
    return _startxiangmuView;
}

-(UILabel *)tipxiangmuLabel{
    if (_tipxiangmuLabel==nil) {
        _tipxiangmuLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*23,
                                                                    SCREEN_WIDTH/375*171.1-SCREEN_WIDTH/375*0.8,
                                                                    SCREEN_WIDTH/375*65,
                                                                    SCREEN_WIDTH/375*20)];
    }
    return _tipxiangmuLabel;
}


-(UIButton *)commitButton{
    if (!_commitButton) {
        _commitButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                       CGRectGetMaxY(self.suggestView.frame)+SCREEN_WIDTH/375*32,
                                                       SCREEN_WIDTH-SCREEN_WIDTH/375*40,
                                                       SCREEN_WIDTH/375*40)];
    }
    return _commitButton;
}


@end


