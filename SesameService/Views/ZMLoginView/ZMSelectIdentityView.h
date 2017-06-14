//
//  ZMSelectIdentityView.h
//  SesameService
//
//  Created by 杜海龙 on 17/3/30.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMSelectIdentityView : UIScrollView

@property(nonatomic,strong)UIButton    *companyButton;
@property(nonatomic,strong)UIButton    *personalButton;

@property(nonatomic,strong)UILabel     *nameLabel;
@property(nonatomic,strong)UITextField *nametextField;

@property(nonatomic,strong)UIButton    *commitButton;

@end
