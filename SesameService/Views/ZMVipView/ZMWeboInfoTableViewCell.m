//
//  ZMWeboInfoTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/5.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMWeboInfoTableViewCell.h"

@implementation ZMWeboInfoTableViewCell

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
    
        
        [ZMLabelAttributeMange setLabel:self.weboLabel
                                   text:@"会员尚未填写"
                                    hex:@"999999"
                          textAlignment:NSTextAlignmentCenter
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
        [self.contentView addSubview:self.weboLabel];
        
    }
    return self;
}


//20 20 35
//lazy
-(UILabel *)weboLabel{
    if (!_weboLabel) {
        _weboLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20, SCREEN_WIDTH/375*20, SCREEN_WIDTH-SCREEN_WIDTH/375*40, SCREEN_WIDTH/375*20)];
    }
    return _weboLabel;
}

@end
