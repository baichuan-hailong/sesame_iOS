//
//  ZMAllUnderstandLeftTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/6.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMAllUnderstandLeftTableViewCell.h"

@interface ZMAllUnderstandLeftTableViewCell ()
@property (nonatomic,strong)UIView *ansView;
@end

@implementation ZMAllUnderstandLeftTableViewCell

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
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
        //self.questionLabel.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:self.questionLabel];
        
        
        
        [ZMLabelAttributeMange setLabel:self.stateLabel
                                   text:@"还剩--小时  |  -人已抢答"
                                    hex:@"999999"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.stateLabel];
        
        
        //answer
        self.ansView.layer.borderColor = [UIColor colorWithHex:tonalColor].CGColor;
        self.ansView.layer.borderWidth = SCREEN_WIDTH/375*0.5;
        self.ansView.layer.cornerRadius= SCREEN_WIDTH/375*2;
        [self.contentView addSubview:self.ansView];
        
        
        [ZMLabelAttributeMange setLabel:self.answerLabel
                                   text:@"回答"
                                    hex:tonalColor
                          textAlignment:NSTextAlignmentCenter
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        self.answerLabel.backgroundColor = [UIColor whiteColor];
        [self.ansView addSubview:self.answerLabel];
        
        
    }
    return self;
}


- (void)setLeftAllUnderstan:(NSDictionary *)leftDic{
    
    NSString *avatar      = [NSString stringWithFormat:@"%@",leftDic[@"user"][@"avatar"]];
    NSString *auth        = [NSString stringWithFormat:@"%@",leftDic[@"user"][@"auth"]];
    NSString *person_name = [NSString stringWithFormat:@"%@",leftDic[@"user"][@"person_name"]];
    NSString *level       = [NSString stringWithFormat:@"%@",leftDic[@"user"][@"level"]];
    
    NSString *corp_name = [NSString stringWithFormat:@"%@",leftDic[@"user"][@"corp_name"]];
    NSString *type = [NSString stringWithFormat:@"%@",leftDic[@"user"][@"type"]];
    
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
    
    
    self.memberShipImageView.frame = CGRectMake(CGRectGetMaxX(self.nameLabel.frame)+SCREEN_WIDTH/375*6,
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
    
    self.moneyLabel.text    = [NSString stringWithFormat:@"赏金 ¥%@",leftDic[@"price"]];
    
    
    
    
    
    
    
    //question
    NSString *question = [NSString stringWithFormat:@"%@  ",leftDic[@"question"]];
    CGSize size = CGSizeMake(SCREEN_WIDTH-SCREEN_WIDTH/375*34, 0);
    CGSize   autoSize = [self.questionLabel actualSizeOfLineSpaceLable:[NSString stringWithFormat:@"%@  ",question]
                                                               andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
                                                               andSize:size];
    //line height
    //[ZMLabelAttributeMange setLineSpacing:self.questionLabel str:self.questionLabel.text];
    //[ZMLabelAttributeMange setLineSpacing:self.questionLabel str:[NSString stringWithFormat:@"%@  ",question]];
    
    
    int height = (int)autoSize.height;
    if (height>70) {
        question = [NSString stringWithFormat:@"%@...",[question substringToIndex:60]];
    }
    
    
    CGSize   SubAutoSize = [self.questionLabel actualSizeOfLineSpaceLable:[NSString stringWithFormat:@"%@  ",question]
                                                               andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
                                                               andSize:size];
    
    
    //add attr image
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
    
    
    int questionHei = (int)SubAutoSize.height+1;
    self.questionLabel.frame = CGRectMake(SCREEN_WIDTH/375*17,
                                  SCREEN_WIDTH/375*56,
                                  SCREEN_WIDTH-SCREEN_WIDTH/375*34,
                                  questionHei);
    
    
    self.stateLabel.text = [NSString stringWithFormat:@"还剩%@小时  |  %@人已抢答",leftDic[@"last_hours"],leftDic[@"answer_user_num"]];
    self.stateLabel.frame = CGRectMake(SCREEN_WIDTH/375*18,
               CGRectGetMaxY(self.questionLabel.frame)+SCREEN_WIDTH/375*14,
               SCREEN_WIDTH/375*200,
               SCREEN_WIDTH/375*17);
    
    //answer
    self.ansView.frame = CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*19-SCREEN_WIDTH/375*50,
                                        CGRectGetMaxY(self.questionLabel.frame)+SCREEN_WIDTH/375*9,
                                        SCREEN_WIDTH/375*50,
                                        SCREEN_WIDTH/375*25);

}



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
        _memberShipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.nameLabel.frame)+SCREEN_WIDTH/375*6,
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
                                                                   SCREEN_WIDTH/375*0)];
    }
    return _questionLabel;
}


-(UILabel *)stateLabel{
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*18,
                                                                CGRectGetMaxY(self.questionLabel.frame)+SCREEN_WIDTH/375*14,
                                                                SCREEN_WIDTH/375*200,
                                                                SCREEN_WIDTH/375*17)];
    }
    return _stateLabel;
}

//answer
-(UIView *)ansView{
    if (!_ansView) {
        _ansView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*19-SCREEN_WIDTH/375*50,
                                     CGRectGetMaxY(self.questionLabel.frame)+SCREEN_WIDTH/375*9,
                                     SCREEN_WIDTH/375*50,
                                     SCREEN_WIDTH/375*25)];
    }
    return _ansView;
}

-(UILabel *)answerLabel{
    if (!_answerLabel) {
        _answerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                0,
                                                                SCREEN_WIDTH/375*50,
                                                                SCREEN_WIDTH/375*25)];
    }
    return _answerLabel;
}
@end
