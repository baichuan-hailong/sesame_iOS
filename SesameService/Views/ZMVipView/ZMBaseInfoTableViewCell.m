//
//  ZMBaseInfoTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/5.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMBaseInfoTableViewCell.h"

@implementation ZMBaseInfoTableViewCell

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
                                   text:@"---"
                                    hex:@"666666"
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
    }
    return self;
}

- (void)setBaseInfoCell:(NSDictionary *)baseDic{
    self.leftLabel.text = baseDic[@"left"];
    
    

    
    NSString *right = [NSString stringWithFormat:@"%@",baseDic[@"right"]];
    CGSize size = CGSizeMake(SCREEN_WIDTH-SCREEN_WIDTH/375*101-SCREEN_WIDTH/375*20, 0);
    CGSize autoSize = [[UILabel new] actualSizeOfLineSpaceLable:right
                                                        andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]
                                                        andSize:size];
    if (autoSize.height>25) {
        self.rightLabel.numberOfLines = 0;
        [ZMLabelAttributeMange setLineSpacing:self.rightLabel
                                          str:baseDic[@"right"]
                                        space:SCREEN_WIDTH/375*4];
    }else{
        self.rightLabel.text = baseDic[@"right"];
    }

}

//43 1
//lazy
-(UILabel *)leftLabel{
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*21,
                                                               SCREEN_WIDTH/375*11,
                                                               SCREEN_WIDTH/375*60,
                                                               SCREEN_WIDTH/375*20)];
    }
    return _leftLabel;
}

//right
-(UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*101,
                                                                SCREEN_WIDTH/375*11,
                                                                SCREEN_WIDTH-SCREEN_WIDTH/375*101-SCREEN_WIDTH/375*20,
                                                                SCREEN_WIDTH/375*20)];
    }
    return _rightLabel;
}


//line
-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*18, SCREEN_WIDTH/375*43, SCREEN_WIDTH-SCREEN_WIDTH/375*35, SCREEN_WIDTH/375*1)];
    }
    return _line;
}


@end
