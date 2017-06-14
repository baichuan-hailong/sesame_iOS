//
//  ZMInvitationMoneyTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/25.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMInvitationMoneyTableViewCell.h"

@interface ZMInvitationMoneyTableViewCell ()
@property (nonatomic , strong) UIView      *middleLine;
@property (nonatomic , strong) UILabel     *leftTipLabel;
@property (nonatomic , strong) UILabel     *rightTipLabel;
@end

@implementation ZMInvitationMoneyTableViewCell

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
        
        //count
        [ZMLabelAttributeMange setLabel:self.countLabel
                                   text:@"--"
                                    hex:tonalColor
                          textAlignment:NSTextAlignmentCenter
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*30]];
        [self.contentView addSubview:self.countLabel];
        //self.countLabel.backgroundColor = [UIColor redColor];
        
        [ZMLabelAttributeMange setLabel:self.countTipLabel
                                   text:@"位"
                                    hex:@"333333"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.countTipLabel];
        
        [ZMLabelAttributeMange setLabel:self.leftTipLabel
                                   text:@"已邀请好友"
                                    hex:@"666666"
                          textAlignment:NSTextAlignmentCenter
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.leftTipLabel];
        
        //money
        [ZMLabelAttributeMange setLabel:self.moneyLabel
                                   text:@"--"
                                    hex:tonalColor
                          textAlignment:NSTextAlignmentCenter
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*30]];
        [self.contentView addSubview:self.moneyLabel];
        //self.moneyLabel.backgroundColor = [UIColor redColor];
        
        [ZMLabelAttributeMange setLabel:self.moneyTipLabel
                                   text:@"元"
                                    hex:@"333333"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.moneyTipLabel];
        
        [ZMLabelAttributeMange setLabel:self.rightTipLabel
                                   text:@"累计获得奖金"
                                    hex:@"666666"
                          textAlignment:NSTextAlignmentCenter
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.contentView addSubview:self.rightTipLabel];
        
        //line
        self.middleLine.backgroundColor = [UIColor colorWithHex:@"979797"];
        [self.contentView addSubview:self.middleLine];
        
    }
    return self;
}

- (void)setTopMoney:(NSDictionary *)topDic{
    NSString *count = [NSString stringWithFormat:@"%@",topDic[@"count"]];
    NSString *money = [NSString stringWithFormat:@"%@",topDic[@"money"]];
    self.moneyLabel.text = money;
    self.countLabel.text = count;
    
    [self.countLabel sizeToFit];
    [self.moneyLabel sizeToFit];
    
    self.moneyLabel.frame = CGRectMake(SCREEN_WIDTH/375*141+(SCREEN_WIDTH-SCREEN_WIDTH/375*141-self.moneyLabel.frame.size.width)/2,
                                       SCREEN_WIDTH/375*9,
                                       self.moneyLabel.frame.size.width,
                                       SCREEN_WIDTH/375*42);
    
    self.moneyTipLabel.frame = CGRectMake(CGRectGetMaxX(self.moneyLabel.frame)+SCREEN_WIDTH/375*7,
                                    SCREEN_WIDTH/375*27,
                                    SCREEN_WIDTH/375*12,
                                    SCREEN_WIDTH/375*17);
    
    self.countLabel.frame = CGRectMake((SCREEN_WIDTH/375*141-self.countLabel.frame.size.width)/2,
                                       SCREEN_WIDTH/375*9,
                                       self.countLabel.frame.size.width,
                                       SCREEN_WIDTH/375*42);
    
    self.countTipLabel.frame = CGRectMake(CGRectGetMaxX(self.countLabel.frame)+SCREEN_WIDTH/375*7,
                                          SCREEN_WIDTH/375*27,
                                          SCREEN_WIDTH/375*12,
                                          SCREEN_WIDTH/375*17);
}


-(UIView *)middleLine{
    if (_middleLine==nil) {
        _middleLine = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*141.8,
                                                                SCREEN_WIDTH/375*29.1,
                                                                SCREEN_WIDTH/375*1,
                                                                SCREEN_WIDTH/375*27.4)];
    }
    return _middleLine;
}

//count
-(UILabel *)countLabel{
    if (_countLabel==nil) {
        _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*52,
                                                               SCREEN_WIDTH/375*9,
                                                               SCREEN_WIDTH/375*18,
                                                               SCREEN_WIDTH/375*42)];
    }
    return _countLabel;
}

-(UILabel *)countTipLabel{
    if (_countTipLabel==nil) {
        _countTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.countLabel.frame)+SCREEN_WIDTH/375*7,
                                                                   SCREEN_WIDTH/375*27,
                                                                   SCREEN_WIDTH/375*12,
                                                                   SCREEN_WIDTH/375*17)];
    }
    return _countTipLabel;
}


-(UILabel *)leftTipLabel{
    if (_leftTipLabel==nil) {
        _leftTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*30,
                                                                SCREEN_WIDTH/375*51,
                                                                SCREEN_WIDTH/375*80,
                                                                SCREEN_WIDTH/375*17)];
    }
    return _leftTipLabel;
}

//money
-(UILabel *)moneyLabel{
    if (_moneyLabel==nil) {
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*186,
                                                                SCREEN_WIDTH/375*9,
                                                                SCREEN_WIDTH/375*129,
                                                                SCREEN_WIDTH/375*42)];
    }
    return _moneyLabel;
}

-(UILabel *)moneyTipLabel{
    if (_moneyTipLabel==nil) {
        _moneyTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.moneyLabel.frame)+SCREEN_WIDTH/375*7,
                                                                   SCREEN_WIDTH/375*27,
                                                                   SCREEN_WIDTH/375*12,
                                                                   SCREEN_WIDTH/375*17)];
    }
    return _moneyTipLabel;
}

-(UILabel *)rightTipLabel{
    if (_rightTipLabel==nil) {
        _rightTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*219,
                                                                  SCREEN_WIDTH/375*51,
                                                                  SCREEN_WIDTH/375*80,
                                                                  SCREEN_WIDTH/375*17)];
    }
    return _rightTipLabel;
}


@end
