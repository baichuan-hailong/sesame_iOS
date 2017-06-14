//
//  BFShareQrCodeView.m
//  SesameService
//
//  Created by 杜海龙 on 17/5/26.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "BFShareQrCodeView.h"

@interface BFShareQrCodeView ()
@property (nonatomic , strong) UIView  *qrView;
@property (nonatomic , strong) UILabel *topLabel;
@property (nonatomic , strong) UILabel *lowLabel;
@property (nonatomic , strong) UIImageView   *qrImageView;
@property (nonatomic , strong) MBProgressHUD *HUD;
@end

@implementation BFShareQrCodeView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHex:@"000000"];
        self.alpha = 0.6;
    }
    return self;
}

- (void)shareShow{
    
    

    self.qrView            = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*300)/2,
                                        (SCREEN_HEIGHT-SCREEN_WIDTH/375*335)/2-SCREEN_WIDTH/375*10,
                                        SCREEN_WIDTH/375*300,
                                        SCREEN_WIDTH/375*335)];
    self.qrView.backgroundColor     = [UIColor colorWithHex:@"FFFFFF"];
    self.qrView.layer.cornerRadius  = SCREEN_WIDTH/375*2;
    self.qrView.layer.masksToBounds = YES;
    
    
    
    self.topLabel            = [[UILabel alloc]initWithFrame:CGRectMake(0,
                                                                     SCREEN_WIDTH/375*25,
                                                                     SCREEN_WIDTH/375*300,
                                                                     SCREEN_WIDTH/375*18)];
    [ZMLabelAttributeMange setLabel:self.topLabel
                               text:@"我的专属二维码"
                                hex:@"000000"
                      textAlignment:NSTextAlignmentCenter
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*18]];
    [self.qrView addSubview:self.topLabel];
    
    self.qrImageView            = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/375*33,
                                                                        SCREEN_WIDTH/375*57,
                                                                        SCREEN_WIDTH/375*234,
                                                                        SCREEN_WIDTH/375*234)];

    
    self.lowLabel            = [[UILabel alloc]initWithFrame:CGRectMake(0,
                                                                        SCREEN_WIDTH/375*301,
                                                                        SCREEN_WIDTH/375*300,
                                                                        SCREEN_WIDTH/375*17)];
    [ZMLabelAttributeMange setLabel:self.lowLabel
                               text:@"好友扫一扫  马上赚奖励"
                                hex:@"999999"
                      textAlignment:NSTextAlignmentCenter
                               font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
    [self.qrView addSubview:self.lowLabel];
    
    
    
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    [keyWindow addSubview:self.qrView];
    [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.qrView.frame            = CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/375*300)/2,
                                                  (SCREEN_HEIGHT-SCREEN_WIDTH/375*335)/2,
                                                  SCREEN_WIDTH/375*300,
                                                  SCREEN_WIDTH/375*335);
    } completion:^(BOOL finished) {
    }];
    
    
    NSString *qrUrl = [NSString stringWithFormat:@"%@/user/qrcode?token=%@",APIDev,[[NSUserDefaults standardUserDefaults] objectForKey:TOKEN]];
    //NSLog(@"qrUrl ------------ %@",qrUrl);
    //self.qrImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.qrView addSubview:self.qrImageView];
    
    
    self.HUD = [[MBProgressHUD alloc] initWithView:self.qrView];
    [self.qrView addSubview:self.HUD];
    [self.HUD show:YES];
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //load data
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:qrUrl]]];
        //main queue
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.HUD hide:YES];
            //refresh
            self.qrImageView.image = image;
        });
    });
}


//touch
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch            = [touches anyObject];
    CGPoint currentPosition   = [touch locationInView:self];
    CGFloat currentY          = currentPosition.y;
    CGFloat currentX          = currentPosition.x;
    if (currentY<(SCREEN_HEIGHT-SCREEN_WIDTH/375*335)/2
        ||currentY>((SCREEN_HEIGHT-SCREEN_WIDTH/375*335)/2+SCREEN_WIDTH/375*335)
        ||currentX<(SCREEN_WIDTH-SCREEN_WIDTH/375*300)/2
        ||currentX>((SCREEN_WIDTH-SCREEN_WIDTH/375*300)/2+SCREEN_WIDTH/375*300)){
        [UIView animateWithDuration:10.38 animations:^{
            [self removeFromSuperview];
            [self.qrView removeFromSuperview];
            
            [self.topLabel removeFromSuperview];
            [self.lowLabel removeFromSuperview];
            
        }];
    }
}

@end
