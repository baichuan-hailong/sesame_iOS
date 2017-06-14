//
//  homeBusinessHeadView.m
//  SesameService
//
//  Created by 娄耀文 on 17/3/24.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "homeHeadView.h"

@implementation homeHeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = [UIColor whiteColor];;
        [self addSubview:self.tipImage];
        [self addSubview:self.titleLable];
        [self addSubview:self.topBtn];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = [UIColor colorWithHex:@"dddddd"];
        [self addSubview:line];
        
    }
    return self;
}

- (UIImageView *)tipImage {

    if (_tipImage == nil) {
        _tipImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, (self.frame.size.height - 12)/2, 13, 12)];
    }
    return _tipImage;
}

- (UILabel *)titleLable {
    
    if (_titleLable == nil) {
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.tipImage.frame) + 6, (self.frame.size.height - SCREEN_WIDTH/26.78)/2, 100, SCREEN_WIDTH/26.78)];
        _titleLable.textColor = [UIColor colorWithHex:@"353846"];
        _titleLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/26.78];
    }
    return _titleLable;
}

- (UIButton *)topBtn {
    
    if (_topBtn == nil) {
        _topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _topBtn.frame = CGRectMake(SCREEN_WIDTH - SCREEN_WIDTH/5,
                                   0,
                                   SCREEN_WIDTH/5,
                                   self.frame.size.height);
        
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(6,
                                                                        (_topBtn.frame.size.height - SCREEN_WIDTH/31.25)/2,
                                                                        (SCREEN_WIDTH/31.25)*4.5,
                                                                         SCREEN_WIDTH/31.25)];
        titleLable.font = [UIFont systemFontOfSize:SCREEN_WIDTH/31.25];
        titleLable.textAlignment = NSTextAlignmentLeft;
        titleLable.textColor = [UIColor colorWithHex:@"999999"];
        titleLable.text = @"查看更多";
        
        UIImageView *nextImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_more"]];
        nextImgView.frame = CGRectMake(CGRectGetMaxX(titleLable.frame),
                                       (_topBtn.frame.size.height - 9)/2,
                                       5,
                                       9);
        
        [_topBtn addSubview:titleLable];
        [_topBtn addSubview:nextImgView];
    }
    return _topBtn;
}

@end
