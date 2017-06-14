//
//  ZMUserDataHeaderTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMUserDataHeaderTableViewCell.h"

@implementation ZMUserDataHeaderTableViewCell

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
        
        
        //left
        [ZMLabelAttributeMange setLabel:self.leftLabel
                                   text:@"头像"
                                    hex:@"333333"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*15]];
        [self.contentView addSubview:self.leftLabel];
        
        
        
        //image
        self.headerImageView.layer.cornerRadius  = SCREEN_WIDTH/375*3;
        self.headerImageView.layer.borderWidth = SCREEN_WIDTH/375*0.3;
        self.headerImageView.layer.borderColor = [UIColor colorWithHex:@"B2B2B2"].CGColor;
        self.headerImageView.layer.masksToBounds = YES;
        self.headerImageView.image               = [UIImage imageNamed:@"placeHeaderImage"];
        [self.contentView addSubview:self.headerImageView];
        
        
        self.headerImageView.contentMode = UIViewContentModeScaleAspectFill;
        
        
        
        self.arrowImageView.image           = [UIImage imageNamed:@"gonext"];
        self.arrowImageView.contentMode     = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.arrowImageView];
    }
    return self;
}

- (void)setAvatar:(NSString *)userType{
    
    NSString *person_avatar;
    if ([userType isEqualToString:@"1"]) {
        person_avatar = [[NSUserDefaults standardUserDefaults] objectForKey:Person_avatar];
    }else{
        person_avatar = [[NSUserDefaults standardUserDefaults] objectForKey:Com_avatar];
    }
    NSLog(@"top set avatar------------%@",person_avatar);
    if (person_avatar.length>0) {
        [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:person_avatar]
                                placeholderImage:[UIImage imageNamed:@"placeHeaderImage"]];
        self.headerImageView.backgroundColor = [UIColor lightGrayColor];
    }else{
        self.headerImageView .backgroundColor = [UIColor lightGrayColor];
    }
}

//left
-(UILabel *)leftLabel{
    if (_leftLabel==nil) {
        _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*31,
                                                               SCREEN_WIDTH/375*24,
                                                               SCREEN_WIDTH/375*100,
                                                               SCREEN_WIDTH/375*21)];
    }
    return _leftLabel;
}

//right
//left
-(UIImageView *)headerImageView{
    if (_headerImageView==nil) {
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*37-SCREEN_WIDTH/375*50,
                                                                SCREEN_WIDTH/375*10,
                                                                SCREEN_WIDTH/375*50,
                                                                SCREEN_WIDTH/375*50)];
    }
    return _headerImageView;
}



-(UIImageView *)arrowImageView{
    
    if (_arrowImageView==nil) {
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*19-SCREEN_WIDTH/375*8,
                                                                        (SCREEN_WIDTH/375*70-SCREEN_WIDTH/375*13)/2,
                                                                        SCREEN_WIDTH/375*8,
                                                                        SCREEN_WIDTH/375*13)];
    }
    return _arrowImageView;
}

@end
