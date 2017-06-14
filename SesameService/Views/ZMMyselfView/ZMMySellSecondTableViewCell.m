//
//  ZMMySellSecondTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/24.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMMySellSecondTableViewCell.h"

@implementation ZMMySellSecondTableViewCell

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
        
        //self.rightLabel.backgroundColor = [UIColor redColor];
        //self.leftLabel.backgroundColor = [UIColor yellowColor];
    }
    return self;
}


- (void)setInvoiceDetail:(NSDictionary *)invoiceDetailDid{
    
    //NSLog(@"-------- %@",invoiceDetailDid);

    self.leftLabel.text = [NSString stringWithFormat:@"%@",invoiceDetailDid[@"left"]];
    
    
    
    NSString *right = [NSString stringWithFormat:@"%@",invoiceDetailDid[@"right"]];
    CGSize size = CGSizeMake(SCREEN_WIDTH-SCREEN_WIDTH/375*150, 0);
    CGSize autoSize = [[UILabel new] actualSizeOfLineSpaceLable:right
                                                        andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
                                                        andSize:size];
    if (autoSize.height>25) {
        self.rightLabel.numberOfLines = 0;
        [ZMLabelAttributeMange setLineSpacing:self.rightLabel
                                          str:invoiceDetailDid[@"right"]
                                        space:SCREEN_WIDTH/375*4];
        
        
        self.line.frame = CGRectMake(SCREEN_WIDTH/375*18,
                                     CGRectGetMaxY(self.rightLabel.frame)+SCREEN_WIDTH/375*15,
                                     SCREEN_WIDTH-SCREEN_WIDTH/375*18-SCREEN_WIDTH/375*17,
                                     SCREEN_WIDTH/375*1);
    }else{
        self.rightLabel.text = invoiceDetailDid[@"right"];
    }
}


//left
-(UILabel *)leftLabel{
    if (_leftLabel==nil) {
        _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*21,
                                                               SCREEN_WIDTH/375*13,
                                                               SCREEN_WIDTH/375*110,
                                                               SCREEN_WIDTH/375*20)];
    }
    return _leftLabel;
}

//right
-(UILabel *)rightLabel{
    if (_rightLabel==nil) {
        _rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*141,
                                            SCREEN_WIDTH/375*13,
                                            SCREEN_WIDTH-SCREEN_WIDTH/375*150,
                                            SCREEN_WIDTH/375*20)];
}
    return _rightLabel;
}


//line
-(UIView *)line{
    if (_line==nil) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*18,
                                         SCREEN_WIDTH/375*45,
                                         SCREEN_WIDTH-SCREEN_WIDTH/375*18-SCREEN_WIDTH/375*17,
                                         SCREEN_WIDTH/375*1)];
    }
    return _line;
}


@end
