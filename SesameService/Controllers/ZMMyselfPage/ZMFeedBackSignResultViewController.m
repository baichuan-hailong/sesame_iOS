//
//  ZMFeedBackSignResultViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/6/8.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMFeedBackSignResultViewController.h"
#import "ZMFeedBackSignView.h"

#import "ZMFeedBackSignTableViewCell.h"

@interface ZMFeedBackSignResultViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic , strong)ZMFeedBackSignView *feedBackSignView;
@property (nonatomic , strong)NSArray            *feedBackArray;
@property (nonatomic, strong) MBProgressHUD      *hud;

@property(nonatomic,strong)NSString *timeStamp;
@end

@implementation ZMFeedBackSignResultViewController

-(void)loadView{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.feedBackSignView    = [[ZMFeedBackSignView alloc] initWithFrame:SCREEN_BOUNDS];
    self.view                = self.feedBackSignView;
    self.feedBackSignView.feedBackTableView.delegate   = self;
    self.feedBackSignView.feedBackTableView.dataSource = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"反馈项目双方签约结果";
    
    
    
    
    
    if (_isFnishFeedBackBool) {
        self.feedBackArray = @[@{@"left":@"项目签约时间",@"right":[self timeChange:self.sign_time]}];
        self.feedBackSignView.feedBackTableView.tableHeaderView = self.feedBackSignView.feedBackHeaderView;
    }else{
        self.feedBackArray = @[];
        self.feedBackSignView.feedBackTableView.tableFooterView = self.feedBackSignView.feedBackFooterView;
        
        self.feedBackSignView.feedBackCommit.userInteractionEnabled = NO;
        self.feedBackSignView.feedBackCommit.alpha = 0.6;
        
        
        self.feedBackSignView.feedBackTimeTextField.delegate = self;
        [self.feedBackSignView.cancleBtn addTarget:self
                                            action:@selector(cancleBtnClick)
                                  forControlEvents:UIControlEventTouchUpInside];
        [self.feedBackSignView.sureBtn addTarget:self
                                          action:@selector(sureBtnClick:)
                                forControlEvents:UIControlEventTouchUpInside];
        
        [self.feedBackSignView.feedBackCommit addTarget:self
                                          action:@selector(feedBackCommitClickAc:)
                                forControlEvents:UIControlEventTouchUpInside];
        
        
        UITapGestureRecognizer *viewTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(cancleBtnClick)];
        [self.view addGestureRecognizer:viewTapGR];
    }
}

#pragma mark - TF Delegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    [UIView animateWithDuration:0.28 animations:^{
        self.feedBackSignView.topView.frame = CGRectMake(0,
                                                         SCREEN_HEIGHT-SCREEN_WIDTH/375*200-SCREEN_WIDTH/375*25,
                                                         SCREEN_WIDTH,
                                                         SCREEN_WIDTH/375*200+SCREEN_WIDTH/375*25);
    }];
    return NO;
}



#pragma mark - cancle & suer
- (void)cancleBtnClick{
    NSLog(@"cancle");
    [UIView animateWithDuration:0.28 animations:^{
        self.feedBackSignView.topView.frame = CGRectMake(0,
                                                        SCREEN_HEIGHT,
                                                        SCREEN_WIDTH,
                                                        SCREEN_WIDTH/375*200+SCREEN_WIDTH/375*25);
    }];
}

- (void)sureBtnClick:(UIButton *)sender{
    NSLog(@"suere");
    [UIView animateWithDuration:0.28 animations:^{
        self.feedBackSignView.topView.frame = CGRectMake(0,
                                                        SCREEN_HEIGHT,
                                                        SCREEN_WIDTH,
                                                        SCREEN_WIDTH/375*200+SCREEN_WIDTH/375*25);
    }];
    
    self.feedBackSignView.feedBackTimeTextField.text = [self changeFormat:self.feedBackSignView.myDatePicker.date];
    self.timeStamp = [self timestamp:self.feedBackSignView.myDatePicker.date];
    
    
    NSMutableParagraphStyle *paraStyle01 = [[NSMutableParagraphStyle alloc] init];
    CGFloat emptylen = self.feedBackSignView.feedBackTimeTextField.font.pointSize*0.2;
    paraStyle01.firstLineHeadIndent = emptylen;//首行缩进
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:self.feedBackSignView.feedBackTimeTextField.text
                                                                   attributes:@{NSParagraphStyleAttributeName:paraStyle01}];
    self.feedBackSignView.feedBackTimeTextField.attributedText = attrText;
    
    self.feedBackSignView.feedBackCommit.userInteractionEnabled = YES;
    self.feedBackSignView.feedBackCommit.alpha = 1;
}



#pragma mark - 提交
- (void)feedBackCommitClickAc:(UIButton *)sender{
    NSLog(@"commit");
    [self hud];
    
    NSDictionary *parm = @{@"info_id":self.infoID,
                           @"sign_time":self.timeStamp};
    NSString *urlStr   = [NSString stringWithFormat:@"%@/info/perform",APIDev];
    [AFNetManager requestWithType:HttpRequestTypePost withUrlString:urlStr withParaments:parm withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"parm --- %@",parm);
        NSLog(@"sign --- %@",object);
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            
            
            self.feedBackArray = @[@{@"left":@"项目签约时间",@"right":[self timeChange:self.timeStamp]}];
            self.feedBackSignView.feedBackTableView.tableHeaderView = self.feedBackSignView.feedBackHeaderView;
            self.feedBackSignView.feedBackTableView.tableFooterView = [[UIView alloc] init];
            [self.feedBackSignView.feedBackTableView reloadData];
            //successful
            [[NSNotificationCenter defaultCenter] postNotificationName:@"finishFeedBackNotifiAc" object:nil];
            
        }else{
            [self showProgress:object[@"status"][@"message"]];
        }
        [self.hud hide:YES];
    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
        [self.hud hide:YES];
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}




#pragma mark - Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.feedBackArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return SCREEN_WIDTH/375*50;
}

/**header**/
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return SCREEN_WIDTH/375*0;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView         = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}



/**footer**/
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return SCREEN_WIDTH/375*0;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *footView         = [[UIView alloc] init];
    footView.backgroundColor = [UIColor clearColor];
    return footView;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *feedDic = self.feedBackArray[indexPath.row];
    
    static NSString *feedBackIndentifire             = @"feedBackIndentifireCell";
    ZMFeedBackSignTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:feedBackIndentifire];
    if (!cell) {
        cell = [[ZMFeedBackSignTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:feedBackIndentifire];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setFeedBack:feedDic];
    if (indexPath.row == self.feedBackArray.count-1) {
        cell.line.alpha = 0;
    }else{
        cell.line.alpha = 1;
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


#pragma mark - 标准时间格式
- (NSString *)changeFormat:(NSDate *)timeData {
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *currentDateStr = [formatter stringFromDate: timeData];
    return currentDateStr;
}

//NSDate转时间戳
- (NSString *)timestamp:(NSDate *)timeData{
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[timeData timeIntervalSince1970]];
    return timeSp;
}



#pragma mark - 时间戳转换为标准时间
- (NSString *)timeChange:(NSString *)timeStamp {
    NSTimeInterval time = [timeStamp doubleValue];// + 28800;  //因为时差问题要加8小时 == 28800
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSString *currentDateStr = [formatter stringFromDate: date];
    return currentDateStr;
}


- (MBProgressHUD *)hud {
    if (_hud == nil) {
        
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _hud.userInteractionEnabled = NO;
        _hud.removeFromSuperViewOnHide = YES;
    }
    return _hud;
}



//MBProgress
- (void)showProgress:(NSString *)tipStr{
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud            = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
    hud.mode                      = MBProgressHUDModeText;
    hud.labelText                 = tipStr;
    hud.margin                    = 20.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
