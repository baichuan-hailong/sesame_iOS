//
//  ZMBusinessTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/24.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMBusinessTableViewCell.h"

@interface ZMBusinessTableViewCell ()
@property (nonatomic , strong) UIView      *bodyView;
@property (nonatomic , strong) UIView      *line;
@end

@implementation ZMBusinessTableViewCell

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
        self.backgroundColor  = [UIColor colorWithHex:backGroundColor];
        
        self.bodyView.backgroundColor = [UIColor whiteColor];
        self.bodyView.layer.cornerRadius = SCREEN_WIDTH/375*8;
        self.bodyView.layer.borderColor  = [UIColor colorWithHex:@"DDDDDD"].CGColor;
        self.bodyView.layer.borderWidth  = SCREEN_WIDTH/375*0.8;
        [self.contentView addSubview:self.bodyView];
        
        self.line.backgroundColor = [UIColor colorWithHex:@"DDDDDD"];
        [self.bodyView addSubview:self.line];
        
        //title
        [ZMLabelAttributeMange setLabel:self.titleLabel
                                   text:@"寻求创意广告营销和品牌升级服务"
                                    hex:@"333333"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
        [self.bodyView addSubview:self.titleLabel];
        
        //sub title
        [ZMLabelAttributeMange setLabel:self.subtitleLabel
                                   text:@"上海  |  项目金额：200W"
                                    hex:@"555555"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.bodyView addSubview:self.subtitleLabel];
        
        //money
        [ZMLabelAttributeMange setLabel:self.moneyLabel
                                   text:@"¥1000"
                                    hex:@"EE6B6A"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.bodyView addSubview:self.moneyLabel];
        
        //one
        [self setlabel:self.oneLabel title:@"策划顾问" color:[UIColor colorWithHex:@"AAAAAA"] textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*10]];
        [self.bodyView addSubview:self.oneLabel];
        
        //two
        [self setlabel:self.twoLabel title:@"广告媒体资源" color:[UIColor colorWithHex:@"AAAAAA"] textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*10]];
        [self.bodyView addSubview:self.twoLabel];
        
        //three
        [self setlabel:self.threeLabel title:@"公关活动" color:[UIColor colorWithHex:@"AAAAAA"] textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*10]];
        [self.bodyView addSubview:self.threeLabel];
        
        //bottom
        [ZMLabelAttributeMange setLabel:self.bottonLabel
                                   text:@"有效期：2016-12-12"
                                    hex:@"999999"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.bodyView addSubview:self.bottonLabel];
        
        //right
        [ZMLabelAttributeMange setLabel:self.rightLabel
                                   text:@"上架中"
                                    hex:tonalColor
                          textAlignment:NSTextAlignmentRight
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.bodyView addSubview:self.rightLabel];
        
    }
    return self;
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

//lazy
-(UIView *)bodyView{
    if (_bodyView==nil) {
        _bodyView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*15, SCREEN_WIDTH/375*15, SCREEN_WIDTH-SCREEN_WIDTH/375*30, SCREEN_WIDTH/375*165)];
    }
    return _bodyView;
}

//@property (nonatomic , strong) UILabel     *titleLabel;
-(UILabel *)titleLabel{
    if (_titleLabel==nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*16.5, SCREEN_WIDTH/375*14.6, SCREEN_WIDTH-SCREEN_WIDTH/375*40-SCREEN_WIDTH/375*115, SCREEN_WIDTH/375*20)];
    }
    return _titleLabel;
}
//@property (nonatomic , strong) UILabel     *subtitleLabel;
-(UILabel *)subtitleLabel{
    if (_subtitleLabel==nil) {
        _subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*16.5, SCREEN_WIDTH/375*40.6, SCREEN_WIDTH-SCREEN_WIDTH/375*40-SCREEN_WIDTH/375*115, SCREEN_WIDTH/375*17)];
    }
    return _subtitleLabel;
}
//@property (nonatomic , strong) UILabel     *moneyLabel;
-(UILabel *)moneyLabel{
    if (_moneyLabel==nil) {
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*18, SCREEN_WIDTH/375*63.6, SCREEN_WIDTH-SCREEN_WIDTH/375*40-SCREEN_WIDTH/375*115, SCREEN_WIDTH/375*21)];
    }
    return _moneyLabel;
}
//@property (nonatomic , strong) UILabel     *oneLabel;
-(UILabel *)oneLabel{
    if (_oneLabel==nil) {
        _oneLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*18, SCREEN_WIDTH/375*94, SCREEN_WIDTH/375*60, SCREEN_WIDTH/375*17)];
    }
    return _oneLabel;
}
//@property (nonatomic , strong) UILabel     *twoLabel;
-(UILabel *)twoLabel{
    if (_twoLabel==nil) {
        _twoLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*85, SCREEN_WIDTH/375*94, SCREEN_WIDTH/375*81, SCREEN_WIDTH/375*17)];
    }
    return _twoLabel;
}
//@property (nonatomic , strong) UILabel     *threeLabel;
-(UILabel *)threeLabel{
    if (_threeLabel==nil) {
        _threeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*173, SCREEN_WIDTH/375*94, SCREEN_WIDTH/375*60, SCREEN_WIDTH/375*17)];
    }
    return _threeLabel;
}
//@property (nonatomic , strong) UILabel     *bottonLabel;
-(UILabel *)bottonLabel{
    if (_bottonLabel==nil) {
        _bottonLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*15, SCREEN_WIDTH/375*138, SCREEN_WIDTH, SCREEN_WIDTH/375*16)];
    }
    return _bottonLabel;
}
//@property (nonatomic , strong) UILabel     *rightLabel;
-(UILabel *)rightLabel{
    if (_rightLabel==nil) {
        _rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*48-SCREEN_WIDTH/375*100, SCREEN_WIDTH/375*14.6, SCREEN_WIDTH/375*100, SCREEN_WIDTH/375*20)];
    }
    return _rightLabel;
}

-(UIView *)line{
    if (_line==nil) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_WIDTH/375*127, SCREEN_WIDTH-SCREEN_WIDTH/375*30, SCREEN_WIDTH/375*0.5)];
    }
    return _line;
}
@end
