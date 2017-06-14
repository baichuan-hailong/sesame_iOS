//
//  ZMMySounceAnswerAudioTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/5/10.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMMySounceAnswerAudioTableViewCell.h"

@implementation ZMMySounceAnswerAudioTableViewCell

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
        
        
        [self.contentView addSubview:self.voiceBtn];
        
        //time
        [ZMLabelAttributeMange setLabel:self.countLabel
                                   text:@"--"
                                    hex:@"999999"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
        [self.contentView addSubview:self.countLabel];
    
    }
    return self;
}


- (void)setAudo:(NSDictionary *)audioDic{
    NSString *time = [NSString stringWithFormat:@"%@",audioDic[@"time"]];
    if (time.length>0&&![time isEqualToString:@"(null)"]) {
        self.timeLabel.text = [self timeChange:time];
    }
    
    
    NSString *audio_time = [NSString stringWithFormat:@"%@",audioDic[@"audio_time"]];
    if (audio_time.length>0&&![audio_time isEqualToString:@"(null)"]) {
        self.countLabel.text = [NSString stringWithFormat:@"%@″",audio_time];
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
//time
-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                               SCREEN_WIDTH/375*11,
                                                               SCREEN_WIDTH/2,
                                                               SCREEN_WIDTH/375*15)];
    }
    return _timeLabel;
}




- (UIButton *)voiceBtn {
    
    if (_voiceBtn == nil) {
        _voiceBtn = [[UIButton alloc] init];
        _voiceBtn.frame = CGRectMake(SCREEN_WIDTH/375*21,
                                     SCREEN_WIDTH/375*33,SCREEN_WIDTH/3.26, SCREEN_WIDTH/9.375);
        _voiceBtn.backgroundColor = [UIColor colorWithHex:tonalColor];
        _voiceBtn.layer.cornerRadius = (SCREEN_WIDTH/9.375)/2;
        
        
        //语音图片
        UIImage     *voiceImg     = [UIImage imageNamed:@"au_voice"];
        UIImageView *voiceImgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/31.25,
                                                                                  (_voiceBtn.height - voiceImg.size.height)/2,
                                                                                  voiceImg.size.width,
                                                                                  voiceImg.size.height)];
        voiceImgView.image = voiceImg;
        
        //loading
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/62.5,
                                                                                                               (_voiceBtn.height - 30)/2,
                                                                                                               30,
                                                                                                               30)];
        
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        activityIndicator.alpha = 0;
        [activityIndicator startAnimating];
        
        
        //playGif
        UIImageView *gifImage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/31.25,
                                                                              (_voiceBtn.height - voiceImg.size.height)/2,
                                                                              voiceImg.size.width,
                                                                              voiceImg.size.height)];
        NSURL * url = [[NSURL alloc]initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"play.gif" ofType:nil]];
        [gifImage yh_setImage:url];
        gifImage.alpha = 0;
        
        
        //tipsLable
        UILabel *tipsLable = [[UILabel alloc] initWithFrame:CGRectMake(_voiceBtn.width - SCREEN_WIDTH/6.25 - SCREEN_WIDTH/25,
                                                                       (_voiceBtn.height - SCREEN_WIDTH/26.78)/2,
                                                                       SCREEN_WIDTH/6.25,
                                                                       SCREEN_WIDTH/26.78)];
        tipsLable.textColor = [UIColor whiteColor];
        tipsLable.textAlignment = NSTextAlignmentRight;
        tipsLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78];
        tipsLable.text = @"免费收听";
        
        [_voiceBtn addSubview:voiceImgView];
        [_voiceBtn addSubview:activityIndicator];
        [_voiceBtn addSubview:gifImage];
        [_voiceBtn addSubview:tipsLable];
        
    }
    return _voiceBtn;
}


/*
 - (UIButton *)voiceBtn {
 
 if (_voiceBtn == nil) {
 _voiceBtn = [[UIButton alloc] init];
 _voiceBtn.frame = CGRectMake(SCREEN_WIDTH/375*21,
 SCREEN_WIDTH/375*33,
 SCREEN_WIDTH/3.26,
 SCREEN_WIDTH/9.375);
 _voiceBtn.backgroundColor = [UIColor colorWithHex:tonalColor];
 _voiceBtn.layer.cornerRadius = (SCREEN_WIDTH/9.375)/2;
 
 
 UIImage     *voiceImg     = [UIImage imageNamed:@"au_voice"];
 UIImageView *voiceImgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/31.25,
 (_voiceBtn.height - voiceImg.size.height)/2,
 voiceImg.size.width,
 voiceImg.size.height)];
 voiceImgView.image = voiceImg;
 [_voiceBtn addSubview:voiceImgView];
 
 
 UILabel *tipsLable = [[UILabel alloc] initWithFrame:CGRectMake(_voiceBtn.width - SCREEN_WIDTH/6.25 - SCREEN_WIDTH/25,
 (_voiceBtn.height - SCREEN_WIDTH/26.78)/2,
 SCREEN_WIDTH/6.25,
 SCREEN_WIDTH/26.78)];
 tipsLable.textColor = [UIColor whiteColor];
 tipsLable.textAlignment = NSTextAlignmentRight;
 tipsLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78];
 tipsLable.text = @"点击播放";
 [_voiceBtn addSubview:tipsLable];
 
 }
 return _voiceBtn;
 }

 
 */



-(UILabel *)countLabel{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*142,
                                                               SCREEN_WIDTH/375*43,
                                                               SCREEN_WIDTH/2,
                                                               SCREEN_WIDTH/375*20)];
    }
    return _countLabel;
}


@end
