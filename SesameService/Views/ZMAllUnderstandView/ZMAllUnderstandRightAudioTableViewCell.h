//
//  ZMAllUnderstandRightAudioTableViewCell.h
//  SesameService
//
//  Created by 杜海龙 on 17/4/28.
//  Copyright © 2017年 anju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMAllUnderstandRightAudioTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView      *headerImageView;
@property(nonatomic,strong)UIImageView      *stateImageView;

@property(nonatomic,strong)UILabel          *nameLabel;
@property (nonatomic , strong)UIImageView   *memberShipImageView;
@property(nonatomic,strong)UILabel          *moneyLabel;

@property(nonatomic,strong)UILabel          *questionLabel;

//answer
@property(nonatomic,strong)UIImageView      *answerImageView;
//@property(nonatomic,strong)UILabel          *answerLabel;
@property(nonatomic,strong)UILabel          *moreAnswerLabel;

//voiceBtn
@property(nonatomic,strong)UIButton          *voiceBtn;
@property(nonatomic,strong)UILabel           *countLabel;

- (void)setRightAudioAllUnderstan:(NSDictionary *)rightDic;
@end
