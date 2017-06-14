//
//  ZMSounceLeftDetailTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/5/10.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMSounceLeftDetailTableViewCell.h"

@interface ZMSounceLeftDetailTableViewCell ()
@property(nonatomic,strong)UIView      *line;
@end

@implementation ZMSounceLeftDetailTableViewCell

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
                                    hex:@"333333"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.timeLabel];
        
        //money
        [ZMLabelAttributeMange setLabel:self.moneyLabel
                                   text:@"-- -"
                                    hex:@"EB6D62"
                          textAlignment:NSTextAlignmentRight
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.moneyLabel];
        
        //question
        [ZMLabelAttributeMange setLabel:self.questionLabel
                                   text:@"--- ---"
                                    hex:@"333333"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.questionLabel];
        
        //state
        //self.stateImageView.image = [UIImage imageNamed:@"isComingImage"];
        [self.contentView addSubview:self.stateImageView];
        
        [ZMLabelAttributeMange setLabel:self.stateLabel
                                   text:@"--  --"
                                    hex:@"999999"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.stateLabel];
        
        //bottom
        //self.bottomButton.backgroundColor = [UIColor redColor];
        self.bottomButton.alpha = 0;
        [self.bottomButton setImage:[UIImage imageNamed:@"deleteImage"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.bottomButton];
        
        
        //note
        [ZMLabelAttributeMange setLabel:self.noteLabel
                                   text:@"--  --"
                                    hex:@"F47373"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.noteLabel];
    }
    return self;
}


- (void)setMyAsk:(NSDictionary *)leftDic{
    
    //time
    NSString *time = [NSString stringWithFormat:@"%@",leftDic[@"time"]];
    self.timeLabel.text = [self timeChange:time];
    //money
    NSString *price = [NSString stringWithFormat:@"%@",leftDic[@"price"]];
    self.moneyLabel.text = [NSString stringWithFormat:@"赏金 ¥%@",price];
    //question
    NSString *question = [NSString stringWithFormat:@"%@",leftDic[@"question"]];
    self.questionLabel.text = [NSString stringWithFormat:@"%@",question];
    [self.questionLabel sizeToFit];
    
    
    //note
    NSString *note = [NSString stringWithFormat:@"%@",leftDic[@"note"]];
    self.noteLabel.text = note;
    
    
    NSString *status = [NSString stringWithFormat:@"%@",leftDic[@"status"]];
    NSString *status_title = [NSString stringWithFormat:@"%@",leftDic[@"status_title"]];
    
    NSString *last_hours = [NSString stringWithFormat:@"%@",leftDic[@"last_hours"]];
    NSString *answer_user_num = [NSString stringWithFormat:@"%@",leftDic[@"answer_user_num"]];
    
    
    //self.stateImageView.backgroundColor = [UIColor lightGrayColor];
    if ([status isEqualToString:@"asked"]||[status isEqualToString:@"dealt"]) {
        //进行中  进行中，还剩-小时  |  -人已回答
        self.bottomButton.alpha = 1;
        self.stateImageView.image = [UIImage imageNamed:@"tipJinxingzhong"];
        self.stateLabel.text = [NSString stringWithFormat:@"%@，还剩%@小时  |  %@人已回答",status_title,last_hours,answer_user_num];
    }else if ([status isEqualToString:@"complete"]) {
        //已完成
        self.bottomButton.alpha = 0;
        self.stateImageView.image = [UIImage imageNamed:@"tipYiwancheng"];
        self.stateLabel.text = [NSString stringWithFormat:@"%@  |  %@人已回答",status_title,answer_user_num];
    }else if ([status isEqualToString:@"expired"]) {
        //已过期
        self.bottomButton.alpha = 0;
        self.stateImageView.image = [UIImage imageNamed:@"tipYiguoqi"];
        self.stateLabel.text = [NSString stringWithFormat:@"%@",status_title];
    }else if ([status isEqualToString:@"closed"]) {
        //已撤销
        self.bottomButton.alpha = 0;
        self.stateImageView.image = [UIImage imageNamed:@"tipYichexiao"];
        self.stateLabel.text = [NSString stringWithFormat:@"%@",status_title];
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



//lazy
-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                         SCREEN_WIDTH/375*129,
                                                         SCREEN_WIDTH,
                                                         SCREEN_WIDTH/375*1)];
    }
    return _line;
}

//time
-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*17,
                                                               SCREEN_WIDTH/375*14,
                                                               SCREEN_WIDTH/2,
                                                               SCREEN_WIDTH/375*18)];
    }
    return _timeLabel;
}

//money
-(UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*17-SCREEN_WIDTH/375*100,
                                                                SCREEN_WIDTH/375*14,
                                                                SCREEN_WIDTH/375*100,
                                                                SCREEN_WIDTH/375*18)];
    }
    return _moneyLabel;
}

//question
-(UILabel *)questionLabel{
    if (!_questionLabel) {
        _questionLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*17,
                                                                   SCREEN_WIDTH/375*46,
                                                                   SCREEN_WIDTH-SCREEN_WIDTH/375*34,
                                                                   SCREEN_WIDTH/375*36)];
    }
    return _questionLabel;
}

//state
-(UIImageView *)stateImageView{
    if (!_stateImageView) {
        _stateImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*19,
                                                                        SCREEN_WIDTH/375*100,
                                                                        SCREEN_WIDTH/375*12,
                                                                        SCREEN_WIDTH/375*12)];
    }
    return _stateImageView;
}

-(UILabel *)stateLabel{
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*34,
                                                                SCREEN_WIDTH/375*97,
                                                                SCREEN_WIDTH/375*200,
                                                                SCREEN_WIDTH/375*17)];
    }
    return _stateLabel;
}

//button
-(UIButton *)bottomButton{
    if (!_bottomButton) {
        _bottomButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*19-SCREEN_WIDTH/375*24,
                                                                   SCREEN_WIDTH/375*87,
                                                                   SCREEN_WIDTH/375*34,
                                                                   SCREEN_WIDTH/375*34)];
    }
    return _bottomButton;
}


-(UILabel *)noteLabel{
    if (!_noteLabel) {
        _noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*34,
                                                                SCREEN_WIDTH/375*120,
                                                                SCREEN_WIDTH-SCREEN_WIDTH/375*50,
                                                                SCREEN_WIDTH/375*17)];
    }
    return _noteLabel;
}


@end
