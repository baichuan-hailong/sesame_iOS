//
//  ZMRealNameAuthView.h
//  SesameService
//
//  Created by 杜海龙 on 17/3/30.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMRealNameAuthView : UIScrollView
@property (nonatomic , strong) UILabel        *nameLabel;
@property (nonatomic , strong) UITextField    *nameTextField;
@property (nonatomic , strong) UILabel        *cardIDLabel;
@property (nonatomic , strong) UITextField    *cardIDTextField;

@property (nonatomic , strong) UILabel        *cardIDOnLabel;
@property (nonatomic , strong) UIImageView    *cardIDOnImageView;


@property (nonatomic , strong) UILabel        *cardIDOffLabel;
@property (nonatomic , strong) UIImageView    *cardIDOffImageView;

@property (nonatomic , strong) UIButton       *commitBtn;

@property (nonatomic , strong) UILabel        *tipLabel;

@end
