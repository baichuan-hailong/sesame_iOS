//
//  ZMMyCreditRightTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/30.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMMyCreditRightTableViewCell.h"

@implementation ZMMyCreditRightTableViewCell

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
        
        self.backgroundColor                 = [UIColor whiteColor];

        self.detailLabel.textColor     = [UIColor colorWithHex:@"333333"];
        self.detailLabel.textAlignment = NSTextAlignmentLeft;
        self.detailLabel.font          = [UIFont systemFontOfSize:SCREEN_WIDTH/375*16];
        [self.contentView addSubview:self.detailLabel];
        
        self.arrowImageView.image = [UIImage imageNamed:@"gonext"];
        self.arrowImageView.contentMode     = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.arrowImageView];
        
        self.biuLine.backgroundColor = [UIColor colorWithHex:@"DEDEDE"];
        //self.biuLine.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.biuLine];
        
        self.rightLabel.textColor     = [UIColor colorWithHex:@"999999"];
        self.rightLabel.textAlignment = NSTextAlignmentRight;
        self.rightLabel.font          = [UIFont systemFontOfSize:SCREEN_WIDTH/375*14];
        //self.rightLabel.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:self.rightLabel];
        
        
    }
    return self;
}


- (void)setDetaillCell:(NSDictionary *)dic{
    
    //"tipIm":@"Unknown1",@"tipStr
    self.detailLabel.text      = [NSString stringWithFormat:@"%@",dic[@"tipStr"]];
}


-(UILabel *)detailLabel{
    
    if (_detailLabel==nil) {
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*18, SCREEN_WIDTH/375*15, 150, SCREEN_WIDTH/375*20)];
    }
    return _detailLabel;
}

-(UIImageView *)arrowImageView{
    
    if (_arrowImageView==nil) {
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*27-SCREEN_WIDTH/375*8, SCREEN_WIDTH/375*18, SCREEN_WIDTH/375*8, SCREEN_WIDTH/375*13)];
    }
    return _arrowImageView;
}
-(UIView *)biuLine{
    
    if (_biuLine==nil) {
        _biuLine = [[UIView alloc] initWithFrame:CGRectMake(29, SCREEN_WIDTH/375*48, SCREEN_WIDTH-29, 1)];
    }
    return _biuLine;
}

-(UILabel *)rightLabel{
    
    if (_rightLabel==nil) {
        _rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*37-SCREEN_WIDTH/375*180, SCREEN_WIDTH/375*15, SCREEN_WIDTH/375*180, SCREEN_WIDTH/375*20)];
    }
    return _rightLabel;
}
@end
