//
//  ZMMyComplaintsTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/24.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMMyComplaintsTableViewCell.h"

@implementation ZMMyComplaintsTableViewCell

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
        
        
        
        //trading num
        [ZMLabelAttributeMange setLabel:self.tradingNumLabel
                                   text:@"-- --"
                                    hex:@"666666"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.tradingNumLabel];
        
        //trading time
        [ZMLabelAttributeMange setLabel:self.tradingTimeLabel
                                   text:@"-- --"
                                    hex:@"666666"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.tradingTimeLabel];
        
        //money
        [ZMLabelAttributeMange setLabel:self.moneyLabel
                                   text:@"--"
                                    hex:@"EE6B6A"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*18]];
        [self.contentView addSubview:self.moneyLabel];
        
        
        //com
        [ZMLabelAttributeMange setLabel:self.comTimeLabel
                                   text:@"-- --"
                                    hex:@"999999"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.comTimeLabel];
        
        //sta
        [ZMLabelAttributeMange setLabel:self.stateLabel
                                   text:@"--"
                                    hex:@"AAAAAA"
                          textAlignment:NSTextAlignmentRight
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.stateLabel];
        
        //res
        [ZMLabelAttributeMange setLabel:self.resultLabel
                                   text:@"-- --"
                                    hex:@"999999"
                          textAlignment:NSTextAlignmentRight
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        self.resultLabel.alpha = 0;
        [self.contentView addSubview:self.resultLabel];
        
    }
    return self;
}






- (void)setComplain:(NSDictionary *)leftDic{
    /*
     {
     id = 3;
     "local_sn" = 201705071430354366;
     price = 100;
     result = "<null>";
     status = pending;
     "status_title" = "\U5904\U7406\U4e2d";
     time = 1494225790;
     title = 123456789012345678901234567890;
     "trade_time" = 1494138641;
     }
     */
    NSString *title = [NSString stringWithFormat:@"%@",leftDic[@"title"]];
    NSString *local_sn = [NSString stringWithFormat:@"%@",leftDic[@"local_sn"]];
    NSString *trade_time = [NSString stringWithFormat:@"%@",leftDic[@"trade_time"]];
    NSString *price = [NSString stringWithFormat:@"%@",leftDic[@"price"]];
    NSString *time = [NSString stringWithFormat:@"%@",leftDic[@"time"]];
    NSString *status = [NSString stringWithFormat:@"%@",leftDic[@"status"]];
    NSString *status_title = [NSString stringWithFormat:@"%@",leftDic[@"status_title"]];
    
    if (title.length>0&&![title isEqualToString:@"(null)"]) {
        self.titleLabel.text = title;
    }
    if (local_sn.length>0&&![local_sn isEqualToString:@"(null)"]) {
        self.tradingNumLabel.text = [NSString stringWithFormat:@"交易号：%@",local_sn];
    }
    if (trade_time.length>0&&![trade_time isEqualToString:@"(null)"]) {
        self.tradingTimeLabel.text = [NSString stringWithFormat:@"交易时间：%@",[self timeChange:trade_time]];
    }
    if (price.length>0&&![price isEqualToString:@"(null)"]) {
        self.moneyLabel.text = [NSString stringWithFormat:@"￥%@",price];
    }
    if (time.length>0&&![time isEqualToString:@"(null)"]) {
        self.comTimeLabel.text = [NSString stringWithFormat:@"投诉时间：%@",[self timeChange:time]];
    }
    
    if (status_title.length>0&&![status_title isEqualToString:@"(null)"]) {
        self.stateLabel.text = status_title;
    }
    
    
    //fnishing pending processing
    if ([status isEqualToString:@"pending"]||[status isEqualToString:@"processing"]) {
        self.stateLabel.textColor = [UIColor colorWithHex:tonalColor];
        self.resultLabel.alpha = 0;
    }else{
        self.stateLabel.textColor = [UIColor colorWithHex:@"AAAAAA"];
        
        NSString *result = [NSString stringWithFormat:@"%@",leftDic[@"result"]];
        if (result.length>0&&![result isEqualToString:@"(null)"]&&![result isEqualToString:@"<null>"]) {
            self.resultLabel.alpha = 1;
            self.resultLabel.text = [NSString stringWithFormat:@"处理结果：%@",result];
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


- (void)setlabel:(UILabel *)label title:(NSString *)title color:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)textFond{
    
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    label.font = textFond;
    label.text = title;
    
    label.layer.borderColor  = [UIColor colorWithHex:@"AAAAAA"].CGColor;
    label.layer.borderWidth  = SCREEN_WIDTH/375*0.5;
    label.layer.cornerRadius = SCREEN_WIDTH/375*8;
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


//trading num
-(UILabel *)tradingNumLabel{
    if (_tradingNumLabel==nil) {
        _tradingNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*17.5,
                                                                 SCREEN_WIDTH/375*38.6,
                                                                 SCREEN_WIDTH-SCREEN_WIDTH/375*17.5-SCREEN_WIDTH/375*79,
                                                                 SCREEN_WIDTH/375*17)];
    }
    return _tradingNumLabel;
}

//trading time
-(UILabel *)tradingTimeLabel{
    if (_tradingTimeLabel==nil) {
        _tradingTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*17.5,
                                                                     SCREEN_WIDTH/375*60.6,
                                                                     SCREEN_WIDTH-SCREEN_WIDTH/375*17.5-SCREEN_WIDTH/375*79,
                                                                     SCREEN_WIDTH/375*17)];
    }
    return _tradingTimeLabel;
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



//com
-(UILabel *)comTimeLabel{
    if (_comTimeLabel==nil) {
        _comTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*17,
                                                                SCREEN_WIDTH/375*133,
                                                                SCREEN_WIDTH-SCREEN_WIDTH/375*79-SCREEN_WIDTH/375*18,
                                                                SCREEN_WIDTH/375*16)];
    }
    return _comTimeLabel;
}

-(UIImageView *)lineImg{
    if (_lineImg==nil) {
        _lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                         SCREEN_WIDTH/375*119,
                                                         SCREEN_WIDTH,
                                                         SCREEN_WIDTH/375*2)];
    }
    return _lineImg;
}


//state
-(UILabel *)stateLabel{
    if (_stateLabel==nil) {
        _stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*18-SCREEN_WIDTH/375*100,
                                                                  SCREEN_WIDTH/375*13,
                                                                  SCREEN_WIDTH/375*100,
                                                                  SCREEN_WIDTH/375*17)];
    }
    return _stateLabel;
}

//res
-(UILabel *)resultLabel{
    if (_resultLabel==nil) {
        _resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*18-SCREEN_WIDTH/375*150,
                                                                SCREEN_WIDTH/375*133,
                                                                SCREEN_WIDTH/375*150,
                                                                SCREEN_WIDTH/375*16)];
    }
    return _resultLabel;
}


@end
