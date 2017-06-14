//
//  ZMMyMoreTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/24.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMMyMoreTableViewCell.h"

@implementation ZMMyMoreTableViewCell

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
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
        [self.contentView addSubview:self.leftLabel];
        
        
        self.arrowImageView.image = [UIImage imageNamed:@"gonext"];
        self.arrowImageView.contentMode     = UIViewContentModeScaleAspectFit;
        //self.arrowImageView.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:self.arrowImageView];
        
        
        self.line.backgroundColor = [UIColor colorWithHex:@"D8D8D8"];
        //self.line.backgroundColor = [UIColor redColor];
        //self.line.alpha = 0;
        [self.contentView addSubview:self.line];
        
    }
    return self;
}

- (void)setMoreTiele:(NSDictionary *)dic{
    self.leftLabel.text = [NSString stringWithFormat:@"%@",dic[@"left"]];
}


//left
-(UILabel *)leftLabel{
    if (_leftLabel==nil) {
        _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*21,
                                                               SCREEN_WIDTH/375*12,
                                                               SCREEN_WIDTH/375*200,
                                                               SCREEN_WIDTH/375*20)];
    }
    return _leftLabel;
}


-(UIImageView *)arrowImageView{
    
    if (_arrowImageView==nil) {
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*19-SCREEN_WIDTH/375*8,
                                                                        (SCREEN_WIDTH/375*45-SCREEN_WIDTH/375*13)/2,
                                                                        SCREEN_WIDTH/375*8,
                                                                        SCREEN_WIDTH/375*13)];
        //_arrowImageView.backgroundColor = [UIColor redColor];
    }
    return _arrowImageView;
}


-(UIView *)line{
    if (_line==nil) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*0,
                                                               SCREEN_WIDTH/375*44.5,
                                                               SCREEN_WIDTH,
                                                               SCREEN_WIDTH/375*0.5)];
    }
    return _line;
}


@end
