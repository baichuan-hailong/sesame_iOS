//
//  ZMUserDataCerTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMUserDataCerTableViewCell.h"

@implementation ZMUserDataCerTableViewCell

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
                                    hex:@"333333"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*15]];
        [self.contentView addSubview:self.leftLabel];
        
        
        
        //right
        [ZMLabelAttributeMange setLabel:self.rightLabel
                                   text:@"--"
                                    hex:@"999999"
                          textAlignment:NSTextAlignmentRight
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
        [self.contentView addSubview:self.rightLabel];
        
        
        
        self.arrowImageView.image           = [UIImage imageNamed:@"gonext"];
        self.arrowImageView.contentMode     = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.arrowImageView];
        
        
        //self.line.backgroundColor = [UIColor colorWithHex:@"DEDEDE"];
        //[self.contentView addSubview:self.line];
        
    }
    return self;
}

- (void)setMoreTiele:(NSDictionary *)dic{
    self.leftLabel.text = [NSString stringWithFormat:@"%@",dic[@"left"]];
    
    self.rightLabel.text = [NSString stringWithFormat:@"%@",dic[@"right"]];
}


//left
-(UILabel *)leftLabel{
    if (_leftLabel==nil) {
        _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*31,
                                                               SCREEN_WIDTH/375*15,
                                                               SCREEN_WIDTH/375*100,
                                                               SCREEN_WIDTH/375*21)];
    }
    return _leftLabel;
}

//right
//left
-(UILabel *)rightLabel{
    if (_rightLabel==nil) {
        _rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*39-SCREEN_WIDTH/375*100,
                                                               SCREEN_WIDTH/375*15,
                                                               SCREEN_WIDTH/375*100,
                                                               SCREEN_WIDTH/375*21)];
    }
    return _rightLabel;
}



-(UIImageView *)arrowImageView{
    
    if (_arrowImageView==nil) {
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*19-SCREEN_WIDTH/375*8,
                                                                        (SCREEN_WIDTH/375*50-SCREEN_WIDTH/375*13)/2,
                                                                        SCREEN_WIDTH/375*8,
                                                                        SCREEN_WIDTH/375*13)];
    }
    return _arrowImageView;
}



@end
