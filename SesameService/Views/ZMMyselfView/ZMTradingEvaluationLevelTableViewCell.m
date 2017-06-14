//
//  ZMTradingEvaluationLevelTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMTradingEvaluationLevelTableViewCell.h"

@implementation ZMTradingEvaluationLevelTableViewCell

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
        
        
        //time
        [ZMLabelAttributeMange setLabel:self.timeLabel
                                   text:@"评价时间：- -"
                                    hex:@"666666"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
        [self.contentView addSubview:self.timeLabel];
        
        
        self.levelView.layer.cornerRadius = SCREEN_WIDTH/375*2;
        self.levelView.layer.borderColor  = [UIColor colorWithHex:@"979797"].CGColor;
        self.levelView.layer.borderWidth  = SCREEN_WIDTH/375*0.5;
        [self.contentView addSubview:self.levelView];
        
        
        [self.levelView addSubview:self.levelBtn];
    }
    return self;
}


- (void)setEvaluationLevel:(NSDictionary *)levelDic{
    NSString *time = [NSString stringWithFormat:@"%@",levelDic[@"time"]];
    if (time.length>0&&![time isEqualToString:@"(null)"]) {
        self.timeLabel.text = [NSString stringWithFormat:@"评价时间：%@",[self timeChange:time]];
    }
    NSString *level= [NSString stringWithFormat:@"%@",levelDic[@"level"]];
    if ([level isEqualToString:@"good"]) {
        [self.levelBtn setLeftImage:[UIImage imageNamed:@"haopingselect"] rightLa:@"好评" rightHex:tonalColor];
    }else if ([level isEqualToString:@"middle"]){
        [self.levelBtn setLeftImage:[UIImage imageNamed:@"zhongpingselect"] rightLa:@"中评" rightHex:tonalColor];
    }else if ([level isEqualToString:@"bad"]){
        [self.levelBtn setLeftImage:[UIImage imageNamed:@"chapingnoselect"] rightLa:@"差评" rightHex:tonalColor];
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
-(UILabel *)timeLabel{
    if (_timeLabel==nil) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*21,
                                                              SCREEN_WIDTH/375*16,
                                                              SCREEN_WIDTH/375*200,
                                                              SCREEN_WIDTH/375*20)];
    }
    return _timeLabel;
}

-(UIView *)levelView{
    if (_levelView==nil) {
        _levelView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*23,
                                                                       SCREEN_WIDTH/375*47,
                                                                       SCREEN_WIDTH/375*89,
                                                                       SCREEN_WIDTH/375*35)];
    }
    return _levelView;
}


//level
-(ZMEvaluationView *)levelBtn{
    if (_levelBtn==nil) {
        _levelBtn = [[ZMEvaluationView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*6.5,
                                                                      SCREEN_WIDTH/375*5.5,
                                                                      SCREEN_WIDTH/375*80,
                                                                      SCREEN_WIDTH/375*24)];
    }
    return _levelBtn;
}



@end
