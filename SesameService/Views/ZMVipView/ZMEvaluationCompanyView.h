//
//  ZMEvaluationCompanyView.h
//  SesameService
//
//  Created by 杜海龙 on 17/3/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMEvaluationCompanyView : UIScrollView

@property(nonatomic,strong)UIImageView      *companyImageView;
@property(nonatomic,strong)UIImageView      *companyLevelImageView;
@property(nonatomic,strong)UILabel          *companyNameLabel;
@property(nonatomic,strong)UILabel          *tipLabel;

@property(nonatomic,strong)UIView           *startView;
@property(nonatomic,strong)NSMutableArray   *starArray;



@property(nonatomic,strong)UITextView       *evaluationTextView;
//place
@property(nonatomic,strong)UILabel          *evaluationPlaceHolderLabel;
@property(nonatomic,strong)UIButton         *commitButton;


@end
