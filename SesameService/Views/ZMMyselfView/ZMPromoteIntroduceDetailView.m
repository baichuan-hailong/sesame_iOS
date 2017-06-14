//
//  ZMPromoteIntroduceDetailView.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/25.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMPromoteIntroduceDetailView.h"

@implementation ZMPromoteIntroduceDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)addUI{
    
    self.promoteIntroduceDetailTableView.backgroundColor = [UIColor colorWithHex:backGroundColor];
    self.promoteIntroduceDetailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.promoteIntroduceDetailTableView];
    
}

//lazy
-(UITableView *)promoteIntroduceDetailTableView{
    if (_promoteIntroduceDetailTableView==nil) {
        _promoteIntroduceDetailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                                   64,
                                                                                   SCREEN_WIDTH,
                                                                                   SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
        
        
    }
    return _promoteIntroduceDetailTableView;
}


@end
