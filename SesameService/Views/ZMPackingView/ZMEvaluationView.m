//
//  ZMEvaluationView.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/26.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMEvaluationView.h"

@interface ZMEvaluationView ()
@property(nonatomic,strong)UIImageView *leftImageView;
@property(nonatomic,strong)UILabel     *rightLabel;
@end


@implementation ZMEvaluationView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addUI];
    }
    return self;
}

- (void)addUI{
    
    self.leftImageView.userInteractionEnabled=YES;
    //[self addSubview:self.leftImageView];
    
    
    
    [ZMLabelAttributeMange setLabel:self.rightLabel
                               text:@"--"
                                hex:@"CCCCCC"
                      textAlignment:NSTextAlignmentRight
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    //[self addSubview:self.rightLabel];
    
    
    
    [ZMLabelAttributeMange setLabel:self.titleLabel
                               text:@"--"
                                hex:@"CCCCCC"
                      textAlignment:NSTextAlignmentRight
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*14]];
    
    //[self setImageEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
}

-(void)setLeftImage:(UIImage *)leftImag rightLa:(NSString *)rightStr rightHex:(NSString *)colorHex{

    self.leftImageView.image = leftImag;
    self.leftImageView.userInteractionEnabled = YES;
    self.rightLabel.text     = rightStr;
    self.rightLabel.textColor= [UIColor colorWithHex:colorHex];
    
    
    [self setImage:leftImag forState:UIControlStateNormal];
    //[self setBackgroundImage:leftImag forState:UIControlStateNormal];
    [self setContentMode:UIViewContentModeScaleAspectFit];
    
    
    [self setTitle:rightStr forState:UIControlStateNormal];
    [self setTitleColor:[UIColor colorWithHex:colorHex] forState:UIControlStateNormal];
    
    [self setImageEdgeInsets:UIEdgeInsetsMake(1.2, 5, 1.2, 45)];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, 2, 0, 0)];
    
    //self.backgroundColor = [UIColor redColor];
}

//lazy
-(UIImageView *)leftImageView{
    
    if (_leftImageView==nil) {
        _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                       0,
                                                                       SCREEN_WIDTH/375*24,
                                                                       SCREEN_WIDTH/375*24)];
    }
    return _leftImageView;
}

-(UILabel *)rightLabel{
    
    if (_rightLabel==nil) {
        _rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*24,
                                                               0,
                                                               SCREEN_WIDTH/375*36,
                                                               SCREEN_WIDTH/375*24)];
    }
    return _rightLabel;
}
@end
