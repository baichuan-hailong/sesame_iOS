//
//  ZMPayTypeTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/5/6.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMPayTypeTableViewCell.h"

@implementation ZMPayTypeTableViewCell

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
        
        //self.payImageView.backgroundColor = [UIColor lightGrayColor];
        self.payImageView.contentMode     = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.payImageView];
        
        
        [ZMLabelAttributeMange setLabel:self.payLabel
                                   text:@"--"
                                    hex:@"333333"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*15]];
        [self.contentView addSubview:self.payLabel];
        
        
        self.arrowImageView.image           = [UIImage imageNamed:@"gonext"];
        self.arrowImageView.contentMode     = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.arrowImageView];
        
        self.line.backgroundColor = [UIColor colorWithHex:@"DEDEDE"];
        [self.contentView addSubview:self.line];
    }
    return self;
}

- (void)setPayType:(NSDictionary *)dic{
    
    NSString *fileName      = [NSString stringWithFormat:@"%@",dic[@"leImage"]];
    self.payImageView.image = [UIImage imageNamed:fileName];
    self.payLabel.text      = [NSString stringWithFormat:@"%@",dic[@"leTip"]];
}

-(UIImageView *)payImageView{
    if (_payImageView==nil) {
        _payImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*22,
                                              SCREEN_WIDTH/375*10,
                                              SCREEN_WIDTH/375*30,
                                              SCREEN_WIDTH/375*30)];
    }
    return _payImageView;
}


-(UILabel *)payLabel{
    if (_payLabel==nil) {
        _payLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*65,
                                                              SCREEN_WIDTH/375*15,
                                                              SCREEN_WIDTH/375*150,
                                                              SCREEN_WIDTH/375*21)];
    }
    return _payLabel;
}

-(UIView *)line{
    if (_line==nil) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*29,
                                                              SCREEN_WIDTH/375*49.5,
                                                              SCREEN_WIDTH-SCREEN_WIDTH/375*29,
                                                              SCREEN_WIDTH/375*0.5)];
    }
    return _line;
}


-(UIImageView *)arrowImageView{
    if (_arrowImageView==nil) {
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*19-SCREEN_WIDTH/375*8,
                                                                        (SCREEN_WIDTH/375*50-SCREEN_WIDTH/375*13)/2,
                                                                        SCREEN_WIDTH/375*8,
                                                                        SCREEN_WIDTH/375*13)];
    }
    return _arrowImageView;
}



@end
