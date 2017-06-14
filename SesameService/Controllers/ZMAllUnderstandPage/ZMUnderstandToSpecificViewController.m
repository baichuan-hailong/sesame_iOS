//
//  ZMUnderstandToSpecificViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/5.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMUnderstandToSpecificViewController.h"
#import "ZMUnderstandToSpecificView.h"
#import "ZMSelectImageCollectionViewCell.h"

#import "TZImagePickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ZMPayViewController.h"

@interface ZMUnderstandToSpecificViewController ()<TZImagePickerControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UITextViewDelegate,UITextFieldDelegate>
{
    NSMutableArray *_selectedPhotos;
    BOOL isPublic;
}
@property (nonatomic,strong)TZImagePickerController *imagePickerVc;

@property(nonatomic,strong)UIActionSheet   *camerSheet;
@property(nonatomic,strong)ZMUnderstandToSpecificView *understandToSpecificView;
@property(nonatomic , strong)MBProgressHUD *HUD;
@end

@implementation ZMUnderstandToSpecificViewController


-(void)loadView{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.understandToSpecificView             = [[ZMUnderstandToSpecificView alloc] initWithFrame:SCREEN_BOUNDS];
    self.view = self.understandToSpecificView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"向ta打听";
    
    //shareAddImage
    _selectedPhotos = [NSMutableArray array];
    [_selectedPhotos addObject:[UIImage imageNamed:@"shareAddImage"]];
    
    self.understandToSpecificView.shareCollectionView.delegate  = self;
    self.understandToSpecificView.shareCollectionView.dataSource= self;
    
    [self addAction];
    
    [self.understandToSpecificView setTopPer:self.personDetailDic];
    
    [self dataSouce];
    
    
    //queston image upload noti
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(uploadQuestionImageSuccessful:)
                                                 name:@"uploadQuestionImageSuccessful"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(uploadQuestionImageFailed)
                                                 name:@"uploadQuestionImageFailed"
                                               object:nil];
}



#pragma mark - 问题图片上传成功
- (void)uploadQuestionImageSuccessful:(NSNotification *)noti{
    [noti object];
    NSMutableArray *questionArray = (NSMutableArray *)[noti object];
    NSLog(@"questionArray ------- %@",questionArray);
    [self evokeRequest:questionArray];
}

- (void)uploadQuestionImageFailed{
    NSLog(@"upload question failed!");
    [self.HUD hide:YES];
    [self showProgress:@"发布失败!"];
}



#pragma mark - DataSouce
- (void)dataSouce{
    
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    [self.HUD show:YES];
    
    NSDictionary *parm = @{@"user_id":self.personDetailDic[@"id"]};
    NSString *urlStr   = [NSString stringWithFormat:@"%@/answer/user-count",APIDev];
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:parm withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"%@",object);
        
        
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            NSString *answer_num = [NSString stringWithFormat:@"%@",object[@"data"][@"answer_num"]];
            NSString *accept_num = [NSString stringWithFormat:@"%@",object[@"data"][@"accept_num"]];
            NSLog(@"%@---%@",answer_num,accept_num);
            
            self.understandToSpecificView.experienceLabel.text = [NSString stringWithFormat:@"累计回答%@次 - 赢得赏金%@次",answer_num,accept_num];
            
        }else{
            [self showProgress:object[@"status"][@"message"]];
        }
        [self.HUD hide:YES];
    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
        [self.HUD hide:YES];
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}



- (void)addAction{
    
    [self.understandToSpecificView.commitButtton addTarget:self action:@selector(commitButttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTapGRAction:)];
    [doubleTapGestureRecognizer setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:doubleTapGestureRecognizer];
    
    self.understandToSpecificView.suggestTextView.delegate = self;
    self.understandToSpecificView.amountTextField.delegate = self;
    [self.understandToSpecificView.amountTextField addTarget:self action:@selector(checkCommitAc) forControlEvents:UIControlEventEditingChanged];
    
    isPublic = YES;
    UITapGestureRecognizer *tapPublicGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(publicTapGRAction:)];
    [self.understandToSpecificView.isPublicView addGestureRecognizer:tapPublicGestureRecognizer];
}

#pragma mark - Public
- (void)publicTapGRAction:(UITapGestureRecognizer *)sender{
    [self viewTapGRAction:nil];
    if (isPublic) {
        self.understandToSpecificView.isPublicTipImageView.image = [UIImage imageNamed:@"publicSelectNoImage"];
        isPublic = NO;
    }else{
        self.understandToSpecificView.isPublicTipImageView.image = [UIImage imageNamed:@"publicSelectImage"];
        isPublic = YES;
    }
}

#pragma mark - TF Delegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.28 animations:^{
        self.understandToSpecificView.frame = CGRectMake(0,
                                                         -SCREEN_WIDTH/375*190,
                                                         SCREEN_WIDTH,
                                                         SCREEN_HEIGHT+SCREEN_WIDTH/375*190);
    }];
    return YES;
}

//touch
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch            = [touches anyObject];
    CGPoint currentPosition   = [touch locationInView:self.view];
    CGFloat currentY          = currentPosition.y;
    
    NSLog(@"%f",currentY);
    if (currentY<SCREEN_WIDTH/375*201||currentY>SCREEN_WIDTH/375*315){
        [self.view endEditing:YES];
        NSLog(@"end");
        
        [UIView animateWithDuration:0.28 animations:^{
            self.understandToSpecificView.frame = CGRectMake(0,
                                                             SCREEN_WIDTH/375*0,
                                                             SCREEN_WIDTH,
                                                             SCREEN_HEIGHT+SCREEN_WIDTH/375*0);
        }];
    }
}




- (void)checkCommitAc{
    if (self.understandToSpecificView.suggestTextView.text.length>0&&self.understandToSpecificView.amountTextField.text.length>0) {
        self.understandToSpecificView.commitButtton.alpha = 1;
        self.understandToSpecificView.commitButtton.userInteractionEnabled = YES;
    }else{
        self.understandToSpecificView.commitButtton.alpha = 0.6;
        self.understandToSpecificView.commitButtton.userInteractionEnabled = NO;
    }
}

#pragma mark - TextViewDelegate
-(void)textViewDidChange:(UITextView *)textView{
    
    if (self.understandToSpecificView.suggestTextView.text.length==0) {
        [self.understandToSpecificView.suggestTextView addSubview:self.understandToSpecificView.suggestPlaceHolderLabel];
    }else{
        [self.understandToSpecificView.suggestPlaceHolderLabel removeFromSuperview];
    }
    self.understandToSpecificView.worldCountLabel.text = [NSString stringWithFormat:@"%lu/300",(unsigned long)textView.text.length];
    
    [self checkCommitAc];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@""] && range.length > 0) {
        return YES;
    }
    else {
        if (textView.text.length - range.length + text.length > 300) {
            return NO;
        }
        else {
            return YES;
        }
    }
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    [UIView animateWithDuration:0.28 animations:^{
        self.understandToSpecificView.frame = CGRectMake(0,
                                                         -SCREEN_WIDTH/375*190,
                                                         SCREEN_WIDTH,
                                                         SCREEN_HEIGHT+SCREEN_WIDTH/375*190);
    }];
    return YES;
}

#pragma mark - tap
- (void)viewTapGRAction:(UITapGestureRecognizer *)sender{
    NSLog(@"tap");
    [self.view endEditing:YES];
    
    [UIView animateWithDuration:0.28 animations:^{
        self.understandToSpecificView.frame = CGRectMake(0,
                                                         SCREEN_WIDTH/375*0,
                                                         SCREEN_WIDTH,
                                                         SCREEN_HEIGHT+SCREEN_WIDTH/375*0);
    }];
}

#pragma mark - 发布
- (void)commitButttonClickAction:(UIButton *)sender{
    [self viewTapGRAction:nil];
    
    NSString *amount = self.understandToSpecificView.amountTextField.text;
    if ([amount integerValue]>=10&&[amount integerValue]<=10000) {
        self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:self.HUD];
        [self.HUD show:YES];
        
        
        NSLog(@"图片张数 ------ %ld",_selectedPhotos.count);
        AliyunOSSManager *ossManager = [AliyunOSSManager new];
        [ossManager creatOSSClient:PrefixATTACHMENTS];
        if (_selectedPhotos.count>1) {
            for (int i=0; i<_selectedPhotos.count-1; i++) {
                UIImage *image = (UIImage *)_selectedPhotos[i];
                NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
                [ossManager uploadQuestionAsyncResister:imageData path:QUESTION index:i total:_selectedPhotos.count-1];
            }
        }else{
            [self evokeRequest:nil];
        }
    }else{
        [self showProgress:@"赏金不可低于10元，不可高于10000元！"];
    }
    
    
}



- (void)evokeRequest:(NSArray *)imageArray{

    NSDictionary *parDic;
    
    if (isPublic) {
        parDic = @{@"question":self.understandToSpecificView.suggestTextView.text,
                   @"price"   :self.understandToSpecificView.amountTextField.text,
                   @"aim_answerer":self.personDetailDic[@"id"],
                   @"public":@"1"};
    }else{
        parDic = @{@"question":self.understandToSpecificView.suggestTextView.text,
                   @"price"   :self.understandToSpecificView.amountTextField.text,
                   @"aim_answerer":self.personDetailDic[@"id"],
                   @"public":@"0"};
    }
    
    NSMutableDictionary *parMutableDic = [NSMutableDictionary dictionaryWithDictionary:parDic];
    if (imageArray.count>0) {
        [parMutableDic setObject:imageArray forKey:@"images"];
    }
    NSLog(@"parMutableDic ------------%@",parMutableDic);
    NSString *urlStr = [NSString stringWithFormat:@"%@/question/create",APIDev];
    [AFNetManager requestWithType:HttpRequestTypePost withUrlString:urlStr withParaments:parMutableDic withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"question ------------- %@",object);
        
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            
            NSString *questionID = [NSString stringWithFormat:@"%@",object[@"data"][@"id"]];
            ZMPayViewController *payVC = [[ZMPayViewController alloc] init];
            payVC.questionID  = questionID;
            payVC.money       = self.understandToSpecificView.amountTextField.text;
            payVC.isSelected  = YES;
            [self.navigationController pushViewController:payVC animated:YES];
        }
        [self.HUD hide:YES];
    } withFailureBlock:^(NSError *error) {
        NSLog(@"qustion  ------------- %@",error);
        [self.HUD hide:YES];
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}



#pragma mark - 图片 Delegate
//TZ
-(void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    
    for (int i=0; i<photos.count; i++) {
        [_selectedPhotos insertObject:photos[i] atIndex:0];
    }
    [self.understandToSpecificView.shareCollectionView reloadData];
}

//pick
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *headerImage = [info objectForKey:UIImagePickerControllerEditedImage];
    //save
    UIImageWriteToSavedPhotosAlbum(headerImage, nil, nil, nil);
    [_selectedPhotos insertObject:headerImage atIndex:0];
    
    [self.understandToSpecificView.shareCollectionView reloadData];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (_selectedPhotos.count<5) {
        return _selectedPhotos.count;
    }else{
        return _selectedPhotos.count-1;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ZMSelectImageCollectionViewCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"selectImageCollectionViewCell"
                                                                                       forIndexPath:indexPath];
    cell.bodyImageView.image = (UIImage *)_selectedPhotos[indexPath.row];
    cell.deleteImageView.tag = 9191+indexPath.row;
    [cell.deleteImageView addTarget:self action:@selector(deleteImageViewBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    if (_selectedPhotos.count<5) {
        if (indexPath.row==_selectedPhotos.count-1) {
            cell.deleteImageView.alpha = 0;
        }else{
            cell.deleteImageView.alpha = 1;
        }
    }else{
        cell.deleteImageView.alpha = 1;
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (iPhone5) {
        return CGSizeMake(SCREEN_WIDTH/375*71, SCREEN_WIDTH/375*80);
    }else{
        return CGSizeMake(SCREEN_WIDTH/375*73, SCREEN_WIDTH/375*80);
    }
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.28 animations:^{
        self.understandToSpecificView.frame = CGRectMake(0,
                                                         SCREEN_WIDTH/375*0,
                                                         SCREEN_WIDTH,
                                                         SCREEN_HEIGHT+SCREEN_WIDTH/375*0);
    }];
    
    NSLog(@"%ld",(long)indexPath.row);
    if (_selectedPhotos.count<5) {
        if (indexPath.row==_selectedPhotos.count-1) {
            self.camerSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                          delegate:self
                                                 cancelButtonTitle:@"取消"
                                            destructiveButtonTitle:nil
                                                 otherButtonTitles:@"拍照",@"从手机相册选择", nil];
            [self.camerSheet showInView:self.view];
        }
    }
}

#pragma mark - Delete Image
- (void)deleteImageViewBtnAction:(UIButton *)sender{
    NSLog(@"delete");
    [_selectedPhotos removeObjectAtIndex:sender.tag-9191];
    [self.understandToSpecificView.shareCollectionView reloadData];
    
}


#pragma mark - SheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == actionSheet.firstOtherButtonIndex) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            NSLog(@"camer");
            [self evokeCame];
        }
    }else if (buttonIndex == actionSheet.firstOtherButtonIndex + 1){
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            
            [self evokeTZCame];
            NSLog(@"library");
        }
    }
}




#pragma mark - 唤起
- (void)evokeTZCame{
    self.imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:(4-_selectedPhotos.count+1) columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    self.imagePickerVc.allowTakePicture                = NO;
    self.imagePickerVc.allowPickingVideo               = NO;
    self.imagePickerVc.allowPickingImage               = YES;
    self.imagePickerVc.allowPickingOriginalPhoto       = NO;
    self.imagePickerVc.allowPickingGif                 = NO;
    self.imagePickerVc.sortAscendingByModificationDate = YES;
    self.imagePickerVc.showSelectBtn                   = NO;
    self.imagePickerVc.allowCrop                       = NO;
    self.imagePickerVc.needCircleCrop                  = NO;
    self.imagePickerVc.circleCropRadius                = 100;
    [_imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
    }];
    [self presentViewController:_imagePickerVc animated:YES completion:nil];
}

- (void)evokeCame{
    UIImagePickerController *imagePickerVC = [[UIImagePickerController alloc] init];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


@end
