//
//  ZMAwardsHonorViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/30.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMAwardsHonorViewController.h"
#import "ZMAwardHonorView.h"
#import "ZMAwardHonorShowTableViewCell.h"
#import "ZMAwardHonorAddFooterView.h"

@interface ZMAwardsHonorViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    BOOL isSelectImg;
    
    BOOL isLoading;
}
@property (nonatomic,strong)ZMAwardHonorView *awardHonorView;

@property(nonatomic,strong)ZMAwardHonorAddFooterView *awardHonorAddFooterView;

@property(nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic , strong) MBProgressHUD *HUD;
@property(nonatomic,strong)UIActionSheet *camerSheet;

@property(nonatomic,strong)NSString *timeStamp;
@property(nonatomic,strong)NSData   *imageData;


@end

@implementation ZMAwardsHonorViewController

-(void)loadView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.awardHonorView = [[ZMAwardHonorView alloc] initWithFrame:SCREEN_BOUNDS];
    self.awardHonorView.awardHonorTableView.delegate = self;
    self.awardHonorView.awardHonorTableView.dataSource=self;
    self.view = self.awardHonorView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"奖项荣誉";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    isSelectImg = NO;
    
    
    UITapGestureRecognizer *viewTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapGRAction:)];
    [self.view addGestureRecognizer:viewTapGR];
    
    
    [self setMJRefreshConfig:self.awardHonorView.awardHonorTableView];
    [self.awardHonorView.awardHonorTableView.mj_header beginRefreshing];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addAwardHonorSuccessful:) name:@"addAwardHonorSuccessful" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addAwardHonorFailed) name:@"addAwardHonorFailed" object:nil];
    
    [self.awardHonorView.cancleBtn addTarget:self action:@selector(cancleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.awardHonorView.sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];

}

#pragma mark - cancle & suer
- (void)cancleBtnClick:(UIButton *)sender{
    NSLog(@"cancle");
    [UIView animateWithDuration:0.28 animations:^{
        self.awardHonorView.topView.frame = CGRectMake(0,
                                                       SCREEN_HEIGHT,
                                                       SCREEN_WIDTH,
                                                       SCREEN_WIDTH/375*200+SCREEN_WIDTH/375*25);
    }];
}

- (void)sureBtnClick:(UIButton *)sender{
    NSLog(@"suere");
    [UIView animateWithDuration:0.28 animations:^{
        self.awardHonorView.topView.frame = CGRectMake(0,
                                                       SCREEN_HEIGHT,
                                                       SCREEN_WIDTH,
                                                       SCREEN_WIDTH/375*200+SCREEN_WIDTH/375*25);
    }];
    
    self.awardHonorAddFooterView.awardTimeTextField.text = [self changeFormat:self.awardHonorView.myDatePicker.date];
    self.timeStamp = [self timestamp:self.awardHonorView.myDatePicker.date];
    NSMutableParagraphStyle *paraStyle01 = [[NSMutableParagraphStyle alloc] init];
    CGFloat emptylen = self.awardHonorAddFooterView.awardTimeTextField.font.pointSize*1;
    paraStyle01.firstLineHeadIndent = emptylen;//首行缩进
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:self.awardHonorAddFooterView.awardTimeTextField.text
                                                                   attributes:@{NSParagraphStyleAttributeName:paraStyle01}];
    self.awardHonorAddFooterView.awardTimeTextField.attributedText = attrText;
    [self tfDidChange];
}


#pragma mark - Picture
- (void)addAwardHonorSuccessful:(NSNotification *)noti{
    
    [noti object];
    NSDictionary *dic = (NSDictionary *)[noti object];
    //NSLog(@"fileDic-------%@",dic);
    NSString *fileName = [NSString stringWithFormat:@"%@",dic[@"fileName"]];
    NSLog(@"fileName------%@",fileName);
    

     NSString *urlStr   = [NSString stringWithFormat:@"%@/user/create-honor",APIDev];
     NSDictionary *praDic = @{@"title":self.awardHonorAddFooterView.awardNameTextField.text,
                             @"picture":fileName,
                             @"record_time":self.timeStamp};
    
     NSMutableDictionary *praMutableDic = [NSMutableDictionary dictionaryWithDictionary:praDic];
     [AFNetManager requestWithType:HttpRequestTypePost withUrlString:urlStr withParaments:praMutableDic withSuccessBlock:^(NSDictionary *object) {
             NSLog(@"%@",object);
             NSString *stateStr    = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
             if ([stateStr isEqualToString:@"success"]) {
                 
                 //NSString *awardID = [NSString stringWithFormat:@"%@",object[@"data"][@"id"]];
                 //[praMutableDic setObject:awardID forKey:@"id"];
                 //[self.dataArray addObject:praMutableDic];
                 
                 
                 isSelectImg = NO;
                 self.awardHonorAddFooterView.awardImageView.image = [UIImage imageNamed:@"awardHonorImage"];
                 self.awardHonorAddFooterView.awardTimeTextField.text = @"";
                 self.awardHonorAddFooterView.awardNameTextField.text = @"";
                 [self tfDidChange];
                 
                 [self.awardHonorView.awardHonorTableView.mj_header beginRefreshing];
                 //[self.awardHonorView.awardHonorTableView reloadData];
             }else{
                 [self showProgress:object[@"status"][@"message"]];
             }
             [self.HUD hide:YES];
     } withFailureBlock:^(NSError *error) {
             NSLog(@"honor ----- %@",error);
             [self.HUD hide:YES];
     } progress:^(float progress) {
             NSLog(@"%f",progress);
     }];
     
}

- (void)addAwardHonorFailed{
    NSLog(@"fail");
    [self showProgress:@"添加失败！"];
    [self.HUD hide:YES];
}


#pragma mark - Footer
- (void)addFooterAction{
    self.awardHonorAddFooterView = [[ZMAwardHonorAddFooterView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*0,
                                                                                              SCREEN_WIDTH/375*0,
                                                                                              SCREEN_WIDTH,
                                                                                              SCREEN_WIDTH/375*503)];
    self.awardHonorView.awardHonorTableView.tableFooterView = self.awardHonorAddFooterView;
    
    [self.awardHonorAddFooterView.addBtn addTarget:self action:@selector(addBtnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.awardHonorAddFooterView.awardNameTextField.delegate = self;
    //self.awardHonorAddFooterView.awardTimeTextField.delegate = self;
    [self.awardHonorAddFooterView.awardNameTextField addTarget:self action:@selector(tfDidChange) forControlEvents:UIControlEventEditingChanged];
    //[self.awardHonorAddFooterView.awardTimeTextField addTarget:self action:@selector(tfDidChange) forControlEvents:UIControlEventEditingChanged];
    
    UITapGestureRecognizer *timeTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(timeTapGRAction:)];
    [self.awardHonorAddFooterView.awardTimeTextField addGestureRecognizer:timeTapGR];
    
    UITapGestureRecognizer *honorImageTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(honorImageTapGRAction:)];
    [self.awardHonorAddFooterView.awardImageView addGestureRecognizer:honorImageTapGR];
}

- (void)tfDidChange{
    if (isSelectImg==YES&&self.awardHonorAddFooterView.awardTimeTextField.text.length>0&&self.awardHonorAddFooterView.awardTimeTextField.text.length>0) {
        self.awardHonorAddFooterView.addBtn.alpha = 1;
        self.awardHonorAddFooterView.addBtn.userInteractionEnabled = YES;
    }else{
        
        self.awardHonorAddFooterView.addBtn.alpha = 0.6;
        self.awardHonorAddFooterView.addBtn.userInteractionEnabled = NO;
    }
}

#pragma mark - TF Delegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    [UIView animateWithDuration:0.28 animations:^{
        self.awardHonorView.topView.frame = CGRectMake(0,
                                            SCREEN_HEIGHT,
                                            SCREEN_WIDTH,
                                            SCREEN_WIDTH/375*200+SCREEN_WIDTH/375*25);
    }];
    
    [UIView animateWithDuration:0.28 animations:^{
        self.awardHonorView.awardHonorTableView.contentOffset = CGPointMake(0,
                                                                            SCREEN_WIDTH/375*91*self.dataArray.count);
    }];
    return YES;
}


#pragma mark - Time
- (void)timeTapGRAction:(UITapGestureRecognizer *)sender{
    
    [self.view endEditing:YES];
    
    [UIView animateWithDuration:0.28 animations:^{
        self.awardHonorView.topView.frame = CGRectMake(0,
                                                       SCREEN_HEIGHT-SCREEN_WIDTH/375*200-SCREEN_WIDTH/375*25,
                                                       SCREEN_WIDTH,
                                                       SCREEN_WIDTH/375*200+SCREEN_WIDTH/375*25);
    }];
    
    self.awardHonorView.myDatePicker.datePickerMode = UIDatePickerModeDate;
    [self.awardHonorView.myDatePicker addTarget:self
                                         action:@selector(datePickerDateChanged:)
                               forControlEvents:UIControlEventValueChanged];
}


#pragma mark - SouceData
- (void)souceData{
    
    NSString *urlStr   = [NSString stringWithFormat:@"%@/user/honor",APIDev];
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:nil withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"%@",object);
        isLoading = YES;
        NSString *stateStr    = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            
            [self.dataArray removeAllObjects];
            NSArray *tempArray = [NSArray arrayWithArray:object[@"data"]];
            self.dataArray     = [NSMutableArray arrayWithArray:tempArray];
            [self.awardHonorView.awardHonorTableView reloadData];
            NSLog(@"data --- %@",self.dataArray);
        }else{
            [self showProgress:object[@"status"][@"message"]];
        }
        [self.awardHonorView.awardHonorTableView.mj_header endRefreshing];
        [self addFooterAction];
    } withFailureBlock:^(NSError *error) {
        NSLog(@"award honor ---- %@",error);
        isLoading = YES;
        self.dataArray     = [NSMutableArray array];
        [self.awardHonorView.awardHonorTableView.mj_header endRefreshing];
        [self addFooterAction];
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}



#pragma mark - Tap
- (void)viewTapGRAction:(UITapGestureRecognizer *)sender{
    NSLog(@"tap");
    [UIView animateWithDuration:0.28 animations:^{
        self.awardHonorView.topView.frame = CGRectMake(0,
                                                       SCREEN_HEIGHT,
                                                       SCREEN_WIDTH,
                                                       SCREEN_WIDTH/375*200+SCREEN_WIDTH/375*25);
    }];
    [self.view endEditing:YES];
    
    
}

#pragma mark - Select Image
- (void)honorImageTapGRAction:(UITapGestureRecognizer *)sender{
    
    [UIView animateWithDuration:0.28 animations:^{
        self.awardHonorView.topView.frame = CGRectMake(0,
                                                       SCREEN_HEIGHT,
                                                       SCREEN_WIDTH,
                                                       SCREEN_WIDTH/375*200+SCREEN_WIDTH/375*25);
    }];
    
    NSLog(@"Select Image");
    self.camerSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                  delegate:self
                                         cancelButtonTitle:@"取消"
                                    destructiveButtonTitle:nil
                                         otherButtonTitles:@"拍照",@"图片上传", nil];
    [self.camerSheet showInView:self.view];
}

#pragma mark - SheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == actionSheet.firstOtherButtonIndex) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *imagePickerVC = [[UIImagePickerController alloc] init];
            imagePickerVC.delegate = self;
            imagePickerVC.allowsEditing = YES;
            imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePickerVC animated:YES completion:nil];
        }
    }else if (buttonIndex == actionSheet.firstOtherButtonIndex + 1){
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            UIImagePickerController *imagePickerVC = [[UIImagePickerController alloc] init];
            [imagePickerVC setModalPresentationStyle:UIModalPresentationFullScreen];
            imagePickerVC.delegate = self;
            imagePickerVC.allowsEditing = YES;
            imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePickerVC animated:YES completion:nil];
        }
    }
}


#pragma mark - 图片处理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    isSelectImg = YES;
    [self tfDidChange];
    
    UIImage *awardImage = [info objectForKey:UIImagePickerControllerEditedImage];
    NSData *imageData = UIImageJPEGRepresentation(awardImage, 0.2);
    self.imageData = imageData;
    self.awardHonorAddFooterView.awardImageView.image = awardImage;
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Add
- (void)addBtnClickAction:(UIButton *)sender{
    NSLog(@"add");
    
    
    if (self.awardHonorAddFooterView.awardNameTextField.text.length>20) {
        [self showProgress:@"奖项名称不能超过20个字符!"];
    }else{
        self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:self.HUD];
        [self.HUD show:YES];
        
        AliyunOSSManager *ossManager = [AliyunOSSManager new];
        [ossManager creatOSSClient:PrefixResource];
        //uploading
        [ossManager uploadObjectAsyncResister:self.imageData path:ResourceUser];
    }
    
    
}



#pragma mark - Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return SCREEN_WIDTH/375*91;
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
                                       text:@"还没有任何奖项荣誉"
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
    
    static NSString *cellIndentifire         = @"awardShowCell";
    NSDictionary *awardDic = self.dataArray[indexPath.row];
    ZMAwardHonorShowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifire];
    if (!cell) {
        cell = [[ZMAwardHonorShowTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifire];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setAwardHonor:awardDic];
    if (indexPath.row==self.dataArray.count-1) {
        cell.line.alpha = 0;
    }else{
        cell.line.alpha = 1;
    }
    cell.deleteBtn.tag = 3040+indexPath.row;
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
                                                                         message:@"确定要删除奖项荣誉？"
                                                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction        = [UIAlertAction actionWithTitle:@"确定"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction *action) {
                                                                [self deleteAward:sender];
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

-(void)deleteAward:(UIButton *)sender{
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    [self.HUD show:YES];
    
    NSDictionary *awardDic            = self.dataArray[sender.tag-3040];
    NSLog(@"%@",awardDic);
    
    NSString *urlStr   = [NSString stringWithFormat:@"%@/user/remove-honor-case",APIDev];
    NSString *awardID   = [NSString stringWithFormat:@"%@",awardDic[@"id"]];
    NSDictionary *parDic = @{@"id":awardID};
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:parDic withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"%@",object);
        NSString *stateStr    = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            [self.dataArray removeObject:awardDic];
            [self.awardHonorView.awardHonorTableView reloadData];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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









- (void)datePickerDateChanged:(UIDatePicker *)paramDatePicker {
    if ([paramDatePicker isEqual:self.awardHonorView.myDatePicker]) {
        NSLog(@"Selected date = %@", paramDatePicker.date);
        self.awardHonorAddFooterView.awardTimeTextField.text = [self changeFormat:paramDatePicker.date];
        
        self.timeStamp = [self timestamp:paramDatePicker.date];
        
        NSMutableParagraphStyle *paraStyle01 = [[NSMutableParagraphStyle alloc] init];
        CGFloat emptylen = self.awardHonorAddFooterView.awardTimeTextField.font.pointSize*1;
        paraStyle01.firstLineHeadIndent = emptylen;//首行缩进
        NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:self.awardHonorAddFooterView.awardTimeTextField.text
                                                                       attributes:@{NSParagraphStyleAttributeName:paraStyle01}];
        self.awardHonorAddFooterView.awardTimeTextField.attributedText = attrText;
        
        //NSLog(@"选择的时间戳 ---- %@",[self timestamp:paramDatePicker.date]);
        //NSLog(@"选择的标准时间---- %@",[self timeChange:[self timestamp:paramDatePicker.date]]);
        //NSLog(@"当前时间戳   ------ %@",[self timestamp]);
        //NSLog(@"当前标准时间 ------ %@",[self timeChange:[self timestamp]]);
        [self tfDidChange];
    }
}



//current system timeCode
- (NSString *)timestamp{
    NSTimeInterval a=[[NSDate date] timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.f", a];//转为字符型
    return timeString;
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


@end
