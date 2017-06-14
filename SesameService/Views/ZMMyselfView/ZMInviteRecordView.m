//
//  ZMInviteRecordView.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/26.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMInviteRecordView.h"

@implementation ZMInviteRecordView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)addUI{
    
    self.inviteRecordTableView.backgroundColor = [UIColor colorWithHex:backGroundColor];
    self.inviteRecordTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.inviteRecordTableView];
    
}

//lazy
-(UITableView *)inviteRecordTableView{
    if (_inviteRecordTableView==nil) {
        _inviteRecordTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                                     64,
                                                                                     SCREEN_WIDTH,
                                                                                     SCREEN_HEIGHT-64)];
        
        
    }
    return _inviteRecordTableView;
}


@end
