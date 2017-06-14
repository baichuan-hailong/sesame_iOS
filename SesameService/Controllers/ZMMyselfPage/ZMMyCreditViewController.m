//
//  ZMMyCreditViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/23.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMMyCreditViewController.h"
#import "ZMMyCreditView.h"
#import "ZMStudyCreditView.h"

#import "ZMMyCreditLeftTableViewCell.h"
#import "ZMMyCreditLeftOneTableViewCell.h"
#import "ZMMyCreditRightTableViewCell.h"
#import "ZMMyCreditRightOneTableViewCell.h"

#import "ZMMyCreditLeftFooterView.h"
#import "ZMMyCreditRightFooterView.h"

#import "ZMEditDataViewController.h"
#import "ZMAwardsHonorViewController.h"
#import "ZMProjectCaseViewController.h"
#import "ZMRealNameAuthViewController.h"
#import "ZMUploadCardViewController.h"


@interface ZMMyCreditViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    int  timeIn;
    int  zeroIn;
    BOOL isLeft;
}
@property (nonatomic,strong)ZMMyCreditView    *myCreditView;
@property (nonatomic,strong)ZMStudyCreditView *studyCreditView;

@property (nonatomic,strong)NSArray *rightArray;


@property(nonatomic,strong)NSTimer *timer;
@end

@implementation ZMMyCreditViewController

-(void)loadView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.myCreditView = [[ZMMyCreditView alloc] initWithFrame:SCREEN_BOUNDS];
    self.myCreditView.leftTableView.delegate = self;
    self.myCreditView.leftTableView.dataSource=self;
    self.view = self.myCreditView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的信用";
    
    isLeft = YES;
    
    [self addAction];
    
    self.rightArray   = @[@{@"tipStr":@"资料填写"},
                          @{@"tipStr":@"实名认证"},
                          @{@"tipStr":@"上传名片"},
                          @{@"tipStr":@"项目案例"},
                          @{@"tipStr":@"奖项荣誉"}];
    
    zeroIn = 0;
    
    [self souceData];
    
}

-(void)viewWillAppear:(BOOL)animated{
    timeIn=80;
    [self evokeScoreAnima];
}

#pragma mark - Souce Data
- (void)souceData{
    //sender coder
    //NSDictionary *parm = @{@"mobile":self.loginView.telTextField.text};
    NSString *urlStr   = [NSString stringWithFormat:@"%@/user/my-credit-index",APIDev];
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:nil withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"%@",object);
        NSLog(@"%@",object[@"status"][@"message"]);
        
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            
        }
    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}


#pragma mark - click
- (void)evokeScoreAnima{
    //NSLog(@"click");
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.38/80 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
    //旋转的角度
    float rolaFloat  = (float)((float)timeIn/(float)100)*M_PI;
    NSLog(@"%f",rolaFloat);
    
    
    //初始化
    float dislocationFloat = 0.0;
    if (0<=timeIn&&timeIn<10) {
        dislocationFloat = (float)((float)-7/(float)100)*M_PI;
    }
    
    if (10<=timeIn&&timeIn<20) {
        dislocationFloat = (float)((float)-5.5/(float)100)*M_PI;
    }
    
    if (20<=timeIn&&timeIn<30) {
        dislocationFloat = (float)((float)-4/(float)100)*M_PI;
    }
    
    if (30<=timeIn&&timeIn<40) {
        dislocationFloat = (float)((float)-2.5/(float)100)*M_PI;
    }
    
    if (40<=timeIn&&timeIn<50) {
        dislocationFloat = (float)((float)-1/(float)100)*M_PI;
    }
    
    if (50<=timeIn&&timeIn<60) {
        dislocationFloat = (float)((float)0.5/(float)100)*M_PI;
    }
    
    if (60<=timeIn&&timeIn<70) {
        dislocationFloat = (float)((float)1.2/(float)100)*M_PI;
    }
    
    if (70<=timeIn&&timeIn<80) {
        dislocationFloat = (float)((float)3.5/(float)100)*M_PI;
    }
    
    if (80<=timeIn&&timeIn<90) {
        dislocationFloat = (float)((float)5/(float)100)*M_PI;
    }
        
    if (timeIn>=90){
        dislocationFloat = (float)((float)7/(float)100)*M_PI;
    }
    
    NSLog(@"%f",dislocationFloat);
    
    //真实角度
    float realFloat = dislocationFloat+rolaFloat;
    NSLog(@"%f",realFloat);
    
    
    CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
    animation.fromValue    = [NSNumber numberWithFloat:dislocationFloat];
    animation.toValue      =  [NSNumber numberWithFloat: realFloat];
    animation.duration     = 0.58;
    animation.autoreverses = NO;
    //防止回到初始位置
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = 1;
    [self.myCreditView.tipView.layer addAnimation:animation forKey:nil];
}

#pragma mark - NSTimer
- (void)timeAction{
    NSLog(@"time");
    zeroIn++;
    NSLog(@"%d",timeIn);
    if (zeroIn<timeIn) {
        self.myCreditView.scoreLabel.text = [NSString stringWithFormat:@"%d",zeroIn];
    }else{
        self.myCreditView.scoreLabel.text = [NSString stringWithFormat:@"%d",timeIn];
        [self.timer invalidate];
        self.timer = nil;
    }
}

#pragma mark - 返回会员中心
- (void)backBtnClickAction:(UIButton *)sender{
    NSLog(@"back");
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Add Action
- (void)addAction{
    
    
    [self.myCreditView.understandButton addTarget:self action:@selector(understandButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.myCreditView.lefrButton addTarget:self action:@selector(lefrButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.myCreditView.rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (isLeft) {
        return 3;
    }else{
        return 6;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (isLeft) {
        if (indexPath.row==0) {
            return SCREEN_WIDTH/375*99;
        }else{
          return SCREEN_WIDTH/375*64;
        }
        
    }else{
        if (indexPath.row==0) {
            return SCREEN_WIDTH/375*195;
        }else{
            return SCREEN_WIDTH/375*48;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (isLeft) {
        return SCREEN_WIDTH/375*70;
    }else{
        return SCREEN_WIDTH/375*100+SCREEN_WIDTH/375*40;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (isLeft) {
        ZMMyCreditLeftFooterView *leftFoot         = [[ZMMyCreditLeftFooterView alloc] init];
        return leftFoot;
    }else{
        

        ZMMyCreditRightFooterView *rightFoot         = [[ZMMyCreditRightFooterView alloc] init];
        [rightFoot.backBtn addTarget:self action:@selector(backBtnClickAction:) forControlEvents:UIControlEventTouchUpInside];
        return rightFoot;
    }
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentifire         = @"myCreditLeftCell";
    static NSString *cellIndenOnetifire      = @"myCreditLeftOneCell";
    static NSString *cellRithtIndentifire    = @"myCreditRightCell";
    static NSString *cellRithtOneIndentifire = @"myCreditRightOneCell";

    
    if (isLeft) {
        
        if (indexPath.row==0) {
            ZMMyCreditLeftOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndenOnetifire];
            if (!cell) {
                cell = [[ZMMyCreditLeftOneTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndenOnetifire];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return cell;
        }else{
            ZMMyCreditLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifire];
            if (!cell) {
                cell = [[ZMMyCreditLeftTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifire];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return cell;
        }
        
    }else{
        
        if (indexPath.row==0) {
            ZMMyCreditRightOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellRithtOneIndentifire];
            if (!cell) {
                cell = [[ZMMyCreditRightOneTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellRithtOneIndentifire];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return cell;
        }else{
            ZMMyCreditRightTableViewCell *rightcell = [tableView dequeueReusableCellWithIdentifier:cellRithtIndentifire];
            if (!rightcell) {
                rightcell = [[ZMMyCreditRightTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellRithtIndentifire];
                rightcell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            NSDictionary *dic = self.rightArray[indexPath.row-1];
            [rightcell setDetaillCell:dic];
            
            if (indexPath.row==1) {
                rightcell.rightLabel.text = @"完整度：60%";
            }else if (indexPath.row==2){
                rightcell.rightLabel.text = @"待完成";
            }else if (indexPath.row==3){
                rightcell.rightLabel.text = @"已完成";
            }else if (indexPath.row==5){
                rightcell.biuLine.alpha=0;
            }
            
            return rightcell;
        }
        
        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"%ld",indexPath.row);
    
    
     if (!isLeft){
        if (indexPath.row==1) {
            ZMEditDataViewController *editDataVC = [[ZMEditDataViewController alloc] init];
            [self.navigationController pushViewController:editDataVC animated:YES];
        }else if (indexPath.row==2){
            ZMRealNameAuthViewController *realNameAuthVC = [[ZMRealNameAuthViewController alloc] init];
            [self.navigationController pushViewController:realNameAuthVC animated:YES];
            
        }else if (indexPath.row==3){
            ZMUploadCardViewController *uploadCardVC = [[ZMUploadCardViewController alloc] init];
            [self.navigationController pushViewController:uploadCardVC animated:YES];
            
        }else if (indexPath.row==4){
            ZMProjectCaseViewController *projectCaseVC = [[ZMProjectCaseViewController alloc] init];
            [self.navigationController pushViewController:projectCaseVC animated:YES];
        }else if (indexPath.row==5){
            ZMAwardsHonorViewController *awardsHonorVC = [[ZMAwardsHonorViewController alloc] init];
            [self.navigationController pushViewController:awardsHonorVC animated:YES];
        }
    }
}




#pragma mark - 了解信用分
- (void)understandButtonAction:(UIButton *)sender{
    
    [self.studyCreditView evokeCard];
}


#pragma mark - left&right
- (void)lefrButtonAction:(UIButton *)sender{
    isLeft = YES;
    [self.myCreditView.leftTableView reloadData];
    
    NSLog(@"left");
    [self.myCreditView.lefrButton setTitleColor:[UIColor colorWithHex:tonalColor] forState:UIControlStateNormal];
    [self.myCreditView.rightButton setTitleColor:[UIColor colorWithHex:@"999999"] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.38 animations:^{
        [self.myCreditView.bottomScrollView setContentOffset:CGPointMake(0, 0)];
        self.myCreditView.tipLine.frame = CGRectMake((SCREEN_WIDTH/2-SCREEN_WIDTH/375*100)/2,
                                                     CGRectGetMaxY(self.myCreditView.lefrButton.frame),
                                                     SCREEN_WIDTH/375*100,
                                                     SCREEN_WIDTH/375*3);
    }];
}

- (void)rightButtonAction:(UIButton *)sender{
    isLeft = NO;
    [self.myCreditView.leftTableView reloadData];
    
    NSLog(@"right");
    [self.myCreditView.lefrButton setTitleColor:[UIColor colorWithHex:@"999999"] forState:UIControlStateNormal];
    [self.myCreditView.rightButton setTitleColor:[UIColor colorWithHex:tonalColor] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.38 animations:^{
        [self.myCreditView.bottomScrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0)];
        self.myCreditView.tipLine.frame = CGRectMake(SCREEN_WIDTH/2+(SCREEN_WIDTH/2-SCREEN_WIDTH/375*100)/2,
                                                     CGRectGetMaxY(self.myCreditView.lefrButton.frame),
                                                     SCREEN_WIDTH/375*100,
                                                     SCREEN_WIDTH/375*3);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//lazy
-(ZMStudyCreditView *)studyCreditView{
    if (_studyCreditView==nil) {
        _studyCreditView = [[ZMStudyCreditView alloc] initWithFrame:SCREEN_BOUNDS];
    }
    return _studyCreditView;
}

@end
