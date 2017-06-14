//
//  ZMVipSelectPositonTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/24.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMVipSelectPositonTableViewCell.h"
@interface ZMVipSelectPositonTableViewCell ()
@property(nonatomic,strong)UIView      *topView;
@property(nonatomic,strong)UIView      *line;
@end
@implementation ZMVipSelectPositonTableViewCell

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
        
        self.topView.backgroundColor = [UIColor colorWithHex:backGroundColor];
        [self.contentView addSubview:self.topView];
        
        self.line.backgroundColor = [UIColor colorWithHex:@"DDDDDD"];
        [self.contentView addSubview:self.line];
        
        //tip
        [ZMLabelAttributeMange setLabel:self.tipLabel
                                   text:@"选择行业"
                                    hex:@"333333"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
        [self.contentView addSubview:self.tipLabel];
        
        //self.tipImageView.backgroundColor = [UIColor redColor];
        self.tipImageView.image = [UIImage imageNamed:@"vipRight"];
        self.tipImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.tipImageView];
        
    }
    return self;
}

-(UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_WIDTH/375*0, SCREEN_WIDTH, SCREEN_WIDTH/375*10)];
    }
    return _topView;
}

-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_WIDTH/375*54, SCREEN_WIDTH, SCREEN_WIDTH/375*1)];
    }
    return _line;
}

-(UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*17, SCREEN_WIDTH/375*10, SCREEN_WIDTH/375*100, SCREEN_WIDTH/375*45)];
    }
    return _tipLabel;
}

-(UIImageView *)tipImageView{
    if (!_tipImageView) {
        _tipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*16.5-SCREEN_WIDTH/375*13, SCREEN_WIDTH/375*10+SCREEN_WIDTH/375*(45-13)/2, SCREEN_WIDTH/375*13, SCREEN_WIDTH/375*13)];
    }
    return _tipImageView;
}


@end
