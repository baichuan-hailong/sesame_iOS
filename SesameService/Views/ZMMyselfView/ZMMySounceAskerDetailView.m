//
//  ZMMySounceAskerDetailView.m
//  SesameService
//
//  Created by 杜海龙 on 17/5/9.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMMySounceAskerDetailView.h"



@implementation ZMMySounceAskerDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)addUI{
    
    self.sounceDetailableView.backgroundColor = [UIColor colorWithHex:backGroundColor];
    self.sounceDetailableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.sounceDetailableView];
    
    
    
    self.makeView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.makeView];
    
    
    [self setButton:self.makeBtn
              title:@"确认答案"
              color:[UIColor colorWithHex:@"FFFFFF"]
               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*16]
                boo:YES];
    [self.makeBtn setBackgroundColor:[UIColor colorWithHex:tonalColor]];
    [self.makeView addSubview:self.makeBtn];
    
    
    self.makeView.alpha = 0;
    self.makeBtn.alpha  = 0;
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


//lazy
-(UITableView *)sounceDetailableView{
    if (_sounceDetailableView==nil) {
        _sounceDetailableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                       64,
                                                                       SCREEN_WIDTH,
                                                                       SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
        
        
    }
    return _sounceDetailableView;
}

//@property(nonatomic,strong)UIView           *makeView;
-(UIView *)makeView{
    if (_makeView==nil) {
        _makeView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                      SCREEN_HEIGHT-SCREEN_WIDTH/375*60,
                                                      SCREEN_WIDTH,
                                                      SCREEN_WIDTH/375*60)];
        
        
    }
    return _makeView;
}

//@property(nonatomic,strong)UIButton         *makeBtn;
-(UIButton *)makeBtn{
    if (_makeBtn==nil) {
        _makeBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                             SCREEN_WIDTH/375*10,
                                                             SCREEN_WIDTH-SCREEN_WIDTH/375*40,
                                                             SCREEN_WIDTH/375*40)];
        
        
    }
    return _makeBtn;
}

@end
