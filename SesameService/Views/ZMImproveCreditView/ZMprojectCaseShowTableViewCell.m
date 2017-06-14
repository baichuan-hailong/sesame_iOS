//
//  ZMprojectCaseShowTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/31.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMprojectCaseShowTableViewCell.h"

@interface ZMprojectCaseShowTableViewCell ()

@end

@implementation ZMprojectCaseShowTableViewCell

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
        
        /*
         [ZMLabelAttributeMange setLabel:self.nameLabel
         text:@"百川"
         hex:@"333333"
         textAlignment:NSTextAlignmentLeft
         font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
         [self.contentView addSubview:self.nameLabel];
         */
        
        
        [ZMLabelAttributeMange setLabel:self.titleLabel
                                   text:@"设计、代理、制作、发布国内及外商"
                                    hex:@"333333"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.titleLabel];
        
        [ZMLabelAttributeMange setLabel:self.timeLabel
                                   text:@"2016-12-12"
                                    hex:@"999999"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.timeLabel];
        
        
        [self.deleteBtn setImage:[UIImage imageNamed:@"deleteImage"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.deleteBtn];
    
        self.line.backgroundColor = [UIColor colorWithHex:@"DDDDDD"];
        [self.contentView addSubview:self.line];
    }
    return self;
}


- (void)setProjectCase:(NSDictionary *)caseDic{
    
    //self.nameLabel.text = [NSString stringWithFormat:@"%@",caseDic[@"customer"]];
    self.titleLabel.text= [NSString stringWithFormat:@"%@",caseDic[@"title"]];
    self.timeLabel.text = [NSString stringWithFormat:@"%@",[self timeChange:caseDic[@"record_time"]]];
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

//lazy
/*
 -(UILabel *)nameLabel{
 if (_nameLabel==nil) {
 _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*18, 
 SCREEN_WIDTH/375*13, 
 SCREEN_WIDTH/375*150, 
 SCREEN_WIDTH/375*20)];
 }
 return _nameLabel;
 }
 */


-(UILabel *)titleLabel{
    if (_titleLabel==nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*18,
                            SCREEN_WIDTH/375*14,
                            SCREEN_WIDTH-SCREEN_WIDTH/375*60,
                            SCREEN_WIDTH/375*17)];
    }
    return _titleLabel;
}

-(UILabel *)timeLabel{
    if (_timeLabel==nil) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*18,
                                                               SCREEN_WIDTH/375*43,
                                                               SCREEN_WIDTH/375*200,
                                                               SCREEN_WIDTH/375*16)];
    }
    return _timeLabel;
}

-(UIButton *)deleteBtn{
    if (_deleteBtn==nil) {
        _deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*19-SCREEN_WIDTH/375*14,
                                (SCREEN_WIDTH/375*71-SCREEN_WIDTH/375*14)/2,
                                SCREEN_WIDTH/375*14,
                                SCREEN_WIDTH/375*14)];
    }
    return _deleteBtn;
}

-(UIView *)line{
    if (_line==nil) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*0,
                                                         SCREEN_WIDTH/375*70,
                                                         SCREEN_WIDTH,
                                                         SCREEN_WIDTH/375*1)];
    }
    return _line;
}


@end
