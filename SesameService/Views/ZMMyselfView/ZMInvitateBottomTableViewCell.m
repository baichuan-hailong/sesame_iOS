//
//  ZMInvitateBottomTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/26.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMInvitateBottomTableViewCell.h"

@interface ZMInvitateBottomTableViewCell ()
@property (nonatomic , strong) UILabel      *titleLabel;
@property (nonatomic , strong) UILabel      *bodyLabel;
@end

@implementation ZMInvitateBottomTableViewCell

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
        
        self.backgroundColor = [UIColor whiteColor];
        //title
        [ZMLabelAttributeMange setLabel:self.titleLabel
                                   text:@"详细规则"
                                    hex:@"333333"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*13]];
        [self.contentView addSubview:self.titleLabel];
        
        
        //body
        [self.contentView addSubview:self.bodyLabel];
        //self.bodyLabel.backgroundColor = [UIColor redColor];
    }
    return self;
}



- (void)setRule:(NSString *)rule{
    
    [ZMLabelAttributeMange setLabel:self.bodyLabel
                               text:rule
                                hex:@"666666"
                      textAlignment:NSTextAlignmentLeft
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
    [ZMLabelAttributeMange setLineSpacing:self.bodyLabel str:self.bodyLabel.text];
}


//lazy
-(UILabel *)titleLabel{
    if (_titleLabel==nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                                SCREEN_WIDTH/375*16,
                                                                SCREEN_WIDTH/375*200,
                                                                SCREEN_WIDTH/375*18)];
    }
    return _titleLabel;
}


-(UILabel *)bodyLabel{
    if (_bodyLabel==nil) {
        _bodyLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                                SCREEN_WIDTH/375*40,
                                                                SCREEN_WIDTH-SCREEN_WIDTH/375*35,
                                                                SCREEN_WIDTH/375*140)];
    }
    return _bodyLabel;
}

@end
