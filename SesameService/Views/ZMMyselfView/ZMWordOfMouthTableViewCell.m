//
//  ZMWordOfMouthTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/24.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMWordOfMouthTableViewCell.h"

@interface ZMWordOfMouthTableViewCell ()
@property (nonatomic,strong)UIView *line;
@end

@implementation ZMWordOfMouthTableViewCell
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
        
        //self.startsView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.startsView];
        
        [ZMLabelAttributeMange setLabel:self.topLabel
                                   text:@"非常好的广告公司……"
                                    hex:@"666666"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.topLabel];
        
        [ZMLabelAttributeMange setLabel:self.timeLabel
                                   text:@"2016-12-12"
                                    hex:@"999999"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.timeLabel];
        
        [ZMLabelAttributeMange setLabel:self.titleLabel
                                   text:@"北京风至飞扬广告有限公司"
                                    hex:@"666666"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.titleLabel];
        
        
        [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:@"http://img4.duitang.com/uploads/blog/201311/13/20131113184407_WsxaM.jpeg"]];
        self.headerImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.headerImageView.layer.cornerRadius = SCREEN_WIDTH/375*15;
        self.headerImageView.layer.masksToBounds= YES;
        [self.contentView addSubview:self.headerImageView];
        
        
        self.line.backgroundColor = [UIColor colorWithHex:@"DDDDDD"];
        [self.contentView addSubview:self.line];
    }
    return self;
}

//lazy
-(ZMStarComponentView *)startsView{
    if (_startsView==nil) {
        _startsView = [[ZMStarComponentView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*16,
                                                                            SCREEN_WIDTH/375*16,
                                                                            SCREEN_WIDTH/375*100,
                                                                            SCREEN_WIDTH/375*12)];
    }
    return _startsView;
}

-(UILabel *)topLabel{
    if (_topLabel==nil) {
        _topLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*17, SCREEN_WIDTH/375*39, SCREEN_WIDTH-SCREEN_WIDTH/375*34, SCREEN_WIDTH/375*17)];
    }
    return _topLabel;
}

-(UILabel *)timeLabel{
    if (_timeLabel==nil) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*17, SCREEN_WIDTH/375*58, SCREEN_WIDTH-SCREEN_WIDTH/375*34, SCREEN_WIDTH/375*16)];
    }
    return _timeLabel;
}

-(UILabel *)titleLabel{
    if (_titleLabel==nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*57, SCREEN_WIDTH/375*90, SCREEN_WIDTH-SCREEN_WIDTH/375*60, SCREEN_WIDTH/375*17)];
    }
    return _titleLabel;
}

-(UIImageView *)headerImageView{
    if (_headerImageView==nil) {
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*17, SCREEN_WIDTH/375*83, SCREEN_WIDTH/375*30, SCREEN_WIDTH/375*30)];
    }
    return _headerImageView;
}

-(UIView *)line{
    if (_line==nil) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*0, SCREEN_WIDTH/375*125, SCREEN_WIDTH, SCREEN_WIDTH/375*1)];
    }
    return _line;
}


@end
