//
//  ZMInformationTranTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/21.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMInformationTranTableViewCell.h"



@implementation ZMInformationTranTableViewCell

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
        
        
        self.line.backgroundColor = [UIColor colorWithHex:@"D8D8D8"];
        [self.contentView addSubview:self.line];
        
        //title
        [ZMLabelAttributeMange setLabel:self.titleLabel
                                   text:@"--- ---"
                                    hex:@"333333"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
        [self.contentView addSubview:self.titleLabel];
        
        
        //money
        [ZMLabelAttributeMange setLabel:self.moneyLabel
                                   text:@"¥--"
                                    hex:@"EE6B6A"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*18]];
        [self.contentView addSubview:self.moneyLabel];
        
        
        //time
        [ZMLabelAttributeMange setLabel:self.bottonLabel
                                   text:@"---：--"
                                    hex:@"666666"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.bottonLabel];
        
        //state
        [ZMLabelAttributeMange setLabel:self.rightLabel
                                   text:@"--"
                                    hex:tonalColor
                          textAlignment:NSTextAlignmentRight
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.rightLabel];
        
    }
    return self;
}



- (void)setInfoTran:(NSDictionary *)dic isLeft:(BOOL)isleft{

    
    NSString *status = [NSString stringWithFormat:@"%@",dic[@"status"]];
    
    //NSLog(@"%@",dic);
    if (isleft) {
        self.titleLabel.text  = [NSString stringWithFormat:@"%@",dic[@"title"]];
        self.moneyLabel.text  = [NSString stringWithFormat:@"¥%@",dic[@"price"]];
        self.bottonLabel.text = [NSString stringWithFormat:@"发布时间：%@",[self timeChange:dic[@"time"]]];
        self.rightLabel.text  = [NSString stringWithFormat:@"%@",dic[@"status_title"]];
        if ([status isEqualToString:@"submit_pending"]) {
            self.rightLabel.textColor = [UIColor colorWithHex:tonalColor];
        }else{
            self.rightLabel.textColor = [UIColor colorWithHex:@"AAAAAA"];
        }
    }else{
        
        self.titleLabel.text  = [NSString stringWithFormat:@"%@",dic[@"title"]];
        self.moneyLabel.text  = [NSString stringWithFormat:@"¥%@",dic[@"price"]];
        self.bottonLabel.text = [NSString stringWithFormat:@"购买时间：%@",[self timeChange:dic[@"time"]]];
        self.rightLabel.text  = [NSString stringWithFormat:@"%@",dic[@"status_title"]];
        if ([status isEqualToString:@"dealt_pending"]) {
            self.rightLabel.textColor = [UIColor colorWithHex:tonalColor];
        }else{
            self.rightLabel.textColor = [UIColor colorWithHex:@"AAAAAA"];
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


//time
-(UILabel *)bottonLabel{
    if (_bottonLabel==nil) {
        _bottonLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*17.5,
                                                                 SCREEN_WIDTH/375*37.6,
                                                                 SCREEN_WIDTH/375*250,
                                                                 SCREEN_WIDTH/375*17)];
    }
    return _bottonLabel;
}

//money
-(UILabel *)moneyLabel{
    if (_moneyLabel==nil) {
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*18,
                                                                SCREEN_WIDTH/375*63.6,
                                                                SCREEN_WIDTH-SCREEN_WIDTH/375*79-SCREEN_WIDTH/375*18,
                                                                SCREEN_WIDTH/375*24)];
    }
    return _moneyLabel;
}



//state
-(UILabel *)rightLabel{
    if (_rightLabel==nil) {
        _rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*18-SCREEN_WIDTH/375*100,
                                                                SCREEN_WIDTH/375*13,
                                                                SCREEN_WIDTH/375*100,
                                                                SCREEN_WIDTH/375*17)];
    }
    return _rightLabel;
}

-(UIView *)line{
    if (_line==nil) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                         SCREEN_WIDTH/375*99.5,
                                                         SCREEN_WIDTH,
                                                         SCREEN_WIDTH/375*0.5)];
    }
    return _line;
}

@end
