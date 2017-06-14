//
//  ZMMyselfStarDetailTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/14.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMMyselfStarDetailTableViewCell.h"

@implementation ZMMyselfStarDetailTableViewCell

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
        self.detailImageView.contentMode     = UIViewContentModeScaleAspectFit;
        //self.detailImageView.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:self.detailImageView];
        
        self.detailLabel.textColor     = [UIColor colorWithHex:@"333333"];
        self.detailLabel.textAlignment = NSTextAlignmentLeft;
        self.detailLabel.font          = [UIFont systemFontOfSize:SCREEN_WIDTH/375*14];
        [self.contentView addSubview:self.detailLabel];
        
        self.arrowImageView.image = [UIImage imageNamed:@"gonext"];
        self.arrowImageView.contentMode     = UIViewContentModeScaleAspectFit;
        //self.arrowImageView.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:self.arrowImageView];
        
        self.biuLine.backgroundColor = [UIColor colorWithHex:@"DEDEDE"];
        [self.contentView addSubview:self.biuLine];
        
        
        //stars
        //self.starView.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:self.starView];
        
        
    }
    return self;
}


- (void)setDetaillCell:(NSDictionary *)dic{
    
    //"tipIm":@"Unknown1",@"tipStr
    self.detailImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",dic[@"tipIm"]]];
    self.detailLabel.text      = [NSString stringWithFormat:@"%@",dic[@"tipStr"]];
}

-(UIImageView *)detailImageView{
    
    if (_detailImageView==nil) {
        _detailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*24, SCREEN_WIDTH/375*18, SCREEN_WIDTH/375*18, SCREEN_WIDTH/375*18)];
    }
    return _detailImageView;
}

-(UILabel *)detailLabel{
    
    if (_detailLabel==nil) {
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*55, SCREEN_WIDTH/375*16.5, 150, SCREEN_WIDTH/375*19)];
    }
    return _detailLabel;
}

-(UIImageView *)arrowImageView{
    
    if (_arrowImageView==nil) {
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*19-SCREEN_WIDTH/375*8,
                                                                        (SCREEN_WIDTH/375*50-SCREEN_WIDTH/375*13)/2,
                                                                        SCREEN_WIDTH/375*8,
                                                                        SCREEN_WIDTH/375*13)];
        //_arrowImageView.backgroundColor = [UIColor redColor];
    }
    return _arrowImageView;
}
-(UIView *)biuLine{
    
    if (_biuLine==nil) {
        _biuLine = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*19.3, SCREEN_WIDTH/375*49, SCREEN_WIDTH-SCREEN_WIDTH/375*19.3, SCREEN_WIDTH/375*1)];
    }
    return _biuLine;
}

-(ZMStarComponentView *)starView{
    
    if (_starView==nil) {
        _starView = [[ZMStarComponentView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*38.4-(SCREEN_WIDTH/375*13)*5-(SCREEN_WIDTH/375*3.4)*4,
                                                                          (SCREEN_WIDTH/375*50-SCREEN_WIDTH/375*12)/2,
                                                                          (SCREEN_WIDTH/375*13)*5+(SCREEN_WIDTH/375*3.4)*4,
                                                                          SCREEN_WIDTH/375*12)];
        //_starView.backgroundColor = [UIColor redColor];
    }
    return _starView;
}

@end
