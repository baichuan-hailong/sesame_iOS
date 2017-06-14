//
//  ZMInviteRecordTypeTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/6/7.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMInviteRecordTypeTableViewCell.h"

@interface ZMInviteRecordTypeTableViewCell ()
@property(nonatomic,strong)UIView *line;
@end

@implementation ZMInviteRecordTypeTableViewCell

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
        
        [ZMLabelAttributeMange setLabel:self.telLabel
                                   text:@"--"
                                    hex:@"666666"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.telLabel];
        
        [ZMLabelAttributeMange setLabel:self.timeLabel
                                   text:@"--"
                                    hex:@"666666"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.timeLabel];
        
        
        self.line.backgroundColor = [UIColor colorWithHex:@"DDDDDD"];
        [self.contentView addSubview:self.line];
        
        [ZMLabelAttributeMange setLabel:self.moneyTipLabel
                                   text:@"贡献奖金："
                                    hex:@"666666"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.moneyTipLabel];
        
        [ZMLabelAttributeMange setLabel:self.moneyLabel
                                   text:@"--"
                                    hex:@"FA4A4A"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.moneyLabel];
        
    }
    return self;
}

-(void)setRecord:(NSDictionary *)recDic{
    self.telLabel.text = [NSString stringWithFormat:@"手机号：%@",recDic[@"username"]];
    self.timeLabel.text = [NSString stringWithFormat:@"注册时间：%@",[self timeChange:recDic[@"time"]]];
    self.moneyLabel.text = [NSString stringWithFormat:@"%@元",recDic[@"reward"]];
}


#pragma mark - 时间戳转换为标准时间
- (NSString *)timeChange:(NSString *)timeStamp {
    NSTimeInterval time = [timeStamp doubleValue];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSString *currentDateStr = [formatter stringFromDate: date];
    return currentDateStr;
}


//lazy

//tel
-(UILabel *)telLabel{
    if (_telLabel==nil) {
        _telLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*17.5,
                                                              SCREEN_WIDTH/375*13.6,
                                                              SCREEN_WIDTH-SCREEN_WIDTH/375*30,
                                                              SCREEN_WIDTH/375*17)];
    }
    return _telLabel;
}

//time
-(UILabel *)timeLabel{
    if (_timeLabel==nil) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*17.5,
                                                               SCREEN_WIDTH/375*64-SCREEN_WIDTH/375*26,
                                                               SCREEN_WIDTH-SCREEN_WIDTH/375*30,
                                                               SCREEN_WIDTH/375*17)];
    }
    return _timeLabel;
}

-(UIView *)line{
    if (_line==nil) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*0,
                                                         SCREEN_WIDTH/375*96-SCREEN_WIDTH/375*26,
                                                         SCREEN_WIDTH,
                                                         SCREEN_WIDTH/375*0.5)];
    }
    return _line;
}

//money
-(UILabel *)moneyTipLabel{
    if (_moneyTipLabel==nil) {
        _moneyTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*17.5,
                                                                   SCREEN_WIDTH/375*107-SCREEN_WIDTH/375*26,
                                                                   SCREEN_WIDTH/375*65,
                                                                   SCREEN_WIDTH/375*17)];
    }
    return _moneyTipLabel;
}
-(UILabel *)moneyLabel{
    if (_moneyLabel==nil) {
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*78,
                                                                SCREEN_WIDTH/375*107-SCREEN_WIDTH/375*26,
                                                                SCREEN_WIDTH/375*60,
                                                                SCREEN_WIDTH/375*17)];
    }
    return _moneyLabel;
}

@end
