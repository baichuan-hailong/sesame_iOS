//
//  ZMMyCreditLeftTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/30.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMMyCreditLeftTableViewCell.h"

@interface ZMMyCreditLeftTableViewCell ()
@property(nonatomic,strong)UIView *leftLine;
@property(nonatomic,strong)UIView *point;
@property(nonatomic,strong)UIView *bottomLine;
@end

@implementation ZMMyCreditLeftTableViewCell

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
        
        self.backgroundColor                 = [UIColor whiteColor];
        
        self.leftLine.backgroundColor = [UIColor colorWithHex:@"DEDEDE"];
        [self.contentView addSubview:self.leftLine];
        
        self.bottomLine.backgroundColor = [UIColor colorWithHex:@"EBEBEB"];
        //self.bottomLine.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.bottomLine];
        
        self.point.backgroundColor = [UIColor colorWithHex:tonalColor];
        self.point.layer.cornerRadius = SCREEN_WIDTH/375*3.5;
        //self.point.alpha = 0.6;
        [self.contentView addSubview:self.point];
        
        [self setlabel:self.scoreLabel title:@"90分" color:[UIColor colorWithHex:tonalColor] textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*10]];
        [self addSubview:self.scoreLabel];
        
        [ZMLabelAttributeMange setLabel:self.titleLabel
                                   text:@"参与商机共享、业务代理\n好生意不难做"
                                    hex:@"666666"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
        self.titleLabel.numberOfLines = 0;
        [self addSubview:self.titleLabel];

    }
    return self;
}


- (void)setlabel:(UILabel *)label title:(NSString *)title color:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)textFond{
    
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    label.font = textFond;
    label.text = title;
    
    label.layer.borderColor  = [UIColor colorWithHex:tonalColor].CGColor;
    label.layer.borderWidth  = SCREEN_WIDTH/375*0.5;
    label.layer.cornerRadius = SCREEN_WIDTH/375*8;
}


//lazy
-(UIView *)leftLine{
    if (_leftLine==nil) {
        _leftLine = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*64, SCREEN_WIDTH/375*0, SCREEN_WIDTH/375*1, SCREEN_WIDTH/375*64)];
    }
    return _leftLine;
}

-(UIView *)point{
    if (_point==nil) {
        _point = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*61, SCREEN_WIDTH/375*28, SCREEN_WIDTH/375*7, SCREEN_WIDTH/375*7)];
    }
    return _point;
}

-(UIView *)bottomLine{
    if (_bottomLine==nil) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*79, SCREEN_WIDTH/375*63, SCREEN_WIDTH-SCREEN_WIDTH/375*79, SCREEN_WIDTH/375*1)];
    }
    return _bottomLine;
}

-(UILabel *)scoreLabel{
    if (_scoreLabel==nil) {
        _scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*15, SCREEN_WIDTH/375*21, SCREEN_WIDTH/375*40, SCREEN_WIDTH/375*20)];
    }
    return _scoreLabel;
}


-(UILabel *)titleLabel{
    if (_titleLabel==nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*91, SCREEN_WIDTH/375*18, SCREEN_WIDTH-SCREEN_WIDTH/375*110, SCREEN_WIDTH/375*34)];
    }
    return _titleLabel;
}
@end
