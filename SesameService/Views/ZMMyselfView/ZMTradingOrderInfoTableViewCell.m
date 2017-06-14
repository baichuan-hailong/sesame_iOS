//
//  ZMTradingOrderInfoTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/25.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMTradingOrderInfoTableViewCell.h"

@implementation ZMTradingOrderInfoTableViewCell

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
                                   text:@"---"
                                    hex:@"999999"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
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

//20 + 8  28
- (void)setDetail:(NSDictionary *)detailDid{
    self.leftLabel.text = [NSString stringWithFormat:@"%@",detailDid[@"left"]];
    self.rightLabel.text= [NSString stringWithFormat:@"%@",detailDid[@"right"]];
}
//left
-(UILabel *)leftLabel{
    if (_leftLabel==nil) {
        _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*18.5,
                                                               SCREEN_WIDTH/375*0,
                                                               SCREEN_WIDTH/375*100,
                                                               SCREEN_WIDTH/375*20)];
    }
    return _leftLabel;
}

//right
-(UILabel *)rightLabel{
    if (_rightLabel==nil) {
        _rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*250-SCREEN_WIDTH/375*19,
                                                                SCREEN_WIDTH/375*0,
                                                                SCREEN_WIDTH/375*250,
                                                                SCREEN_WIDTH/375*20)];
    }
    return _rightLabel;
}



@end
