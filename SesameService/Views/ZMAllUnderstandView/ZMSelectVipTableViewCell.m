//
//  ZMSelectVipTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/13.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMSelectVipTableViewCell.h"

@interface ZMSelectVipTableViewCell ()


@end

@implementation ZMSelectVipTableViewCell

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
        
        self.line.backgroundColor = [UIColor colorWithHex:@"DDDDDD"];
        [self.contentView addSubview:self.line];
        

        self.headerImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.headerImageView.layer.cornerRadius = SCREEN_WIDTH/375*2;
        self.headerImageView.layer.masksToBounds= YES;
        [self.contentView addSubview:self.headerImageView];
        
        //name
        [ZMLabelAttributeMange setLabel:self.nameLabel
                                   text:@"--"
                                    hex:@"333333"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*13]];
        [self.contentView addSubview:self.nameLabel];
        
        //company
        [ZMLabelAttributeMange setLabel:self.companyLabel
                                   text:@"---"
                                    hex:@"999999"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.companyLabel];
        
        //position
        [ZMLabelAttributeMange setLabel:self.positionLabel
                                   text:@"--"
                                    hex:@"333333"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*11]];
        [self.contentView addSubview:self.positionLabel];
        
        
        //state
        self.stateImageView.image           = [UIImage imageNamed:@"haveRenzhengImage"];
        self.stateImageView.contentMode     = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.stateImageView];
    
        
        //jinpai
        //self.memberShipImageView.image = [UIImage imageNamed:@"jinpaiImage"];
        //self.memberShipImageView.backgroundColor = [UIColor yellowColor];
        self.memberShipImageView.contentMode     = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.memberShipImageView];
        
        
    }
    return self;
}


- (void)setVip:(NSDictionary *)vipDic{
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@",vipDic[@"person_name"]];
    [self.nameLabel sizeToFit];
    
    NSString *position   = [NSString stringWithFormat:@"%@",vipDic[@"title"]];
    self.positionLabel.frame = CGRectMake(CGRectGetMaxX(self.nameLabel.frame)+SCREEN_WIDTH/375*6.3,
                                          SCREEN_WIDTH/375*23,
                                          SCREEN_WIDTH/375*100,
                                          SCREEN_WIDTH/375*16);
    self.positionLabel.text = position;
    
    [self.positionLabel sizeToFit];

    NSString *avatar     = [NSString stringWithFormat:@"%@",vipDic[@"avatar"]];
    NSString *auth       = [NSString stringWithFormat:@"%@",vipDic[@"auth"]];
    NSString *level      = [NSString stringWithFormat:@"%@",vipDic[@"level"]];
    NSString *company    = [NSString stringWithFormat:@"%@",vipDic[@"corp_name"]];
    
    //NSString *main_biz   = [NSString stringWithFormat:@"%@",vipDic[@"main_biz"]];
    
    self.companyLabel.text = company;
    
    if (avatar.length>10) {
        [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:avatar]
                                placeholderImage:[UIImage imageNamed:@"placeHeaderImage"]];
    }else{
        self.headerImageView .backgroundColor = [UIColor lightGrayColor];
        self.headerImageView.image = [UIImage imageNamed:@"placeHeaderImage"];
    }
    
    
    
    

     if ([auth isEqualToString:@"authed"]){
     self.stateImageView.alpha = 1;
     }else{
      self.stateImageView.alpha = 0;
     }
     
     
     if ([level isEqualToString:@"gold"]) {
     self.memberShipImageView.image = [UIImage imageNamed:@"jinpaiImage"];
     }else if ([level isEqualToString:@"silver"]){
     self.memberShipImageView.image = [UIImage imageNamed:@"yinpaiImage"];
     }else if ([level isEqualToString:@"copper"]){
     self.memberShipImageView.image = [UIImage imageNamed:@"tongpaiImage"];
     }
    
    self.memberShipImageView.frame = CGRectMake(CGRectGetMaxX(self.positionLabel.frame)+SCREEN_WIDTH/375*6,
                                                SCREEN_WIDTH/375*22,
                                                SCREEN_WIDTH/375*14,
                                                SCREEN_WIDTH/375*16);
    
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

-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_WIDTH/375*82, SCREEN_WIDTH, SCREEN_WIDTH/375*1)];
    }
    return _line;
}

-(UIImageView *)headerImageView{
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*17, SCREEN_WIDTH/375*17, SCREEN_WIDTH/375*50, SCREEN_WIDTH/375*50)];
    }
    return _headerImageView;
}

//name
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*80, SCREEN_WIDTH/375*21, SCREEN_WIDTH/375*50, SCREEN_WIDTH/375*18)];
    }
    return _nameLabel;
}

//positon
-(UILabel *)positionLabel{
    if (!_positionLabel) {
        _positionLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*130,
                                                                   SCREEN_WIDTH/375*23,
                                                                   SCREEN_WIDTH/375*100,
                                                                   SCREEN_WIDTH/375*16)];
    }
    return _positionLabel;
}

//company
-(UILabel *)companyLabel{
    if (!_companyLabel) {
        _companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*80, SCREEN_WIDTH/375*44, SCREEN_WIDTH, SCREEN_WIDTH/375*17)];
    }
    return _companyLabel;
}





//state
-(UIImageView *)stateImageView{
    if (!_stateImageView) {
        _stateImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*56,
                                                                        SCREEN_WIDTH/375*56,
                                                                        SCREEN_WIDTH/375*16,
                                                                        SCREEN_WIDTH/375*16)];
    }
    return _stateImageView;
}

-(UIImageView *)memberShipImageView{
    
    if (_memberShipImageView==nil) {
        _memberShipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.positionLabel.frame)+SCREEN_WIDTH/375*6,
                                                                             SCREEN_WIDTH/375*22,
                                                                             SCREEN_WIDTH/375*14,
                                                                             SCREEN_WIDTH/375*16)];
    }
    return _memberShipImageView;
}


@end
