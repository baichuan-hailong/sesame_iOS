//
//  ZMStarTradingEvaluationView.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMStarTradingEvaluationView.h"

@interface ZMStarTradingEvaluationView ()
@property (nonatomic,strong)NSMutableArray *starArray;
@end

@implementation ZMStarTradingEvaluationView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        [self addUI];
    }
    
    return self;
}

- (void)addUI{
    
    self.starArray = [NSMutableArray array];
    
    
    for (int i=0; i<5; i++) {
        UIImageView *starImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/375*15.2)*i+(SCREEN_WIDTH/375*4.1)*i,
                                                                                   (self.height-SCREEN_WIDTH/375*14.5)/2,
                                                                                   SCREEN_WIDTH/375*15.2,
                                                                                   SCREEN_WIDTH/375*14.5)];
        //starImageView.backgroundColor = [UIColor redColor];
        starImageView.image = [UIImage imageNamed:@"agentStar2"];
        starImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.starArray addObject:starImageView];
        [self addSubview:starImageView];
    }
    //self.width;
    //self.height;
    //13 12
    //5
    //4x3.4
}



- (void)starInit:(NSInteger)starInt{
    for (int i=0; i<starInt; i++) {
        UIImageView *starImageView = self.starArray[i];
        starImageView.image = [UIImage imageNamed:@"agentStar1"];
    }
}

@end
