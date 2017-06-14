//
//  ZMPayMoneyTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/5/6.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMPayMoneyTableViewCell.h"

@interface ZMPayMoneyTableViewCell ()

@end

@implementation ZMPayMoneyTableViewCell

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
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.line.backgroundColor = [UIColor colorWithHex:@"DEDEDE"];
        [self.contentView addSubview:self.line];
    
        
        //tip
        [ZMLabelAttributeMange setLabel:self.tipLabel
                                   text:@"---"
                                    hex:@"333333"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*15]];
        [self.contentView addSubview:self.tipLabel];
        
        
        //money
        [ZMLabelAttributeMange setLabel:self.moneyLabel
                                   text:@"---"
                                    hex:@"FA4A4A"
                          textAlignment:NSTextAlignmentRight
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*16]];
        [self.contentView addSubview:self.moneyLabel];
        
    }
    return self;
}


- (void)setPayMoney:(NSDictionary *)dic{
    
    
    self.tipLabel.text   = [NSString stringWithFormat:@"%@",dic[@"tip"]];
    self.moneyLabel.text = [NSString stringWithFormat:@"%@",dic[@"money"]];
}




-(UILabel *)tipLabel{
    if (_tipLabel==nil) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*19,
                                               SCREEN_WIDTH/375*14,
                                               SCREEN_WIDTH/375*100,
                                               SCREEN_WIDTH/375*21)];
    }
    return _tipLabel;
}


-(UILabel *)moneyLabel{
    if (_moneyLabel==nil) {
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*19+SCREEN_WIDTH/375*100,
                                                      SCREEN_WIDTH/375*14,
                                                      SCREEN_WIDTH-SCREEN_WIDTH/375*19-SCREEN_WIDTH/375*100-SCREEN_WIDTH/375*19,
                                                      SCREEN_WIDTH/375*21)];
}
    return _moneyLabel;
}


-(UIView *)line{
    if (_line==nil) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*0,
                                              SCREEN_WIDTH/375*49.5,
                                              SCREEN_WIDTH,
                                              SCREEN_WIDTH/375*0.5)];
    }
    return _line;
}


@end
