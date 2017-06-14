//
//  ZMExitTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/23.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMExitTableViewCell.h"

@implementation ZMExitTableViewCell

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
        
        self.exitlLabel.textColor     = [UIColor colorWithHex:@"FA4A4A"];
        self.exitlLabel.textAlignment = NSTextAlignmentCenter;
        self.exitlLabel.font = [UIFont systemFontOfSize:SCREEN_WIDTH/375*16];
        self.exitlLabel.text = @"退出登录";
        [self.contentView addSubview:self.exitlLabel];
        
        
    }
    return self;
}

//lazy
-(UILabel *)exitlLabel{
    if (_exitlLabel==nil) {
        _exitlLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/375*50)];
    }
    return _exitlLabel;
}

@end
