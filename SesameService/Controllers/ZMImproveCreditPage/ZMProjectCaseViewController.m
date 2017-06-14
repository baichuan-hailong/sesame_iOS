//
//  ZMProjectCaseViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/30.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMProjectCaseViewController.h"
#import "ZMProjectCaseView.h"
#import "ZMprojectCaseShowTableViewCell.h"
#import "ZMProjectCaseAddFooterView.h"

@interface ZMProjectCaseViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    BOOL isLoading;
}
@property(nonatomic,strong)ZMProjectCaseView *projectCaseView;
@property(nonatomic,strong)ZMProjectCaseAddFooterView *projectCaseFooterView;

@property(nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic , strong) MBProgressHUD *HUD;

@property(nonatomic,strong)NSString *timeStamp;
@property(nonatomic,strong)NSData   *imageData;
@end

@implementation ZMProjectCaseViewController

-(void)loadView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.projectCaseView = [[ZMProjectCaseView alloc] initWithFrame:SCREEN_BOUNDS];
    self.projectCaseView.projectCaseTableView.delegate = self;
    self.projectCaseView.projectCaseTableView.dataSource=self;
    self.view = self.projectCaseView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"项目案例";
    
    
    UITapGestureRecognizer *viewTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(viewTapGRAction:)];
    [self.view addGestureRecognizer:viewTapGR];
    
    
    [self setMJRefreshConfig:self.projectCaseView.projectCaseTableView];
    [self.projectCaseView.projectCaseTableView.mj_header beginRefreshing];
    
    [self.projectCaseView.cancleBtn addTarget:self action:@selector(cancleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.projectCaseView.sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];

}

#pragma mark - cancle & suer
- (void)cancleBtnClick:(UIButton *)sender{
    NSLog(@"cancle");
    [UIView animateWithDuration:0.28 animations:^{
        self.projectCaseView.topView.frame = CGRectMake(0,
                                                       SCREEN_HEIGHT,
                                                       SCREEN_WIDTH,
                                                       SCREEN_WIDTH/375*200+SCREEN_WIDTH/375*25);
    }];
}

- (void)sureBtnClick:(UIButton *)sender{
    NSLog(@"suere");
    [UIView animateWithDuration:0.28 animations:^{
        self.projectCaseView.topView.frame = CGRectMake(0,
                                                       SCREEN_HEIGHT,
                                                       SCREEN_WIDTH,
                                                       SCREEN_WIDTH/375*200+SCREEN_WIDTH/375*25);
    }];
    
    self.projectCaseFooterView.timeTextField.text = [self changeFormat:self.projectCaseView.myDatePicker.date];
    self.timeStamp = [self timestamp:self.projectCaseView.myDatePicker.date];

    
    NSMutableParagraphStyle *paraStyle01 = [[NSMutableParagraphStyle alloc] init];
    CGFloat emptylen = self.projectCaseFooterView.timeTextField.font.pointSize*1;
    paraStyle01.firstLineHeadIndent = emptylen;//首行缩进
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:self.projectCaseFooterView.timeTextField.text
                                                                   attributes:@{NSParagraphStyleAttributeName:paraStyle01}];
    self.projectCaseFooterView.timeTextField.attributedText = attrText;
    

    [self tfDidChange];
}


- (void)addFooterAction{
    
    self.projectCaseFooterView = [[ZMProjectCaseAddFooterView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*0,
                                              SCREEN_WIDTH/375*0,
                                              SCREEN_WIDTH,
                                              SCREEN_WIDTH/375*317)];
    
    self.projectCaseView.projectCaseTableView.tableFooterView = self.projectCaseFooterView;
    
    self.projectCaseFooterView.projectTextField.delegate = self;
    
    
    self.projectCaseFooterView.timeTextField.userInteractionEnabled  = YES;
    UITapGestureRecognizer *timeTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(timeTapGRAction:)];
    [self.projectCaseFooterView.timeTextField addGestureRecognizer:timeTapGR];
    
    
    self.projectCaseFooterView.addBtn.userInteractionEnabled = NO;
    self.projectCaseFooterView.addBtn.alpha = 0.6;
    [self.projectCaseFooterView.addBtn addTarget:self action:@selector(addBtnClickAction:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)tfDidChange{
    if (self.projectCaseFooterView.timeTextField.text.length>0&&self.projectCaseFooterView.projectTextField.text.length>0) {
        
        self.projectCaseFooterView.addBtn.userInteractionEnabled = YES;
        self.projectCaseFooterView.addBtn.alpha = 1;
    }else{
        
        self.projectCaseFooterView.addBtn.userInteractionEnabled = NO;
        self.projectCaseFooterView.addBtn.alpha = 0.6;
    }
}


#pragma mark - Time
- (void)timeTapGRAction:(UITapGestureRecognizer *)sender{
    
    [self.view endEditing:YES];
    
    [UIView animateWithDuration:0.28 animations:^{
        self.projectCaseView.topView.frame = CGRectMake(0,
                                                            SCREEN_HEIGHT-SCREEN_WIDTH/375*200-SCREEN_WIDTH/375*25,
                                                            SCREEN_WIDTH,
                                                            SCREEN_WIDTH/375*200+SCREEN_WIDTH/375*25);
    }];
    
    self.projectCaseView.myDatePicker.datePickerMode = UIDatePickerModeDate;
    [self.projectCaseView.myDatePicker addTarget:self
                                         action:@selector(datePickerDateChanged:)
                               forControlEvents:UIControlEventValueChanged];
}

#pragma mark - 添加
- (void)addBtnClickAction:(UIButton *)sender{
    NSLog(@"add");
    
    
    if (self.projectCaseFooterView.projectTextField.text.length>0&&self.projectCaseFooterView.projectTextField.text.length<=30&&self.timeStamp.length>0) {
        self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:self.HUD];
        [self.HUD show:YES];
        
        
        [UIView animateWithDuration:0.28 animations:^{
            self.projectCaseView.topView.frame = CGRectMake(0,
                                                            SCREEN_HEIGHT,
                                                            SCREEN_WIDTH,
                                                            SCREEN_WIDTH/375*200+SCREEN_WIDTH/375*25);
        }];
        [self.view endEditing:YES];
        
        
        NSString *urlStr   = [NSString stringWithFormat:@"%@/user/create-case",APIDev];
        NSDictionary *praDic = @{@"title":self.projectCaseFooterView.projectTextField.text,
                                 @"record_time":self.timeStamp};
        
        
        NSLog(@"praDic ---- %@",praDic);
        
        NSMutableDictionary *praMutableDic = [NSMutableDictionary dictionaryWithDictionary:praDic];
        
        [AFNetManager requestWithType:HttpRequestTypePost withUrlString:urlStr withParaments:praMutableDic withSuccessBlock:^(NSDictionary *object) {
            NSLog(@"%@",object);
            NSString *stateStr    = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
            if ([stateStr isEqualToString:@"success"]) {
                NSString *caseID = [NSString stringWithFormat:@"%@",object[@"data"][@"id"]];
                
                [praMutableDic setObject:caseID forKey:@"id"];
                [self.dataArray addObject:praMutableDic];
                
                self.projectCaseFooterView.projectTextField.text = @"";
                self.projectCaseFooterView.timeTextField.text = @"";
                
                self.projectCaseFooterView.addBtn.userInteractionEnabled = NO;
                self.projectCaseFooterView.addBtn.alpha = 0.6;
                
                [self.projectCaseView.projectCaseTableView reloadData];
            }else{
                [self showProgress:object[@"status"][@"message"]];
            }
            [self.HUD hide:YES];
        } withFailureBlock:^(NSError *error) {
            NSLog(@"add ----------- %@",error);
            [self.HUD hide:YES];
        } progress:^(float progress) {
            NSLog(@"%f",progress);
        }];
    }else{
        if (self.projectCaseFooterView.projectTextField.text.length>30) {
            [self showProgress:@"项目名称的不能超过30个字符！"];
        }else{
            [self showProgress:@"请完整填写案例信息！"];
        }
    }
}



#pragma mark - TF Delegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

    [UIView animateWithDuration:0.28 animations:^{
        self.projectCaseView.topView.frame = CGRectMake(0,
                                                            SCREEN_HEIGHT,
                                                            SCREEN_WIDTH,
                                                            SCREEN_WIDTH/375*200+SCREEN_WIDTH/375*25);
    }];
    
    [UIView animateWithDuration:0.28 animations:^{
        self.projectCaseView.projectCaseTableView.contentOffset = CGPointMake(0, SCREEN_WIDTH/375*91*self.dataArray.count);
    }];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    [self tfDidChange];
    return YES;
}

#pragma mark - SouceData
- (void)souceData{

    NSString *urlStr   = [NSString stringWithFormat:@"%@/user/case",APIDev];
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:nil withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"%@",object);
        isLoading = YES;
        NSString *stateStr    = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            
            [self.dataArray removeAllObjects];
            NSArray *tempArray =  [NSArray arrayWithArray:object[@"data"]];
            self.dataArray = [NSMutableArray arrayWithArray:tempArray];
            [self.projectCaseView.projectCaseTableView reloadData];
            NSLog(@"data --- %@",self.dataArray);
            
        }else{
            [self showProgress:object[@"status"][@"message"]];
        }
        [self addFooterAction];
        [self.projectCaseView.projectCaseTableView.mj_header endRefreshing];
    } withFailureBlock:^(NSError *error) {
        NSLog(@"pro case - %@",error);
        isLoading = YES;
        [self addFooterAction];
        [self.projectCaseView.projectCaseTableView.mj_header endRefreshing];
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}


#pragma mark - Tap
- (void)viewTapGRAction:(UITapGestureRecognizer *)sender{
    NSLog(@"tap");
    [UIView animateWithDuration:0.28 animations:^{
        self.projectCaseView.topView.frame = CGRectMake(0,
                                                    SCREEN_HEIGHT,
                                                    SCREEN_WIDTH,
                                                    SCREEN_WIDTH/375*200+SCREEN_WIDTH/375*25);
    }];
    [self.view endEditing:YES];
    
}





//获取系统当前的时间戳
- (NSString *)timestamp{
    NSTimeInterval a=[[NSDate date] timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.f", a];//转为字符型
    return timeString;
}




#pragma mark - Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREEN_WIDTH/375*71;
}

/********header**********/
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (self.dataArray.count==0) {
        
        if (isLoading) {
            return SCREEN_WIDTH/375*40;
        }else{
            return SCREEN_WIDTH/375*0.01;
        }
    }else{
        
        return SCREEN_WIDTH/375*0.01;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (self.dataArray.count==0) {
        
        if (isLoading) {
            UIView *header         = [[UIView alloc] init];
            header.backgroundColor = [UIColor whiteColor];
            UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/375*40)];
            [ZMLabelAttributeMange setLabel:headerLabel
                                       text:@"还没有任何项目案例"
                                        hex:@"333333"
                              textAlignment:NSTextAlignmentCenter
                                       font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*15]];
            [header addSubview:headerLabel];
            return header;
        }else{
            UIView *header         = [[UIView alloc] init];
            header.backgroundColor = [UIColor clearColor];
            return header;
        }
        
    }else{
        UIView *header         = [[UIView alloc] init];
        header.backgroundColor = [UIColor clearColor];
        return header;
    }
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIndentifire = @"showCell";
    NSDictionary *caseDic            = self.dataArray[indexPath.row];
    ZMprojectCaseShowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifire];
    if (!cell) {
        cell = [[ZMprojectCaseShowTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                     reuseIdentifier:cellIndentifire];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setProjectCase:caseDic];
    if (indexPath.row==self.dataArray.count-1) {
        cell.line.alpha = 0;
    }else{
        cell.line.alpha = 1;
    }
    cell.deleteBtn.tag = 3030+indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"Did Select");
}


#pragma mark - Delete
- (void)deleteBtnClick:(UIButton *)sender{
    NSLog(@"delete");
    
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:nil
                                                                         message:@"确定要删除项目案例？"
                                                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction        = [UIAlertAction actionWithTitle:@"确定"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction *action) {
                                                                
                                                                [self deleteCase:sender];
                                                            }];
    UIAlertAction *cancle          = [UIAlertAction actionWithTitle:@"取消"
                                                              style:UIAlertActionStyleCancel
                                                            handler:^(UIAlertAction *action) {
                                                            }];
    
    [cancle setValue:[UIColor colorWithHex:@"000000"] forKey:@"titleTextColor"];
    [alertDialog addAction:cancle];
    [alertDialog addAction:okAction];
    [self presentViewController:alertDialog animated:YES completion:nil];
}

- (void)deleteCase:(UIButton *)sender{
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    [self.HUD show:YES];
    
    NSDictionary *caseDic            = self.dataArray[sender.tag-3030];
    NSLog(@"%@",caseDic);
    
    NSString *urlStr   = [NSString stringWithFormat:@"%@/user/remove-honor-case",APIDev];
    NSString *caseID   = [NSString stringWithFormat:@"%@",caseDic[@"id"]];
    NSDictionary *parDic = @{@"id":caseID};
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:parDic withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"%@",object);
        NSString *stateStr    = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            
            [self.dataArray removeObject:caseDic];
            [self.projectCaseView.projectCaseTableView reloadData];
        }else{
            [self showProgress:object[@"status"][@"message"]];
        }
        [self.HUD hide:YES];
    } withFailureBlock:^(NSError *error) {
        NSLog(@"delete ---------------------- %@",error);
        [self.HUD hide:YES];
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}


- (void)setMJRefreshConfig:(UITableView *)tableView{
    
    MJRefreshNormalHeader     *header;
    header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(souceData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    [header setTitle:@"下拉刷新"  forState:MJRefreshStateIdle];
    [header setTitle:@"释放更新"  forState:MJRefreshStatePulling];
    [header setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    tableView.mj_header = header;
    
}


- (void)datePickerDateChanged:(UIDatePicker *)paramDatePicker {
    if ([paramDatePicker isEqual:self.projectCaseView.myDatePicker]) {
        NSLog(@"Selected date = %@", paramDatePicker.date);
        self.projectCaseFooterView.timeTextField.text = [self changeFormat:paramDatePicker.date];
        self.timeStamp = [self timestamp:paramDatePicker.date];
        

        
        NSMutableParagraphStyle *paraStyle01 = [[NSMutableParagraphStyle alloc] init];
        CGFloat emptylen = self.projectCaseFooterView.timeTextField.font.pointSize*1;
        paraStyle01.firstLineHeadIndent = emptylen;//首行缩进
        NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:self.projectCaseFooterView.timeTextField.text
                                                                       attributes:@{NSParagraphStyleAttributeName:paraStyle01}];
        self.projectCaseFooterView.timeTextField.attributedText = attrText;
        
        
        
        //NSLog(@"选择的时间戳 ---- %@",[self timestamp:paramDatePicker.date]);
        //NSLog(@"选择的标准时间---- %@",[self timeChange:[self timestamp:paramDatePicker.date]]);
        //NSLog(@"当前时间戳   ------ %@",[self timestamp]);
        //NSLog(@"当前标准时间 ------ %@",[self timeChange:[self timestamp]]);
        
        [self tfDidChange];
    }
}


#pragma mark - 时间戳转换为标准时间
- (NSString *)timeChange:(NSString *)timeStamp {
    NSTimeInterval time = [timeStamp doubleValue];// + 28800;  //因为时差问题要加8小时 == 28800
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSString *currentDateStr = [formatter stringFromDate: date];
    return currentDateStr;
}




#pragma mark - 标准时间格式
- (NSString *)changeFormat:(NSDate *)timeData {
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr = [formatter stringFromDate: timeData];
    return currentDateStr;
}



//NSDate转时间戳
- (NSString *)timestamp:(NSDate *)timeData{
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[timeData timeIntervalSince1970]];
    return timeSp;
}



//MBProgress
- (void)showProgress:(NSString *)tipStr{
    MBProgressHUD *hud            = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
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
