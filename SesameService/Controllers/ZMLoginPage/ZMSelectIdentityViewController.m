//
//  ZMSelectIdentityViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/30.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMSelectIdentityViewController.h"
#import "ZMSelectIdentityView.h"

@interface ZMSelectIdentityViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)ZMSelectIdentityView *selectIdentityView;

//默认企业
@property(nonatomic,strong)NSString *userType;

@property (nonatomic , strong) MBProgressHUD *HUD;
@end

@implementation ZMSelectIdentityViewController
-(void)loadView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.selectIdentityView = [[ZMSelectIdentityView alloc] initWithFrame:SCREEN_BOUNDS];
    self.view               = self.selectIdentityView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择会员身份";
    
    
    //默认企业
    self.userType = @"2";
    
    [self addAction];
    
    
    /********************Binding*************************/
    //Avatar
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(uploadAvatarSuccessfulAc)
                                                 name:@"uploadAvatarSuccessful"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(uploadAvatarFailedAc)
                                                 name:@"uploadAvatarFailed"
                                               object:nil];
}

-(void)backAction{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addAction{
    [self.selectIdentityView.companyButton addTarget:self action:@selector(companyButtonClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.selectIdentityView.personalButton addTarget:self action:@selector(personalButtonClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.selectIdentityView.commitButton addTarget:self action:@selector(commitButtonClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    self.selectIdentityView.commitButton.alpha                  = 0.6;
    self.selectIdentityView.commitButton.userInteractionEnabled = NO;
    
    self.selectIdentityView.nametextField.delegate = self;
    [self.selectIdentityView.nametextField addTarget:self action:@selector(monitoringChange:) forControlEvents:UIControlEventEditingChanged];
    
    UITapGestureRecognizer *viewTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapGRAction:)];
    [self.view addGestureRecognizer:viewTapGR];
}

#pragma mark - tap
- (void)viewTapGRAction:(UITapGestureRecognizer *)sender{
    NSLog(@"tap");
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.28 animations:^{
        self.selectIdentityView.contentOffset = CGPointMake(0, SCREEN_WIDTH/375*0);
    }];
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.28 animations:^{
        self.selectIdentityView.contentOffset = CGPointMake(0, SCREEN_WIDTH/375*150);
    }];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    // Prevent crashing undo bug – see note below.
    if(range.length + range.location > textField.text.length){
        return NO;
    }
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    if (newLength > 30) {
    }
    return newLength <= 30;
}

#pragma mark - 监测输入
- (void)monitoringChange:(UITextField *)sender{
    if (self.selectIdentityView.nametextField.text.length>0) {
        self.selectIdentityView.commitButton.alpha = 1;
        self.selectIdentityView.commitButton.userInteractionEnabled = YES;
    }else{
        self.selectIdentityView.commitButton.alpha = 0.6;
        self.selectIdentityView.commitButton.userInteractionEnabled = NO;
    }
}


#pragma mark - Company
- (void)companyButtonClickedAction:(UIButton *)sender{
    
    //[self.selectIdentityView.companyButton setImage:[UIImage imageNamed:@"companySelect"] forState:UIControlStateNormal];
    //[self.selectIdentityView.personalButton setImage:[UIImage imageNamed:@"personNoselect"] forState:UIControlStateNormal];
    //[self evokeLogout:@"确认要选择企业会员吗？" isCom:YES];
    
    [self.selectIdentityView.companyButton setBackgroundImage:[UIImage imageNamed:@"companySelect"] forState:UIControlStateNormal];
    [self.selectIdentityView.personalButton setBackgroundImage:[UIImage imageNamed:@"personNoselect"] forState:UIControlStateNormal];
    
    [self.selectIdentityView.personalButton setBackgroundColor:[UIColor colorWithHex:@"CCCCCC"]];
    [self.selectIdentityView.companyButton setBackgroundColor:[UIColor colorWithHex:tonalColor]];
    
    self.userType = @"2";
    
    self.selectIdentityView.nameLabel.text = @"企业名称";
    self.selectIdentityView.nametextField.placeholder = @"请输入企业名称";
}

#pragma mark - Personal
- (void)personalButtonClickedAction:(UIButton *)sender{
    

    [self.selectIdentityView.companyButton setBackgroundImage:[UIImage imageNamed:@"companyNoSelect"] forState:UIControlStateNormal];
    [self.selectIdentityView.personalButton setBackgroundImage:[UIImage imageNamed:@"personSelect"] forState:UIControlStateNormal];
    //[self evokeLogout:@"确认要选择个人会员吗？" isCom:NO];
    
    [self.selectIdentityView.companyButton setBackgroundColor:[UIColor colorWithHex:@"CCCCCC"]];
    [self.selectIdentityView.personalButton setBackgroundColor:[UIColor colorWithHex:tonalColor]];
    
    
    self.userType = @"1";
    
    self.selectIdentityView.nameLabel.text = @"真实姓名";
    self.selectIdentityView.nametextField.placeholder = @"请输入真实姓名";
}



#pragma mark - Logout
- (void)evokeLogout:(NSString *)title isCom:(BOOL)isComBool{
    
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:nil
                                                                         message:title
                                                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction        = [UIAlertAction actionWithTitle:@"确定"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction *action) {
                                                                [self.selectIdentityView.companyButton setBackgroundColor:[UIColor colorWithHex:@"CCCCCC"]];
                                                                [self.selectIdentityView.personalButton setBackgroundColor:[UIColor colorWithHex:@"CCCCCC"]];
                                                                if (isComBool) {
                                                                    NSLog(@"com");
                                                                    [self selectType:@"2"];
                                        
                                                                }else{
                                                                    NSLog(@"per");
                                                                    [self selectType:@"1"];
                                                                    
                                                                }
                                                
    }];
    UIAlertAction *cancle          = [UIAlertAction actionWithTitle:@"取消"
                                                              style:UIAlertActionStyleCancel
                                                            handler:^(UIAlertAction *action) {
                                                                [self.selectIdentityView.companyButton setBackgroundColor:[UIColor colorWithHex:@"CCCCCC"]];
                                                                [self.selectIdentityView.personalButton setBackgroundColor:[UIColor colorWithHex:@"CCCCCC"]];
                                                                NSLog(@"cal");
    }];
    
    [cancle setValue:[UIColor colorWithHex:@"000000"]
              forKey:@"titleTextColor"];
    [alertDialog addAction:cancle];
    [alertDialog addAction:okAction];
    [self presentViewController:alertDialog animated:YES completion:nil];
}


#pragma mark - 提交
- (void)commitButtonClickedAction:(UIButton *)sender{
    
    [UIView animateWithDuration:0.28 animations:^{
        self.selectIdentityView.contentOffset = CGPointMake(0, SCREEN_WIDTH/375*0);
    } completion:^(BOOL finished) {
        [self setUserType];
    }];
}

- (void)setUserType{
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    [self.HUD show:YES];
    [self.view endEditing:YES];
    
    if (self.selectIdentityView.nametextField.text.length<=30) {
        NSDictionary *parDic = @{@"type":self.userType,
                                 @"name":self.selectIdentityView.nametextField.text};
        NSLog(@"%@",parDic);
        NSString *urlStr = [NSString stringWithFormat:@"%@/user/set-type",APIDev];
        
        
        [AFNetManager requestWithType:HttpRequestTypePost withUrlString:urlStr withParaments:parDic withSuccessBlock:^(NSDictionary *object) {
            NSLog(@"select Type ------------- %@",object);
            NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
            if ([stateStr isEqualToString:@"success"]) {
                [[NSUserDefaults standardUserDefaults] setObject:self.userType forKey:USER_TYPE];
                //successful login
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:IS_LOGIN];
                
                
                if (self.bingHeaderImageUrl.length>10) {
                    //上传头像
                    [self updateBindAvatar];
                }else{
                    [self.HUD hide:YES];
                    [self showProgress:@"设置成功"];
                    [self loginNextAc];
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
                
                
            }else{
                [self.HUD hide:YES];
                //fail login
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:IS_LOGIN];
                [self showProgress:object[@"status"][@"message"]];
                
            }
            
        } withFailureBlock:^(NSError *error) {
            NSLog(@"select Type ------------- %@",error);
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:IS_LOGIN];
            [self.HUD hide:YES];
        } progress:^(float progress) {
            NSLog(@"%f",progress);
        }];
    }else{
        [self showProgress:@"不允许超出30个字符"];
    }
}



#pragma mark - Binding upload avatar
- (void)updateBindAvatar{
    NSLog(@"bingHeaderImageUrl ------------------------ %@",self.bingHeaderImageUrl);
    
    UIImage *headerImage = [UIImage imageWithData:[NSData
                                                   dataWithContentsOfURL:[NSURL URLWithString:self.bingHeaderImageUrl]]];
    NSData *imageData = UIImageJPEGRepresentation(headerImage, 0.5);
    

    AliyunOSSManager *ossManager = [AliyunOSSManager new];
    [ossManager creatOSSClient:PrefixAVATAR];
    //uploading
    [ossManager uploadObjectAsyncResister:imageData path:AVATAR];
    
}

#pragma mark - Avatar upload successful
- (void)uploadAvatarSuccessfulAc{
    [self.HUD hide:YES];
    [self showProgress:@"设置成功"];
    [self loginNextAc];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)uploadAvatarFailedAc{
    
    [self.HUD hide:YES];
}






#pragma mark - 登录下一步
- (void)loginNextAc{
    if ([self.entranceType isEqualToString:@"MySelf"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MySelfLoginNextAction" object:nil];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:self.entranceType object:nil];
    }
}








#pragma mark - Select Type
- (void)selectType:(NSString *)typeInteger{
    

     
     NSString *baseUrl = @"/user/set-type";
     NSString *bodyStr = [NSString stringWithFormat:@"type=%@",typeInteger];
     NSDictionary *dic = [AFNetManager postRequextwithUrlString:baseUrl withParaments:bodyStr];
     
     NSLog(@"set --- %@",dic);
     NSLog(@"%@",dic[@"status"][@"message"]);
     
     NSString *stateStr = [NSString stringWithFormat:@"%@",dic[@"status"][@"state"]];
     if ([stateStr isEqualToString:@"success"]) {
     //Save Info
     [[NSUserDefaults standardUserDefaults] setObject:typeInteger forKey:USER_TYPE];
     [self showProgress:@"设置成功"];
     }else{
     [self showProgress:dic[@"status"][@"message"]];
     }
     
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
