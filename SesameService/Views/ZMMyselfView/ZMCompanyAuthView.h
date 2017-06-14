//
//  ZMCompanyAuthView.h
//  SesameService
//
//  Created by 杜海龙 on 17/4/28.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMCompanyAuthView : UIScrollView
@property (nonatomic , strong) UILabel        *companyLabel;
@property (nonatomic , strong) UITextField    *companyTextField;


@property (nonatomic , strong) UILabel        *cardIDOnLabel;
@property (nonatomic , strong) UIImageView    *cardIDOnImageView;

@property (nonatomic , strong) UIButton       *commitBtn;
@end
