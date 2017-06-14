//
//  ZMEmptyView.m
//  SesameService
//
//  Created by 杜海龙 on 17/5/18.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMEmptyView.h"

@interface ZMEmptyView ()
@property (nonatomic,strong)UIImageView *emptyImageView;
@property (nonatomic,strong)UILabel *emptyLabel;
@end

@implementation ZMEmptyView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addUI];
    }
    return self;
}

- (void)addUI{
    
    self.backgroundColor              = [UIColor colorWithHex:backGroundColor];
    
    self.emptyImageView.image = [UIImage imageNamed:@"emptyViewImage"];
    [self addSubview:self.emptyImageView];
    
    [ZMLabelAttributeMange setLabel:self.emptyLabel
                               text:@"暂无业务信息"
                                hex:@"9A9A9A"
                      textAlignment:NSTextAlignmentCenter
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    [self addSubview:self.emptyLabel];
    
}


- (void)setBottomTitle:(NSString *)bottomTitle{
    self.emptyLabel.text = bottomTitle;
}

-(UIImageView *)emptyImageView{
    if (_emptyImageView==nil) {
        _emptyImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*63)/2,
                                                                        (SCREEN_HEIGHT-64-SCREEN_WIDTH/375*63)/2-64,
                                                                        SCREEN_WIDTH/375*63,
                                                                        SCREEN_WIDTH/375*63)];
    }
    return _emptyImageView;
}

-(UILabel *)emptyLabel{
    if (_emptyLabel==nil) {
        _emptyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                CGRectGetMaxY(self.emptyImageView.frame)+SCREEN_WIDTH/375*19,
                                                                SCREEN_WIDTH,
                                                                SCREEN_WIDTH/375*10)];
    }
    return _emptyLabel;
}


@end
