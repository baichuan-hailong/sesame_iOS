//
//  ZMUnderstandToSpecificView.h
//  SesameService
//
//  Created by 杜海龙 on 17/4/5.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMUnderstandToSpecificView : UIView
//header image
@property(nonatomic,strong)UIImageView      *headerImageView;
@property(nonatomic,strong)UIImageView      *stateImageView;

@property(nonatomic,strong)UILabel          *nameLabel;

@property (nonatomic , strong)UIImageView   *memberShipImageView;
@property(nonatomic,strong)UILabel          *memberLabel;

//experience
@property(nonatomic,strong)UILabel          *experienceLabel;



@property(nonatomic,strong)UITextView *suggestTextView;
@property(nonatomic,strong)UILabel    *suggestPlaceHolderLabel;
@property(nonatomic,strong)UILabel    *worldCountLabel;

@property (nonatomic, strong)UICollectionView *shareCollectionView;

//amount
@property(nonatomic,strong)UITextField  *amountTextField;

//isPublic
@property(nonatomic,strong)UIView       *isPublicView;
@property(nonatomic,strong)UIImageView  *isPublicTipImageView;
@property(nonatomic,strong)UILabel      *isPublicTipLabel;
@property(nonatomic,strong)UILabel      *isPublicBottomLabel;

//release
@property(nonatomic,strong)UIButton     *commitButtton;

- (void)setTopPer:(NSDictionary *)topDic;
@end
