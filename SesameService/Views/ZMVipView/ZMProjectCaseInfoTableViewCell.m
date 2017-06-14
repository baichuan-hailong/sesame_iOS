//
//  ZMProjectCaseInfoTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/5.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMProjectCaseInfoTableViewCell.h"

@implementation ZMProjectCaseInfoTableViewCell

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
        
        //left
        [ZMLabelAttributeMange setLabel:self.leftLabel
                                   text:@"---"
                                    hex:@"999999"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.leftLabel];
        
        
        //right
        [ZMLabelAttributeMange setLabel:self.rightLabel
                                   text:@"---"
                                    hex:@"333333"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*13]];
        [self.contentView addSubview:self.rightLabel];
    }
    return self;
}

- (void)setCaseInfoCell:(NSDictionary *)caseDic row:(NSInteger)row{
    self.leftLabel.text  = [NSString stringWithFormat:@"%@",[self timeChange:caseDic[@"record_time"]]];
    self.rightLabel.text = caseDic[@"title"];
    //self.leftLabel.backgroundColor = [UIColor redColor];
    //self.rightLabel.backgroundColor= [UIColor yellowColor];
}

#pragma mark - 时间戳转换为标准时间
- (NSString *)timeChange:(NSString *)timeStamp {
    NSTimeInterval time = [timeStamp doubleValue];// + 28800;  //因为时差问题要加8小时 == 28800
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSString *currentDateStr = [formatter stringFromDate: date];
    return currentDateStr;
}


//20 19
-(UILabel *)leftLabel{
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*24,
                                                               SCREEN_WIDTH/375*0,
                                                               SCREEN_WIDTH/375*80,
                                                               SCREEN_WIDTH/375*20)];
    }
    return _leftLabel;
}

//right
-(UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*111,
                                            SCREEN_WIDTH/375*0,
                                            SCREEN_WIDTH-SCREEN_WIDTH/375*111-SCREEN_WIDTH/375*20,
                                            SCREEN_WIDTH/375*20)];
    }
    return _rightLabel;
}

@end
