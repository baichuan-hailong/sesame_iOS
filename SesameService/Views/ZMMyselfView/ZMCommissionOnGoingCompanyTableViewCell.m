//
//  ZMCommissionOnGoingCompanyTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/5/25.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMCommissionOnGoingCompanyTableViewCell.h"

@implementation ZMCommissionOnGoingCompanyTableViewCell

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
        
        
        
        //title
        [ZMLabelAttributeMange setLabel:self.titleLabel
                                   text:@"-- --"
                                    hex:@"333333"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
        [self.contentView addSubview:self.titleLabel];
        
        //tuijie
        [ZMLabelAttributeMange setLabel:self.tuijieComLabel
                                   text:@"---"
                                    hex:@"666666"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.tuijieComLabel];
        //self.tuijieComLabel.backgroundColor = [UIColor redColor];
        
        //money
        [ZMLabelAttributeMange setLabel:self.moneyLabel
                                   text:@"---"
                                    hex:@"666666"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.moneyLabel];
        
        //acc
        [ZMLabelAttributeMange setLabel:self.accountedLabel
                                   text:@"- -"
                                    hex:@"666666"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.accountedLabel];
        
        //time
        [ZMLabelAttributeMange setLabel:self.timeLabel
                                   text:@"- -"
                                    hex:@"666666"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.timeLabel];
        
        
        //tip
        [ZMLabelAttributeMange setLabel:self.tipLabel
                                   text:@"- - -"
                                    hex:@"FA4A4A"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.tipLabel];
        
        //state
        [ZMLabelAttributeMange setLabel:self.stateLabel
                                   text:@"--"
                                    hex:@"AAAAAA"
                          textAlignment:NSTextAlignmentRight
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.stateLabel];
        
    }
    return self;
}


- (void)setCommission:(NSDictionary *)commisionDid isLeft:(BOOL)isLeft{
    
    
    
    NSString *title = [NSString stringWithFormat:@"%@",commisionDid[@"title"]];
    if (title.length>0&&![title isEqualToString:@"(null)"]) {
        self.titleLabel.text = title;
    }
    NSString *target_amount_value = [NSString stringWithFormat:@"%@",commisionDid[@"target_amount_value"]];
    if (target_amount_value.length>0&&![target_amount_value isEqualToString:@"(null)"]) {
        self.moneyLabel.text = [NSString stringWithFormat:@"预估标的额：%@W",target_amount_value];
    }
    NSString *reward_type = [NSString stringWithFormat:@"%@",commisionDid[@"reward_type"]];
    if ([reward_type isEqualToString:@"fixed_value"]) {
        //按金额
        NSString *reward_value = [NSString stringWithFormat:@"%@",commisionDid[@"reward_value"]];
        self.accountedLabel.text = [NSString stringWithFormat:@"期望推介费：%@W",reward_value];
    }else if ([reward_type isEqualToString:@"fixed_percent"]) {
        //按比例
        NSString *reward_percent = [NSString stringWithFormat:@"%@",commisionDid[@"reward_percent"]];
        float rewaidPercent = [reward_percent floatValue];
        self.accountedLabel.text = [NSString stringWithFormat:@"期望推介费：%.2f%@",rewaidPercent*100,@"%"];
        
    }else if ([reward_type isEqualToString:@"market_avg"]) {
        //按行业惯例或接单方规定
        self.accountedLabel.text = @"期望推介费：按行业惯例或接单方规定";
    }else if ([reward_type isEqualToString:@"negotiable"]) {
        //认可平台协商的结果
        self.accountedLabel.text = @"期望推介费：认可平台协商的结果";
    }
    
    
    NSString *demander_name = [NSString stringWithFormat:@"%@",commisionDid[@"demander_name"]];
    NSString *type_title = [NSString stringWithFormat:@"%@",commisionDid[@"type_title"]];
    if (demander_name.length>0&&![demander_name isEqualToString:@"(null)"]&&type_title.length>0&&![type_title isEqualToString:@"(null)"]) {
        self.tuijieComLabel.text = [NSString stringWithFormat:@"推介的公司：%@ | %@",demander_name,type_title];
    }
    
    
    NSString *note = [NSString stringWithFormat:@"%@",commisionDid[@"status_note"][@"note"]];
    if (note.length>0&&![note isEqualToString:@"(null)"]) {
        self.tipLabel.text  = note;
    }
    NSString *time = [NSString stringWithFormat:@"%@",commisionDid[@"time"]];
    if (time.length>0&&![time isEqualToString:@"(null)"]) {
        self.timeLabel.text = [NSString stringWithFormat:@"发起时间：%@",[self timeChange:time]];
    }
    
    NSString *status_title = [NSString stringWithFormat:@"%@",commisionDid[@"status_title"]];
    if (status_title.length>0&&![status_title isEqualToString:@"(null)"]) {
        self.stateLabel.text  = status_title;
    }
    
    NSString *status = [NSString stringWithFormat:@"%@",commisionDid[@"status"]];
    if ([status isEqualToString:@"reject_die"]) {
        //已关闭
        self.stateLabel.textColor = [UIColor colorWithHex:@"AAAAAA"];
    }else if ([status isEqualToString:@"finish_done"]||[status isEqualToString:@"finished_done"]) {
        //已完成
        self.stateLabel.textColor = [UIColor colorWithHex:@"AAAAAA"];
    }else{
        //进行中
        self.stateLabel.textColor = [UIColor colorWithHex:tonalColor];
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

//38.6
-(UILabel *)tuijieComLabel{
    if (_tuijieComLabel==nil) {
        _tuijieComLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*17.5,
                                                                SCREEN_WIDTH/375*38.6,
                                                                SCREEN_WIDTH-SCREEN_WIDTH/375*79-SCREEN_WIDTH/375*18,
                                                                SCREEN_WIDTH/375*17)];
    }
    return _tuijieComLabel;
}


//money
-(UILabel *)moneyLabel{
    if (_moneyLabel==nil) {
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*17.5,
                                                                SCREEN_WIDTH/375*60.6,
                                                                SCREEN_WIDTH-SCREEN_WIDTH/375*79-SCREEN_WIDTH/375*18,
                                                                SCREEN_WIDTH/375*17)];
    }
    return _moneyLabel;
}



//account
-(UILabel *)accountedLabel{
    if (_accountedLabel==nil) {
        _accountedLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*17.5,
                                                                    SCREEN_WIDTH/375*82.6,
                                                                    SCREEN_WIDTH-SCREEN_WIDTH/375*79-SCREEN_WIDTH/375*18,
                                                                    SCREEN_WIDTH/375*17)];
    }
    return _accountedLabel;
}


//time
-(UILabel *)timeLabel{
    if (_timeLabel==nil) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*17.5,
                                                               SCREEN_WIDTH/375*103.6,
                                                               SCREEN_WIDTH/375*250,
                                                               SCREEN_WIDTH/375*17)];
    }
    return _timeLabel;
}

//tip
-(UILabel *)tipLabel{
    if (_tipLabel==nil) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*17.5,
                                                              SCREEN_WIDTH/375*126.6,
                                                              SCREEN_WIDTH-SCREEN_WIDTH/375*20,
                                                              SCREEN_WIDTH/375*17)];
        //_tipLabel.backgroundColor = [UIColor yellowColor];
    }
    return _tipLabel;
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


@end
