//
//  ZMShareDetailCell.m
//  SesameService
//
//  Created by 娄耀文 on 17/3/29.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMShareDetailCell.h"

@implementation ZMShareDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setValueWithDic:(NSDictionary *)info {

    /** 项目信息 */
    if (self.tag == 0) {
        
        self.titleLable.text   = @"标的金额项目类型";
        self.contentLable.text = @"500W";
    } else if (self.tag == 1) {
        
        self.titleLable.text   = @"项目面积";
        self.contentLable.text = @"280亩";
    } else if (self.tag == 2) {
        
        self.titleLable.text   = @"开工时间";
        self.contentLable.text = @"2017年10月";
    } else if (self.tag == 3) {
        
        self.titleLable.text   = @"项目所在地";
        self.contentLable.text = @"发布国内及外商来华广告；广告信息咨询（不含中发布国内及外商来华广告；广告信息咨询（不含中发布国内及外商来华广告；广告信息咨询（不含中发布国内及外商来华广告；广告信息咨询（不含中发布国内及外商来华广告；广告信息咨询（不含中发布国内及外商来华广告；广告信息咨询（不含中发布国内及外商来华广告；广告信息咨询（不含中发布国内及外商来华广告；广告信息咨询（不含中";
    } else if (self.tag == 4) {
        
        self.titleLable.text   = @"甲方名称";
        self.contentLable.text = @"河北某公司";
    } else if (self.tag == 5) {
        
        self.titleLable.text   = @"工期";
        self.contentLable.text = @"设计、代理、制作、发布国内及外商来华广告；广告信息咨询（不含中介服务）；组织文化艺术交流活动。";
    }
    
    NSString *test = self.contentLable.text;
    CGSize size = CGSizeMake(SCREEN_WIDTH - SCREEN_WIDTH/3.41, 0);
    CGSize autoSize = [[UILabel new] actualSizeOfLable:test
                                                   andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/26.78] andSize:size];
    
    self.contentLable.frame = CGRectMake(CGRectGetMaxX(self.titleLable.frame) + SCREEN_WIDTH/22,
                                         (SCREEN_WIDTH/8.33 - SCREEN_WIDTH/26.78)/2,
                                         SCREEN_WIDTH - SCREEN_WIDTH/3.41,
                                         autoSize.height);
}

- (void)setValueWithDic:(NSDictionary *)info ofSection:(NSInteger)section {
    
    //code here...
    if (section == 2) {
        
        /** 项目信息 */
        if (self.tag == 0) {
            
            self.titleLable.text   = @"所在城市";
            self.contentLable.text = [[NSString stringWithFormat:@"%@",info[@"info"][@"biz_locate"]] stringByReplacingOccurrencesOfString:@"^" withString:@" "];
        } else if (self.tag == 1) {
            
            self.titleLable.text   = @"项目类型";
            self.contentLable.text = info[@"info"][@"type"];
        } else if (self.tag == 2) {
        
            self.titleLable.text   = @"预估标的额";
            self.contentLable.text = [[NSString stringWithFormat:@"%@",info[@"info"][@"target_amount"]] isEqualToString:@"<null>"] ? @"" : info[@"info"][@"target_amount"][@"title"];
        } else if (self.tag == 3) {
            
            self.titleLable.text   = @"消息有效期";
            self.contentLable.text = [toolClass changeTimeToDay:[NSString stringWithFormat:@"%@",info[@"info"][@"expire_time"]]];
        } else if (self.tag == 4) {
            
            self.titleLable.text   = @"甲方联系方式";
            self.contentLable.text = @"购买可见";
            self.contentLable.textColor = [UIColor colorWithHex:@"00bf8f"];
        } else if (self.tag == 5) {
            
            self.titleLable.text   = @"可提供的支持";
            self.contentLable.text = [[NSString stringWithFormat:@"%@",info[@"info"][@"support_level"]] isEqualToString:@"<null>"] ? @"" : info[@"info"][@"support_level"][@"title"];
        } else if (self.tag == 6) {
            
            self.titleLable.text   = @"项目说明";
            self.contentLable.text = info[@"info"][@"description"];
            //self.contentLable.textColor = [UIColor colorWithHex:@"00bf8f"];
        }
        
    }
    
    NSString *test = self.contentLable.text;
    CGSize size = CGSizeMake(SCREEN_WIDTH - SCREEN_WIDTH/3.41, 0);
    CGSize autoSize = [[UILabel new] actualSizeOfLable:test
                                               andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/26.78] andSize:size];
    
    self.contentLable.frame = CGRectMake(CGRectGetMaxX(self.titleLable.frame) + SCREEN_WIDTH/22,
                                         (SCREEN_WIDTH/8.33 - SCREEN_WIDTH/26.78)/2,
                                         SCREEN_WIDTH - SCREEN_WIDTH/3.41,
                                         autoSize.height);
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.line];
        [self.contentView addSubview:self.titleLable];
        [self.contentView addSubview:self.contentLable];
    }
    return self;
}

- (UIView *)line {

    if (_line == nil) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/25,
                                                         0,
                                                         SCREEN_WIDTH - SCREEN_WIDTH/12.5,
                                                         0.5)];
        _line.backgroundColor = [UIColor colorWithHex:@"e7e7e7"];
    }
    return _line;
}


- (UILabel *)titleLable {
    
    if (_titleLable == nil) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.frame = CGRectMake(SCREEN_WIDTH/25,
                                       /*self.backView.frame.size.height - SCREEN_WIDTH/8.33*/0,
                                       SCREEN_WIDTH/26.78 * 5.2,
                                       SCREEN_WIDTH/8.33);
        _titleLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78];
        _titleLable.textAlignment = NSTextAlignmentLeft;
        _titleLable.textColor = [UIColor colorWithHex:@"999999"];
        _titleLable.numberOfLines = 2;
    }
    return _titleLable;
}


- (UILabel *)contentLable {
    
    if (_contentLable == nil) {
        _contentLable = [[UILabel alloc] init];
        _contentLable.frame = CGRectMake(CGRectGetMaxX(self.titleLable.frame) + SCREEN_WIDTH/22,
                                        (SCREEN_WIDTH/8.33 - SCREEN_WIDTH/26.78)/2,
                                         SCREEN_WIDTH - SCREEN_WIDTH/3.41,
                                         SCREEN_WIDTH/26.78);
        _contentLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78];
        _contentLable.textAlignment = NSTextAlignmentLeft;
        _contentLable.numberOfLines = 0;
        _contentLable.textColor = [UIColor colorWithHex:@"333333"];
    }
    return _contentLable;
}




@end
