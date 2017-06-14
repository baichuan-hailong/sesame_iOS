//
//  ZMShareTopCell.m
//  SesameService
//
//  Created by 娄耀文 on 17/3/29.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMShareTopCell.h"

@implementation ZMShareTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setValueWithDic:(NSDictionary *)info {
    
    //code here...
    if (info != nil) {
        NSString *content = [NSString stringWithFormat:@"%@",info[@"info"][@"title"]];
        self.titleLable.text = content;
        CGSize titleSize = [content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - SCREEN_WIDTH/12.5, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:SCREEN_WIDTH/26.78]} context:nil].size;
        self.titleLable.height = titleSize.height + 3;
        
        self.expireLable.text = [NSString stringWithFormat:@"%@ 发布",[toolClass changeTimeToDay:[NSString stringWithFormat:@"%@",info[@"info"][@"time"]]]];
    }
 
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleLable];
        [self addSubview:self.expireLable];
        
    }
    return self;
}


- (UILabel *)titleLable {
    
    if (_titleLable == nil) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.frame = CGRectMake(SCREEN_WIDTH/25,
                                       SCREEN_WIDTH/25,
                                       SCREEN_WIDTH - SCREEN_WIDTH/12.5,
                                       0);
        _titleLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:3];
        _titleLable.textAlignment = NSTextAlignmentLeft;
        _titleLable.textColor = [UIColor colorWithHex:@"333333"];
        _titleLable.numberOfLines = 0;
    }
    return _titleLable;
}


- (UILabel *)expireLable {
    
    if (_expireLable == nil) {
        _expireLable = [[UILabel alloc] init];
        _expireLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        _expireLable.textAlignment = NSTextAlignmentLeft;
        _expireLable.textColor = [UIColor colorWithHex:@"999999"];
    }
    _expireLable.frame = CGRectMake(SCREEN_WIDTH/25,
                                    self.titleLable.bottom + SCREEN_WIDTH/53.57,
                                    SCREEN_WIDTH - SCREEN_WIDTH/12.5,
                                    SCREEN_WIDTH/31.25);
    return _expireLable;
}


@end
