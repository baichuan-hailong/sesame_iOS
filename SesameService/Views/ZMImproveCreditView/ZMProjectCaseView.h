//
//  ZMProjectCaseView.h
//  SesameService
//
//  Created by 杜海龙 on 17/3/30.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMProjectCaseView : UIView
@property (nonatomic, strong)UIView   *topView;
@property (nonatomic, strong)UIButton *cancleBtn;
@property (nonatomic, strong)UIButton *sureBtn;
@property (nonatomic, strong)UIDatePicker *myDatePicker;
@property (nonatomic, strong)UITableView  *projectCaseTableView;
@end
