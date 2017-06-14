//
//  ZMAllUnderstandRightAudioTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/28.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMAllUnderstandRightAudioTableViewCell.h"

@interface ZMAllUnderstandRightAudioTableViewCell ()
@property(nonatomic,strong)UIView *answerView;
@end

@implementation ZMAllUnderstandRightAudioTableViewCell

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
        
        
        self.headerImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.headerImageView.layer.borderWidth = SCREEN_WIDTH/375*0.2;
        self.headerImageView.layer.borderColor = [UIColor colorWithHex:@"B2B2B2"].CGColor;
        
        [self.contentView addSubview:self.headerImageView];
        
        //state
        self.stateImageView.image           = [UIImage imageNamed:@"haveRenzhengImage"];
        self.stateImageView.contentMode     = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.stateImageView];
        
        //1
        //self.memberShipImageView.image = [UIImage imageNamed:@"jinpaiImage"];
        //self.memberShipImageView.backgroundColor = [UIColor yellowColor];
        self.memberShipImageView.contentMode     = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.memberShipImageView];
        
        
        
        
        
        
        //name
        [ZMLabelAttributeMange setLabel:self.nameLabel
                                   text:@"--"
                                    hex:@"333333"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
        [self.contentView addSubview:self.nameLabel];
        
        //money
        [ZMLabelAttributeMange setLabel:self.moneyLabel
                                   text:@"赏金 ¥-"
                                    hex:@"EB6D62"
                          textAlignment:NSTextAlignmentRight
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*13]];
        [self.contentView addSubview:self.moneyLabel];
        
        
        //question
        [ZMLabelAttributeMange setLabel:self.questionLabel
                                   text:@"-- --"
                                    hex:@"333333"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*13]];
        //self.questionLabel.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.questionLabel];
        
        
        
        //answer
        self.answerView.backgroundColor    = [UIColor colorWithHex:@"F7F7F7"];
        self.answerView.layer.cornerRadius = SCREEN_WIDTH/375*2;
        self.answerView.layer.masksToBounds= YES;
        [self.contentView addSubview:self.answerView];
        
        //img
        self.answerImageView.image = [UIImage imageNamed:@"datipImage"];
        [self.answerView addSubview:self.answerImageView];
        
        
        //more
        [ZMLabelAttributeMange setLabel:self.moreAnswerLabel
                                   text:@"更多免费答案 >"
                                    hex:@"999999"
                          textAlignment:NSTextAlignmentRight
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.moreAnswerLabel];
        
        
        
        
        //self.answerView.backgroundColor =[UIColor yellowColor];
        //voice button
        self.answerView.userInteractionEnabled = YES;
        [self.answerView addSubview:self.voiceBtn];
        
        //time
        [ZMLabelAttributeMange setLabel:self.countLabel
                                   text:@"--"
                                    hex:@"999999"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
        [self.answerView addSubview:self.countLabel];
        
        
    }
    return self;
}


- (void)setRightAudioAllUnderstan:(NSDictionary *)rightDic{
    
    
    NSString *avatar      = [NSString stringWithFormat:@"%@",rightDic[@"user"][@"avatar"]];
    NSString *auth        = [NSString stringWithFormat:@"%@",rightDic[@"user"][@"auth"]];
    NSString *person_name = [NSString stringWithFormat:@"%@",rightDic[@"user"][@"person_name"]];
    NSString *level       = [NSString stringWithFormat:@"%@",rightDic[@"user"][@"level"]];
    
    
    NSString *corp_name = [NSString stringWithFormat:@"%@",rightDic[@"user"][@"corp_name"]];
    NSString *type = [NSString stringWithFormat:@"%@",rightDic[@"user"][@"type"]];
    
    if (avatar.length>10) {
        [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:avatar]
                                placeholderImage:[UIImage imageNamed:@"placeHeaderImage"]];
        self.headerImageView.backgroundColor = [UIColor lightGrayColor];
    }else{
        self.headerImageView.image = [UIImage imageNamed:@"placeHeaderImage"];
        self.headerImageView.backgroundColor = [UIColor lightGrayColor];
    }
    
    
    if ([auth isEqualToString:@"authed"]){
        self.stateImageView.alpha = 1;
    }else{
        self.stateImageView.alpha = 0;
    }
    
    if ([type isEqualToString:@"1"]) {
        if (person_name.length>0&&![person_name isEqualToString:@"(null)"]) {
            self.nameLabel.text = person_name;
        }
    }else{
        if (corp_name.length>0&&![corp_name isEqualToString:@"(null)"]) {
            self.nameLabel.text = corp_name;
        }
    }
    [self.nameLabel sizeToFit];
    
    
    self.memberShipImageView.frame = CGRectMake(CGRectGetMaxX(self.nameLabel.frame)+SCREEN_WIDTH/375*5.3,
                                                SCREEN_WIDTH/375*21,
                                                SCREEN_WIDTH/375*14,
                                                SCREEN_WIDTH/375*16);
    
    
    if ([level isEqualToString:@"gold"]) {
        self.memberShipImageView.image = [UIImage imageNamed:@"jinpaiImage"];
    }else if ([level isEqualToString:@"silver"]){
        self.memberShipImageView.image = [UIImage imageNamed:@"yinpaiImage"];
    }else if ([level isEqualToString:@"copper"]){
        self.memberShipImageView.image = [UIImage imageNamed:@"tongpaiImage"];
    }
    self.moneyLabel.text    = [NSString stringWithFormat:@"赏金 ¥%@",rightDic[@"price"]];
    
    
    
    
    
    
    
    //question
    NSString *question = [NSString stringWithFormat:@"%@",rightDic[@"question"]];
    self.questionLabel.numberOfLines = 0;
    CGSize size = CGSizeMake(SCREEN_WIDTH-SCREEN_WIDTH/375*34, 0);
    CGSize autoSize = [self.questionLabel actualSizeOfLineSpaceLable:[NSString stringWithFormat:@"%@  ",question]
                                                             andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
                                                             andSize:size];
    
    int autoSizeHe = (int)autoSize.height;
    if (autoSizeHe>70) {
        question = [NSString stringWithFormat:@"%@...",[question substringToIndex:60]];
    }
    CGSize HHAutoSize = [self.questionLabel actualSizeOfLineSpaceLable:[NSString stringWithFormat:@"%@  ",question]
                                                             andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
                                                             andSize:size];
    //追加图片
    NSArray *imageArray = [NSArray arrayWithArray:rightDic[@"images"]];
    if (imageArray.count>0) {
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:self.questionLabel.text];
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
    
    //self.questionLabel.backgroundColor = [UIColor redColor];
    int hhautoSizeHe = (int)HHAutoSize.height+1;
    self.questionLabel.frame = CGRectMake(SCREEN_WIDTH/375*17,
                                          SCREEN_WIDTH/375*56,
                                          SCREEN_WIDTH-SCREEN_WIDTH/375*34,
                                          hhautoSizeHe);
    
    
    
    
    
    
    //answer
    self.answerView.frame = CGRectMake(SCREEN_WIDTH/375*18,
                                       CGRectGetMaxY(self.questionLabel.frame)+SCREEN_WIDTH/375*11,
                                       SCREEN_WIDTH-SCREEN_WIDTH/375*39,
                                       SCREEN_WIDTH/375*63);
    
    //more
    self.moreAnswerLabel.frame = CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*21-SCREEN_WIDTH/375*100,
                                            CGRectGetMaxY(self.answerView.frame)+SCREEN_WIDTH/375*12,
                                            SCREEN_WIDTH/375*100,
                                            SCREEN_WIDTH/375*14);
    
    
    
    

    NSString *audio_time      = [NSString stringWithFormat:@"%@",rightDic[@"accept_anwer"][@"audio_time"]];
    self.countLabel.text = [NSString stringWithFormat:@"%@″",audio_time];
}


//lazy
//lazy
-(UIImageView *)headerImageView{
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*19,
                                                                         SCREEN_WIDTH/375*13,
                                                                         SCREEN_WIDTH/375*35,
                                                                         SCREEN_WIDTH/375*35)];
        _headerImageView.layer.cornerRadius = SCREEN_WIDTH/375*2;
        _headerImageView.layer.masksToBounds= YES;
    }
    return _headerImageView;
}

//state
-(UIImageView *)stateImageView{
    if (!_stateImageView) {
        _stateImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*45.8,
                                                                        SCREEN_WIDTH/375*39,
                                                                        SCREEN_WIDTH/375*12.2,
                                                                        SCREEN_WIDTH/375*12.1)];
    }
    return _stateImageView;
}

//name
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*63,
                                                               SCREEN_WIDTH/375*20,
                                                               SCREEN_WIDTH/375*50,
                                                               SCREEN_WIDTH/375*20)];
    }
    return _nameLabel;
}


-(UIImageView *)memberShipImageView{
    
    if (_memberShipImageView==nil) {
        _memberShipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*113,
                                                                             SCREEN_WIDTH/375*21,
                                                                             SCREEN_WIDTH/375*14,
                                                                             SCREEN_WIDTH/375*16)];
    }
    return _memberShipImageView;
}


//money
-(UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*18-SCREEN_WIDTH/375*100,
                                                                SCREEN_WIDTH/375*20,
                                                                SCREEN_WIDTH/375*100,
                                                                SCREEN_WIDTH/375*18)];
    }
    return _moneyLabel;
}



//question
-(UILabel *)questionLabel{
    if (!_questionLabel) {
        _questionLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*17,
                                                                   SCREEN_WIDTH/375*56,
                                                                   SCREEN_WIDTH-SCREEN_WIDTH/375*34,
                                                                   SCREEN_WIDTH/375*36)];
    }
    return _questionLabel;
}

//answer
-(UIView *)answerView{
    if (!_answerView) {
        _answerView = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*18,
                                                                CGRectGetMaxY(self.questionLabel.frame)+SCREEN_WIDTH/375*11,
                                                                SCREEN_WIDTH-SCREEN_WIDTH/375*39,
                                                                SCREEN_WIDTH/375*63)];
    }
    return _answerView;
}

-(UIImageView *)answerImageView{
    
    if (_answerImageView==nil) {
        _answerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*0,
                                                                         SCREEN_WIDTH/375*0,
                                                                         SCREEN_WIDTH/375*23,
                                                                         SCREEN_WIDTH/375*23)];
    }
    return _answerImageView;
}




//more
-(UILabel *)moreAnswerLabel{
    if (!_moreAnswerLabel) {
        _moreAnswerLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*21-SCREEN_WIDTH/375*100,
                                                                     CGRectGetMaxY(self.answerView.frame)+SCREEN_WIDTH/375*12,
                                                                     SCREEN_WIDTH/375*100,
                                                                     SCREEN_WIDTH/375*14)];
    }
    return _moreAnswerLabel;
}



- (UIButton *)voiceBtn {
    
    if (_voiceBtn == nil) {
        _voiceBtn = [[UIButton alloc] init];
        _voiceBtn.frame = CGRectMake(SCREEN_WIDTH/375*18,
                                     SCREEN_WIDTH/375*12, SCREEN_WIDTH/3.26, SCREEN_WIDTH/9.375);
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
 _voiceBtn.frame = CGRectMake(SCREEN_WIDTH/375*18,
 SCREEN_WIDTH/375*12,
 SCREEN_WIDTH/375*115,
 SCREEN_WIDTH/375*40);
 _voiceBtn.backgroundColor = [UIColor colorWithHex:tonalColor];
 _voiceBtn.layer.cornerRadius = (SCREEN_WIDTH/375*40)/2;
 
 
 UIImage     *voiceImg     = [UIImage imageNamed:@"au_voice"];
 UIImageView *voiceImgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*12,
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
 tipsLable.text = @"免费收听";
 [_voiceBtn addSubview:tipsLable];
 
 }
 return _voiceBtn;
 }
 */



-(UILabel *)countLabel{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*139,
                                                                SCREEN_WIDTH/375*22,
                                                                SCREEN_WIDTH/2,
                                                                SCREEN_WIDTH/375*20)];
    }
    return _countLabel;
}



@end
