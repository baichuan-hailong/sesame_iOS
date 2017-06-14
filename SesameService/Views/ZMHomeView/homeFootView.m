//
//  homeFootView.m
//  SesameService
//
//  Created by 娄耀文 on 17/5/25.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "homeFootView.h"

@implementation homeFootView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithHex:backColor];;

        [self addSubview:self.topBtn];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = [UIColor colorWithHex:@"dddddd"];
        [self addSubview:line];
        
    }
    return self;
}


- (UIButton *)topBtn {
    
    if (_topBtn == nil) {
        _topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _topBtn.frame = CGRectMake(0,
                                   0,
                                   SCREEN_WIDTH,
                                   SCREEN_WIDTH/9.375);
        [_topBtn setBackgroundImage:[toolClass imageWithColor:[UIColor colorWithHex:@"fafafa"] size:_topBtn.size] forState:UIControlStateNormal];
        [_topBtn setBackgroundImage:[toolClass imageWithColor:[UIColor colorWithHex:backColor] size:_topBtn.size] forState:UIControlStateHighlighted];
        
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                       (_topBtn.height - SCREEN_WIDTH/28.85)/2,
                                                                        SCREEN_WIDTH,
                                                                        SCREEN_WIDTH/28.85)];
        titleLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/28.85];
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.textColor = [UIColor colorWithHex:@"999999"];
        titleLable.text = @"点击查看更多项目";
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, _topBtn.height - 0.5, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = [UIColor colorWithHex:@"dddddd"];
        
        [_topBtn addSubview:titleLable];
        [_topBtn addSubview:line];
    }
    return _topBtn;
}


@end
