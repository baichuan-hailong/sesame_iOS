//
//  BFShareView.m
//  biufang
//
//  Created by 杜海龙 on 16/10/8.
//  Copyright © 2016年 biufang. All rights reserved.
//

#import "BFShareView.h"

@interface BFShareView ()

@property (nonatomic , strong) UIView *shareBodyView;
//UIButton * noOneButton
@property (nonatomic , strong) UIButton * noOneButton;
@property (nonatomic , strong) UILabel  * noOneLabel;
@property (nonatomic , strong) UIButton * noTwoButton;
@property (nonatomic , strong) UILabel  * noTwoLabel;
@property (nonatomic , strong) UIButton * noThreeButton;
@property (nonatomic , strong) UILabel  * noThreeLabel;
@property (nonatomic , strong) UIButton * noFourButton;
@property (nonatomic , strong) UILabel  * noFourLabel;


@property (nonatomic , strong) UILabel  * tipLabel;
@property (nonatomic , strong) UIButton * cancleButton;
@property (nonatomic , strong) UIView   * canclLine;

@end

@implementation BFShareView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHex:@"000000"];
        self.alpha = 0.6;
    }
    return self;
}


//add UI
- (void)creatButtonsAc{
    
    //weixin
    self.noOneButton      = [self creatBtnWithFrame:CGRectMake(SCREEN_WIDTH/375*32,
                                                               (SCREEN_HEIGHT-SCREEN_WIDTH/375*194)+SCREEN_WIDTH/375*63,
                                                               SCREEN_WIDTH/375*32,
                                                               SCREEN_WIDTH/375*26)
                                                    image:[UIImage imageNamed:@"shareweixin"]
                                           animationFrame:CGRectMake(SCREEN_WIDTH/375*32,
                                                                     (SCREEN_HEIGHT-SCREEN_WIDTH/375*194)+SCREEN_WIDTH/375*63+SCREEN_WIDTH/375*10,
                                                                     SCREEN_WIDTH/375*32,
                                                                     SCREEN_WIDTH/375*26)
                                                    delay:0];
    self.noOneButton.tag                = 701;
    //self.noOneButton.backgroundColor    = [UIColor orangeColor];
    [self.noOneButton addTarget:self action:@selector(shareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    self.noOneLabel = [[UILabel alloc] initWithFrame:CGRectMake(-SCREEN_WIDTH/375*15,
                                                                SCREEN_WIDTH/375*26+SCREEN_WIDTH/375*5,
                                                                SCREEN_WIDTH/375*62,
                                                                SCREEN_WIDTH/375*13)];
    self.noOneLabel.text = @"微信好友";
    self.noOneLabel.textColor = [UIColor colorWithHex:@"000000"];
    self.noOneLabel.font = [UIFont systemFontOfSize:SCREEN_WIDTH/375*11];
    self.noOneLabel.textAlignment = NSTextAlignmentCenter;
    [self.noOneButton addSubview:self.noOneLabel];
    
    
    
    //weixin circle
    self.noTwoButton      = [self creatBtnWithFrame:CGRectMake(SCREEN_WIDTH/375*131,
                                                               (SCREEN_HEIGHT-SCREEN_WIDTH/375*194)+SCREEN_WIDTH/375*63,
                                                               SCREEN_WIDTH/375*26,
                                                               SCREEN_WIDTH/375*26)
                                                    image:[UIImage imageNamed:@"sharepengyou"]
                                     animationFrame:CGRectMake(SCREEN_WIDTH/375*131,
                                                               (SCREEN_HEIGHT-SCREEN_WIDTH/375*194)+SCREEN_WIDTH/375*63+SCREEN_WIDTH/375*10,
                                                               SCREEN_WIDTH/375*26,
                                                               SCREEN_WIDTH/375*26)
                                                    delay:0];
    self.noTwoButton.tag                = 702;
    //self.noTwoButton.backgroundColor    = [UIColor orangeColor];
    [self.noTwoButton addTarget:self action:@selector(shareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.noTwoLabel = [[UILabel alloc] initWithFrame:CGRectMake(-SCREEN_WIDTH/375*30,
                                                                SCREEN_WIDTH/375*26+SCREEN_WIDTH/375*5,
                                                                SCREEN_WIDTH/375*86,
                                                                SCREEN_WIDTH/375*13)];
    self.noTwoLabel.text = @"微信朋友圈";
    self.noTwoLabel.textColor = [UIColor colorWithHex:@"000000"];
    self.noTwoLabel.font = [UIFont systemFontOfSize:SCREEN_WIDTH/375*11];
    self.noTwoLabel.textAlignment = NSTextAlignmentCenter;
    [self.noTwoButton addSubview:self.noTwoLabel];
    
    
    
    //QQ
    self.noFourButton      = [self creatBtnWithFrame:CGRectMake(SCREEN_WIDTH/375*220,
                                                                (SCREEN_HEIGHT-SCREEN_WIDTH/375*194)+SCREEN_WIDTH/375*63,
                                                                SCREEN_WIDTH/375*28,
                                                                SCREEN_WIDTH/375*28)
                                               image:[UIImage imageNamed:@"shareqq"]
                                      animationFrame:CGRectMake(SCREEN_WIDTH/375*220,
                                                                (SCREEN_HEIGHT-SCREEN_WIDTH/375*194)+SCREEN_WIDTH/375*63+SCREEN_WIDTH/375*10,
                                                                SCREEN_WIDTH/375*28,
                                                                SCREEN_WIDTH/375*28)
                                               delay:0];
    self.noFourButton.tag                = 703;
    //self.noFourButton.backgroundColor    = [UIColor orangeColor];
    [self.noFourButton addTarget:self action:@selector(shareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.noFourLabel = [[UILabel alloc] initWithFrame:CGRectMake(-SCREEN_WIDTH/375*30,
                                                                 SCREEN_WIDTH/375*26+SCREEN_WIDTH/375*5,
                                                                 SCREEN_WIDTH/375*88,
                                                                 SCREEN_WIDTH/375*13)];
    self.noFourLabel.text = @"QQ好友";
    self.noFourLabel.textColor = [UIColor colorWithHex:@"000000"];
    self.noFourLabel.font = [UIFont systemFontOfSize:SCREEN_WIDTH/375*12];
    self.noFourLabel.textAlignment = NSTextAlignmentCenter;
    [self.noFourButton addSubview:self.noFourLabel];
    
    
    
    
    
    
     //qqZone
     self.noThreeButton      = [self creatBtnWithFrame:CGRectMake(SCREEN_WIDTH/375*310,
                                                                 (SCREEN_HEIGHT-SCREEN_WIDTH/375*194)+SCREEN_WIDTH/375*63,
                                                                 SCREEN_WIDTH/375*30,
                                                                 SCREEN_WIDTH/375*29)
                                                                 image:[UIImage imageNamed:@"shareQQZoneImage"]
                                                                 animationFrame:CGRectMake(SCREEN_WIDTH/375*310,
                                                                 (SCREEN_HEIGHT-SCREEN_WIDTH/375*194)+SCREEN_WIDTH/375*63+SCREEN_WIDTH/375*10,
                                                                 SCREEN_WIDTH/375*30,
                                                                 SCREEN_WIDTH/375*29)
                                                         delay:0];
     self.noThreeButton.tag                = 704;
     //self.noThreeButton.backgroundColor    = [UIColor orangeColor];
     [self.noThreeButton addTarget:self action:@selector(shareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
     
     
     self.noThreeLabel = [[UILabel alloc] initWithFrame:CGRectMake(-SCREEN_WIDTH/375*20,
                                                                 SCREEN_WIDTH/375*26+SCREEN_WIDTH/375*5,
                                                                 SCREEN_WIDTH/375*70,
                                                                 SCREEN_WIDTH/375*13)];
     self.noThreeLabel.text = @"QQ空间";
     self.noThreeLabel.textColor = [UIColor colorWithHex:@"000000"];
     self.noThreeLabel.font = [UIFont systemFontOfSize:SCREEN_WIDTH/375*12];
     self.noThreeLabel.textAlignment = NSTextAlignmentCenter;
     //self.noThreeLabel.backgroundColor    = [UIColor orangeColor];
     [self.noThreeButton addSubview:self.noThreeLabel];
     
     
    
    
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    //tip
    self.tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                  SCREEN_HEIGHT-SCREEN_WIDTH/375*149-SCREEN_WIDTH/375*45,
                                                  SCREEN_WIDTH,
                                                  SCREEN_WIDTH/375*45)];
    self.tipLabel.backgroundColor = [UIColor colorWithHex:@"EFEFF4"];
    [ZMLabelAttributeMange setLabel:self.tipLabel
                               text:@"立即通过以下方式邀请好友"
                                hex:@"000000"
                      textAlignment:NSTextAlignmentCenter
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*13]];
    [keyWindow addSubview:self.tipLabel];
    
    
    //cancle
    self.canclLine = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                              SCREEN_HEIGHT-SCREEN_WIDTH/375*49,
                                                              SCREEN_WIDTH,
                                                              SCREEN_WIDTH/375*1)];
    self.canclLine.backgroundColor = [UIColor colorWithHex:@"DDDDDD"];
    [keyWindow addSubview:self.canclLine];
    
    self.cancleButton = [[UIButton alloc] initWithFrame:CGRectMake(0,
                                                                   SCREEN_HEIGHT-SCREEN_WIDTH/375*48,
                                                                   SCREEN_WIDTH,
                                                                   SCREEN_WIDTH/375*48)];
    [self.cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancleButton setTitleColor:[UIColor colorWithHex:@"000000"] forState:UIControlStateNormal];
    self.cancleButton.titleLabel.font = [UIFont systemFontOfSize:SCREEN_WIDTH/375*16];
    [keyWindow addSubview:self.cancleButton];
    
    [self.cancleButton addTarget:self action:@selector(cancleButtonDidClickedAction:) forControlEvents:UIControlEventTouchUpInside];
}


-(void)shareShow{
    
    self.shareBodyView            = [[UIView alloc]initWithFrame:CGRectMake(0,
                                                                            SCREEN_HEIGHT-SCREEN_WIDTH/375*194,
                                                                            SCREEN_WIDTH,
                                                                            SCREEN_WIDTH/375*194)];
    self.shareBodyView.backgroundColor     = [UIColor colorWithHex:@"FFFFFF"];
    self.shareBodyView.layer.masksToBounds = YES;
    
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [UIView animateWithDuration:0.38 animations:^{
    }];
    
    [keyWindow addSubview:self];
    
    [keyWindow addSubview:self.shareBodyView];
    
    [self creatButtonsAc];
    
    
}

-(void)shareButtonClick:(UIButton*)sender{
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(shareViewDidSelectButWithBtnTag:)]) {
        
        [self.delegate shareViewDidSelectButWithBtnTag:sender.tag];
        
        
        if (sender.tag==706) {
            [UIView animateWithDuration:10.38 animations:^{
                [self removeFromSuperview];
                [self.shareBodyView removeFromSuperview];
                [self.noOneButton removeFromSuperview];
                [self.noTwoButton removeFromSuperview];
                [self.noThreeButton removeFromSuperview];
                [self.noFourButton removeFromSuperview];
                
                [self.tipLabel removeFromSuperview];
                [self.canclLine removeFromSuperview];
                [self.cancleButton removeFromSuperview];
                
            }];
        }
    }
    
}


//touch
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch            = [touches anyObject];
    CGPoint currentPosition   = [touch locationInView:self];
    CGFloat currentY          = currentPosition.y;
    if (currentY<(SCREEN_HEIGHT-SCREEN_WIDTH/375*194)){
        [UIView animateWithDuration:10.38 animations:^{
            [self removeFromSuperview];
            [self.shareBodyView removeFromSuperview];
            
            [self.noOneButton removeFromSuperview];
            [self.noTwoButton removeFromSuperview];
            [self.noThreeButton removeFromSuperview];
            [self.noFourButton removeFromSuperview];
            
            [self.tipLabel removeFromSuperview];
            [self.canclLine removeFromSuperview];
            [self.cancleButton removeFromSuperview];
        }];
    }
}

-(void)shareHide{

    [UIView animateWithDuration:10.38 animations:^{
        
        [self removeFromSuperview];
        
        [self.shareBodyView removeFromSuperview];
        
        [self.noOneButton removeFromSuperview];
        [self.noTwoButton removeFromSuperview];
        [self.noThreeButton removeFromSuperview];
        [self.noFourButton removeFromSuperview];
        
        [self.tipLabel removeFromSuperview];
        [self.canclLine removeFromSuperview];
        [self.cancleButton removeFromSuperview];
        
    }];
}

//cancle
- (void)cancleButtonDidClickedAction:(UIButton *)sender{

    [UIView animateWithDuration:10.38 animations:^{
        
        [self removeFromSuperview];
        
        [self.shareBodyView removeFromSuperview];
        
        [self.noOneButton removeFromSuperview];
        [self.noTwoButton removeFromSuperview];
        [self.noThreeButton removeFromSuperview];
        [self.noFourButton removeFromSuperview];
        
        [self.tipLabel removeFromSuperview];
        [self.canclLine removeFromSuperview];
        [self.cancleButton removeFromSuperview];
        
    }];
}



//creat share btn
-(UIButton *)creatBtnWithFrame:(CGRect)frame
                         image:(UIImage *)image
                animationFrame:(CGRect)animationFrame
                         delay:(CGFloat)afterDelay{
    
    UIButton *shareButton      = [[UIButton alloc]init];
    shareButton.frame          = frame;
    //[shareButton setBackgroundImage:image forState:UIControlStateNormal];
    [shareButton setImage:image forState:UIControlStateNormal];
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow  addSubview:shareButton];
    
    
    
    [UIView animateWithDuration:1.0 delay:afterDelay usingSpringWithDamping:0.2 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        shareButton.frame      = animationFrame;
    } completion:^(BOOL finished) {
        
    }];
    return shareButton;
    
    //usingSpringWithDamping :弹簧动画的阻尼值，也就是相当于摩擦力的大小，该属性的值从0.0到1.0之间，越靠近0，阻尼越小，弹动的幅度越大，反之阻尼越大，弹动的幅度越小，如果大道一定程度，会出现弹不动的情况。
    //initialSpringVelocity  :弹簧动画的速率，或者说是动力。值越小弹簧的动力越小，弹簧拉伸的幅度越小，反之动力越大，弹簧拉伸的幅度越大。这里需要注意的是，如果设置为0，表示忽略该属性，由动画持续时间和阻尼计算动画的效果。
}


@end
