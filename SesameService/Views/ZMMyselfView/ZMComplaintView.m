//
//  ZMComplaintView.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/24.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMComplaintView.h"

@interface ZMComplaintView ()
@property(nonatomic,strong)UIView  *topView;

@property(nonatomic,strong)UIView  *bottomView;

@property(nonatomic,strong)UILabel *tipLabel;
@end

@implementation ZMComplaintView

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
    
    self.topView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.topView];
    
    //title
    [ZMLabelAttributeMange setLabel:self.titleLabel
                               text:@"-- --"
                                hex:@"333333"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    [self.topView addSubview:self.titleLabel];
    
    //time
    [ZMLabelAttributeMange setLabel:self.buyLabel
                               text:@"-- --"
                                hex:@"666666"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
    [self.topView addSubview:self.buyLabel];
    
    //num
    [ZMLabelAttributeMange setLabel:self.numberLabel
                               text:@"-- --"
                                hex:@"666666"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
    [self.topView addSubview:self.numberLabel];
    
    
    //money
    [ZMLabelAttributeMange setLabel:self.moneyLabel
                               text:@"--"
                                hex:@"EE6B6A"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*18]];
    [self.topView addSubview:self.moneyLabel];
    
    
    //bottom
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.bottomView];
    
    //tip
    [ZMLabelAttributeMange setLabel:self.tipLabel
                               text:@"投诉说明"
                                hex:@"333333"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    [self.bottomView addSubview:self.tipLabel];
    
    
    self.suggestView.layer.cornerRadius = 4;
    self.suggestView.layer.borderColor = [UIColor colorWithHex:@"DDDDDD"].CGColor;
    self.suggestView.layer.borderWidth = 1;
    self.suggestView.backgroundColor = [UIColor whiteColor];
    [self.bottomView addSubview:self.suggestView];
    
    
    self.suggestTextView.font = [UIFont fontWithName:@"Helvetica" size:14.f];
    self.suggestTextView.backgroundColor = [UIColor whiteColor];
    [self.suggestView addSubview:self.suggestTextView];
    
    
    self.suggestPlaceHolderLabel.font = [UIFont fontWithName:@"Helvetica" size:14.f];
    self.suggestPlaceHolderLabel.text=@"请输入投诉详情！";
    self.suggestPlaceHolderLabel.textColor=[UIColor colorWithHex:@"B2B2B2"];
    //self.suggestPlaceHolderLabel.backgroundColor = [UIColor orangeColor];
    [self.suggestTextView addSubview:self.suggestPlaceHolderLabel];
    
    
    self.worldCountLabel.textAlignment = NSTextAlignmentRight;
    self.worldCountLabel.text = @"0/300";
    self.worldCountLabel.font = [UIFont systemFontOfSize:SCREEN_WIDTH/375*14];
    self.worldCountLabel.textColor = [UIColor colorWithHex:@"B2B2B2"];
    //self.worldCountLabel.backgroundColor = [UIColor orangeColor];
    [self.suggestView addSubview:self.worldCountLabel];
    
    
    [self setButton:self.commitButton
              title:@"提交"
              color:[UIColor colorWithHex:@"FFFFFF"]
               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*16]
                boo:YES];
    [self.commitButton setBackgroundColor:[UIColor colorWithHex:tonalColor]];
    self.commitButton.alpha = 0.6;
    self.commitButton.userInteractionEnabled = NO;
    [self.bottomView addSubview:self.commitButton];
    
}


- (void)setTopDicView:(NSDictionary *)topDic{
    NSLog(@"%@",topDic);
    /*
     self.buyTipDic = @{@"title":title,
     @"time":time,
     @"status":status,
     @"status_title":status_title,
     @"price":price,
     @"local_sn":local_sn};
     
     */
    
    NSString *title       = [NSString stringWithFormat:@"%@",topDic[@"title"]];
    
    NSString *time        = [NSString stringWithFormat:@"%@",topDic[@"time"]];
    NSString *price       = [NSString stringWithFormat:@"%@",topDic[@"price"]];
    NSString *local_sn  = [NSString stringWithFormat:@"%@",topDic[@"local_sn"]];
    
    if (title.length>0&&![title isEqualToString:@"(null)"]) {
        self.titleLabel.text  = [NSString stringWithFormat:@"%@",title];
    }
    self.titleLabel.numberOfLines = 0;
    CGSize   size    = CGSizeMake(SCREEN_WIDTH-SCREEN_WIDTH/375*17.5-SCREEN_WIDTH/375*79, 0);
    CGSize  autoSize = [[UILabel new] actualSizeOfLineSpaceLable:[NSString stringWithFormat:@"%@",title]
                                                         andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
                                                         andSize:size];
    
    int height = (int)autoSize.height+1;
    self.titleLabel.frame = CGRectMake(SCREEN_WIDTH/375*17.5,
                                       SCREEN_WIDTH/375*13.6,
                                       SCREEN_WIDTH-SCREEN_WIDTH/375*17.5-SCREEN_WIDTH/375*79,
                                       height);
    
    
    self.topView.frame = CGRectMake(SCREEN_WIDTH/375*0,
                                    64,
                                    SCREEN_WIDTH,
                                    SCREEN_WIDTH/375*100+height);
    
    if (time.length>0&&![time isEqualToString:@"(null)"]) {
        self.buyLabel.text= [NSString stringWithFormat:@"购买时间：%@",[self timeChange:time]];
    }
    if (price.length>0&&![price isEqualToString:@"(null)"]) {
        self.moneyLabel.text  = [NSString stringWithFormat:@"¥%@",price];
    }
    
    if (local_sn.length>0&&![local_sn isEqualToString:@"(null)"]) {
        self.numberLabel.text = [NSString stringWithFormat:@"交易号：%@",local_sn];
    }
    self.buyLabel.frame = CGRectMake(SCREEN_WIDTH/375*17.5,
                                     CGRectGetMaxY(self.titleLabel.frame)+SCREEN_WIDTH/375*2,
                                     SCREEN_WIDTH-SCREEN_WIDTH/375*79-SCREEN_WIDTH/375*18,
                                     SCREEN_WIDTH/375*17);
    
    self.numberLabel.frame = CGRectMake(SCREEN_WIDTH/375*17.5,
                              CGRectGetMaxY(self.buyLabel.frame)+SCREEN_WIDTH/375*2,
                              SCREEN_WIDTH-SCREEN_WIDTH/375*79-SCREEN_WIDTH/375*18,
                              SCREEN_WIDTH/375*17);
    
    self.moneyLabel.frame = CGRectMake(SCREEN_WIDTH/375*18,
                                       CGRectGetMaxY(self.numberLabel.frame)+SCREEN_WIDTH/375*2,
                                       SCREEN_WIDTH-SCREEN_WIDTH/375*79-SCREEN_WIDTH/375*18,
                                       SCREEN_WIDTH/375*24);
    
   
    
    self.bottomView.frame = CGRectMake(0,
                   CGRectGetMaxY(self.topView.frame)+SCREEN_WIDTH/375*14,
                   SCREEN_WIDTH,
                   SCREEN_HEIGHT-(CGRectGetMaxY(self.topView.frame)+SCREEN_WIDTH/375*14));
}


#pragma mark - 时间戳转换为标准时间
- (NSString *)timeChange:(NSString *)timeStamp {
    NSTimeInterval time = [timeStamp doubleValue];// + 28800;  //因为时差问题要加8小时 == 28800
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSString *currentDateStr = [formatter stringFromDate: date];
    return currentDateStr;
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


-(UIView *)topView{
    if (_topView==nil) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*0,
                                                             64,
                                                             SCREEN_WIDTH,
                                                             SCREEN_WIDTH/375*120)];
    }
    return _topView;
}

//title
-(UILabel *)titleLabel{
    if (_titleLabel==nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*17.5,
                                    SCREEN_WIDTH/375*13.6,
                                    SCREEN_WIDTH-SCREEN_WIDTH/375*17.5-SCREEN_WIDTH/375*79,
                                    SCREEN_WIDTH/375*20)];
}
    return _titleLabel;
}

//com
-(UILabel *)buyLabel{
    if (_buyLabel==nil) {
        _buyLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*17.5,
                                                              SCREEN_WIDTH/375*38.6,
                                                              SCREEN_WIDTH-SCREEN_WIDTH/375*79-SCREEN_WIDTH/375*18,
                                                              SCREEN_WIDTH/375*17)];
    }
    return _buyLabel;
}

//num
-(UILabel *)numberLabel{
    if (_numberLabel==nil) {
        _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*17.5,
                                                                 SCREEN_WIDTH/375*61,
                                                                 SCREEN_WIDTH-SCREEN_WIDTH/375*79-SCREEN_WIDTH/375*18,
                                                                 SCREEN_WIDTH/375*17)];
    }
    return _numberLabel;
}

//money
-(UILabel *)moneyLabel{
    if (_moneyLabel==nil) {
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*18,
                                                                SCREEN_WIDTH/375*83.6,
                                                                SCREEN_WIDTH-SCREEN_WIDTH/375*79-SCREEN_WIDTH/375*18,
                                                                SCREEN_WIDTH/375*24)];
    }
    return _moneyLabel;
}


-(UIView *)bottomView{
    if (_bottomView==nil) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0,
                CGRectGetMaxY(self.topView.frame)+SCREEN_WIDTH/375*14,
                SCREEN_WIDTH,
                SCREEN_HEIGHT-(CGRectGetMaxY(self.topView.frame)+SCREEN_WIDTH/375*14))];
    }
    return _bottomView;
}

-(UILabel *)tipLabel{
    if (_tipLabel==nil) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*19,
                                                                SCREEN_WIDTH/375*15,
                                                                SCREEN_WIDTH/375*100,
                                                                SCREEN_WIDTH/375*20)];
    }
    return _tipLabel;
}

-(UIView *)suggestView{
    
    if (_suggestView==nil) {
        _suggestView=[[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*18,
                                                              SCREEN_WIDTH/375*45,
                                                              SCREEN_WIDTH-SCREEN_WIDTH/375*36,
                                                              SCREEN_WIDTH/375*186)];
    }
    return _suggestView;
}

-(UITextView *)suggestTextView{
    
    if (_suggestTextView==nil) {
        _suggestTextView=[[UITextView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*5,
                                                                      SCREEN_WIDTH/375*0,
                                                                      SCREEN_WIDTH-SCREEN_WIDTH/375*36-SCREEN_WIDTH/375*10,
                                                                      SCREEN_WIDTH/375*186-SCREEN_WIDTH/375*20)];
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
        _worldCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*40-SCREEN_WIDTH/375*8-100,
                                                                     SCREEN_WIDTH/375*161,
                                                                     100,
                                                                     SCREEN_WIDTH/375*14)];
    }
    return _worldCountLabel;
}


-(UIButton *)commitButton{
    if (!_commitButton) {
        _commitButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                                   SCREEN_WIDTH/375*256,
                                                                   SCREEN_WIDTH-SCREEN_WIDTH/375*40,
                                                                   SCREEN_WIDTH/375*40)];
    }
    return _commitButton;
}


@end
