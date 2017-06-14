//
//  ZMMyInvoiceTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/24.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMMyInvoiceTableViewCell.h"

@implementation ZMMyInvoiceTableViewCell

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
        
        //money
        [ZMLabelAttributeMange setLabel:self.moneyLabel
                                   text:@"¥50.00"
                                    hex:@"EE6B6A"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*18]];
        [self.contentView addSubview:self.moneyLabel];
        
        
        //state
        [ZMLabelAttributeMange setLabel:self.stateLabel
                                   text:@"审核中"
                                    hex:tonalColor
                          textAlignment:NSTextAlignmentRight
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.stateLabel];
        
        
        //type
        [ZMLabelAttributeMange setLabel:self.titleLabel
                                   text:@"发票类型：普通发票"
                                    hex:@"666666"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.titleLabel];
        
        
        //time
        [ZMLabelAttributeMange setLabel:self.timeLabel
                                   text:@"提交时间：2017-04-10"
                                    hex:@"666666"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.timeLabel];
        
        
        
        self.line.backgroundColor = [UIColor colorWithHex:@"D8D8D8"];
        [self.contentView addSubview:self.line];
    }
    return self;
}

- (void)setInvoiceIntro:(NSDictionary *)invoiceDid{
    
}


//money
-(UILabel *)moneyLabel{
    if (_moneyLabel==nil) {
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*18,
                                                                SCREEN_WIDTH/375*12.6,
                                                                SCREEN_WIDTH/375*200,
                                                                SCREEN_WIDTH/375*25)];
    }
    return _moneyLabel;
}

//state
-(UILabel *)stateLabel{
    if (_stateLabel==nil) {
        _stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*17-SCREEN_WIDTH/375*200,
                                                                SCREEN_WIDTH/375*13,
                                                                SCREEN_WIDTH/375*200,
                                                                SCREEN_WIDTH/375*17)];
    }
    return _stateLabel;
}

//type
-(UILabel *)titleLabel{
    if (_titleLabel==nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*17.5,
                                                                SCREEN_WIDTH/375*40.6,
                                                                SCREEN_WIDTH-SCREEN_WIDTH/375*40,
                                                                SCREEN_WIDTH/375*17)];
    }
    return _titleLabel;
}

//time
-(UILabel *)timeLabel{
    if (_timeLabel==nil) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*17.5,
                                                               SCREEN_WIDTH/375*62.6,
                                                               SCREEN_WIDTH-SCREEN_WIDTH/375*40,
                                                               SCREEN_WIDTH/375*17)];
    }
    return _timeLabel;
}



-(UIView *)line{
    if (_line==nil) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                         SCREEN_WIDTH/375*94.5,
                                                         SCREEN_WIDTH,
                                                         SCREEN_WIDTH/375*0.5)];
    }
    return _line;
}


@end
