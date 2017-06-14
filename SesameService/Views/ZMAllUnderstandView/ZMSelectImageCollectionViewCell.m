//
//  ZMSelectImageCollectionViewCell.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/6.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMSelectImageCollectionViewCell.h"

@implementation ZMSelectImageCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor                 = [UIColor whiteColor];
        
        [self.deleteImageView setImage:[UIImage imageNamed:@"submitListShareDelete"] forState:UIControlStateNormal];
        
        
        
        self.bodyImageView.layer.cornerRadius = SCREEN_WIDTH/375*3;
        self.bodyImageView.layer.masksToBounds= YES;
        self.bodyImageView.contentMode        = UIViewContentModeScaleAspectFill;
        
        self.bodyImageView.userInteractionEnabled   = YES;
        //self.deleteImageView.userInteractionEnabled = YES;
        
        [self addSubview:self.bodyImageView];
        [self addSubview:self.deleteImageView];
        
        //self.deleteImageView.backgroundColor = [UIColor orangeColor];
        
    }
    return self;
}

//80x80

//lazy
-(UIImageView *)bodyImageView{
    if (_bodyImageView==nil) {
        _bodyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                       SCREEN_WIDTH/375*10,
                                                                       SCREEN_WIDTH/375*70,
                                                                       SCREEN_WIDTH/375*70)];
    }
    return _bodyImageView;
}
-(UIButton *)deleteImageView{
    if (_deleteImageView==nil) {
        _deleteImageView = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*50,
                                                                      SCREEN_WIDTH/375*0,
                                                                      SCREEN_WIDTH/375*26,
                                                                      SCREEN_WIDTH/375*26)];
    }
    return _deleteImageView;
}
@end
