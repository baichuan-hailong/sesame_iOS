//
//  ZMCompanyVipTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMCompanyVipTableViewCell.h"

@interface ZMCompanyVipTableViewCell ()

@end

@implementation ZMCompanyVipTableViewCell
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
        self.backgroundColor      = [UIColor whiteColor];
        
        self.line.backgroundColor = [UIColor colorWithHex:@"DDDDDD"];
        [self.contentView addSubview:self.line];
        
        
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
        
        
        //company
        [ZMLabelAttributeMange setLabel:self.companyLabel
                                   text:@"---"
                                    hex:@"333333"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
        //self.companyLabel.numberOfLines = 0;
        [self.contentView addSubview:self.companyLabel];
        
        
        //self.memberShipImageView.image = [UIImage imageNamed:@"jinpaiImage"];
        self.memberShipImageView.contentMode     = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.memberShipImageView];
        
        
        //rename
        [self setlabel:self.renameLabel
                 title:@"建筑工程"
                 color:[UIColor colorWithHex:@"999999"]
         textAlignment:NSTextAlignmentCenter
                  font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*10]];
        //[self.contentView addSubview:self.renameLabel];
        
        //list
        [self setlabel:self.listLabel
                 title:@"规划设计"
                 color:[UIColor colorWithHex:@"999999"]
         textAlignment:NSTextAlignmentCenter
                  font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*10]];
        //[self.contentView addSubview:self.listLabel];
        
        self.tagView.userInteractionEnabled = NO;
        [self.contentView addSubview:self.tagView];
        
        //self.companyLabel.backgroundColor = [UIColor redColor];
        
    }
    return self;
}


- (void)setCompanyVip:(NSDictionary *)leftDic mainBizArray:(NSArray *)mainBizArray{
    
    
    self.companyLabel.text = [NSString stringWithFormat:@"%@",leftDic[@"corp_name"]];
    if (self.companyLabel.text.length>10) {
        self.companyLabel.frame = CGRectMake(SCREEN_WIDTH/375*92,
                                             SCREEN_WIDTH/375*22,
                                             SCREEN_WIDTH/3*2,
                                             SCREEN_WIDTH/375*20);
    
        [self.companyLabel sizeToFit];
    }else{
        [self.companyLabel sizeToFit];
    }
    
    
    
    
    self.memberShipImageView.frame = CGRectMake(CGRectGetMaxX(self.companyLabel.frame)+SCREEN_WIDTH/375*6.3,
                                                SCREEN_WIDTH/375*22,
                                                SCREEN_WIDTH/375*14,
                                                SCREEN_WIDTH/375*16);
    
    
    NSString *level      = [NSString stringWithFormat:@"%@",leftDic[@"level"]];
    if ([level isEqualToString:@"gold"]) {
        self.memberShipImageView.image = [UIImage imageNamed:@"jinpaiImage"];
    }else if ([level isEqualToString:@"silver"]){
        self.memberShipImageView.image = [UIImage imageNamed:@"yinpaiImage"];
    }else if ([level isEqualToString:@"copper"]){
        self.memberShipImageView.image = [UIImage imageNamed:@"tongpaiImage"];
    }
    NSString *avatar     = [NSString stringWithFormat:@"%@",leftDic[@"avatar"]];
    NSString *auth       = [NSString stringWithFormat:@"%@",leftDic[@"auth"]];
    //NSString *main_biz   = [NSString stringWithFormat:@"%@",leftDic[@"main_biz"]];
    if (avatar.length>10) {
        [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:avatar]
                                placeholderImage:[UIImage imageNamed:@"placeHeaderImage"]];
    }else{
        self.headerImageView.image = [UIImage imageNamed:@"placeHeaderImage"];
    }
    
    if ([auth isEqualToString:@"unauthed"]) {
        self.stateImageView.alpha = 0;
    }else if ([auth isEqualToString:@"authed"]){
        self.stateImageView.alpha = 1;
    }
    
    NSMutableArray *tagArr = [NSMutableArray array];
    
    NSString *main_biz = [NSString stringWithFormat:@"%@",leftDic[@"main_biz"]];
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

//company
-(UILabel *)companyLabel{
    if (_companyLabel==nil) {
        _companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*92,
                                                                  SCREEN_WIDTH/375*22,
                                                                  SCREEN_WIDTH/375*224,
                                                                  SCREEN_WIDTH/375*20)];
    }
    return _companyLabel;
}

-(UIImageView *)memberShipImageView{
    
    if (_memberShipImageView==nil) {
        _memberShipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.companyLabel.frame)+SCREEN_WIDTH/375*6.3,
                                                                             SCREEN_WIDTH/375*22,
                                                                             SCREEN_WIDTH/375*14,
                                                                             SCREEN_WIDTH/375*16)];
    }
    return _memberShipImageView;
}


//建筑工程
-(UILabel *)renameLabel{
    if (!_renameLabel) {
        _renameLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*92,
                                                                 SCREEN_WIDTH/375*48,
                                                                 SCREEN_WIDTH/375*60,
                                                                 SCREEN_WIDTH/375*17)];
    }
    return _renameLabel;
}


//规划设计
-(UILabel *)listLabel{
    if (!_listLabel) {
        _listLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*159,
                                                               SCREEN_WIDTH/375*48,
                                                               SCREEN_WIDTH/375*60,
                                                               SCREEN_WIDTH/375*17)];
    }
    return _listLabel;
}

- (TTGTextTagCollectionView *)tagView {
    
    if (_tagView == nil) {
        _tagView = [[TTGTextTagCollectionView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*92,
                                                                              SCREEN_WIDTH/375*48,
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
