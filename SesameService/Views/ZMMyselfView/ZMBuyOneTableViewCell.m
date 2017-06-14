//
//  ZMBuyOneTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/24.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMBuyOneTableViewCell.h"

@implementation ZMBuyOneTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor  = [UIColor whiteColor];
        
        
        self.lineImg.image = [UIImage imageNamed:@"pathLine"];
        self.lineImg.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.lineImg];
        
        //title
        [ZMLabelAttributeMange setLabel:self.titleLabel
                                   text:@"-- --"
                                    hex:@"333333"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
        [self.contentView addSubview:self.titleLabel];
        
        //time
        [ZMLabelAttributeMange setLabel:self.buyLabel
                                   text:@"---"
                                    hex:@"666666"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.buyLabel];
        
        //num
        [ZMLabelAttributeMange setLabel:self.numberLabel
                                   text:@"---"
                                    hex:@"666666"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.numberLabel];
        
        
        //money
        [ZMLabelAttributeMange setLabel:self.moneyLabel
                                   text:@"--"
                                    hex:@"EE6B6A"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*18]];
        [self.contentView addSubview:self.moneyLabel];
        
        
        
        //sta
        [ZMLabelAttributeMange setLabel:self.stateLabel
                                   text:@"--"
                                    hex:@"AAAAAA"
                          textAlignment:NSTextAlignmentRight
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.stateLabel];
        
        //pingjia
        self.pingjiaBtn.layer.cornerRadius = SCREEN_WIDTH/375*2;
        self.pingjiaBtn.layer.masksToBounds= YES;
        [self.pingjiaBtn setTitle:@"评价" forState:UIControlStateNormal];
        [self.pingjiaBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.pingjiaBtn.backgroundColor = [UIColor colorWithHex:tonalColor];
        self.pingjiaBtn.titleLabel.font = [UIFont systemFontOfSize:SCREEN_WIDTH/375*14];
        self.pingjiaBtn.alpha  =0;
        [self.contentView addSubview:self.pingjiaBtn];
        
        //tousu
        self.tousuBtn.layer.cornerRadius = SCREEN_WIDTH/375*2;
        self.tousuBtn.layer.borderColor  = [UIColor colorWithHex:@"AAAAAA"].CGColor;
        self.tousuBtn.layer.borderWidth  = SCREEN_WIDTH/375*0.5;
        self.tousuBtn.layer.masksToBounds= YES;
        [self.tousuBtn setTitle:@"投诉" forState:UIControlStateNormal];
        [self.tousuBtn setTitleColor:[UIColor colorWithHex:@"AAAAAA"] forState:UIControlStateNormal];
        self.tousuBtn.titleLabel.font = [UIFont systemFontOfSize:SCREEN_WIDTH/375*14];
        self.tousuBtn.alpha = 0;
        [self.contentView addSubview:self.tousuBtn];
    }
    return self;
}



- (void)setBuyTipOne:(NSDictionary *)dic{
    
    NSLog(@"dic  --------  %@",dic);
    
    /*
     self.buyTipDic = @{@"title":title,
     @"time":time,
     @"status":status,
     @"status_title":status_title,
     @"price":price,
     @"local_sn":local_sn};
     
     */
    if ([dic count]!=0) {
        NSLog(@"null");
        
        NSString *title       = [NSString stringWithFormat:@"%@",dic[@"title"]];
        NSString *status_title= [NSString stringWithFormat:@"%@",dic[@"status_title"]];
        NSString *status= [NSString stringWithFormat:@"%@",dic[@"status"]];
        NSString *time        = [NSString stringWithFormat:@"%@",dic[@"time"]];
        NSString *price       = [NSString stringWithFormat:@"%@",dic[@"price"]];
        NSString *local_sn  = [NSString stringWithFormat:@"%@",dic[@"local_sn"]];
        
        if (title.length>0&&![title isEqualToString:@"(null)"]) {
            self.titleLabel.text  = [NSString stringWithFormat:@"%@",title];
            
            CGSize size = CGSizeMake(SCREEN_WIDTH-SCREEN_WIDTH/375*17.5-SCREEN_WIDTH/375*79, 0);
            CGSize autoSize = [[UILabel new] actualSizeOfLineSpaceLable:title
                                                                andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
                                                                andSize:size];
            
            
            self.titleLabel.numberOfLines = 0;
            self.titleLabel.frame= CGRectMake(SCREEN_WIDTH/375*17.5,
                                              SCREEN_WIDTH/375*13.6,
                                              SCREEN_WIDTH-SCREEN_WIDTH/375*17.5-SCREEN_WIDTH/375*79,
                                              autoSize.height);
        }
        
        
        
        
        self.buyLabel.frame = CGRectMake(SCREEN_WIDTH/375*17.5,
                                         CGRectGetMaxY(self.titleLabel.frame)+SCREEN_WIDTH/375*4,
                                         SCREEN_WIDTH-SCREEN_WIDTH/375*79-SCREEN_WIDTH/375*18,
                                         SCREEN_WIDTH/375*17);
        
        
        
        self.numberLabel.frame = CGRectMake(SCREEN_WIDTH/375*17.5,
                                            CGRectGetMaxY(self.titleLabel.frame)+SCREEN_WIDTH/375*27.4,
                                            SCREEN_WIDTH-SCREEN_WIDTH/375*79-SCREEN_WIDTH/375*18,
                                            SCREEN_WIDTH/375*17);
        
        
        self.moneyLabel.frame = CGRectMake(SCREEN_WIDTH/375*18,
                                           CGRectGetMaxY(self.titleLabel.frame)+SCREEN_WIDTH/375*50,
                                           SCREEN_WIDTH-SCREEN_WIDTH/375*79-SCREEN_WIDTH/375*18,
                                           SCREEN_WIDTH/375*24);
        
        
        self.lineImg.frame = CGRectMake(0,
                                        CGRectGetMaxY(self.titleLabel.frame)+SCREEN_WIDTH/375*86.4,
                                        SCREEN_WIDTH,
                                        SCREEN_WIDTH/375*2);
        
        self.tousuBtn.frame = CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*17-SCREEN_WIDTH/375*60-SCREEN_WIDTH/375*70,
                                         CGRectGetMaxY(self.titleLabel.frame)+SCREEN_WIDTH/375*97.4,
                                         SCREEN_WIDTH/375*60,
                                         SCREEN_WIDTH/375*30);
        
        
        self.pingjiaBtn.frame = CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*17-SCREEN_WIDTH/375*60,
                                           CGRectGetMaxY(self.titleLabel.frame)+SCREEN_WIDTH/375*97.4,
                                           SCREEN_WIDTH/375*60,
                                           SCREEN_WIDTH/375*30);
        
        
        if (status_title.length>0&&![status_title isEqualToString:@"(null)"]) {
            self.stateLabel.text  = [NSString stringWithFormat:@"%@",status_title];
        }
        if (time.length>0&&![time isEqualToString:@"(null)"]) {
            self.buyLabel.text= [NSString stringWithFormat:@"购买时间：%@",[self timeChange:time]];
        }
        if (price.length>0&&![price isEqualToString:@"(null)"]) {
            self.moneyLabel.text  = [NSString stringWithFormat:@"¥%@",price];
        }
        
        if (local_sn.length>0&&![local_sn isEqualToString:@"(null)"]) {
            self.numberLabel.text = [NSString stringWithFormat:@"交易号：%@",local_sn];
        }
        
        if ([status isEqualToString:@"dealt_pending"]) {
            self.stateLabel.textColor = [UIColor colorWithHex:tonalColor];
            self.pingjiaBtn.alpha = 1;
            self.tousuBtn.alpha   = 1;
            
        }else{
            
            if (status.length>0&&![status isEqualToString:@"(null)"]) {
                self.stateLabel.textColor = [UIColor colorWithHex:@"AAAAAA"];
                self.pingjiaBtn.alpha = 0;
                self.tousuBtn.alpha   = 1;
                
                
                
                self.pingjiaBtn.frame = CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*17-SCREEN_WIDTH/375*60-SCREEN_WIDTH/375*70,
                                                   CGRectGetMaxY(self.titleLabel.frame)+SCREEN_WIDTH/375*97.4,
                                                   SCREEN_WIDTH/375*60,
                                                   SCREEN_WIDTH/375*30);
                
                
                self.tousuBtn.frame = CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*17-SCREEN_WIDTH/375*60,
                                                 CGRectGetMaxY(self.titleLabel.frame)+SCREEN_WIDTH/375*97.4,
                                                 SCREEN_WIDTH/375*60,
                                                 SCREEN_WIDTH/375*30);
                
            }
            
        }
        
        
        
        
        NSString *is_complaint = [NSString stringWithFormat:@"%@",dic[@"is_complaint"]];
        //NSString *status = [NSString stringWithFormat:@"%@",dic[@"status"]];
        
        NSLog(@"%@%@",is_complaint,status);
        if ([status isEqualToString:@"rate_done"]&&[is_complaint integerValue]==1) {
            //已评价 已投诉
            //self.moreArray =      @[@{@"left":@"更多项目信息"},
            //@{@"left":@"交易评价"},
            //@{@"left":@"投诉详情"}];
        }else if ([is_complaint integerValue]==1) {
            
            //self.moreArray =      @[@{@"left":@"更多项目信息"},
            //@{@"left":@"投诉详情"}];
            self.pingjiaBtn.alpha = 1;
            self.tousuBtn.alpha   = 0;
            
            
            
            self.pingjiaBtn.frame = CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*17-SCREEN_WIDTH/375*60,
                                               CGRectGetMaxY(self.titleLabel.frame)+SCREEN_WIDTH/375*97.4,
                                               SCREEN_WIDTH/375*60,
                                               SCREEN_WIDTH/375*30);
            
            
            self.tousuBtn.frame = CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*17-SCREEN_WIDTH/375*60-SCREEN_WIDTH/375*70,
                                             CGRectGetMaxY(self.titleLabel.frame)+SCREEN_WIDTH/375*97.4,
                                             SCREEN_WIDTH/375*60,
                                             SCREEN_WIDTH/375*30);
        }else if ([status isEqualToString:@"rate_done"]) {
            
            //self.moreArray =      @[@{@"left":@"更多项目信息"},
            //@{@"left":@"交易评价"}];
            self.pingjiaBtn.alpha = 0;
            self.tousuBtn.alpha   = 1;
            
            
            
            self.pingjiaBtn.frame = CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*17-SCREEN_WIDTH/375*60-SCREEN_WIDTH/375*70,
                                               CGRectGetMaxY(self.titleLabel.frame)+SCREEN_WIDTH/375*97.4,
                                               SCREEN_WIDTH/375*60,
                                               SCREEN_WIDTH/375*30);
            
            
            self.tousuBtn.frame = CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*17-SCREEN_WIDTH/375*60,
                                             CGRectGetMaxY(self.titleLabel.frame)+SCREEN_WIDTH/375*97.4,
                                             SCREEN_WIDTH/375*60,
                                             SCREEN_WIDTH/375*30);
        }else{
            //self.moreArray =      @[@{@"left":@"更多项目信息"}];
            self.pingjiaBtn.alpha = 1;
            self.tousuBtn.alpha   = 1;
        }
    }
    
    
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


//line
-(UIImageView *)lineImg{
    if (_lineImg==nil) {
        _lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                 SCREEN_WIDTH/375*120,
                                                                 SCREEN_WIDTH,
                                                                 SCREEN_WIDTH/375*2)];
    }
    return _lineImg;
}


//state
-(UILabel *)stateLabel{
    if (_stateLabel==nil) {
        _stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*17-SCREEN_WIDTH/375*100,
                                                                SCREEN_WIDTH/375*14,
                                                                SCREEN_WIDTH/375*100,
                                                                SCREEN_WIDTH/375*17)];
    }
    return _stateLabel;
}

//cancle
-(UIButton *)pingjiaBtn{
    if (_pingjiaBtn==nil) {
        _pingjiaBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*17-SCREEN_WIDTH/375*60,
                                                                SCREEN_WIDTH/375*131,
                                                                SCREEN_WIDTH/375*60,
                                                                SCREEN_WIDTH/375*30)];
    }
    return _pingjiaBtn;
}

-(UIButton *)tousuBtn{
    if (_tousuBtn==nil) {
        _tousuBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*17-SCREEN_WIDTH/375*60-SCREEN_WIDTH/375*70,
                                                                 SCREEN_WIDTH/375*131,
                                                                 SCREEN_WIDTH/375*60,
                                                                 SCREEN_WIDTH/375*30)];
    }
    return _tousuBtn;
}



@end
