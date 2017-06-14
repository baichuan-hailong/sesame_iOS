//
//  ZMAwardHonorInfoTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/5.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMAwardHonorInfoTableViewCell.h"

@interface ZMAwardHonorInfoTableViewCell ()
//left
@property(nonatomic,strong)UIImageView *leftPicImageView;
@property(nonatomic,strong)UILabel     *leftTipLable;
@property(nonatomic,strong)UILabel     *leftTimeLabel;

//right
@property(nonatomic,strong)UIImageView *rightPicImageView;
@property(nonatomic,strong)UILabel     *rightTipLable;
@property(nonatomic,strong)UILabel     *rightTimeLabel;
@end

@implementation ZMAwardHonorInfoTableViewCell

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
        self.leftView.layer.cornerRadius = SCREEN_WIDTH/375*4;
        self.leftView.layer.borderColor  = [UIColor colorWithHex:@"DDDDDD"].CGColor;
        self.leftView.layer.borderWidth  = SCREEN_WIDTH/375*0.5;
        self.leftView.layer.masksToBounds= YES;
        [self.contentView addSubview:self.leftView];
        
        self.leftPicImageView.backgroundColor = [UIColor lightGrayColor];
        self.leftPicImageView.contentMode     = UIViewContentModeScaleAspectFill;
        self.leftPicImageView.layer.masksToBounds=YES;
        [self.leftView addSubview:self.leftPicImageView];
        
        
        [ZMLabelAttributeMange setLabel:self.leftTipLable
                                   text:@"---"
                                    hex:@"333333"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.leftView addSubview:self.leftTipLable];
        
        [ZMLabelAttributeMange setLabel:self.leftTimeLabel
                                   text:@"---"
                                    hex:@"999999"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.leftView addSubview:self.leftTimeLabel];
        
        //right
        self.rightView.layer.cornerRadius = SCREEN_WIDTH/375*4;
        self.rightView.layer.borderColor  = [UIColor colorWithHex:@"DDDDDD"].CGColor;
        self.rightView.layer.borderWidth  = SCREEN_WIDTH/375*0.5;
        self.rightView.layer.masksToBounds= YES;
        [self.contentView addSubview:self.rightView];
        
        self.rightPicImageView.backgroundColor = [UIColor lightGrayColor];
        self.rightPicImageView.contentMode     = UIViewContentModeScaleAspectFill;
        self.rightPicImageView.layer.masksToBounds=YES;
        [self.rightView addSubview:self.rightPicImageView];
        
        
        [ZMLabelAttributeMange setLabel:self.rightTipLable
                                   text:@"---"
                                    hex:@"333333"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.rightView addSubview:self.rightTipLable];
        
        [ZMLabelAttributeMange setLabel:self.rightTimeLabel
                                   text:@"---"
                                    hex:@"999999"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
        [self.rightView addSubview:self.rightTimeLabel];
        
    }
    return self;
}

- (void)setAwardHonor:(NSDictionary *)leftDic right:(NSDictionary *)rightDic{

    //left
    NSString *leftUrl     = [NSString stringWithFormat:@"%@",leftDic[@"picture"]];
    NSString *title       = [NSString stringWithFormat:@"%@",leftDic[@"title"]];
    NSString *record_time = [NSString stringWithFormat:@"%@",leftDic[@"record_time"]];
    
    
    [self.leftPicImageView sd_setImageWithURL:[NSURL URLWithString:leftUrl]];
    self.leftTipLable.text = title;
    //self.leftTipLable.backgroundColor = [UIColor redColor];
    self.leftTimeLabel.text= [self timeChange:record_time];
    
    //right
    NSString *rightUrl         = [NSString stringWithFormat:@"%@",rightDic[@"picture"]];
    NSString *righttitle       = [NSString stringWithFormat:@"%@",rightDic[@"title"]];
    NSString *rightrecord_time = [NSString stringWithFormat:@"%@",rightDic[@"record_time"]];
    
    
    [self.rightPicImageView sd_setImageWithURL:[NSURL URLWithString:rightUrl]];
    self.rightTipLable.text = righttitle;
    //self.rightTipLable.backgroundColor = [UIColor orangeColor];
    self.rightTimeLabel.text= [self timeChange:rightrecord_time];
}


- (void)setAwardHonor:(NSDictionary *)leftDic{
    self.rightView.alpha = 0;
    
    
    NSString *leftUrl     = [NSString stringWithFormat:@"%@",leftDic[@"picture"]];
    NSString *title       = [NSString stringWithFormat:@"%@",leftDic[@"title"]];
    NSString *record_time = [NSString stringWithFormat:@"%@",leftDic[@"record_time"]];
    
    //left
    [self.leftPicImageView sd_setImageWithURL:[NSURL URLWithString:leftUrl]];
    self.leftTipLable.text = title;
    //self.leftTipLable.backgroundColor = [UIColor redColor];
    self.leftTimeLabel.text= [self timeChange:record_time];
}

#pragma mark - 时间戳转换为标准时间
- (NSString *)timeChange:(NSString *)timeStamp {
    NSTimeInterval time = [timeStamp doubleValue];// + 28800;  //因为时差问题要加8小时 == 28800
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSString *currentDateStr = [formatter stringFromDate: date];
    return currentDateStr;
}

//165  15 10
-(UIView *)leftView{
    if (!_leftView) {
        _leftView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*24,
                                                             SCREEN_WIDTH/375*10,
                                                             SCREEN_WIDTH/375*155,
                                                             SCREEN_WIDTH/375*165)];
    }
    return _leftView;
}

-(UIImageView *)leftPicImageView{
    if (!_leftPicImageView) {
        _leftPicImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*0,
                                                             SCREEN_WIDTH/375*0,
                                                             SCREEN_WIDTH/375*155,
                                                             SCREEN_WIDTH/375*117)];
    }
    return _leftPicImageView;
}

-(UILabel *)leftTipLable{
    if (!_leftTipLable) {
        _leftTipLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*7,
                                                             SCREEN_WIDTH/375*124,
                                                             SCREEN_WIDTH/375*138,
                                                             SCREEN_WIDTH/375*17)];
    }
    return _leftTipLable;
}

-(UILabel *)leftTimeLabel{
    if (!_leftTimeLabel) {
        _leftTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*7,
                                                                  SCREEN_WIDTH/375*144,
                                                                  SCREEN_WIDTH/375*138,
                                                                  SCREEN_WIDTH/375*16)];
    }
    return _leftTimeLabel;
}

//right
-(UIView *)rightView{
    if (!_rightView) {
        _rightView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*24-SCREEN_WIDTH/375*155,
                                                              SCREEN_WIDTH/375*10,
                                                              SCREEN_WIDTH/375*155,
                                                              SCREEN_WIDTH/375*165)];
    }
    return _rightView;
}

-(UIImageView *)rightPicImageView{
    if (!_rightPicImageView) {
        _rightPicImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*0,
                                                                          SCREEN_WIDTH/375*0,
                                                                          SCREEN_WIDTH/375*155,
                                                                          SCREEN_WIDTH/375*117)];
    }
    return _rightPicImageView;
}

-(UILabel *)rightTipLable{
    if (!_rightTipLable) {
        _rightTipLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*7,
                                                                  SCREEN_WIDTH/375*124,
                                                                  SCREEN_WIDTH/375*138,
                                                                  SCREEN_WIDTH/375*17)];
    }
    return _rightTipLable;
}

-(UILabel *)rightTimeLabel{
    if (!_rightTimeLabel) {
        _rightTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*7,
                                                                   SCREEN_WIDTH/375*144,
                                                                   SCREEN_WIDTH/375*138,
                                                                   SCREEN_WIDTH/375*16)];
    }
    return _rightTimeLabel;
}

@end
