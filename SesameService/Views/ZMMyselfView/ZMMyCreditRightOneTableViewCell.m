//
//  ZMMyCreditRightOneTableViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/13.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMMyCreditRightOneTableViewCell.h"

@implementation ZMMyCreditRightOneTableViewCell

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
        
        self.backgroundColor                 = [UIColor whiteColor];
        UIView *headerView         = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_WIDTH/375*0, SCREEN_WIDTH, SCREEN_WIDTH/375*195)];
        headerView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:headerView];
        
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/375*35)];
        topView.backgroundColor = [UIColor colorWithHex:backGroundColor];
        //topView.backgroundColor = [UIColor redColor];
        
        UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*13, 0, SCREEN_WIDTH, SCREEN_WIDTH/375*35)];
        topLabel.backgroundColor = [UIColor colorWithHex:backGroundColor];
        [ZMLabelAttributeMange setLabel:topLabel
                                   text:@"保持良好的信用习惯"
                                    hex:@"333333"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*13]];
        [headerView addSubview:topView];
        [topView addSubview:topLabel];
        
        
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_WIDTH/375*160, SCREEN_WIDTH, SCREEN_WIDTH/375*35)];
        bottomView.backgroundColor = [UIColor colorWithHex:backGroundColor];
        //topView.backgroundColor = [UIColor redColor];
        
        UILabel *bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*13, 0, SCREEN_WIDTH, SCREEN_WIDTH/375*35)];
        bottomLabel.backgroundColor = [UIColor colorWithHex:backGroundColor];
        [ZMLabelAttributeMange setLabel:bottomLabel
                                   text:@"完善企业信息"
                                    hex:@"333333"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*13]];
        [headerView addSubview:bottomView];
        [bottomView addSubview:bottomLabel];
        
        
        //one
        UILabel *oneLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*16, SCREEN_WIDTH/375*45, SCREEN_WIDTH, SCREEN_WIDTH/375*35)];
        [ZMLabelAttributeMange setLabel:oneLabel
                                   text:@".多发布优质商机信息，收获更多好评"
                                    hex:@"333333"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
        [headerView addSubview:oneLabel];
        
        //two
        UILabel *twoLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*16, SCREEN_WIDTH/375*80, SCREEN_WIDTH, SCREEN_WIDTH/375*35)];
        [ZMLabelAttributeMange setLabel:twoLabel
                                   text:@".多购买平台商机信息，证明您的行业服务实力"
                                    hex:@"333333"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
        [headerView addSubview:twoLabel];
        
        //three
        UILabel *threeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*16, SCREEN_WIDTH/375*115, SCREEN_WIDTH, SCREEN_WIDTH/375*35)];
        [ZMLabelAttributeMange setLabel:threeLabel
                                   text:@".丰富人脉关系，建立良好的口碑"
                                    hex:@"333333"
                          textAlignment:NSTextAlignmentLeft
                                   font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
        [headerView addSubview:threeLabel];
    }
    return self;
}


#pragma mark - RightHeaderView
- (void)rihtHeaderView{
    
}

@end
