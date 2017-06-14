//
//  ZMMyselfPersonTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/22.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMMyselfPersonTableViewCell.h"

@implementation ZMMyselfPersonTableViewCell

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
        
        self.backgroundColor = [UIColor whiteColor];
        
        //person
        //self.headerImageViwe.backgroundColor     = [UIColor yellowColor];
        self.headerImageViwe.layer.cornerRadius  = SCREEN_WIDTH/375*5;
        self.headerImageViwe.layer.borderWidth = SCREEN_WIDTH/375*0.3;
        self.headerImageViwe.layer.borderColor = [UIColor colorWithHex:@"B2B2B2"].CGColor;
        self.headerImageViwe.layer.masksToBounds = YES;
        self.headerImageViwe.image               = [UIImage imageNamed:@"placeHeaderImage"];
        [self.contentView addSubview:self.headerImageViwe];
        
        //[self.headerImageViwe sd_setImageWithURL:[NSURL URLWithString:@"http://img4.duitang.com/uploads/blog/201311/13/20131113184407_WsxaM.jpeg"]];
        self.headerImageViwe.contentMode = UIViewContentModeScaleAspectFill;
        
        //state
        //arrow
        self.stateImageView.image           = [UIImage imageNamed:@"haveRenzhengImage"];
        self.stateImageView.alpha           = 0;
        self.stateImageView.contentMode     = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.stateImageView];
        
        
        self.nameLabel.textColor = [UIColor colorWithHex:@"333333"];
        self.nameLabel.textAlignment = NSTextAlignmentLeft;
        self.nameLabel.font = [UIFont systemFontOfSize:SCREEN_WIDTH/375*14];
        self.nameLabel.text = @"-- -- ";
        [self.contentView addSubview:self.nameLabel];
        
        
        //1
        //self.memberShipImageView.image = [UIImage imageNamed:@"jinpaiImage"];
        [self.contentView addSubview:self.memberShipImageView];
        
        
    
        self.lookPersonInfoLabel.textColor = [UIColor colorWithHex:@"333333"];
        self.lookPersonInfoLabel.textAlignment = NSTextAlignmentLeft;
        self.lookPersonInfoLabel.font = [UIFont systemFontOfSize:SCREEN_WIDTH/375*14];
        self.lookPersonInfoLabel.text = @"---";
        [self.contentView addSubview:self.lookPersonInfoLabel];
        
        
        //arrow
        self.arrowImageView.image           = [UIImage imageNamed:@"gonext"];
        self.arrowImageView.contentMode     = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.arrowImageView];
        
    }
    return self;
}

- (void)setPersonCell:(NSDictionary *)personDic{

    NSString *avatar      = [NSString stringWithFormat:@"%@",personDic[@"avatar"]];
    NSString *auth        = [NSString stringWithFormat:@"%@",personDic[@"auth"]];
    NSString *person_name = [NSString stringWithFormat:@"%@",personDic[@"person_name"]];
    NSString *level       = [NSString stringWithFormat:@"%@",personDic[@"level"]];
    
    
    
    //NSString *person_url    = [NSString stringWithFormat:@"%@%@%@",OutsideNetWorkPath,AVATAR,avatar];
    NSLog(@"avatar------------%@",avatar);
    if (avatar.length>10) {
        [self.headerImageViwe sd_setImageWithURL:[NSURL URLWithString:avatar]
                                placeholderImage:[UIImage imageNamed:@"placeHeaderImage"]];
    }else{
        self.headerImageViwe.image = [UIImage imageNamed:@"placeHeaderImage"];
        self.headerImageViwe .backgroundColor = [UIColor lightGrayColor];
    }
    
    
    if ([auth isEqualToString:@"unauthed"]) {
        self.stateImageView.alpha = 0;
    }else if ([auth isEqualToString:@"authed"]){
        self.stateImageView.alpha = 1;
    }else{
        self.stateImageView.alpha = 0;
    }
    
    NSLog(@"%@",person_name);
    NSLog(@"%ld",person_name.length);
    if (person_name.length>0&&![person_name isEqualToString:@"(null)"]) {
        self.nameLabel.text = person_name;
    }
    
    
    if ([level isEqualToString:@"gold"]) {
        self.lookPersonInfoLabel.text  = @"金牌会员";
        self.memberShipImageView.image = [UIImage imageNamed:@"jinpaiImage"];
    }else if ([level isEqualToString:@"silver"]){
        self.lookPersonInfoLabel.text  = @"银牌会员";
        self.memberShipImageView.image = [UIImage imageNamed:@"yinpaiImage"];
    }else if ([level isEqualToString:@"copper"]){
        self.lookPersonInfoLabel.text  = @"铜牌会员";
        self.memberShipImageView.image = [UIImage imageNamed:@"tongpaiImage"];
    }
    
}


- (void)setButton:(UIButton *)button title:(NSString *)title color:(UIColor *)textColor font:(UIFont *)textFond boo:(BOOL)islayer{
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    button.titleLabel.font    = textFond;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    if (islayer) {
        button.layer.borderColor  = [UIColor whiteColor].CGColor;
        button.layer.borderWidth  = SCREEN_WIDTH/375*1;
        button.layer.cornerRadius = SCREEN_WIDTH/375*4;
    }
}



//person
- (UIImageView *)headerImageViwe{
    
    if (_headerImageViwe==nil) {
        _headerImageViwe = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*15, (SCREEN_WIDTH/375*87-SCREEN_WIDTH/375*65)/2, SCREEN_WIDTH/375*65, SCREEN_WIDTH/375*65)];
    }
    return _headerImageViwe;
}

-(UILabel *)nameLabel{
    
    if (_nameLabel==nil) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*93,
                                                               SCREEN_WIDTH/375*21,
                                                               SCREEN_WIDTH-SCREEN_WIDTH/375*93-SCREEN_WIDTH/375*64,
                                                               SCREEN_WIDTH/375*20)];
        
    }
    return _nameLabel;
}

-(UILabel *)lookPersonInfoLabel{
    
    if (_lookPersonInfoLabel==nil) {
        _lookPersonInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*93,
                                                                          SCREEN_WIDTH/375*45,
                                                                          SCREEN_WIDTH/375*60,
                                                                          SCREEN_WIDTH/375*20)];
    }
    return _lookPersonInfoLabel;
}


//28 32
-(UIImageView *)memberShipImageView{
    
    if (_memberShipImageView==nil) {
        _memberShipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*155.3,
                                                                             SCREEN_WIDTH/375*45+SCREEN_WIDTH/375*2,
                                                                             SCREEN_WIDTH/375*14,
                                                                             SCREEN_WIDTH/375*16)];
    }
    return _memberShipImageView;
}

-(UIImageView *)stateImageView{
    
    if (_stateImageView==nil) {
        _stateImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*69,
                                                                        SCREEN_WIDTH/375*64,
                                                                        SCREEN_WIDTH/375*16,
                                                                        SCREEN_WIDTH/375*16)];
    }
    return _stateImageView;
}



//arrow
-(UIImageView *)arrowImageView{
    
    if (_arrowImageView==nil) {
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*19-SCREEN_WIDTH/375*8,
                                                                        (SCREEN_WIDTH/375*87-SCREEN_WIDTH/375*13)/2,
                                                                        SCREEN_WIDTH/375*8,
                                                                        SCREEN_WIDTH/375*13)];
    }
    return _arrowImageView;
}
@end
