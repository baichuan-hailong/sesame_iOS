//
//  ZMStarComponentView.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/14.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMStarComponentView.h"

@interface ZMStarComponentView ()
@property (nonatomic,strong)NSMutableArray *starArray;
@end

@implementation ZMStarComponentView

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
        UIImageView *starImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/375*13)*i+(SCREEN_WIDTH/375*3.4)*i,
                                                                                   (self.height-SCREEN_WIDTH/375*12)/2,
                                                                                   SCREEN_WIDTH/375*13,
                                                                                   SCREEN_WIDTH/375*12)];
        //starImageView.backgroundColor = [UIColor yellowColor];
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
