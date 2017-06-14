//
//  ZMCommissionDetailTopTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/25.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMCommissionDetailTopTableViewCell.h"

@implementation ZMCommissionDetailTopTableViewCell

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
        
        /*
         //num
         [ZMLabelAttributeMange setLabel:self.numberLabel
         text:@"单号：123456789010234"
         hex:@"666666"
         textAlignment:NSTextAlignmentLeft
         font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
         [self.contentView addSubview:self.numberLabel];
         
         */
        
       
        //time
        [ZMLabelAttributeMange setLabel:self.timeLabel
                                   text:@"--"
                                    hex:@"666666"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.timeLabel];
        
        
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


- (void)setTopDetail:(NSDictionary *)dic isLeft:(BOOL)isLeft{
    
    if (isLeft) {
        NSString *title = [NSString stringWithFormat:@"%@",dic[@"title"]];
        if (title.length>0&&![title isEqualToString:@"(null)"]) {
            self.titleLabel.text = title;
            
            
        }
        
        
        CGSize   size    = CGSizeMake(SCREEN_WIDTH-SCREEN_WIDTH/375*17.5-SCREEN_WIDTH/375*79, 0);
        CGSize  autoSize = [[UILabel new] actualSizeOfLineSpaceLable:[NSString stringWithFormat:@"%@",title]
                                                             andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
                                                             andSize:size];
        
        int height = (int)autoSize.height+1;
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.frame = CGRectMake(SCREEN_WIDTH/375*17.5,
                                           SCREEN_WIDTH/375*14.6,
                                           SCREEN_WIDTH-SCREEN_WIDTH/375*17.5-SCREEN_WIDTH/375*79,
                                           height);
        
        NSString *time = [NSString stringWithFormat:@"%@",dic[@"time"]];
        if (time.length>0&&![time isEqualToString:@"(null)"]) {
            self.timeLabel.text = [NSString stringWithFormat:@"发起时间：%@",[self timeChange:time]];
        }
        
        
        self.timeLabel.frame = CGRectMake(SCREEN_WIDTH/375*17.5,
                                          CGRectGetMaxY(self.titleLabel.frame)+SCREEN_WIDTH/375*10,
                                          SCREEN_WIDTH/375*250,
                                          SCREEN_WIDTH/375*17);
        
        NSString *status_title = [NSString stringWithFormat:@"%@",dic[@"status_title"]];
        if (status_title.length>0&&![status_title isEqualToString:@"(null)"]) {
            self.stateLabel.text  = status_title;
        }
        
        NSString *status = [NSString stringWithFormat:@"%@",dic[@"status"]];
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
    }else{
        NSString *title = [NSString stringWithFormat:@"%@",dic[@"title"]];
        if (title.length>0&&![title isEqualToString:@"(null)"]) {
            self.titleLabel.text = title;
        }
        
        CGSize   size    = CGSizeMake(SCREEN_WIDTH-SCREEN_WIDTH/375*17.5-SCREEN_WIDTH/375*79, 0);
        CGSize  autoSize = [[UILabel new] actualSizeOfLineSpaceLable:[NSString stringWithFormat:@"%@",title]
                                                             andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
                                                             andSize:size];
        
        int height = (int)autoSize.height+1;
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.frame = CGRectMake(SCREEN_WIDTH/375*17.5,
                                           SCREEN_WIDTH/375*14.6,
                                           SCREEN_WIDTH-SCREEN_WIDTH/375*17.5-SCREEN_WIDTH/375*79,
                                           height);
        
        NSString *time = [NSString stringWithFormat:@"%@",dic[@"time"]];
        if (time.length>0&&![time isEqualToString:@"(null)"]) {
            self.timeLabel.text = [NSString stringWithFormat:@"接单时间：%@",[self timeChange:time]];
        }
        
        self.timeLabel.frame = CGRectMake(SCREEN_WIDTH/375*17.5,
                                          CGRectGetMaxY(self.titleLabel.frame)+SCREEN_WIDTH/375*10,
                                          SCREEN_WIDTH/375*250,
                                          SCREEN_WIDTH/375*17);
        
        NSString *status_title = [NSString stringWithFormat:@"%@",dic[@"status_title"]];
        if (status_title.length>0&&![status_title isEqualToString:@"(null)"]) {
            self.stateLabel.text  = status_title;
        }
        
        NSString *status = [NSString stringWithFormat:@"%@",dic[@"status"]];
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
                                                                SCREEN_WIDTH/375*14.6,
                                                                SCREEN_WIDTH-SCREEN_WIDTH/375*17.5-SCREEN_WIDTH/375*79,
                                                                SCREEN_WIDTH/375*20)];
    }
    return _titleLabel;
}


/*
 //num
 -(UILabel *)numberLabel{
 if (_numberLabel==nil) {
 _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*17.5,
 SCREEN_WIDTH/375*39.6,
 SCREEN_WIDTH-SCREEN_WIDTH/375*79-SCREEN_WIDTH/375*18,
 SCREEN_WIDTH/375*17)];
 }
 return _numberLabel;
 }
 

 */



//time
-(UILabel *)timeLabel{
    if (_timeLabel==nil) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*17.5,
                                                               SCREEN_WIDTH/375*39.6,
                                                               SCREEN_WIDTH/375*250,
                                                               SCREEN_WIDTH/375*17)];
    }
    return _timeLabel;
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

@end
