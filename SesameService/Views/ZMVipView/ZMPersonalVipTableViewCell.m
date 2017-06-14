//
//  ZMPersonalVipTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/24.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMPersonalVipTableViewCell.h"

@interface ZMPersonalVipTableViewCell ()


@end

@implementation ZMPersonalVipTableViewCell

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
        
        //header Image
        self.headerImageView.backgroundColor = [UIColor lightGrayColor];
        self.headerImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.headerImageView.layer.cornerRadius = SCREEN_WIDTH/375*5;
        self.headerImageView.layer.borderWidth = SCREEN_WIDTH/375*0.3;
        self.headerImageView.layer.borderColor = [UIColor colorWithHex:@"B2B2B2"].CGColor;
        self.headerImageView.layer.masksToBounds= YES;
        [self.contentView addSubview:self.headerImageView];
        
        
        //state
        self.stateImageView.image           = [UIImage imageNamed:@"haveRenzhengImage"];
        self.stateImageView.contentMode     = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.stateImageView];
        
        
        //name
        [ZMLabelAttributeMange setLabel:self.nameLabel
                                   text:@"--"
                                    hex:@"333333"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
        [self.contentView addSubview:self.nameLabel];
        
        
        //jinpai
        self.memberShipImageView.contentMode     = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.memberShipImageView];
        
        
        //company
        [ZMLabelAttributeMange setLabel:self.companyLabel
                                   text:@""
                                    hex:@"666666"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.companyLabel];
        
        
        
        
        
        //rename
        [self setlabel:self.renameLabel
                 title:@"营销推广"
                 color:[UIColor colorWithHex:@"999999"]
         textAlignment:NSTextAlignmentCenter
                  font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*10]];
        //[self.contentView addSubview:self.renameLabel];
        
        //list
        [self setlabel:self.listLabel
                 title:@"风云榜入榜"
                 color:[UIColor colorWithHex:@"999999"]
         textAlignment:NSTextAlignmentCenter
                  font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*10]];
        //[self.contentView addSubview:self.listLabel];
        
        self.tagView.userInteractionEnabled = NO;
        [self.contentView addSubview:self.tagView];
    }
    return self;
}


- (void)setPersonVip:(NSDictionary *)rightDic mainBizArray:(NSArray *)mainBizArray{
    
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@",rightDic[@"person_name"]];
    if (self.nameLabel.text.length>10) {
        self.nameLabel.frame = CGRectMake(SCREEN_WIDTH/375*92,
                                          SCREEN_WIDTH/375*14,
                                          SCREEN_WIDTH/3*2,
                                          SCREEN_WIDTH/375*20);
    }else{
        [self.nameLabel sizeToFit];
    }
    
    self.memberShipImageView.frame = CGRectMake(CGRectGetMaxX(self.nameLabel.frame)+SCREEN_WIDTH/375*6.3,
                                                SCREEN_WIDTH/375*15,
                                                SCREEN_WIDTH/375*14,
                                                SCREEN_WIDTH/375*16);
    
    
    
    NSString *corp_name     = [NSString stringWithFormat:@"%@",rightDic[@"corp_name"]];
    NSString *title     = [NSString stringWithFormat:@"%@",rightDic[@"title"]];
    if (corp_name.length>0&&![corp_name isEqualToString:@"(null)"]&&title.length>0&&![title isEqualToString:@"(null)"]) {
        self.companyLabel.text = [NSString stringWithFormat:@"%@  |  %@",corp_name,title];
    }else if (corp_name.length>0&&![corp_name isEqualToString:@"(null)"]) {
        self.companyLabel.text = [NSString stringWithFormat:@"%@",corp_name];
    }else if (title.length>0&&![title isEqualToString:@"(null)"]) {
        self.companyLabel.text = [NSString stringWithFormat:@"%@",title];
    }else{
        self.companyLabel.text = @"暂无企业和职位信息";
    }
    
    
    NSString *avatar     = [NSString stringWithFormat:@"%@",rightDic[@"avatar"]];
    NSString *auth       = [NSString stringWithFormat:@"%@",rightDic[@"auth"]];
    NSString *level      = [NSString stringWithFormat:@"%@",rightDic[@"level"]];
    //NSString *main_biz   = [NSString stringWithFormat:@"%@",rightDic[@"main_biz"]];
    
    if (avatar.length>10) {
        [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:avatar]
                                placeholderImage:[UIImage imageNamed:@"placeHeaderImage"]];
    }else{
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
    
    NSMutableArray *tagArr = [NSMutableArray array];
    
    NSString *main_biz = [NSString stringWithFormat:@"%@",rightDic[@"main_biz"]];
    int per_main_int = [main_biz intValue];
    
    for (int i=0; i<mainBizArray.count; i++) {
        int compare = (int)pow(2, i);
        if (per_main_int&compare) {
            NSDictionary *mainBizDic = mainBizArray[i];
            [tagArr addObject:mainBizDic[@"tag"]];
        }
    }
    [_tagView removeAllTags];
    [_tagView addTags:tagArr];
}



- (void)setlabel:(UILabel *)label title:(NSString *)title color:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)textFond{
    
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    label.font = textFond;
    label.text = title;
    
    label.layer.borderColor  = [UIColor colorWithHex:@"999999"].CGColor;
    label.layer.borderWidth  = SCREEN_WIDTH/375*0.5;
    label.layer.cornerRadius = SCREEN_WIDTH/375*8;
}

-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                         SCREEN_WIDTH/375*89.5,
                                                         SCREEN_WIDTH,
                                                         SCREEN_WIDTH/375*0.5)];
    }
    return _line;
}

//header image
-(UIImageView *)headerImageView{
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*17,
                                                                         SCREEN_WIDTH/375*15,
                                                                         SCREEN_WIDTH/375*60,
                                                                         SCREEN_WIDTH/375*60)];
    }
    return _headerImageView;
}

//state
-(UIImageView *)stateImageView{
    if (!_stateImageView) {
        _stateImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*65,
                                                                        SCREEN_WIDTH/375*63,
                                                                        SCREEN_WIDTH/375*16,
                                                                        SCREEN_WIDTH/375*16)];
    }
    return _stateImageView;
}
//name
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*92,
                                                               SCREEN_WIDTH/375*14,
                                                               SCREEN_WIDTH/375*50,
                                                               SCREEN_WIDTH/375*20)];
    }
    return _nameLabel;
}


-(UIImageView *)memberShipImageView{
    
    if (_memberShipImageView==nil) {
        _memberShipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*142,
                                                                             SCREEN_WIDTH/375*15,
                                                                             SCREEN_WIDTH/375*14,
                                                                             SCREEN_WIDTH/375*16)];
    }
    return _memberShipImageView;
}



//company
-(UILabel *)companyLabel{
    if (!_companyLabel) {
        _companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*92,
                                                                  SCREEN_WIDTH/375*35,
                                                                  SCREEN_WIDTH-SCREEN_WIDTH/375*92-SCREEN_WIDTH/375*20,
                                                                  SCREEN_WIDTH/375*17)];
    }
    return _companyLabel;
}





//rename
-(UILabel *)renameLabel{
    if (!_renameLabel) {
        _renameLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*92,
                                                                 SCREEN_WIDTH/375*58,
                                                                 SCREEN_WIDTH/375*60,
                                                                 SCREEN_WIDTH/375*17)];
    }
    return _renameLabel;
}


//list
-(UILabel *)listLabel{
    if (!_listLabel) {
        _listLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*159,
                                                               SCREEN_WIDTH/375*58,
                                                               SCREEN_WIDTH/375*71,
                                                               SCREEN_WIDTH/375*17)];
    }
    return _listLabel;
}

- (TTGTextTagCollectionView *)tagView {
    
    if (_tagView == nil) {
        _tagView = [[TTGTextTagCollectionView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*92,
                                                                              SCREEN_WIDTH/375*58,
                                                                              SCREEN_WIDTH,
                                                                              SCREEN_WIDTH/375*21)];
        
        /** config */
        _tagView.defaultConfig.tagTextFont          = [UIFont systemFontOfSize:SCREEN_WIDTH/375*9];
        _tagView.defaultConfig.tagTextColor         = [UIColor colorWithHex:@"999999"];
        //_tagView.defaultConfig.tagSelectedTextColor = [UIColor colorWithHex:@"ffffff"];
        _tagView.defaultConfig.tagBackgroundColor   = [UIColor whiteColor];
        _tagView.defaultConfig.tagSelectedBackgroundColor = [UIColor colorWithHex:tonalColor];
        _tagView.defaultConfig.tagCornerRadius         = SCREEN_WIDTH/375*7;
        _tagView.defaultConfig.tagSelectedCornerRadius = SCREEN_WIDTH/375*7;
        _tagView.defaultConfig.tagBorderWidth         = SCREEN_WIDTH/375*0.5;
        _tagView.defaultConfig.tagSelectedBorderWidth = SCREEN_WIDTH/375*1;
        _tagView.defaultConfig.tagBorderColor       = [UIColor colorWithHex:@"999999"];
        //_tagView.defaultConfig.tagSelectedBorderColor = [UIColor colorWithHex:tonalColor];
        _tagView.defaultConfig.tagShadowColor       = [UIColor whiteColor];
        _tagView.defaultConfig.tagShadowOffset      = CGSizeMake(0, 0);
        _tagView.defaultConfig.tagShadowRadius      = 0;
        _tagView.defaultConfig.tagShadowOpacity     = 0;
        _tagView.defaultConfig.tagExtraSpace        = CGSizeMake(18, 5);
        _tagView.verticalSpacing = SCREEN_WIDTH/375*7;
        
        
        //_tagView.backgroundColor = [UIColor redColor];
    }
    return _tagView;
}


@end
