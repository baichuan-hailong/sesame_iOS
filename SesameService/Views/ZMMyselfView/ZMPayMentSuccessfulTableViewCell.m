//
//  ZMPayMentSuccessfulTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/5/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMPayMentSuccessfulTableViewCell.h"

@implementation ZMPayMentSuccessfulTableViewCell

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
        

        
        [ZMLabelAttributeMange setLabel:self.leftLabel
                                   text:@"--"
                                    hex:@"333333"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.leftLabel];
        
        [ZMLabelAttributeMange setLabel:self.rightLable
                                   text:@"--"
                                    hex:@"666666"
                          textAlignment:NSTextAlignmentRight
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.rightLable];
        
    }
    return self;
}

- (void)setAccont:(NSDictionary *)accDic{
    self.leftLabel.text  = [NSString stringWithFormat:@"%@",accDic[@"left"]];
    self.rightLable.text = [NSString stringWithFormat:@"%@",accDic[@"right"]];
}


-(UILabel *)leftLabel{
    if (_leftLabel==nil) {
        _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*30,
                                                                SCREEN_WIDTH/375*10,
                                                                SCREEN_WIDTH/375*100,
                                                                SCREEN_WIDTH/375*30)];
    }
    return _leftLabel;
}

-(UILabel *)rightLable{
    if (_rightLable==nil) {
        _rightLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*30-SCREEN_WIDTH/2,
                                                                SCREEN_WIDTH/375*10,
                                                                SCREEN_WIDTH/2,
                                                                SCREEN_WIDTH/375*30)];
    }
    return _rightLable;
}

-(UIView *)line{
    if (_line==nil) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                    SCREEN_WIDTH/375*49,
                                                    SCREEN_WIDTH,
                                                    SCREEN_WIDTH/375*1)];
    }
    return _line;
}

@end
