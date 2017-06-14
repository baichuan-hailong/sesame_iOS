//
//  ZMTradingEvaluationTopTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMTradingEvaluationTopTableViewCell.h"

@implementation ZMTradingEvaluationTopTableViewCell

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
        
        //time
        [ZMLabelAttributeMange setLabel:self.buyLabel
                                   text:@"--"
                                    hex:@"666666"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.buyLabel];
        
        //num
        [ZMLabelAttributeMange setLabel:self.numberLabel
                                   text:@"--"
                                    hex:@"666666"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.numberLabel];
        
        
        //money
        [ZMLabelAttributeMange setLabel:self.moneyLabel
                                   text:@"--"
                                    hex:@"EE6B6A"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*18]];
        [self.contentView addSubview:self.moneyLabel];
    }
    return self;
}



- (void)setTradingEvaTop:(NSDictionary *)topDic{
    
    //NSLog(@"topDic ---------------------------------- %@",topDic);
    
    NSString *title       = [NSString stringWithFormat:@"%@",topDic[@"title"]];
    //NSString *status_title= [NSString stringWithFormat:@"%@",topDic[@"status_title"]];
    //NSString *status      = [NSString stringWithFormat:@"%@",topDic[@"status"]];
    NSString *time        = [NSString stringWithFormat:@"%@",topDic[@"time"]];
    NSString *price       = [NSString stringWithFormat:@"%@",topDic[@"price"]];
    NSString *local_sn  = [NSString stringWithFormat:@"%@",topDic[@"local_sn"]];
    
    if (title.length>0&&![title isEqualToString:@"(null)"]) {
        self.titleLabel.text  = [NSString stringWithFormat:@"%@",title];
    }
    
    
    CGSize   size      = CGSizeMake(SCREEN_WIDTH-SCREEN_WIDTH/375*17.5-SCREEN_WIDTH/375*79, 0);
    CGSize  autoSize = [[UILabel new] actualSizeOfLineSpaceLable:[NSString stringWithFormat:@"%@",title]
                                                         andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
                                                         andSize:size];
    int height = (int)autoSize.height+1;
    self.titleLabel.frame = CGRectMake(SCREEN_WIDTH/375*17.5,
                                       SCREEN_WIDTH/375*13.6,
                                       SCREEN_WIDTH-SCREEN_WIDTH/375*17.5-SCREEN_WIDTH/375*79,
                                       height);
    self.titleLabel.numberOfLines = 0;
    
    
    
    if (time.length>0&&![time isEqualToString:@"(null)"]) {
        self.buyLabel.text= [NSString stringWithFormat:@"购买时间：%@",[self timeChange:time]];
    }
    if (price.length>0&&![price isEqualToString:@"(null)"]) {
        self.moneyLabel.text  = [NSString stringWithFormat:@"¥%@",price];
    }
    
    if (local_sn.length>0&&![local_sn isEqualToString:@"(null)"]) {
        self.numberLabel.text = [NSString stringWithFormat:@"交易号：%@",local_sn];
    }
    
    
    self.buyLabel.frame = CGRectMake(SCREEN_WIDTH/375*17.5,
                                     CGRectGetMaxY(self.titleLabel.frame)+SCREEN_WIDTH/375*2,
                                     SCREEN_WIDTH-SCREEN_WIDTH/375*79-SCREEN_WIDTH/375*18,
                                     SCREEN_WIDTH/375*17);
    
    
    self.numberLabel.frame = CGRectMake(SCREEN_WIDTH/375*17.5,
                                        CGRectGetMaxY(self.buyLabel.frame)+SCREEN_WIDTH/375*2,
                                        SCREEN_WIDTH-SCREEN_WIDTH/375*79-SCREEN_WIDTH/375*18,
                                        SCREEN_WIDTH/375*17);
    
    self.moneyLabel.frame = CGRectMake(SCREEN_WIDTH/375*18,
                                       CGRectGetMaxY(self.numberLabel.frame)+SCREEN_WIDTH/375*2,
                                       SCREEN_WIDTH-SCREEN_WIDTH/375*79-SCREEN_WIDTH/375*18,
                                       SCREEN_WIDTH/375*24);
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
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*17.5,
                                                                SCREEN_WIDTH/375*13.6,
                                                                SCREEN_WIDTH-SCREEN_WIDTH/375*17.5-SCREEN_WIDTH/375*79,
                                                                SCREEN_WIDTH/375*20)];
    }
    return _titleLabel;
}

//com
-(UILabel *)buyLabel{
    if (_buyLabel==nil) {
        _buyLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*17.5,
                                                              SCREEN_WIDTH/375*38.6,
                                                              SCREEN_WIDTH-SCREEN_WIDTH/375*79-SCREEN_WIDTH/375*18,
                                                              SCREEN_WIDTH/375*17)];
    }
    return _buyLabel;
}

//num
-(UILabel *)numberLabel{
    if (_numberLabel==nil) {
        _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*17.5,
                                                                 SCREEN_WIDTH/375*61,
                                                                 SCREEN_WIDTH-SCREEN_WIDTH/375*79-SCREEN_WIDTH/375*18,
                                                                 SCREEN_WIDTH/375*17)];
    }
    return _numberLabel;
}

//money
-(UILabel *)moneyLabel{
    if (_moneyLabel==nil) {
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*18,
                                                                SCREEN_WIDTH/375*83.6,
                                                                SCREEN_WIDTH-SCREEN_WIDTH/375*79-SCREEN_WIDTH/375*18,
                                                                SCREEN_WIDTH/375*24)];
    }
    return _moneyLabel;
}


@end
