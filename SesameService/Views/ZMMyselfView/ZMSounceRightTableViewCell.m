//
//  ZMSounceRightTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/29.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMSounceRightTableViewCell.h"

@interface ZMSounceRightTableViewCell ()

@end

@implementation ZMSounceRightTableViewCell

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
        
        self.headerImageView.backgroundColor = [UIColor lightGrayColor];
        self.headerImageView.layer.borderWidth = SCREEN_WIDTH/375*0.2;
        self.headerImageView.layer.borderColor = [UIColor colorWithHex:@"B2B2B2"].CGColor;

        [self.contentView addSubview:self.headerImageView];
        
        //name
        [ZMLabelAttributeMange setLabel:self.nameLabel
                                   text:@"--"
                                    hex:@"333333"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
        [self.contentView addSubview:self.nameLabel];
        
        //memberShip
        //self.memberShipImageView.backgroundColor = [UIColor lightGrayColor];
        self.memberShipImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.memberShipImageView];
        
        
        //money
        [ZMLabelAttributeMange setLabel:self.moneyLabel
                                   text:@"-- -"
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
        //[self.questionLabel sizeToFit];
        //self.questionLabel.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.questionLabel];
        
        
        
        
        //state
        [self.contentView addSubview:self.stateImageView];
        
        [ZMLabelAttributeMange setLabel:self.stateLabel
                                   text:@"-- --"
                                    hex:@"999999"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.stateLabel];
    }
    return self;
}



- (void)setMyAnswer:(NSDictionary *)rightDic{
    //avatar
    NSString *avatar = [NSString stringWithFormat:@"%@",rightDic[@"user"][@"avatar"]];
    if (avatar.length>0) {
        [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:avatar]
                                placeholderImage:[UIImage imageNamed:@"placeHeaderImage"]];
        self.headerImageView.backgroundColor = [UIColor lightGrayColor];
    }else{
        self.headerImageView.image = [UIImage imageNamed:@"placeHeaderImage"];
    }
    
    //name
    NSString *type = [NSString stringWithFormat:@"%@",rightDic[@"user"][@"type"]];
    if ([type isEqualToString:@"1"]) {
        
        NSString *person_name = [NSString stringWithFormat:@"%@",rightDic[@"user"][@"person_name"]];
        if (person_name.length>0&&![person_name isEqualToString:@"(null)"]) {
            self.nameLabel.text = person_name;
        }
        
    }else{
        NSString *corp_name = [NSString stringWithFormat:@"%@",rightDic[@"user"][@"corp_name"]];
        if (corp_name.length>0&&![corp_name isEqualToString:@"(null)"]) {
            self.nameLabel.text = corp_name;
        }
    }
    [self.nameLabel sizeToFit];
    self.memberShipImageView.frame = CGRectMake(CGRectGetMaxX(self.nameLabel.frame)+SCREEN_WIDTH/375*8,
                                                SCREEN_WIDTH/375*21,
                                                SCREEN_WIDTH/375*14,
                                                SCREEN_WIDTH/375*16);
    
    
    //level
    NSString *level = [NSString stringWithFormat:@"%@",rightDic[@"user"][@"level"]];
    if ([level isEqualToString:@"gold"]) {
        self.memberShipImageView.image = [UIImage imageNamed:@"jinpaiImage"];
    }else if ([level isEqualToString:@"silver"]){
        self.memberShipImageView.image = [UIImage imageNamed:@"yinpaiImage"];
    }else if ([level isEqualToString:@"copper"]){
        self.memberShipImageView.image = [UIImage imageNamed:@"tongpaiImage"];
    }
    
    
    //money
    NSString *price = [NSString stringWithFormat:@"%@",rightDic[@"price"]];
    if (price.length>0&&![price isEqualToString:@"(null)"]) {
        self.moneyLabel.text = [NSString stringWithFormat:@"赏金 ¥%@",price];
    }
    
    
    
    //question
    /*
     NSString *question = [NSString stringWithFormat:@"%@  ",rightDic[@"question"]];
     CGSize size     = CGSizeMake(SCREEN_WIDTH-SCREEN_WIDTH/375*34, 0);
     CGSize autoSize = [[UILabel new] actualSizeOfLable:[NSString stringWithFormat:@"%@",question]
     andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/375*13]
     andSize:size];
     
     self.questionLabel.numberOfLines = 0;
     if (question.length>0&&![question isEqualToString:@"(null)"]) {
     self.questionLabel.text = question;
     }
     
     self.questionLabel.frame = CGRectMake(SCREEN_WIDTH/375*17,
     SCREEN_WIDTH/375*56,
     SCREEN_WIDTH-SCREEN_WIDTH/375*34,
     autoSize.height);
     
     
     
     
     //追加图片
     NSArray *imageArray = [NSArray arrayWithArray:rightDic[@"images"]];
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
    
    
    
    
    
    NSString *question = [NSString stringWithFormat:@"%@  ",rightDic[@"question"]];
    CGSize size = CGSizeMake(SCREEN_WIDTH-SCREEN_WIDTH/375*34, 0);
    CGSize autoSize = [self.questionLabel actualSizeOfLineSpaceLable:[NSString stringWithFormat:@"%@  ",question]
                                                             andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
                                                             andSize:size];
    //行高
    //[ZMLabelAttributeMange setLineSpacing:self.questionLabel str:self.questionLabel.text];
    //[ZMLabelAttributeMange setLineSpacing:self.questionLabel str:[NSString stringWithFormat:@"%@  ",question]];
    
    int autoHieght = (int)autoSize.height;
    if (autoHieght>70) {
        question = [NSString stringWithFormat:@"%@...",[question substringToIndex:60]];
    }
    CGSize HHautoSize = [self.questionLabel actualSizeOfLineSpaceLable:[NSString stringWithFormat:@"%@  ",question]
                                                             andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
                                                             andSize:size];
    
    //追加图片
    NSArray *imageArray = [NSArray arrayWithArray:rightDic[@"images"]];
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
    
    
    
    
    
    
    
    
    
    
    //state
    self.stateImageView.frame = CGRectMake(SCREEN_WIDTH/375*19,
                                           CGRectGetMaxY(self.questionLabel.frame)+SCREEN_WIDTH/375*14,
                                           SCREEN_WIDTH/375*12,
                                           SCREEN_WIDTH/375*12);
    
    
    
    self.stateLabel.frame = CGRectMake(SCREEN_WIDTH/375*34,
                                       CGRectGetMaxY(self.questionLabel.frame)+SCREEN_WIDTH/375*11,
                                       SCREEN_WIDTH/375*300,
                                       SCREEN_WIDTH/375*17);
    
    self.line.frame = CGRectMake(0,
                                 CGRectGetMaxY(self.stateLabel.frame)+SCREEN_WIDTH/375*13,
                                 SCREEN_WIDTH,
                                 SCREEN_WIDTH/375*1);
    
    
    NSString *status = [NSString stringWithFormat:@"%@",rightDic[@"status"]];
    NSString *status_title = [NSString stringWithFormat:@"%@",rightDic[@"status_title"]];
    
    NSString *last_hours = [NSString stringWithFormat:@"%@",rightDic[@"last_hours"]];
    NSString *answer_user_num = [NSString stringWithFormat:@"%@",rightDic[@"answer_user_num"]];
    
    
    
    NSString *aim_answerer = [NSString stringWithFormat:@"%@",rightDic[@"aim_answerer"]];
    //NSString *userID     = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:USER_ID]];
    if ([aim_answerer integerValue]==0) {
        //非指定
        if ([status isEqualToString:@"asked"]) {
            //进行中
            self.stateImageView.image = [UIImage imageNamed:@"tipJinxingzhong"];
            self.stateLabel.text = [NSString stringWithFormat:@"%@，还剩%@小时  |  %@人已回答",status_title,last_hours,answer_user_num];
        }else if ([status isEqualToString:@"dealt"]){
            //已回答
            self.stateImageView.image = [UIImage imageNamed:@"yihuidaImageTip"];
            if ([answer_user_num integerValue]>0) {
                self.stateLabel.text = [NSString stringWithFormat:@"%@，还剩%@小时 | %@人已回答",status_title,last_hours,answer_user_num];
            }else{
                self.stateLabel.text = [NSString stringWithFormat:@"%@，还剩%@小时",status_title,last_hours];
            }
        }else if ([status isEqualToString:@"complete"]) {
            //已完成
            NSString *reward = [NSString stringWithFormat:@"%@",rightDic[@"reward"]];
            if ([reward integerValue]>0) {
                self.stateImageView.image = [UIImage imageNamed:@"tipYiwancheng"];
                //yes采纳
               self.stateLabel.text = [NSString stringWithFormat:@"%@，获得赏金¥%@元",status_title,reward];
            }else{
                self.stateImageView.image = [UIImage imageNamed:@"yijieshu"];
                //no采纳
                self.stateLabel.text = [NSString stringWithFormat:@"%@，未获得赏金",status_title];
            }
            
        }else if ([status isEqualToString:@"expired"]) {
            //已过期
            self.stateImageView.image = [UIImage imageNamed:@"tipYiguoqi"];
            NSString *reward = [NSString stringWithFormat:@"%@",rightDic[@"reward"]];
            if ([reward integerValue]>0) {
                //yes采纳
                self.stateLabel.text = [NSString stringWithFormat:@"%@，获得赏金¥%@元",status_title,reward];
            }else{
                //no采纳
                self.stateLabel.text = [NSString stringWithFormat:@"%@，未获得赏金",status_title];
            }
        }else if ([status isEqualToString:@"closed"]) {
            //已撤销
            self.stateImageView.image = [UIImage imageNamed:@"tipYichexiao"];
            NSString *reward = [NSString stringWithFormat:@"%@",rightDic[@"reward"]];
            if ([reward integerValue]>0) {
                //yes采纳
                self.stateLabel.text = [NSString stringWithFormat:@"%@，获得赏金¥%@元",status_title,reward];
            }else{
                //no采纳
                self.stateLabel.text = [NSString stringWithFormat:@"%@，未获得赏金",status_title];
            }
        }
    }else{
        //指定
        if ([status isEqualToString:@"asked"]) {
            //进行中
            self.stateImageView.image = [UIImage imageNamed:@"tipJinxingzhong"];
            if ([answer_user_num integerValue]>0) {
                self.stateLabel.text = [NSString stringWithFormat:@"%@，还剩%@小时",status_title,last_hours];
            }else{
                self.stateLabel.text = [NSString stringWithFormat:@"%@，还剩%@小时",status_title,last_hours];
            }
        }else if ([status isEqualToString:@"dealt"]) {
        
            //已回答
            self.stateImageView.image = [UIImage imageNamed:@"yihuidaImageTip"];
            if ([answer_user_num integerValue]>0) {
                self.stateLabel.text = [NSString stringWithFormat:@"%@，还剩%@小时",status_title,last_hours];
            }else{
                self.stateLabel.text = [NSString stringWithFormat:@"%@，还剩%@小时",status_title,last_hours];
            }
        }else if ([status isEqualToString:@"complete"]) {
            //已完成
            self.stateImageView.image = [UIImage imageNamed:@"tipYiwancheng"];
            NSString *reward = [NSString stringWithFormat:@"%@",rightDic[@"reward"]];
            if ([reward integerValue]>0) {
                //yes采纳
                self.stateLabel.text = [NSString stringWithFormat:@"%@，获得赏金¥%@元",status_title,reward];
            }else{
                //no采纳
                self.stateLabel.text = [NSString stringWithFormat:@"%@，未获得赏金",status_title];
            }
            
        }else if ([status isEqualToString:@"expired"]) {
            //已过期
            self.stateImageView.image = [UIImage imageNamed:@"tipYiguoqi"];
            NSString *reward = [NSString stringWithFormat:@"%@",rightDic[@"reward"]];
            if ([reward integerValue]>0) {
                //yes采纳
                self.stateLabel.text = [NSString stringWithFormat:@"%@，获得赏金¥%@元",status_title,reward];
            }else{
                //no采纳
                self.stateLabel.text = [NSString stringWithFormat:@"%@，未获得赏金",status_title];
            }
        }else if ([status isEqualToString:@"closed"]) {
            //已撤销
            self.stateImageView.image = [UIImage imageNamed:@"tipYichexiao"];
            NSString *reward = [NSString stringWithFormat:@"%@",rightDic[@"reward"]];
            if ([reward integerValue]>0) {
                //yes采纳
                self.stateLabel.text = [NSString stringWithFormat:@"%@，获得赏金¥%@元",status_title,reward];
            }else{
                //no采纳
                self.stateLabel.text = [NSString stringWithFormat:@"%@，未获得赏金",status_title];
            }
        }
    }
}



/****  Detail ***/
- (void)setMyDetailAnswer:(NSDictionary *)rightDic{
    //avatar
    NSString *avatar = [NSString stringWithFormat:@"%@",rightDic[@"user"][@"avatar"]];
    if (avatar.length>0) {
        [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:avatar]
                                placeholderImage:[UIImage imageNamed:@"placeHeaderImage"]];
        self.headerImageView.backgroundColor = [UIColor lightGrayColor];
    }else{
        self.headerImageView.image = [UIImage imageNamed:@"placeHeaderImage"];
    }
    
    //name
    NSString *type = [NSString stringWithFormat:@"%@",rightDic[@"user"][@"type"]];
    if ([type isEqualToString:@"1"]) {
        
        NSString *person_name = [NSString stringWithFormat:@"%@",rightDic[@"user"][@"person_name"]];
        if (person_name.length>0&&![person_name isEqualToString:@"(null)"]) {
            self.nameLabel.text = person_name;
        }
        
    }else{
        NSString *corp_name = [NSString stringWithFormat:@"%@",rightDic[@"user"][@"corp_name"]];
        if (corp_name.length>0&&![corp_name isEqualToString:@"(null)"]) {
            self.nameLabel.text = corp_name;
        }
    }
    [self.nameLabel sizeToFit];
    self.memberShipImageView.frame = CGRectMake(CGRectGetMaxX(self.nameLabel.frame)+SCREEN_WIDTH/375*8,
                                                SCREEN_WIDTH/375*21,
                                                SCREEN_WIDTH/375*14,
                                                SCREEN_WIDTH/375*16);
    
    
    //level
    NSString *level = [NSString stringWithFormat:@"%@",rightDic[@"user"][@"level"]];
    if ([level isEqualToString:@"gold"]) {
        self.memberShipImageView.image = [UIImage imageNamed:@"jinpaiImage"];
    }else if ([level isEqualToString:@"silver"]){
        self.memberShipImageView.image = [UIImage imageNamed:@"yinpaiImage"];
    }else if ([level isEqualToString:@"copper"]){
        self.memberShipImageView.image = [UIImage imageNamed:@"tongpaiImage"];
    }
    
    
    //money
    NSString *price = [NSString stringWithFormat:@"%@",rightDic[@"price"]];
    if (price.length>0&&![price isEqualToString:@"(null)"]) {
        self.moneyLabel.text = [NSString stringWithFormat:@"赏金 ¥%@",price];
    }
    
    
    
    //question
    NSString *question = [NSString stringWithFormat:@"%@",rightDic[@"question"]];
    CGSize size     = CGSizeMake(SCREEN_WIDTH-SCREEN_WIDTH/375*34, 0);
    CGSize autoSize = [[UILabel new] actualSizeOfLable:[NSString stringWithFormat:@"%@",question]
                                               andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/375*13]
                                               andSize:size];
    
    self.questionLabel.numberOfLines = 0;
    if (question.length>0&&![question isEqualToString:@"(null)"]) {
        self.questionLabel.text = question;
    }
    
    self.questionLabel.frame = CGRectMake(SCREEN_WIDTH/375*17,
                                          SCREEN_WIDTH/375*56,
                                          SCREEN_WIDTH-SCREEN_WIDTH/375*34,
                                          autoSize.height);
    
    
    
    
    
    
    /* 图片 **/
    self.photosView.py_x = SCREEN_WIDTH/25;
    NSArray *imgArr    = (NSArray *)rightDic[@"images"];
    if (imgArr.count != 0) {
        self.photosView.height = SCREEN_WIDTH/6.25;
        self.photosView.py_y   = self.questionLabel.bottom + SCREEN_WIDTH/37.5;
        
        NSMutableArray *images = [[NSMutableArray alloc] init];
        for (int i = 0; i < imgArr.count; i++) {
            NSString *imgStr   = [NSString stringWithFormat:@"%@",[imgArr objectAt:i][@"file"]];
            [images addObject:imgStr];
        }
        self.photosView.thumbnailUrls = images;
        self.photosView.originalUrls  = images;
        if (imgArr.count == 1) {
            self.photosView.py_width  = (SCREEN_WIDTH/6.25);
        } else {
            self.photosView.py_width  = (SCREEN_WIDTH/6.25) * 4 + 30;
        }
    } else {
        //没图片
        self.photosView.thumbnailUrls = nil;
        self.photosView.originalUrls  = nil;
        self.photosView.height = 0;
        self.photosView.py_y = self.questionLabel.bottom;
    }
    
    //self.photosView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.photosView];
    
    
    
    
    
    
    //state
    self.stateImageView.frame = CGRectMake(SCREEN_WIDTH/375*19,
                                           CGRectGetMaxY(self.photosView.frame)+SCREEN_WIDTH/375*9,
                                           SCREEN_WIDTH/375*12,
                                           SCREEN_WIDTH/375*12);
    
    
    
    self.stateLabel.frame = CGRectMake(SCREEN_WIDTH/375*34,
                                       CGRectGetMaxY(self.photosView.frame)+SCREEN_WIDTH/375*6,
                                       SCREEN_WIDTH/375*300,
                                       SCREEN_WIDTH/375*17);
    
    self.line.alpha = 0;
    
    
    NSString *status = [NSString stringWithFormat:@"%@",rightDic[@"status"]];
    NSString *status_title = [NSString stringWithFormat:@"%@",rightDic[@"status_title"]];
    
    NSString *last_hours = [NSString stringWithFormat:@"%@",rightDic[@"last_hours"]];
    NSString *answer_user_num = [NSString stringWithFormat:@"%@",rightDic[@"answer_user_num"]];
    
    
    
    NSString *aim_answerer = [NSString stringWithFormat:@"%@",rightDic[@"aim_answerer"]];
    //NSString *userID     = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:USER_ID]];
    if ([aim_answerer integerValue]==0) {
        //非指定
        if ([status isEqualToString:@"asked"]) {
            //进行中
            self.stateImageView.image = [UIImage imageNamed:@"tipJinxingzhong"];
            self.stateLabel.text = [NSString stringWithFormat:@"%@，还剩%@小时  |  %@人已回答",status_title,last_hours,answer_user_num];
        }else if ([status isEqualToString:@"dealt"]) {
            //进行中
            self.stateImageView.image = [UIImage imageNamed:@"yihuidaImageTip"];
            if ([answer_user_num integerValue]>0) {
                self.stateLabel.text = [NSString stringWithFormat:@"%@，还剩%@小时",status_title,last_hours];
            }else{
                self.stateLabel.text = [NSString stringWithFormat:@"%@，还剩%@小时",status_title,last_hours];
            }
            //yihuidaImageTip
        }else if ([status isEqualToString:@"complete"]) {
            //已完成
            NSString *reward = [NSString stringWithFormat:@"%@",rightDic[@"reward"]];
            if ([reward integerValue]>0) {
                self.stateImageView.image = [UIImage imageNamed:@"tipYiwancheng"];
                //yes采纳
                self.stateLabel.text = [NSString stringWithFormat:@"%@，获得赏金¥%@元",status_title,reward];
            }else{
                self.stateImageView.image = [UIImage imageNamed:@"yijieshu"];
                //no采纳
                self.stateLabel.text = [NSString stringWithFormat:@"%@，未获得赏金",status_title];
            }
            
        }else if ([status isEqualToString:@"expired"]) {
            //已过期
            self.stateImageView.image = [UIImage imageNamed:@"tipYiguoqi"];
            NSString *reward = [NSString stringWithFormat:@"%@",rightDic[@"reward"]];
            if ([reward integerValue]>0) {
                //yes采纳
                self.stateLabel.text = [NSString stringWithFormat:@"%@，获得赏金¥%@元",status_title,reward];
            }else{
                //no采纳
                self.stateLabel.text = [NSString stringWithFormat:@"%@，未获得赏金",status_title];
            }
        }else if ([status isEqualToString:@"closed"]) {
            //已撤销
            self.stateImageView.image = [UIImage imageNamed:@"tipYichexiao"];
            NSString *reward = [NSString stringWithFormat:@"%@",rightDic[@"reward"]];
            if ([reward integerValue]>0) {
                //yes采纳
                self.stateLabel.text = [NSString stringWithFormat:@"%@，获得赏金¥%@元",status_title,reward];
            }else{
                //no采纳
                self.stateLabel.text = [NSString stringWithFormat:@"%@，未获得赏金",status_title];
            }
        }
    }else{
        //指定
        if ([status isEqualToString:@"asked"]) {
            //进行中
            self.stateImageView.image = [UIImage imageNamed:@"tipJinxingzhong"];
            if ([answer_user_num integerValue]>0) {
                self.stateLabel.text = [NSString stringWithFormat:@"%@，还剩%@小时",status_title,last_hours];
            }else{
                self.stateLabel.text = [NSString stringWithFormat:@"%@，还剩%@小时",status_title,last_hours];
            }
            //yihuidaImageTip
        }else if ([status isEqualToString:@"dealt"]) {
            //进行中
            self.stateImageView.image = [UIImage imageNamed:@"yihuidaImageTip"];
            if ([answer_user_num integerValue]>0) {
                self.stateLabel.text = [NSString stringWithFormat:@"%@，还剩%@小时",status_title,last_hours];
            }else{
                self.stateLabel.text = [NSString stringWithFormat:@"%@，还剩%@小时",status_title,last_hours];
            }
            //yihuidaImageTip
        }else if ([status isEqualToString:@"complete"]) {
            //已完成
            self.stateImageView.image = [UIImage imageNamed:@"tipYiwancheng"];
            NSString *reward = [NSString stringWithFormat:@"%@",rightDic[@"reward"]];
            if ([reward integerValue]>0) {
                //yes采纳
                self.stateLabel.text = [NSString stringWithFormat:@"%@，获得赏金¥%@元",status_title,reward];
            }else{
                //no采纳
                self.stateLabel.text = [NSString stringWithFormat:@"%@，未获得赏金",status_title];
            }
            
        }else if ([status isEqualToString:@"expired"]) {
            //已过期
            self.stateImageView.image = [UIImage imageNamed:@"tipYiguoqi"];
            NSString *reward = [NSString stringWithFormat:@"%@",rightDic[@"reward"]];
            if ([reward integerValue]>0) {
                self.stateLabel.text = [NSString stringWithFormat:@"%@",status_title];
            }else{
                self.stateLabel.text = [NSString stringWithFormat:@"%@，未获得赏金",status_title];
            }
        }else if ([status isEqualToString:@"closed"]) {
            //已撤销
            self.stateImageView.image = [UIImage imageNamed:@"tipYichexiao"];
            NSString *reward = [NSString stringWithFormat:@"%@",rightDic[@"reward"]];
            if ([reward integerValue]>0) {
                //yes采纳
                self.stateLabel.text = [NSString stringWithFormat:@"%@，获得赏金¥%@元",status_title,reward];
            }else{
                //no采纳
                self.stateLabel.text = [NSString stringWithFormat:@"%@，未获得赏金",status_title];
            }
        }
    }
}







//lazy
-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                         SCREEN_WIDTH/375*133,
                                                         SCREEN_WIDTH,
                                                         SCREEN_WIDTH/375*1)];
    }
    return _line;
}

-(UIImageView *)headerImageView{
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*18,
                                                                         SCREEN_WIDTH/375*12,
                                                                         SCREEN_WIDTH/375*35,
                                                                         SCREEN_WIDTH/375*35)];
        _headerImageView.layer.cornerRadius = SCREEN_WIDTH/375*2;
        _headerImageView.layer.masksToBounds= YES;
    }
    return _headerImageView;
}

//money
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*62,
                                                               SCREEN_WIDTH/375*20,
                                                               SCREEN_WIDTH/2,
                                                               SCREEN_WIDTH/375*20)];
    }
    return _nameLabel;
}


-(UIImageView *)memberShipImageView{
    if (!_memberShipImageView) {
        _memberShipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.nameLabel.frame)+SCREEN_WIDTH/375*8,
                                                                             SCREEN_WIDTH/375*21,
                                                                             SCREEN_WIDTH/375*14,
                                                                             SCREEN_WIDTH/375*16)];
        
    }
    return _memberShipImageView;
}


//money
-(UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*17-SCREEN_WIDTH/375*100,
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


- (PYPhotosView *)photosView {
    
    if (_photosView == nil) {
        
        _photosView = [PYPhotosView photosView];
        _photosView.layoutType = PYPhotosViewLayoutTypeFlow;
        _photosView.autoLayoutWithWeChatSytle = NO;
        _photosView.py_height  = SCREEN_WIDTH/6.25;
        
        // 设置图片间距为10
        _photosView.photoMargin  = 10;
        _photosView.photosMaxCol = 4;
        _photosView.photoWidth   = SCREEN_WIDTH/6.25;
        _photosView.photoHeight  = SCREEN_WIDTH/6.25;
    }
    return _photosView;
}

//state
-(UIImageView *)stateImageView{
    if (!_stateImageView) {
        _stateImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*19,
                                                                        SCREEN_WIDTH/375*106,
                                                                        SCREEN_WIDTH/375*12,
                                                                        SCREEN_WIDTH/375*12)];
    }
    return _stateImageView;
}

-(UILabel *)stateLabel{
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*34,
                                                                SCREEN_WIDTH/375*103,
                                                                SCREEN_WIDTH/375*300,
                                                                SCREEN_WIDTH/375*17)];
    }
    return _stateLabel;
}
@end
