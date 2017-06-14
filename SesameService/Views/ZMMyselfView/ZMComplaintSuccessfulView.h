//
//  ZMComplaintSuccessfulView.h
//  SesameService
//
//  Created by 杜海龙 on 17/4/26.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMComplaintSuccessfulView : UIScrollView
@property (nonatomic , strong) UIImageView *stateImageView;

@property (nonatomic , strong) UILabel     *successfulLabel;
@property (nonatomic , strong) UILabel     *tipLabel;

@property (nonatomic , strong) UIButton     *checkBtn;
@property (nonatomic , strong) UIButton     *bacBtn;

@property (nonatomic , strong) UILabel      *telLabel;
@end
