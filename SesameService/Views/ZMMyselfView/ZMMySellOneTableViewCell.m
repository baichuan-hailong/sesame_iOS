//
//  ZMMySellOneTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/24.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMMySellOneTableViewCell.h"

@implementation ZMMySellOneTableViewCell

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
                                   text:@"--- ---"
                                    hex:@"333333"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
        [self.contentView addSubview:self.titleLabel];
        //self.titleLabel.backgroundColor = [UIColor redColor];
        
        //com
        [ZMLabelAttributeMange setLabel:self.comTimeLabel
                                   text:@"-- --"
                                    hex:@"666666"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.comTimeLabel];
        
    
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
        
        //cancle
        self.cancleBtn.layer.cornerRadius = SCREEN_WIDTH/375*2;
        self.cancleBtn.layer.borderColor  = [UIColor colorWithHex:@"AAAAAA"].CGColor;
        self.cancleBtn.layer.borderWidth  = SCREEN_WIDTH/375*0.5;
        self.cancleBtn.layer.masksToBounds= YES;
        [self.cancleBtn setTitle:@"--" forState:UIControlStateNormal];
        [self.cancleBtn setTitleColor:[UIColor colorWithHex:@"AAAAAA"] forState:UIControlStateNormal];
        self.cancleBtn.titleLabel.font = [UIFont systemFontOfSize:SCREEN_WIDTH/375*14];
        self.cancleBtn.alpha = 0;
        [self.contentView addSubview:self.cancleBtn];
        
        
        self.leftTipLabel.alpha = 0;
        self.rightTipLabel.alpha= 0;
        
        
        //self.leftTipLabel.backgroundColor = [UIColor redColor];
        [ZMLabelAttributeMange setLabel:self.leftTipLabel
                                   text:@"--"
                                    hex:@"999999"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.leftTipLabel];
        
        
        //self.rightTipLabel.backgroundColor = [UIColor redColor];
        [ZMLabelAttributeMange setLabel:self.rightTipLabel
                                   text:@"--"
                                    hex:@"999999"
                          textAlignment:NSTextAlignmentRight
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.rightTipLabel];
        
    }
    return self;
}



- (void)setSellOne:(NSDictionary *)dic{
    
    /*
     self.sellTipDic = @{@"title":title,
     @"time":time,
     @"status":status,
     @"status_title":status_title,
     @"price":price};
     
     self.sellTipDic = @{@"title":title,
     @"time":time,
     @"status":status,
     @"status_title":status_title,
     @"price":price,
     @"accept_time":accept_time,
     @"cancel_time":cancel_time,
     @"expire_time":expire_time,
     @"local_sn":local_sn};
     */
    
    NSString *title  = [NSString stringWithFormat:@"%@",dic[@"title"]];
    NSString *status_title  = [NSString stringWithFormat:@"%@",dic[@"status_title"]];
    NSString *time  = [NSString stringWithFormat:@"%@",dic[@"time"]];
    NSString *price  = [NSString stringWithFormat:@"%@",dic[@"price"]];
    
    if (title.length>0&&![title isEqualToString:@"(null)"]) {
        self.titleLabel.text  = [NSString stringWithFormat:@"%@",title];
        CGSize size = CGSizeMake(SCREEN_WIDTH-SCREEN_WIDTH/375*17.5-SCREEN_WIDTH/375*79, 0);
        CGSize autoSize = [[UILabel new] actualSizeOfLineSpaceLable:title
                                                            andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
                                                            andSize:size];
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.frame = CGRectMake(SCREEN_WIDTH/375*17.5,
                                           SCREEN_WIDTH/375*14.6,
                                           SCREEN_WIDTH-SCREEN_WIDTH/375*17.5-SCREEN_WIDTH/375*79,
                                           autoSize.height);
    }
    
    
    
    self.comTimeLabel.frame = CGRectMake(SCREEN_WIDTH/375*17.5,
                                         CGRectGetMaxY(self.titleLabel.frame)+SCREEN_WIDTH/375*4,
                                         SCREEN_WIDTH-SCREEN_WIDTH/375*79-SCREEN_WIDTH/375*18,
                                         SCREEN_WIDTH/375*17);
    
    
    self.moneyLabel.frame = CGRectMake(SCREEN_WIDTH/375*18,
                                       CGRectGetMaxY(self.titleLabel.frame)+SCREEN_WIDTH/375*30,
                                       SCREEN_WIDTH-SCREEN_WIDTH/375*79-SCREEN_WIDTH/375*18,
                                       SCREEN_WIDTH/375*24);
    
    
    self.lineImg.frame = CGRectMake(0,
                              CGRectGetMaxY(self.titleLabel.frame)+SCREEN_WIDTH/375*66.4,
                              SCREEN_WIDTH,
                              SCREEN_WIDTH/375*2);
    
    
    self.leftTipLabel.frame = CGRectMake(SCREEN_WIDTH/375*17,
                                         CGRectGetMaxY(self.titleLabel.frame)+SCREEN_WIDTH/375*84.4,
                                         SCREEN_WIDTH/375*200,
                                         SCREEN_WIDTH/375*16);
    
    self.rightTipLabel.frame = CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*17-SCREEN_WIDTH/375*170,
                                    CGRectGetMaxY(self.titleLabel.frame)+SCREEN_WIDTH/375*84.4,
                                    SCREEN_WIDTH/375*170,
                                    SCREEN_WIDTH/375*16);
    
    
    self.cancleBtn.frame = CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*19-SCREEN_WIDTH/375*70,
                                      CGRectGetMaxY(self.titleLabel.frame)+SCREEN_WIDTH/375*77.4,
                                      SCREEN_WIDTH/375*70,
                                      SCREEN_WIDTH/375*30);
    
    
    
    if (status_title.length>0&&![status_title isEqualToString:@"(null)"]) {
        self.stateLabel.text  = [NSString stringWithFormat:@"%@",status_title];
    }
    if (time.length>0&&![time isEqualToString:@"(null)"]) {
        self.comTimeLabel.text= [NSString stringWithFormat:@"发布时间：%@",[self timeChange:time]];
    }
    if (price.length>0&&![price isEqualToString:@"(null)"]) {
        self.moneyLabel.text  = [NSString stringWithFormat:@"¥%@",price];
    }
    
    
    NSString *status = [NSString stringWithFormat:@"%@",dic[@"status"]];
    if ([status isEqualToString:@"submit_pending"]) {
        //发布中
        self.stateLabel.textColor = [UIColor colorWithHex:tonalColor];
        [self.cancleBtn setTitle:@"取消发布" forState:UIControlStateNormal];
        self.leftTipLabel.alpha = 0;
        self.rightTipLabel.alpha= 0;
        self.cancleBtn.alpha = 1;
    }else{
        self.stateLabel.textColor = [UIColor colorWithHex:@"AAAAAA"];
        
        if ([status isEqualToString:@"dealt_pending"]||[status isEqualToString:@"rate_done"]){
            //已售出
            self.leftTipLabel.alpha = 1;
            self.rightTipLabel.alpha= 1;
            self.cancleBtn.alpha = 0;
            NSString *local_sn  = [NSString stringWithFormat:@"%@",dic[@"local_sn"]];
            NSString *accept_time  = [NSString stringWithFormat:@"%@",dic[@"accept_time"]];
            self.leftTipLabel.text = [NSString stringWithFormat:@"交易号：%@",local_sn];
            self.rightTipLabel.text= [NSString stringWithFormat:@"售出时间：%@",[self timeChange:accept_time]];
        }else if ([status isEqualToString:@"expired_die"]||[status isEqualToString:@"expired_die"]){
            //过期下架
            NSString *expire_time  = [NSString stringWithFormat:@"%@",dic[@"expire_time"]];
            self.leftTipLabel.text= [NSString stringWithFormat:@"下架时间：%@",[self timeChange:expire_time]];
            
            self.leftTipLabel.alpha = 1;
            self.rightTipLabel.alpha= 0;
            self.cancleBtn.alpha = 1;
            
            
            self.cancleBtn.layer.cornerRadius = SCREEN_WIDTH/375*2;
            self.cancleBtn.layer.borderWidth  = SCREEN_WIDTH/375*0;
            self.cancleBtn.layer.masksToBounds= YES;
            [self.cancleBtn setTitle:@"再次发布" forState:UIControlStateNormal];
            [self.cancleBtn setTitleColor:[UIColor colorWithHex:@"FFFFFF"] forState:UIControlStateNormal];
            self.cancleBtn.backgroundColor = [UIColor colorWithHex:tonalColor];
    
            
        }else if ([status isEqualToString:@"cancel_die"]){
            //已取消
            NSString *cancel_time  = [NSString stringWithFormat:@"%@",dic[@"cancel_time"]];
            self.leftTipLabel.text= [NSString stringWithFormat:@"取消时间：%@",[self timeChange:cancel_time]];
            
            self.leftTipLabel.alpha = 1;
            self.rightTipLabel.alpha= 0;
            self.cancleBtn.alpha = 1;
            
            self.cancleBtn.layer.cornerRadius = SCREEN_WIDTH/375*2;
            self.cancleBtn.layer.borderWidth  = SCREEN_WIDTH/375*0;
            self.cancleBtn.layer.masksToBounds= YES;
            [self.cancleBtn setTitle:@"再次发布" forState:UIControlStateNormal];
            [self.cancleBtn setTitleColor:[UIColor colorWithHex:@"FFFFFF"] forState:UIControlStateNormal];
            self.cancleBtn.backgroundColor = [UIColor colorWithHex:tonalColor];
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
                                                                SCREEN_WIDTH/375*14.6,
                                                                SCREEN_WIDTH-SCREEN_WIDTH/375*17.5-SCREEN_WIDTH/375*79,
                                                                SCREEN_WIDTH/375*20)];
    }
    return _titleLabel;
}

//com
-(UILabel *)comTimeLabel{
    if (_comTimeLabel==nil) {
        _comTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*17.5,
                                                                  SCREEN_WIDTH/375*38.6,
                                                                  SCREEN_WIDTH-SCREEN_WIDTH/375*79-SCREEN_WIDTH/375*18,
                                                                  SCREEN_WIDTH/375*17)];
    }
    return _comTimeLabel;
}

//money
-(UILabel *)moneyLabel{
    if (_moneyLabel==nil) {
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*18,
                                                                SCREEN_WIDTH/375*64.6,
                                                                SCREEN_WIDTH-SCREEN_WIDTH/375*79-SCREEN_WIDTH/375*18,
                                                                SCREEN_WIDTH/375*24)];
    }
    return _moneyLabel;
}


//line
-(UIImageView *)lineImg{
    if (_lineImg==nil) {
        _lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                 SCREEN_WIDTH/375*101,
                                                                 SCREEN_WIDTH,
                                                                 SCREEN_WIDTH/375*2)];
    }
    return _lineImg;
}


//state
-(UILabel *)stateLabel{
    if (_stateLabel==nil) {
        _stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*19-SCREEN_WIDTH/375*100,
                                                                SCREEN_WIDTH/375*14,
                                                                SCREEN_WIDTH/375*100,
                                                                SCREEN_WIDTH/375*17)];
    }
    return _stateLabel;
}

//cancle
-(UIButton *)cancleBtn{
    if (_cancleBtn==nil) {
        _cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*19-SCREEN_WIDTH/375*70,
                                                                 SCREEN_WIDTH/375*111,
                                                                 SCREEN_WIDTH/375*70,
                                                                 SCREEN_WIDTH/375*30)];
    }
    return _cancleBtn;
}


//left tip
-(UILabel *)leftTipLabel{
    if (_leftTipLabel==nil) {
        _leftTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*17,
                                                                SCREEN_WIDTH/375*118,
                                                                SCREEN_WIDTH/375*200,
                                                                SCREEN_WIDTH/375*16)];
    }
    return _leftTipLabel;
}

//right tip
-(UILabel *)rightTipLabel{
    if (_rightTipLabel==nil) {
        _rightTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*17-SCREEN_WIDTH/375*170,
                                                                  SCREEN_WIDTH/375*118,
                                                                  SCREEN_WIDTH/375*170,
                                                                  SCREEN_WIDTH/375*16)];
    }
    return _rightTipLabel;
}

@end
