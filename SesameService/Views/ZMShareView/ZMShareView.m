//
//  ZMShareView.m
//  SesameService
//
//  Created by 娄耀文 on 17/3/24.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMShareView.h"

@implementation ZMShareView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.shareTableView];
}


- (UITableView *)shareTableView {
    
    if (_shareTableView == nil) {
        _shareTableView = [[UITableView alloc] init];
        _shareTableView.frame = CGRectMake(0,
                                           64,
                                           SCREEN_WIDTH,
                                           SCREEN_HEIGHT - 64);
        _shareTableView.backgroundColor = [UIColor colorWithHex:backColor];
        _shareTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        //_shareTableView.showsVerticalScrollIndicator = NO;
        
        
        _shareTableView.tableHeaderView = ({
            
            UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/3)];
            headView.backgroundColor = [UIColor whiteColor];
            headView.layer.borderColor = [UIColor colorWithHex:@"dddddd"].CGColor;
            headView.layer.borderWidth = 0.5;
            
            /** title */
            UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                            SCREEN_WIDTH/37.5,
                                                                            SCREEN_WIDTH,
                                                                            SCREEN_WIDTH/26.78)];
            titleLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:1];
            titleLable.textAlignment = NSTextAlignmentCenter;
            titleLable.textColor = [UIColor colorWithHex:@"666666"];
            titleLable.text = @"信息能换钱，只需3步";

            /** content */
            UILabel *oneLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/7.8,
                                                                   titleLable.bottom + SCREEN_WIDTH/25,
                                                                   SCREEN_WIDTH/15,
                                                                   SCREEN_WIDTH/15)];
            oneLable.backgroundColor = [UIColor colorWithHex:tonalColor];
            oneLable.textColor = [UIColor whiteColor];
            oneLable.textAlignment = NSTextAlignmentCenter;
            oneLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:6];
            oneLable.text = @"1";
            oneLable.layer.masksToBounds = YES;
            oneLable.layer.cornerRadius = SCREEN_WIDTH/30;

            UILabel *twoLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - (SCREEN_WIDTH/15)/2,
                                                                          titleLable.bottom + SCREEN_WIDTH/25,
                                                                          SCREEN_WIDTH/15,
                                                                          SCREEN_WIDTH/15)];
            twoLable.backgroundColor = [UIColor colorWithHex:tonalColor];
            twoLable.textColor = [UIColor whiteColor];
            twoLable.textAlignment = NSTextAlignmentCenter;
            twoLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:6];
            twoLable.text = @"2";
            twoLable.layer.masksToBounds = YES;
            twoLable.layer.cornerRadius = SCREEN_WIDTH/30;

    

            UILabel *threeLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - SCREEN_WIDTH/7.8 - SCREEN_WIDTH/15,
                                                                            titleLable.bottom + SCREEN_WIDTH/25,
                                                                            SCREEN_WIDTH/15,
                                                                            SCREEN_WIDTH/15)];
            threeLable.backgroundColor = [UIColor colorWithHex:tonalColor];
            threeLable.textColor = [UIColor whiteColor];
            threeLable.textAlignment = NSTextAlignmentCenter;
            threeLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78 weight:6];
            threeLable.text = @"3";
            threeLable.layer.masksToBounds = YES;
            threeLable.layer.cornerRadius = SCREEN_WIDTH/30;

            UIView *line1 = [[UIView alloc] init];
            
            line1.width   = SCREEN_WIDTH/12.5;
            line1.height  = 1;
            line1.centerX = SCREEN_WIDTH/3;
            line1.centerY = twoLable.centerY;
            line1.backgroundColor = [UIColor colorWithHex:@"979797"];

            UIView *line2 = [[UIView alloc] init];
            line2.width   = SCREEN_WIDTH/12.5;
            line2.height  = 1;
            line2.centerX = (SCREEN_WIDTH/3)*2;
            line2.centerY = twoLable.centerY;
            line2.backgroundColor = [UIColor colorWithHex:@"979797"];
            
            
            UILabel *tipsLable1 = [[UILabel alloc] init];
            tipsLable1.width = SCREEN_WIDTH/4.17;
            tipsLable1.height = SCREEN_WIDTH/31.25;
            tipsLable1.centerX = oneLable.centerX;
            tipsLable1.y = oneLable.bottom + SCREEN_WIDTH/46.875;
            tipsLable1.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
            tipsLable1.textAlignment = NSTextAlignmentCenter;
            tipsLable1.textColor = [UIColor colorWithHex:@"666666"];
            tipsLable1.text = @"发布信息";

            UILabel *tipsLable2 = [[UILabel alloc] init];
            tipsLable2.width = SCREEN_WIDTH/4.17;
            tipsLable2.centerX = twoLable.centerX;
            tipsLable2.y = twoLable.bottom + SCREEN_WIDTH/46.875;
            
            tipsLable2.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
            tipsLable2.numberOfLines = 0;
            tipsLable2.textAlignment = NSTextAlignmentCenter;
            tipsLable2.textColor = [UIColor colorWithHex:@"666666"];
            tipsLable2.text = @"其他会员购买您的信息";
            [tipsLable2 sizeToFit];
            
            UILabel *tipsLable3 = [[UILabel alloc] init];
            tipsLable3.width = SCREEN_WIDTH/4.17;
            tipsLable3.height = SCREEN_WIDTH/31.25;
            tipsLable3.centerX = threeLable.centerX;
            tipsLable3.y = threeLable.bottom + SCREEN_WIDTH/46.875;
            
            tipsLable3.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
            tipsLable3.textAlignment = NSTextAlignmentCenter;
            tipsLable3.textColor = [UIColor colorWithHex:@"666666"];
            tipsLable3.text = @"获得信息费";

            
            
            [headView addSubview:titleLable];
            [headView addSubview:oneLable];
            [headView addSubview:twoLable];
            [headView addSubview:threeLable];
            [headView addSubview:line1];
            [headView addSubview:line2];
            [headView addSubview:tipsLable1];
            [headView addSubview:tipsLable2];
            [headView addSubview:tipsLable3];
            headView;
        });
    }
    return _shareTableView;
}

@end
