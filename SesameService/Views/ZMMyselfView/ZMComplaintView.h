//
//  ZMComplaintView.h
//  SesameService
//
//  Created by 杜海龙 on 17/4/24.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMComplaintView : UIScrollView
@property (nonatomic , strong) UILabel     *titleLabel;
@property (nonatomic , strong) UILabel     *buyLabel;
@property (nonatomic , strong) UILabel     *numberLabel;
@property (nonatomic , strong) UILabel     *moneyLabel;

- (void)setTopDicView:(NSDictionary *)topDic;


@property(nonatomic,strong)UIView     *suggestView;
@property(nonatomic,strong)UITextView *suggestTextView;
@property(nonatomic,strong)UILabel    *suggestPlaceHolderLabel;
@property(nonatomic,strong)UILabel    *worldCountLabel;

@property(nonatomic,strong)UIButton    *commitButton;
@end
