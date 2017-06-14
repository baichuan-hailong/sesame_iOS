//
//  ZMFeedBackSignView.h
//  SesameService
//
//  Created by 杜海龙 on 17/6/8.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMFeedBackSignView : UIView

@property(nonatomic,strong)UITableView      *feedBackTableView;
@property(nonatomic,strong)UIView           *feedBackHeaderView;

@property(nonatomic,strong)UIView           *feedBackFooterView;
@property(nonatomic,strong)UITextField      *feedBackTimeTextField;
@property(nonatomic,strong)UIButton         *feedBackCommit;


@property (nonatomic, strong)UIView   *topView;
@property (nonatomic, strong)UIButton *cancleBtn;
@property (nonatomic, strong)UIButton *sureBtn;
@property (nonatomic, strong)UIDatePicker *myDatePicker;

@end
