//
//  ZMOrderProgressTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/5/17.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMOrderProgressTableViewCell.h"

@implementation ZMOrderProgressTableViewCell

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
                                   text:@"-- --"
                                    hex:@"999999"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*11]];
        [self.contentView addSubview:self.timeLabel];
        
        //note
        [ZMLabelAttributeMange setLabel:self.noteLabel
                                   text:@"-- --"
                                    hex:@"666666"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
        [self.contentView addSubview:self.noteLabel];
        
        //left line
        self.leftLine.backgroundColor = [UIColor colorWithHex:@"E0E0E0"];
        [self.contentView addSubview:self.leftLine];
        
        //point
        self.leftPoint.layer.cornerRadius = SCREEN_WIDTH/375*4;
        self.leftPoint.layer.masksToBounds= YES;
        self.leftPoint.backgroundColor = [UIColor colorWithHex:@"D8D8D8"];
        [self.contentView addSubview:self.leftPoint];
        
        
        //bottom line
        self.botLine.backgroundColor = [UIColor colorWithHex:@"E2E2E2"];
        [self.contentView addSubview:self.botLine];
        
        self.shutterView.backgroundColor = [UIColor whiteColor];
        self.shutterView.alpha = 0;
        [self.contentView addSubview:self.shutterView];
        
    }
    return self;
}



//time
-(UILabel *)timeLabel{
    if (_timeLabel==nil) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*52,
                                                        SCREEN_WIDTH/375*8.7,
                                                        SCREEN_WIDTH/375*200,
                                                        SCREEN_WIDTH/375*13)];
    }
    return _timeLabel;
}


//note
-(UILabel *)noteLabel{
    if (_noteLabel==nil) {
        _noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*52,
                                                               CGRectGetMaxY(self.timeLabel.frame)+SCREEN_WIDTH/375*5,
                                                               SCREEN_WIDTH-SCREEN_WIDTH/375*52-SCREEN_WIDTH/375*25,
                                                               SCREEN_WIDTH/375*20)];
    }
    return _noteLabel;
}

-(UIView *)shutterView{
    if (_shutterView==nil) {
        _shutterView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*18,
                                                              SCREEN_WIDTH/375*0,
                                                              SCREEN_WIDTH/375*8,
                                                              SCREEN_WIDTH/375*10)];
    }
    return _shutterView;
}

//point
-(UIView *)leftPoint{
    if (_leftPoint==nil) {
        _leftPoint = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*18.5,
                                                               SCREEN_WIDTH/375*10,
                                                               SCREEN_WIDTH/375*8,
                                                               SCREEN_WIDTH/375*8)];
    }
    return _leftPoint;
}
//leftLine;
-(UIView *)leftLine{
    if (_leftLine==nil) {
        _leftLine = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*22,
                                                              SCREEN_WIDTH/375*0,
                                                              SCREEN_WIDTH/375*1,
                                                              SCREEN_WIDTH/375*80)];
    }
    return _leftLine;
}
//botLine;
-(UIView *)botLine{
    if (_botLine==nil) {
        _botLine = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*41.4,
                                                         SCREEN_WIDTH/375*80-SCREEN_WIDTH/375*0.5,
                                                         SCREEN_WIDTH-SCREEN_WIDTH/375*41.4-SCREEN_WIDTH/375*25,
                                                         SCREEN_WIDTH/375*0.5)];
    }
    return _botLine;
}

- (void)setOrProNote:(NSDictionary *)noteDic{
    
    NSLog(@"noteDic  %@",noteDic);
    NSString *time = [NSString stringWithFormat:@"%@",noteDic[@"time"]];
    NSString *note = [NSString stringWithFormat:@"%@",noteDic[@"note"]];
    self.timeLabel.text = [self timeChange:time];
    self.noteLabel.text = note;
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

@end
