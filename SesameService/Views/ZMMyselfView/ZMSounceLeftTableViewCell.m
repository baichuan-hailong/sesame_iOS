//
//  ZMSounceLeftTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/29.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMSounceLeftTableViewCell.h"

@interface ZMSounceLeftTableViewCell ()

@end

@implementation ZMSounceLeftTableViewCell

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
        
        self.line.backgroundColor = [UIColor colorWithHex:@"EEEEEE"];
        [self.contentView addSubview:self.line];
        
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
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*13]];
        [self.contentView addSubview:self.questionLabel];
        
        
        //state
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
    }
    return self;
}


- (void)setMyAsk:(NSDictionary *)leftDic{
    
    //time
    NSString *time = [NSString stringWithFormat:@"%@",leftDic[@"time"]];
    if (time.length>0&&![time isEqualToString:@"(null)"]) {
        self.timeLabel.text = [self timeChange:time];
    }
    
    //money
    NSString *price = [NSString stringWithFormat:@"%@",leftDic[@"price"]];
    if (price.length>0&&![price isEqualToString:@"(null)"]) {
        self.moneyLabel.text = [NSString stringWithFormat:@"赏金 ¥%@",price];
    }
    
    
    
    
    
    //question
    /*
     NSString *question = [NSString stringWithFormat:@"%@  ",leftDic[@"question"]];
     CGSize size     = CGSizeMake(SCREEN_WIDTH-SCREEN_WIDTH/375*34, 0);
     CGSize autoSize = [[UILabel new] actualSizeOfLable:[NSString stringWithFormat:@"%@ ",question]
     andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/375*13]
     andSize:size];
     
     self.questionLabel.numberOfLines = 0;
     self.questionLabel.text  = question;
     self.questionLabel.frame = CGRectMake(SCREEN_WIDTH/375*17,
     SCREEN_WIDTH/375*46,
     SCREEN_WIDTH-SCREEN_WIDTH/375*34,
     autoSize.height);
     self.questionLabel.backgroundColor = [UIColor redColor];
     
     //追加图片
     NSArray *imageArray = [NSArray arrayWithArray:leftDic[@"images"]];
     if (imageArray.count>0) {
     NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:question];
     UIImage *image               = [UIImage imageNamed:@"haveImageImage"];
     NSTextAttachment *attachment = [[NSTextAttachment alloc]init];
     attachment.image             = image;
     attachment.bounds            = CGRectMake(0, -2, 15, 12);
     NSAttributedString *attrStr1 = [NSAttributedString attributedStringWithAttachment:attachment];
     [attrStr appendAttributedString:attrStr1];
     
     //行高
     NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
     [paragraphStyle1 setLineSpacing:SCREEN_WIDTH/375*4];
     [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [question length])];
     
     self.questionLabel.attributedText = attrStr;
     }else{
     
     NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:self.questionLabel.text];
     //行高
     NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
     [paragraphStyle1 setLineSpacing:SCREEN_WIDTH/375*4];
     [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [question length])];
     
     self.questionLabel.attributedText = attrStr;
     }
     
     
     */
    NSString *question = [NSString stringWithFormat:@"%@  ",leftDic[@"question"]];
    CGSize size = CGSizeMake(SCREEN_WIDTH-SCREEN_WIDTH/375*34, 0);
    CGSize autoSize = [self.questionLabel actualSizeOfLineSpaceLable:[NSString stringWithFormat:@"%@  ",question]
                                                               andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
                                                               andSize:size];
    //行高
    //[ZMLabelAttributeMange setLineSpacing:self.questionLabel str:self.questionLabel.text];
    //[ZMLabelAttributeMange setLineSpacing:self.questionLabel str:[NSString stringWithFormat:@"%@  ",question]];
    
    
    int autoHeight = (int)autoSize.height;
    if (autoHeight>70) {
        question = [NSString stringWithFormat:@"%@...",[question substringToIndex:60]];
    }
    
    CGSize HHautoSize = [self.questionLabel actualSizeOfLineSpaceLable:[NSString stringWithFormat:@"%@  ",question]
                                                             andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
                                                             andSize:size];
    //追加图片
    NSArray *imageArray = [NSArray arrayWithArray:leftDic[@"images"]];
    if (imageArray.count>0) {
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:question];
        UIImage *image               = [UIImage imageNamed:@"haveImageImage"];
        NSTextAttachment *attachment = [[NSTextAttachment alloc]init];
        attachment.image             = image;
        attachment.bounds            = CGRectMake(0, -2, 15, 12);
        NSAttributedString *attrStr1 = [NSAttributedString attributedStringWithAttachment:attachment];
        [attrStr appendAttributedString:attrStr1];
        
        //行高
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle1 setLineSpacing:SCREEN_WIDTH/375*4];
        [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [question length])];
        
        self.questionLabel.attributedText = attrStr;
    }else{
        
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:self.questionLabel.text];
        //行高
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle1 setLineSpacing:SCREEN_WIDTH/375*4];
        [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [question length])];
        
        self.questionLabel.attributedText = attrStr;
    }
    
    self.questionLabel.numberOfLines   = 0;
    //self.questionLabel.backgroundColor = [UIColor redColor];
    
    
    int questionHei = (int)HHautoSize.height+1;
    
    self.questionLabel.frame = CGRectMake(SCREEN_WIDTH/375*17,
                                          SCREEN_WIDTH/375*56,
                                          SCREEN_WIDTH-SCREEN_WIDTH/375*34,
                                          questionHei);
    
    
    
    
    
    
    

    
    
    NSString *status = [NSString stringWithFormat:@"%@",leftDic[@"status"]];
    NSString *status_title = [NSString stringWithFormat:@"%@",leftDic[@"status_title"]];
    
    NSString *last_hours = [NSString stringWithFormat:@"%@",leftDic[@"last_hours"]];
    NSString *answer_user_num = [NSString stringWithFormat:@"%@",leftDic[@"answer_user_num"]];
    
    
    //指定人
    NSString *aim_answerer = [NSString stringWithFormat:@"%@",leftDic[@"aim_answerer"]];
    if ([aim_answerer integerValue]>0) {
        //指定
        if ([status isEqualToString:@"asked"]) {
            //进行中  进行中，还剩-小时  |  -人已回答
            self.bottomButton.alpha = 0;
            self.stateImageView.image = [UIImage imageNamed:@"tipJinxingzhong"];
            self.stateLabel.text = [NSString stringWithFormat:@"%@，还剩%@小时",status_title,last_hours];
        }else if ([status isEqualToString:@"dealt"]){
            self.bottomButton.alpha = 0;
            self.stateImageView.image = [UIImage imageNamed:@"tipJinxingzhong"];
            self.stateLabel.text = [NSString stringWithFormat:@"%@，还剩%@小时",status_title,last_hours];
            
        }else if ([status isEqualToString:@"complete"]) {
            //已完成
            self.bottomButton.alpha = 0;
            self.stateImageView.image = [UIImage imageNamed:@"tipYiwancheng"];
            self.stateLabel.text = [NSString stringWithFormat:@"%@",@"已完成"];
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
        
    }else{
        //非指定
        if ([status isEqualToString:@"asked"]) {
            //进行中  进行中，还剩-小时  |  -人已回答
            self.bottomButton.alpha = 0;
            self.stateImageView.image = [UIImage imageNamed:@"tipJinxingzhong"];
            self.stateLabel.text = [NSString stringWithFormat:@"%@，还剩%@小时  |  %@人已回答",status_title,last_hours,answer_user_num];
        }else if ([status isEqualToString:@"dealt"]){
            self.bottomButton.alpha = 0;
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
    
    
    
    
    
    
    //CGRectGetMaxY(self.questionLabel.frame)+SCREEN_WIDTH/375*47
    self.line.frame = CGRectMake(0,
                                 CGRectGetMaxY(self.questionLabel.frame)+SCREEN_WIDTH/375*47,
                                 SCREEN_WIDTH,
                                 SCREEN_WIDTH/375*1);
    
    //state
    self.stateImageView.frame = CGRectMake(SCREEN_WIDTH/375*19,
                                           CGRectGetMaxY(self.questionLabel.frame)+SCREEN_WIDTH/375*18,
                                           SCREEN_WIDTH/375*12,
                                           SCREEN_WIDTH/375*12);
    
    self.stateLabel.frame = CGRectMake(SCREEN_WIDTH/375*34,
                                       CGRectGetMaxY(self.questionLabel.frame)+SCREEN_WIDTH/375*15,
                                       SCREEN_WIDTH/375*200,
                                       SCREEN_WIDTH/375*17);
    
    //button
    self.bottomButton.frame = CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*19-SCREEN_WIDTH/375*24,
                                         CGRectGetMaxY(self.questionLabel.frame)+SCREEN_WIDTH/375*14,
                                         SCREEN_WIDTH/375*34,
                                         SCREEN_WIDTH/375*34);
    
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
                                                                   SCREEN_WIDTH/375*0)];
    }
    return _questionLabel;
}

-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                         CGRectGetMaxY(self.questionLabel.frame)+SCREEN_WIDTH/375*47,
                                                         SCREEN_WIDTH,
                                                         SCREEN_WIDTH/375*1)];
    }
    return _line;
}

//state
-(UIImageView *)stateImageView{
    if (!_stateImageView) {
        _stateImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*19,
                                                                        CGRectGetMaxY(self.questionLabel.frame)+SCREEN_WIDTH/375*18,
                                                                        SCREEN_WIDTH/375*12,
                                                                        SCREEN_WIDTH/375*12)];
    }
    return _stateImageView;
}

-(UILabel *)stateLabel{
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*34,
                                                                CGRectGetMaxY(self.questionLabel.frame)+SCREEN_WIDTH/375*15,
                                                                SCREEN_WIDTH/375*200,
                                                                SCREEN_WIDTH/375*17)];
    }
    return _stateLabel;
}

//button
-(UIButton *)bottomButton{
    if (!_bottomButton) {
        _bottomButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*19-SCREEN_WIDTH/375*24,
                                                                   CGRectGetMaxY(self.questionLabel.frame)+SCREEN_WIDTH/375*14,
                                                                   SCREEN_WIDTH/375*34,
                                                                   SCREEN_WIDTH/375*34)];
    }
    return _bottomButton;
}


@end
