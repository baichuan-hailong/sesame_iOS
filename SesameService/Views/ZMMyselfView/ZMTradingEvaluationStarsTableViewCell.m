//
//  ZMTradingEvaluationStarsTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMTradingEvaluationStarsTableViewCell.h"

@implementation ZMTradingEvaluationStarsTableViewCell

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
        
        //信息
        //self.xinxiStarView.backgroundColor = [UIColor orangeColor];
        [self.xinxiStarView starInit:0];
        [self.contentView addSubview:self.xinxiStarView];
        
        
        [ZMLabelAttributeMange setLabel:self.xinxiLabel
                                   text:@"信息可靠："
                                    hex:@"666666"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
        [self.contentView addSubview:self.xinxiLabel];
        
        //关系
        //self.guanxiStarView.backgroundColor = [UIColor orangeColor];
        [self.guanxiStarView starInit:0];
        [self.contentView addSubview:self.guanxiStarView];
        
        [ZMLabelAttributeMange setLabel:self.guanxiLabel
                                   text:@"关系到位："
                                    hex:@"666666"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
        [self.contentView addSubview:self.guanxiLabel];
        
        //价格
        //self.jiageStarView.backgroundColor = [UIColor orangeColor];
        [self.jiageStarView starInit:0];
        [self.contentView addSubview:self.jiageStarView];
        
        [ZMLabelAttributeMange setLabel:self.jiageLabel
                                   text:@"价格合理："
                                    hex:@"666666"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
        [self.contentView addSubview:self.jiageLabel];
        
        //项目
        //self.xiangmuStarView.backgroundColor = [UIColor orangeColor];
        [self.xiangmuStarView starInit:0];
        [self.contentView addSubview:self.xiangmuStarView];
        
        [ZMLabelAttributeMange setLabel:self.xiangmuLabel
                                   text:@"项目价值："
                                    hex:@"666666"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
        [self.contentView addSubview:self.xiangmuLabel];
        
        
        //tip
        [ZMLabelAttributeMange setLabel:self.tipLabel
                                   text:@"--- ---"
                                    hex:@"333333"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*16]];
        //self.tipLabel.numberOfLines = 0;
        //self.tipLabel.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.tipLabel];
        
    }
    return self;
}


- (void)setEvaluationStars:(NSDictionary *)starDic{
    
    NSString *reliable = [NSString stringWithFormat:@"%@",starDic[@"reliable"]];
    NSString *relation = [NSString stringWithFormat:@"%@",starDic[@"relation"]];
    NSString *price    = [NSString stringWithFormat:@"%@",starDic[@"price"]];
    NSString *project  = [NSString stringWithFormat:@"%@",starDic[@"project"]];
    NSString *content  = [NSString stringWithFormat:@"%@",starDic[@"content"]];
    
    NSLog(@"%@",starDic);
    
    //信息
    [self.xinxiStarView starInit:[reliable integerValue]];
    //关系
    [self.guanxiStarView starInit:[relation integerValue]];
    //价格
    [self.jiageStarView starInit:[price integerValue]];
    //项目
    [self.xiangmuStarView starInit:[project integerValue]];

    
    
    
    //content
    CGSize   size   = CGSizeMake(SCREEN_WIDTH-SCREEN_WIDTH/375*19.5-SCREEN_WIDTH/375*15, 0);
    CGSize autoSize = [[UILabel new] actualSizeOfLineSpaceLable:[NSString stringWithFormat:@"%@",content]
                                                        andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/375*16]
                                                        andSize:size];
    
    //self.tipLabel.backgroundColor = [UIColor redColor];
    self.tipLabel.numberOfLines = 0;
    //tip
    if (content.length>0&&![content isEqualToString:@"(null)"]&&![content isEqualToString:@"<null>"]) {
        self.tipLabel.text = content;
        [self.tipLabel size];
        [ZMLabelAttributeMange setLineSpacing:self.tipLabel str:content];
    }else{
        self.tipLabel.text = @"";
    }
    
    
    self.tipLabel.frame = CGRectMake(SCREEN_WIDTH/375*19.5,
                                     SCREEN_WIDTH/375*156.6,
                                     SCREEN_WIDTH-SCREEN_WIDTH/375*19.5-SCREEN_WIDTH/375*15,
                                     autoSize.height);
}


//信息
-(ZMStarTradingEvaluationView *)xinxiStarView{
    if (_xinxiStarView==nil) {
        _xinxiStarView = [[ZMStarTradingEvaluationView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*89.8,
                                                                                       SCREEN_WIDTH/375*24,
                                                                                       SCREEN_WIDTH/375*100,
                                                                                       SCREEN_WIDTH/375*14.5)];
    }
    return _xinxiStarView;
}

-(UILabel *)xinxiLabel{
    if (_xinxiLabel==nil) {
        _xinxiLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                   SCREEN_WIDTH/375*24-(SCREEN_WIDTH/375*20-SCREEN_WIDTH/375*14.5)/2,
                                                   SCREEN_WIDTH/375*79,
                                                   SCREEN_WIDTH/375*20)];
    }
    return _xinxiLabel;
}


//关系
-(ZMStarTradingEvaluationView *)guanxiStarView{
    if (_guanxiStarView==nil) {
        _guanxiStarView = [[ZMStarTradingEvaluationView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*89.8,
                                                                                       SCREEN_WIDTH/375*55,
                                                                                       SCREEN_WIDTH/375*100,
                                                                                       SCREEN_WIDTH/375*14.5)];
    }
    return _guanxiStarView;
}

-(UILabel *)guanxiLabel{
    if (_guanxiLabel==nil) {
        _guanxiLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                    SCREEN_WIDTH/375*55-(SCREEN_WIDTH/375*20-SCREEN_WIDTH/375*14.5)/2,
                                                    SCREEN_WIDTH/375*79,
                                                    SCREEN_WIDTH/375*20)];
    }
    return _guanxiLabel;
}

//价格
-(ZMStarTradingEvaluationView *)jiageStarView{
    if (_jiageStarView==nil) {
        _jiageStarView = [[ZMStarTradingEvaluationView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*89.8,
                                                                                        SCREEN_WIDTH/375*85,
                                                                                        SCREEN_WIDTH/375*100,
                                                                                        SCREEN_WIDTH/375*14.5)];
    }
    return _jiageStarView;
}

-(UILabel *)jiageLabel{
    if (_jiageLabel==nil) {
        _jiageLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                    SCREEN_WIDTH/375*85-(SCREEN_WIDTH/375*20-SCREEN_WIDTH/375*14.5)/2,
                                                    SCREEN_WIDTH/375*79,
                                                    SCREEN_WIDTH/375*20)];
    }
    return _jiageLabel;
}

//项目
-(ZMStarTradingEvaluationView *)xiangmuStarView{
    if (_xiangmuStarView==nil) {
        _xiangmuStarView = [[ZMStarTradingEvaluationView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*89.8,
                                                                                        SCREEN_WIDTH/375*114,
                                                                                        SCREEN_WIDTH/375*100,
                                                                                        SCREEN_WIDTH/375*14.5)];
    }
    return _xiangmuStarView;
}


-(UILabel *)xiangmuLabel{
    if (_xiangmuLabel==nil) {
        _xiangmuLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*20,
                                                SCREEN_WIDTH/375*114-(SCREEN_WIDTH/375*20-SCREEN_WIDTH/375*14.5)/2,
                                                SCREEN_WIDTH/375*79,
                                                SCREEN_WIDTH/375*20)];
    }
    return _xiangmuLabel;
}

//tip
-(UILabel *)tipLabel{
    if (_tipLabel==nil) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*19.5,
                                                          SCREEN_WIDTH/375*156.6,
                                                          SCREEN_WIDTH-SCREEN_WIDTH/375*19.5-SCREEN_WIDTH/375*15,
                                                          SCREEN_WIDTH/375*0)];
    }
    return _tipLabel;
}


@end
