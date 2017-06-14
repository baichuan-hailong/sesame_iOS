//
//  ZMMySounceAnswerTextTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/5/10.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMMySounceAnswerTextTableViewCell.h"

@implementation ZMMySounceAnswerTextTableViewCell

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
        
        //self.line.backgroundColor = [UIColor colorWithHex:@"EEEEEE"];
        //[self.contentView addSubview:self.line];
        
        //time
        [ZMLabelAttributeMange setLabel:self.timeLabel
                                   text:@"--  --"
                                    hex:@"999999"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*10]];
        [self.contentView addSubview:self.timeLabel];
        
        
    
        //time
        [ZMLabelAttributeMange setLabel:self.answerLabel
                                   text:@"--"
                                    hex:@"666666"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
        [self.contentView addSubview:self.answerLabel];
        
    }
    return self;
}


- (void)setTextSounce:(NSDictionary *)textDic{
    NSString *time = [NSString stringWithFormat:@"%@",textDic[@"time"]];
    if (time.length>0&&![time isEqualToString:@"(null)"]) {
        self.timeLabel.text = [self timeChange:time];
    }
    
    
    NSString *answer = [NSString stringWithFormat:@"%@",textDic[@"answer"]];
    if (answer.length>0&&![answer isEqualToString:@"(null)"]) {
        self.answerLabel.text = answer;
    }
}


#pragma mark - 时间戳转换为标准时间
- (NSString *)timeChange:(NSString *)timeStamp {
    NSTimeInterval time = [timeStamp doubleValue];// + 28800;  //因为时差问题要加8小时 == 28800
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSString *currentDateStr = [formatter stringFromDate: date];
    return currentDateStr;
}




-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                               SCREEN_WIDTH/375*11,
                                                               SCREEN_WIDTH/2,
                                                               SCREEN_WIDTH/375*15)];
    }
    return _timeLabel;
}


-(UILabel *)answerLabel{
    if (!_answerLabel) {
        _answerLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*21,
                                                               SCREEN_WIDTH/375*33,
                                                               SCREEN_WIDTH-SCREEN_WIDTH/375*42,
                                                               SCREEN_WIDTH/375*40)];
    }
    return _answerLabel;
}


@end
