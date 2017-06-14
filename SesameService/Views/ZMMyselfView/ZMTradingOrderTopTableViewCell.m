//
//  ZMTradingOrderTopTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/25.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMTradingOrderTopTableViewCell.h"

@implementation ZMTradingOrderTopTableViewCell

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
                                   text:@"金额"
                                    hex:@"666666"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*16]];
        [self.contentView addSubview:self.leftLabel];
        
        
        //right
        [ZMLabelAttributeMange setLabel:self.rightLabel
                                   text:@"+100.00"
                                    hex:@"333333"
                          textAlignment:NSTextAlignmentRight
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*26]];
        [self.contentView addSubview:self.rightLabel];
        
    }
    return self;
}

//21 + 22  64


- (void)setDetail:(NSDictionary *)detailDid{
    self.leftLabel.text = [NSString stringWithFormat:@"%@",detailDid[@"left"]];
    self.rightLabel.text= [NSString stringWithFormat:@"%@",detailDid[@"right"]];
}


//left
-(UILabel *)leftLabel{
    if (_leftLabel==nil) {
        _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*18.5,
                                                               SCREEN_WIDTH/375*21,
                                                               SCREEN_WIDTH/375*100,
                                                               SCREEN_WIDTH/375*22)];
    }
    return _leftLabel;
}

//right
-(UILabel *)rightLabel{
    if (_rightLabel==nil) {
        _rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*150-SCREEN_WIDTH/375*19,
                                                                SCREEN_WIDTH/375*16,
                                                                SCREEN_WIDTH/375*150,
                                                                SCREEN_WIDTH/375*34)];
    }
    return _rightLabel;
}




@end
