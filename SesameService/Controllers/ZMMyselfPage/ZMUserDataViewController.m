//
//  ZMUserDataViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMUserDataViewController.h"
#import "ZMUserDataView.h"

#import "ZMUserDataTwoTableViewCell.h"
#import "ZMUserDataCerTableViewCell.h"
#import "ZMUserDataHeaderTableViewCell.h"

#import "ZMEditDataViewController.h"
#import "ZMAwardsHonorViewController.h"
#import "ZMProjectCaseViewController.h"
#import "ZMRealNameAuthViewController.h"

#import "ZMBaseCompanyInfoViewController.h"
#import "ZMCompanyAuthViewController.h"

@interface ZMUserDataViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,strong)ZMUserDataView *userDataView;
@property (nonatomic,strong)NSArray      *detailDataArray;
@property (nonatomic,strong)NSArray      *cerDataArray;
@property(nonatomic,strong)UIActionSheet *camerSheet;
@property (nonatomic , strong) MBProgressHUD *HUD;
@end

@implementation ZMUserDataViewController

- (void)loadView {
    //change
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.userDataView    = [[ZMUserDataView alloc] initWithFrame:SCREEN_BOUNDS];
    self.view                                 = self.userDataView;
    self.userDataView.userDataTableView.delegate   = self;
    self.userDataView.userDataTableView.dataSource = self;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的资料";
    
    
    self.detailDataArray =      @[@{@"left":@"基础信息"},
                                  @{@"left":@"项目案例"},
                                  @{@"left":@"奖项荣誉"}];
    
    
    
    if ([self.userType isEqualToString:@"1"]) {
        //个人是否认证
        NSString *isPersonAuth = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Person_auth]];
        if ([isPersonAuth isEqualToString:@"unauthed"]) {
            self.cerDataArray =      @[@{@"left":@"实名认证",@"right":@"未认证"}];
        }else if ([isPersonAuth isEqualToString:@"authed"]){
            self.cerDataArray =      @[@{@"left":@"实名认证",@"right":@"已认证"}];
        }else if ([isPersonAuth isEqualToString:@"unchecked"]){
            self.cerDataArray =      @[@{@"left":@"实名认证",@"right":@"待审核"}];
        }else if ([isPersonAuth isEqualToString:@"failed"]){
            self.cerDataArray =      @[@{@"left":@"实名认证",@"right":@"未通过"}];
        }
    }else{
        //公司是否认证
        NSString *isComAuth = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Com_auth]];
        if ([isComAuth isEqualToString:@"unauthed"]) {
            self.cerDataArray =      @[@{@"left":@"企业认证",@"right":@"未认证"}];
        }else if ([isComAuth isEqualToString:@"authed"]){
            self.cerDataArray =      @[@{@"left":@"企业认证",@"right":@"已认证"}];
        }else if ([isComAuth isEqualToString:@"unchecked"]){
            self.cerDataArray =      @[@{@"left":@"企业认证",@"right":@"待审核"}];
        }else if ([isComAuth isEqualToString:@"failed"]){
            self.cerDataArray =      @[@{@"left":@"企业认证",@"right":@"未通过"}];
        }
    }
    
    //Avatar
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(uploadAvatarSuccessfulAc)
                                                 name:@"uploadAvatarSuccessful"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(uploadAvatarFailedAc)
                                                 name:@"uploadAvatarFailed"
                                               object:nil];
    
    //commit cer successful
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"haveCommitCheckSuccessful" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(haveCommitCheckSuccessfulAc)
                                                 name:@"haveCommitCheckSuccessful"
                                               object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [self obtainUserInfo];
}

#pragma mark - Obtain User Info
- (void)obtainUserInfo{
    //sender coder
    
    NSString *urlStr   = [NSString stringWithFormat:@"%@/user/my-info",APIDev];
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:nil withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"myself ----------------- %@",object);
        
        NSString *stateStr    = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            NSString *typeStr = [NSString stringWithFormat:@"%@",object[@"data"][@"type"]];
            
            //update
            [[NSUserDefaults standardUserDefaults] setObject:typeStr forKey:USER_TYPE];
            self.userType = typeStr;
            
            
            if ([typeStr isEqualToString:@"1"]) {
                //personal
                //个人是否认证
                [[NSUserDefaults standardUserDefaults] setObject:object[@"data"][@"auth"]        forKey:Person_auth];
                //个人是否认证
                NSString *isPersonAuth = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Person_auth]];
                if ([isPersonAuth isEqualToString:@"unauthed"]) {
                    self.cerDataArray =      @[@{@"left":@"实名认证",@"right":@"未认证"}];
                }else if ([isPersonAuth isEqualToString:@"authed"]){
                    self.cerDataArray =      @[@{@"left":@"实名认证",@"right":@"已认证"}];
                }else if ([isPersonAuth isEqualToString:@"unchecked"]){
                    self.cerDataArray =      @[@{@"left":@"实名认证",@"right":@"待审核"}];
                }else if ([isPersonAuth isEqualToString:@"failed"]){
                    self.cerDataArray =      @[@{@"left":@"实名认证",@"right":@"认证失败"}];
                }
            }else if([typeStr isEqualToString:@"2"]){
                //company
                //公司是否认证
                [[NSUserDefaults standardUserDefaults] setObject:object[@"data"][@"auth"]      forKey:Com_auth];
                //公司是否认证
                NSString *isComAuth = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Com_auth]];
                if ([isComAuth isEqualToString:@"unauthed"]) {
                    self.cerDataArray =      @[@{@"left":@"实名认证",@"right":@"未认证"}];
                }else if ([isComAuth isEqualToString:@"authed"]){
                    self.cerDataArray =      @[@{@"left":@"实名认证",@"right":@"已认证"}];
                }else if ([isComAuth isEqualToString:@"unchecked"]){
                    self.cerDataArray =      @[@{@"left":@"实名认证",@"right":@"待审核"}];
                }else if ([isComAuth isEqualToString:@"failed"]){
                    self.cerDataArray =      @[@{@"left":@"实名认证",@"right":@"未通过"}];
                }
                
            }
            
            
        }else{
            [self showProgress:object[@"status"][@"message"]];
        }
    } withFailureBlock:^(NSError *error) {
        NSLog(@"myself -------------------- %@",error);
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}




- (void)haveCommitCheckSuccessfulAc{
    
    if ([self.userType isEqualToString:@"1"]) {
        //个人是否认证
        NSString *isPersonAuth = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Person_auth]];
        if ([isPersonAuth isEqualToString:@"unauthed"]) {
            self.cerDataArray =      @[@{@"left":@"实名认证",@"right":@"未认证"}];
        }else if ([isPersonAuth isEqualToString:@"authed"]){
            self.cerDataArray =      @[@{@"left":@"实名认证",@"right":@"已认证"}];
        }else if ([isPersonAuth isEqualToString:@"unchecked"]){
            self.cerDataArray =      @[@{@"left":@"实名认证",@"right":@"待审核"}];
        }else if ([isPersonAuth isEqualToString:@"failed"]){
            self.cerDataArray =      @[@{@"left":@"实名认证",@"right":@"认证失败"}];
        }
    }else{
        //公司是否认证
        NSString *isComAuth = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Com_auth]];
        if ([isComAuth isEqualToString:@"unauthed"]) {
            self.cerDataArray =      @[@{@"left":@"实名认证",@"right":@"未认证"}];
        }else if ([isComAuth isEqualToString:@"authed"]){
            self.cerDataArray =      @[@{@"left":@"实名认证",@"right":@"已认证"}];
        }else if ([isComAuth isEqualToString:@"unchecked"]){
            self.cerDataArray =      @[@{@"left":@"实名认证",@"right":@"待审核"}];
        }else if ([isComAuth isEqualToString:@"failed"]){
            self.cerDataArray =      @[@{@"left":@"实名认证",@"right":@"认证失败"}];
        }
    }
    [self.userDataView.userDataTableView reloadData];
}



#pragma mark - Avatar upload successful
- (void)uploadAvatarSuccessfulAc{
    [self.HUD hide:YES];
    [self showProgress:@"资料更新成功"];
    [self.userDataView.userDataTableView reloadData];
}

- (void)uploadAvatarFailedAc{
    
    [self.HUD hide:YES];
    [self.userDataView.userDataTableView reloadData];
}




#pragma mark - Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else if (section==1){
        return self.detailDataArray.count;
    }else{
        return self.cerDataArray.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        return SCREEN_WIDTH/375*70;
    }else if (indexPath.section==1){
        return SCREEN_WIDTH/375*50;
    }else{
        return SCREEN_WIDTH/375*50;
    }
    
}




/**footer**/
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return SCREEN_WIDTH/375*14;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footView         = [[UIView alloc] init];
    footView.backgroundColor = [UIColor clearColor];
    return footView;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *oneIndentifire             = @"oneCell";
    static NSString *secondIndentifire          = @"secondCell";
    static NSString *cerIndentifire             = @"cerCell";
    if (indexPath.section==0) {
        ZMUserDataHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:oneIndentifire];
        if (!cell) {
            cell = [[ZMUserDataHeaderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:oneIndentifire];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell setAvatar:self.userType];
        return cell;
    }else if (indexPath.section==1) {
        
        NSDictionary *dic = self.detailDataArray[indexPath.row];
        ZMUserDataTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:secondIndentifire];
        if (!cell) {
            cell = [[ZMUserDataTwoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:secondIndentifire];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell setMoreTiele:dic];
        if (indexPath.row==self.detailDataArray.count-1) {
            cell.line.alpha = 0;
        }else{
            cell.line.alpha = 1;
        }
        return cell;
    }else{
    
        NSDictionary *dic = self.cerDataArray[indexPath.row];
        ZMUserDataCerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cerIndentifire];
        if (!cell) {
            cell = [[ZMUserDataCerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cerIndentifire];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell setMoreTiele:dic];
        
        if ([self.userType isEqualToString:@"1"]) {
            //个人是否认证
            NSString *isPersonAuth = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Person_auth]];
            if ([isPersonAuth isEqualToString:@"unauthed"]) {
                //未认证
                cell.rightLabel.textColor = [UIColor colorWithHex:@"FA4A4A"];
            }else if ([isPersonAuth isEqualToString:@"authed"]){
                //已认证
                cell.rightLabel.textColor = [UIColor colorWithHex:@"999999"];
            }else if ([isPersonAuth isEqualToString:@"unchecked"]){
                //待审核
                cell.rightLabel.textColor = [UIColor colorWithHex:tonalColor];
            }else if ([isPersonAuth isEqualToString:@"failed"]){
                //未通过"
                cell.rightLabel.textColor = [UIColor colorWithHex:@"FA4A4A"];
            }
        }else{
            //公司是否认证
            NSString *isComAuth = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Com_auth]];
            if ([isComAuth isEqualToString:@"unauthed"]) {
                //未认证
                cell.rightLabel.textColor = [UIColor colorWithHex:@"FA4A4A"];
            }else if ([isComAuth isEqualToString:@"authed"]){
                //已认证
                cell.rightLabel.textColor = [UIColor colorWithHex:@"999999"];
            }else if ([isComAuth isEqualToString:@"unchecked"]){
                //待审核
                cell.rightLabel.textColor = [UIColor colorWithHex:tonalColor];
            }else if ([isComAuth isEqualToString:@"failed"]){
                //未通过
                cell.rightLabel.textColor = [UIColor colorWithHex:@"FA4A4A"];
            }
        }
        
        return cell;
    }
    
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section==0) {
        NSLog(@"hImg");
        self.camerSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                        destructiveButtonTitle:nil
                                             otherButtonTitles:@"拍照",@"图片上传", nil];
        [self.camerSheet showInView:self.view];
    }else if (indexPath.section==1){
        if (indexPath.row==0) {
            NSLog(@"1");
            if ([self.userType isEqualToString:@"1"]) {
                ZMEditDataViewController *editDataVC = [[ZMEditDataViewController alloc] init];
                [self.navigationController pushViewController:editDataVC animated:YES];
            }else{
                ZMBaseCompanyInfoViewController *baseCompanyInfoVC = [[ZMBaseCompanyInfoViewController alloc] init];
                [self.navigationController pushViewController:baseCompanyInfoVC animated:YES];                
            }

        }else if (indexPath.row==1){
            NSLog(@"2");
            ZMProjectCaseViewController *projectCaseVC = [[ZMProjectCaseViewController alloc] init];
            [self.navigationController pushViewController:projectCaseVC animated:YES];
        }else{
            NSLog(@"3");
            ZMAwardsHonorViewController *awardsHonorVC = [[ZMAwardsHonorViewController alloc] init];
            [self.navigationController pushViewController:awardsHonorVC animated:YES];
        }
    }else{
        NSLog(@"cer");
        if ([self.userType isEqualToString:@"1"]) {
            ZMRealNameAuthViewController *realNameAuthVC = [[ZMRealNameAuthViewController alloc] init];
            [self.navigationController pushViewController:realNameAuthVC animated:YES];
        }else{
            ZMCompanyAuthViewController *companyAuthVC = [[ZMCompanyAuthViewController alloc] init];
            [self.navigationController pushViewController:companyAuthVC animated:YES];
        }
    }
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
    
    UIImage *headerImage = [info objectForKey:UIImagePickerControllerEditedImage];
    ZMUserDataHeaderTableViewCell *cell = [self.userDataView.userDataTableView  cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.headerImageView.image = headerImage;
    
    
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    [self.HUD show:YES];
    
    
    NSData *imageData = UIImageJPEGRepresentation(headerImage, 0.5);
    
    AliyunOSSManager *ossManager = [AliyunOSSManager new];
    [ossManager creatOSSClient:PrefixAVATAR];
    //uploading
    [ossManager uploadObjectAsyncResister:imageData path:AVATAR];

}



-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
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



@end
