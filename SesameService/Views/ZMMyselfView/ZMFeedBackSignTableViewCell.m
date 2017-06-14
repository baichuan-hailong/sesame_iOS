//
//  ZMFeedBackSignTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/6/8.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMFeedBackSignTableViewCell.h"

@implementation ZMFeedBackSignTableViewCell

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
        
        
        //left
        [ZMLabelAttributeMange setLabel:self.leftLabel
                                   text:@"-- --"
                                    hex:@"333333"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*15]];
        [self.contentView addSubview:self.leftLabel];
        
        //right
        [ZMLabelAttributeMange setLabel:self.rightLabel
                                   text:@"---"
                                    hex:@"999999"
                          textAlignment:NSTextAlignmentRight
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
        [self.contentView addSubview:self.rightLabel];
    }
    return self;
}


//left
-(UILabel *)leftLabel{
    if (_leftLabel==nil) {
        _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                         SCREEN_WIDTH/375*0,
                                                         SCREEN_WIDTH/3,
                                                         SCREEN_WIDTH/375*50)];
    }
    return _leftLabel;
}


//right
-(UILabel *)rightLabel{
    if (_rightLabel==nil) {
        _rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/3-SCREEN_WIDTH/375*20,
                                                           SCREEN_WIDTH/375*0,
                                                           SCREEN_WIDTH/3,
                                                           SCREEN_WIDTH/375*50)];
    }
    return _rightLabel;
}

-(UIView *)line{
    if (_line==nil) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                        SCREEN_WIDTH/375*49.5,
                                                        SCREEN_WIDTH,
                                                        SCREEN_WIDTH/375*0.5)];
    }
    return _line;
}


- (void)setFeedBack:(NSDictionary *)dic{
    self.leftLabel.text = [NSString stringWithFormat:@"%@",dic[@"left"]];
    self.rightLabel.text= [NSString stringWithFormat:@"%@",dic[@"right"]];
}

@end
