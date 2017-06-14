//
//  ZMUnderstandView.h
//  SesameService
//
//  Created by 杜海龙 on 17/4/6.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMUnderstandView : UIView

@property(nonatomic,strong)UIButton         *leftButtton;

@property(nonatomic,strong)UIButton         *rightButtton;


@property(nonatomic,strong)UITextView *suggestTextView;
@property(nonatomic,strong)UILabel    *suggestPlaceHolderLabel;
@property(nonatomic,strong)UILabel    *worldCountLabel;


//isPublic
@property(nonatomic,strong)UIView       *isPublicView;
@property(nonatomic,strong)UIImageView  *isPublicTipImageView;
@property(nonatomic,strong)UILabel      *isPublicTipLabel;
@property(nonatomic,strong)UILabel      *isPublicBottomLabel;



@property (nonatomic, strong)UICollectionView *shareCollectionView;
//amount
@property(nonatomic,strong)UITextField         *amountTextField;
//release
@property(nonatomic,strong)UIButton            *commitButtton;
@end
