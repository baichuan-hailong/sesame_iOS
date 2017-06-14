//
//  ZMInvoiceDetailTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/24.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMInvoiceDetailTableViewCell.h"

@implementation ZMInvoiceDetailTableViewCell

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
        
        
        
        self.line.backgroundColor = [UIColor colorWithHex:@"E7E7E7"];
        [self.contentView addSubview:self.line];
    }
    return self;
}


- (void)setInvoiceDetail:(NSDictionary *)invoiceDetailDid{
    self.leftLabel.text = [NSString stringWithFormat:@"%@",invoiceDetailDid[@"left"]];
    self.rightLabel.text= [NSString stringWithFormat:@"%@",invoiceDetailDid[@"right"]];
}


//left
-(UILabel *)leftLabel{
    if (_leftLabel==nil) {
        _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*22,
                                                                SCREEN_WIDTH/375*23,
                                                                SCREEN_WIDTH/375*80,
                                                                SCREEN_WIDTH/375*20)];
    }
    return _leftLabel;
}

//right
-(UILabel *)rightLabel{
    if (_rightLabel==nil) {
        _rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*121,
                                                               SCREEN_WIDTH/375*23,
                                                               SCREEN_WIDTH-SCREEN_WIDTH/375*150,
                                                               SCREEN_WIDTH/375*20)];
    }
    return _rightLabel;
}


//line
-(UIView *)line{
    if (_line==nil) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*19,
                                                         SCREEN_WIDTH/375*58,
                                                         SCREEN_WIDTH-SCREEN_WIDTH/375*19-SCREEN_WIDTH/375*17,
                                                         SCREEN_WIDTH/375*1)];
    }
    return _line;
}


@end
