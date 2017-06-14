//
//  ZMMySellSecondPartyATableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/5/18.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMMySellSecondPartyATableViewCell.h"

@implementation ZMMySellSecondPartyATableViewCell

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
                                   text:@"--"
                                    hex:@"999999"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
        [self.contentView addSubview:self.leftLabel];
        
        
        //right
        [ZMLabelAttributeMange setLabel:self.rightLabel
                                   text:@"---"
                                    hex:@"333333"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
        [self.contentView addSubview:self.rightLabel];
        
        [ZMLabelAttributeMange setLabel:self.rightTitleLabel
                                   text:@"---"
                                    hex:@"333333"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
        [self.contentView addSubview:self.rightTitleLabel];
        
        [ZMLabelAttributeMange setLabel:self.rightDownLabel
                                   text:@"---"
                                    hex:tonalColor
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
        [self.contentView addSubview:self.rightDownLabel];
        
        
        
        self.line.backgroundColor = [UIColor colorWithHex:@"E7E7E7"];
        [self.contentView addSubview:self.line];
        
        //self.rightLabel.backgroundColor = [UIColor redColor];
        //self.rightDownLabel.backgroundColor = [UIColor redColor];
        //self.leftLabel.backgroundColor = [UIColor yellowColor];
    }
    return self;
}


- (void)setInvoiceDetail:(NSDictionary *)invoiceDetailDid{
    
    self.leftLabel.text     = [NSString stringWithFormat:@"%@",invoiceDetailDid[@"left"]];
    self.rightLabel.text    = [NSString stringWithFormat:@"%@",invoiceDetailDid[@"right"]];
    self.rightTitleLabel.text    = [NSString stringWithFormat:@"%@",invoiceDetailDid[@"rightTitle"]];
    self.rightDownLabel.text= [NSString stringWithFormat:@"%@",invoiceDetailDid[@"tel"]];
    
}


//left
-(UILabel *)leftLabel{
    if (_leftLabel==nil) {
        _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*21,
                                                               SCREEN_WIDTH/375*10,
                                                               SCREEN_WIDTH/375*110,
                                                               SCREEN_WIDTH/375*20)];
    }
    return _leftLabel;
}

//right
-(UILabel *)rightLabel{
    if (_rightLabel==nil) {
        _rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*141,
                                                                SCREEN_WIDTH/375*9,
                                                                SCREEN_WIDTH-SCREEN_WIDTH/375*150,
                                                                SCREEN_WIDTH/375*20)];
    }
    return _rightLabel;
}

-(UILabel *)rightTitleLabel{
    if (_rightTitleLabel==nil) {
        _rightTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*141,
                                                                    CGRectGetMaxY(self.rightLabel.frame)+SCREEN_WIDTH/375*3,
                                                                    SCREEN_WIDTH-SCREEN_WIDTH/375*150,
                                                                    SCREEN_WIDTH/375*20)];
    }
    return _rightTitleLabel;
}



-(UILabel *)rightDownLabel{
    if (_rightDownLabel==nil) {
        _rightDownLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*141,
                                                                CGRectGetMaxY(self.rightTitleLabel.frame)+SCREEN_WIDTH/375*3,
                                                                SCREEN_WIDTH-SCREEN_WIDTH/375*150,
                                                                SCREEN_WIDTH/375*20)];
    }
    return _rightDownLabel;
}


//line
-(UIView *)line{
    if (_line==nil) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*18,
                                                         SCREEN_WIDTH/375*81,
                                                         SCREEN_WIDTH-SCREEN_WIDTH/375*18-SCREEN_WIDTH/375*17,
                                                         SCREEN_WIDTH/375*1)];
    }
    return _line;
}


@end
