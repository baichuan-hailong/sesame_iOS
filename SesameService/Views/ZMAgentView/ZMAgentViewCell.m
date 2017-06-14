//
//  ZMAgentViewCell.m
//  SesameService
//
//  Created by 娄耀文 on 17/3/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMAgentViewCell.h"

@implementation ZMAgentViewCell

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

    self.titleLable.text   = @"寻求创意广告营销和品牌升级服务";
    self.publishLable.text = @"发布日期：2016-12-12";
    self.agentAreaLable.text = @"代理区域：北京";
    self.agentPriceLable.text = @"代理佣金：5%";
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor colorWithHex:backColor];
        [self.contentView addSubview:self.backView];
        [self.backView addSubview:self.titleLable];
        [self.backView addSubview:self.agentAreaView];
        [self.backView addSubview:self.agentPriceView];
        [self.agentAreaView addSubview:self.agentAreaImg];
        [self.agentAreaView addSubview:self.agentAreaLable];
        [self.agentPriceView addSubview:self.agentPriceImg];
        [self.agentPriceView addSubview:self.agentPriceLable];
        
        [self.backView addSubview:self.detailLable];
        [self.backView addSubview:self.footView];
        [self.footView addSubview:self.publishLable];
        
    }
    return self;
}


- (UIView *)backView {
    
    if (_backView == nil) {
        _backView = [[UIView alloc] init];
        _backView.frame = CGRectMake(SCREEN_WIDTH/25, 12, SCREEN_WIDTH - SCREEN_WIDTH/12.5, SCREEN_WIDTH/2.35);
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.borderColor = [UIColor colorWithHex:@"dddddd"].CGColor;
        _backView.layer.borderWidth = 0.5;
        _backView.layer.cornerRadius = 8;
        _backView.layer.masksToBounds = YES;
        
        
    }
    return _backView;
}

- (UILabel *)titleLable {
    
    if (_titleLable == nil) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.frame = CGRectMake(SCREEN_WIDTH/25,
                                       SCREEN_WIDTH/26.78,
                                       SCREEN_WIDTH/1.35,
                                       SCREEN_WIDTH/26.78);
        _titleLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:3];
        _titleLable.textAlignment = NSTextAlignmentLeft;
        _titleLable.textColor = [UIColor colorWithHex:@"333333"];
    }
    return _titleLable;
}

/** 代理区域 */
- (UIView *)agentAreaView {

    if (_agentAreaView == nil) {
        _agentAreaView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/25,
                                                                  CGRectGetMaxY(self.titleLable.frame) + SCREEN_WIDTH/36,
                                                                  (self.backView.frame.size.width - SCREEN_WIDTH/12.5)/2,
                                                                  SCREEN_WIDTH/28.85)];
    }
    return _agentAreaView;
}

- (UIImageView *)agentAreaImg {

    if (_agentAreaImg == nil) {
        _agentAreaImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH/28.85)/1.3, SCREEN_WIDTH/28.85)];
        _agentAreaImg.image = [UIImage imageNamed:@"agentArea"];
    }
    return _agentAreaImg;
}

- (UILabel *)agentAreaLable {
    
    if (_agentAreaLable == nil) {
        _agentAreaLable = [[UILabel alloc] init];
        _agentAreaLable.frame = CGRectMake(CGRectGetMaxX(self.agentAreaImg.frame) + 5,
                                           0,
                                           self.agentAreaView.frame.size.width - self.agentAreaImg.frame.size.width - 5,
                                           SCREEN_WIDTH/31.25);
        _agentAreaLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        _agentAreaLable.textAlignment = NSTextAlignmentLeft;
        _agentAreaLable.textColor = [UIColor colorWithHex:@"666666"];
    }
    return _agentAreaLable;
}


/** 代理价格 */
- (UIView *)agentPriceView {
    
    if (_agentPriceView == nil) {
        _agentPriceView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.agentAreaView.frame),
                                                                   CGRectGetMaxY(self.titleLable.frame) + SCREEN_WIDTH/36,
                                                                  (self.backView.frame.size.width - SCREEN_WIDTH/12.5)/2,
                                                                   SCREEN_WIDTH/28.85)];
    }
    return _agentPriceView;
}

- (UIImageView *)agentPriceImg {
    
    if (_agentPriceImg == nil) {
        _agentPriceImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH/28.85)/1.09, SCREEN_WIDTH/28.85)];
        _agentPriceImg.image = [UIImage imageNamed:@"agentPrice"];
    }
    return _agentPriceImg;
}

- (UILabel *)agentPriceLable {
    
    if (_agentPriceLable == nil) {
        _agentPriceLable = [[UILabel alloc] init];
        _agentPriceLable.frame = CGRectMake(CGRectGetMaxX(self.agentPriceImg.frame) + 5,
                                            0,
                                            self.agentPriceView.frame.size.width - self.agentPriceImg.frame.size.width - 5,
                                            SCREEN_WIDTH/31.25);
        _agentPriceLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        _agentPriceLable.textAlignment = NSTextAlignmentLeft;
        _agentPriceLable.textColor = [UIColor colorWithHex:@"666666"];
    }
    return _agentPriceLable;
}



/** detailInfo */
- (UILabel *)detailLable {
    
    if (_detailLable == nil) {
        _detailLable = [[UILabel alloc] init];
        _detailLable.frame = CGRectMake(SCREEN_WIDTH/25,
                                        CGRectGetMaxY(self.agentAreaView.frame) + SCREEN_WIDTH/36,
                                        self.backView.frame.size.width - SCREEN_WIDTH/12.5,
                                        SCREEN_WIDTH/31.25);
        _detailLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        _detailLable.textAlignment = NSTextAlignmentLeft;
        _detailLable.textColor = [UIColor colorWithHex:@"666666"];
        _detailLable.numberOfLines = 3;
        _detailLable.text = @"随着市场需求不断增涨，预计在未来的3年内，我爱我家将至少再发展10余个城市";
        [_detailLable sizeToFit];
    }
    return _detailLable;
}




- (UIView *)footView {
    
    if (_footView == nil) {
        _footView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                             self.backView.frame.size.height - self.backView.frame.size.height/3.55,
                                                             self.backView.frame.size.width,
                                                             self.backView.frame.size.height/4)];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _footView.frame.size.width, 0.5)];
        line.backgroundColor = [UIColor colorWithHex:@"dddddd"];
        [_footView addSubview:line];
    }
    return _footView;
}

- (UILabel *)publishLable {
    
    if (_publishLable == nil) {
        _publishLable = [[UILabel alloc] init];
        _publishLable.frame = CGRectMake(SCREEN_WIDTH/25,
                                        (self.footView.frame.size.height - SCREEN_WIDTH/31.25)/2,
                                         SCREEN_WIDTH/2,
                                         SCREEN_WIDTH/31.25);
        _publishLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        _publishLable.textAlignment = NSTextAlignmentLeft;
        _publishLable.textColor = [UIColor colorWithHex:@"999999"];
    }
    return _publishLable;
}




@end
