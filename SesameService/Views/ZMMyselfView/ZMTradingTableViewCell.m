//
//  ZMTradingTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/21.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMTradingTableViewCell.h"

@implementation ZMTradingTableViewCell

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
                                   text:@"---"
                                    hex:@"333333"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
        [self.contentView addSubview:self.titleLabel];
        
        
        //time
        [ZMLabelAttributeMange setLabel:self.timeLabel
                                   text:@"--"
                                    hex:@"666666"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.timeLabel];
        
        
        //money
        [ZMLabelAttributeMange setLabel:self.moneyLabel
                                   text:@"--"
                                    hex:@"333333"
                          textAlignment:NSTextAlignmentRight
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*16]];
        [self.contentView addSubview:self.moneyLabel];
        
        
        self.line.backgroundColor = [UIColor colorWithHex:@"D8D8D8"];
        [self.contentView addSubview:self.line];
    }
    return self;
}

- (void)setPromoteIntro:(NSDictionary *)promoteDid{
    
    NSString *settle_amount = [NSString stringWithFormat:@"%@",promoteDid[@"settle_amount"]];
    NSString *time          = [NSString stringWithFormat:@"%@",promoteDid[@"time"]];
    NSString *flow          = [NSString stringWithFormat:@"%@",promoteDid[@"flow"]];
    NSString *settlement_title    = [NSString stringWithFormat:@"%@",promoteDid[@"settlement_title"]];
    self.titleLabel.text = settlement_title;
    
    if ([flow isEqualToString:@"inflow"]) {
        self.moneyLabel.text = [NSString stringWithFormat:@"+%@",settle_amount];
    }else{
        self.moneyLabel.text = [NSString stringWithFormat:@"-%@",settle_amount];
    }
    
    self.timeLabel.text = [self timeChange:time];
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
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*18.5,
                                                                SCREEN_WIDTH/375*10.7,
                                                                SCREEN_WIDTH/375*200,
                                                                SCREEN_WIDTH/375*20)];
    }
    return _titleLabel;
}

//time
-(UILabel *)timeLabel{
    if (_timeLabel==nil) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*18.5,
                                                               SCREEN_WIDTH/375*29.7,
                                                               SCREEN_WIDTH/375*200,
                                                               SCREEN_WIDTH/375*17)];
    }
    return _timeLabel;
}

//money
-(UILabel *)moneyLabel{
    if (_moneyLabel==nil) {
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*17-SCREEN_WIDTH/375*100,
                                                                (SCREEN_WIDTH/375*60-SCREEN_WIDTH/375*21)/2,
                                                                SCREEN_WIDTH/375*100,
                                                                SCREEN_WIDTH/375*21)];
    }
    return _moneyLabel;
}

-(UIView *)line{
    if (_line==nil) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                         SCREEN_WIDTH/375*59.5,
                                                         SCREEN_WIDTH,
                                                         SCREEN_WIDTH/375*0.5)];
    }
    return _line;
}


@end
