//
//  ZMEditDataViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/3/23.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMEditDataViewController.h"
#import "ZMEditDataView.h"

@interface ZMEditDataViewController ()<TTGTextTagCollectionViewDelegate,
                                        UITextFieldDelegate,
                                        UIPickerViewDelegate,
                                        UIPickerViewDataSource>
{
    int currentValue;
    int curTotal;
    
    NSInteger _provinceSelectedRow;
    NSInteger _citySelectedRow;
    NSInteger _areaSelectedRow;
    
    NSString *_selectedProvinceTitle;
    NSString *_selectedCityTitle;
    NSString *_selectedAreaTitle;
}
/** 城市选择 */
@property (nonatomic, strong) NSDictionary             *cityDic;
@property (nonatomic, strong) NSArray                  *provinceArray;
@property (nonatomic, strong) NSArray                  *cityArray;
@property (nonatomic, strong) NSArray                  *areaArray;




@property (nonatomic,strong) ZMEditDataView *editDataView;
//姓名
@property (nonatomic,strong)NSString *person_name;
//性别
@property (nonatomic,strong)NSString *person_gender;
//性别
@property (nonatomic,strong)NSString *genderStr;
//tel
@property (nonatomic,strong)NSString *person_telphone;
//email
@property (nonatomic,strong)NSString *person_email;
//公司名称
@property (nonatomic,strong)NSString *person_corp_name;
//职务
@property (nonatomic,strong)NSString *person_title;
//City
@property (nonatomic,strong)NSString *person_city;
//old par
@property (nonatomic,strong)NSMutableDictionary *old_parDic;
//hud
@property (nonatomic , strong) MBProgressHUD *HUD;
//tags
@property(nonatomic,strong)NSMutableArray *tagsArray;
@end

@implementation ZMEditDataViewController
-(void)loadView{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.editDataView = [[ZMEditDataView alloc] initWithFrame:SCREEN_BOUNDS];
    self.editDataView.contentSize = CGSizeMake(SCREEN_WIDTH,
                               CGRectGetMaxY(self.editDataView.tagBackView.frame)+SCREEN_WIDTH/375*23);
    self.editDataView.tagView.delegate = self;
    self.view = self.editDataView;
    
    
    
    self.editDataView.infoPicker.delegate   = self;
    self.editDataView.infoPicker.dataSource = self;
    
    [self.editDataView.confirmBtn addTarget:self action:@selector(pickViewConfirm) forControlEvents:UIControlEventTouchUpInside];
    [self.editDataView.cancelBtn addTarget:self action:@selector(pickViewCancel) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"基础信息";

    
    [self addAction];
    
    [self rightButton];
    
    
    self.old_parDic = [[NSMutableDictionary alloc] init];
    
    
    //个人姓名
    self.person_name = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Person_name]];
    if (self.person_name.length>0&&![self.person_name isEqualToString:@"(null)"]) {
        self.editDataView.nametextField.text = self.person_name;
        [self.old_parDic setObject:self.person_name forKey:@"person_name"];
    }
    
    
    //个人性别 0-1 female-male
    self.person_gender = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Person_gender]];
    if (self.person_gender.length>0&&![self.person_gender isEqualToString:@"(null)"]) {
        self.genderStr = self.person_gender;
        [self.old_parDic setObject:self.person_gender forKey:@"gender"];
    }
    
    if ([self.person_gender isEqualToString:@"0"]) {
        self.editDataView.maleImageView.image   = [UIImage imageNamed:@"maleNoSelectedImage"];
        self.editDataView.femaleImageView.image = [UIImage imageNamed:@"maleSelectedImage"];
    }else if ([self.person_gender isEqualToString:@"1"]) {
        self.editDataView.maleImageView.image   = [UIImage imageNamed:@"maleSelectedImage"];
        self.editDataView.femaleImageView.image = [UIImage imageNamed:@"maleNoSelectedImage"];
    }
    
    //个人联系电话
    self.person_telphone = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Person_telphone]];
    if (self.person_telphone.length>0&&![self.person_telphone isEqualToString:@"(null)"]) {
        self.editDataView.telTextField.text  = self.person_telphone;
        [self.old_parDic setObject:self.person_telphone forKey:@"telphone"];
    }
    
    //个人邮箱
    self.person_email = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Person_email]];
    if (self.person_email.length>0&&![self.person_email isEqualToString:@"(null)"]) {
        self.editDataView.emailTextField.text= self.person_email;
        [self.old_parDic setObject:self.person_email forKey:@"email"];
    }
    
    //个人公司名称
    self.person_corp_name = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Person_corp_name]];
    if (self.person_corp_name.length>0&&![self.person_corp_name isEqualToString:@"(null)"]) {
        self.editDataView.companyTextField.text = self.person_corp_name;
        [self.old_parDic setObject:self.person_corp_name forKey:@"corp_name"];
    }
    
    //个人现任职务
    self.person_title = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Person_title]];
    if (self.person_title.length>0&&![self.person_title isEqualToString:@"(null)"]) {
        self.editDataView.positionTextField.text = self.person_title;
        [self.old_parDic setObject:self.person_title forKey:@"title"];
    }
    
    //个人所在城市
    self.person_city = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Person_city]];
    
    
    if (self.person_city.length>0&&![self.person_city isEqualToString:@"(null)"]) {
       
        self.editDataView.cityTextField.text = [self.person_city stringByReplacingOccurrencesOfString:@"^" withString:@" "];
        [self.old_parDic setObject:self.person_city forKey:@"city"];
        
        
        NSArray *arrayCity = [self.person_city componentsSeparatedByString:@"^"];
        
        if (arrayCity.count==1) {
            _selectedProvinceTitle = arrayCity[0];
        }else if (arrayCity.count==2){
            _selectedProvinceTitle = arrayCity[0];
            _selectedCityTitle     = arrayCity[1];
        }else if (arrayCity.count==3){
            _selectedProvinceTitle = arrayCity[0];
            _selectedCityTitle     = arrayCity[1];
            _selectedAreaTitle     = arrayCity[2];
        }
    }
    
    
    //个人主营业务
    NSString *per_main_biz = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Person_main_biz]];
    //NSLog(@"per_main_biz ------ %@",per_main_biz);
    if (per_main_biz.length>0&&![per_main_biz isEqualToString:@"(null)"]) {
        [self.old_parDic setObject:per_main_biz forKey:@"main_biz"];
    }
    
    [self observeProjectTag];
    
    [self initAc];
    
    [self initCity];
}



/** pickView Action */
- (void)pickViewConfirm {
    
    NSLog(@"确认");
    
    _selectedProvinceTitle = [self pickerView:self.editDataView.infoPicker titleForRow:_provinceSelectedRow forComponent:0];
    _selectedCityTitle     = [self pickerView:self.editDataView.infoPicker titleForRow:_citySelectedRow forComponent:1];
    _selectedAreaTitle     = [self pickerView:self.editDataView.infoPicker titleForRow:_areaSelectedRow forComponent:2];
    if ([_selectedProvinceTitle isEqualToString:@"(null)"]) {
        _selectedProvinceTitle = @"";
    }
    if ([_selectedCityTitle isEqualToString:@"(null)"]) {
        _selectedCityTitle = @"";
    }
    if ([_selectedAreaTitle isEqualToString:@"(null)"]) {
        _selectedAreaTitle = @"";
    }
    
    NSLog(@"%@",[NSString stringWithFormat:@"%@ %@ %@",_selectedProvinceTitle,_selectedCityTitle,_selectedAreaTitle]);
    
    
    self.editDataView.cityTextField.text = [NSString stringWithFormat:@"%@ %@ %@",_selectedProvinceTitle,_selectedCityTitle,_selectedAreaTitle];
   
    
    [UIView animateWithDuration:0.28 animations:^{
        self.editDataView.pickerView.y = SCREEN_HEIGHT;
    } completion:^(BOOL finished) {
        //_currentPick = 0;
        _provinceSelectedRow = 0;
        _citySelectedRow     = 0;
        _areaSelectedRow     = 0;
    }];
}

- (void)pickViewCancel {
    
    NSLog(@"取消");
    [UIView animateWithDuration:0.28 animations:^{
        self.editDataView.pickerView.y = SCREEN_HEIGHT;
    } completion:^(BOOL finished) {
        //_currentPick = 0;
        _provinceSelectedRow = 0;
        _citySelectedRow     = 0;
        _areaSelectedRow     = 0;
    }];
}






#pragma mark- pickerView代理方法
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    //列数
    return 3;
}

//每列对应多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (component == 0) {
        return _provinceArray.count;
    } else if (component == 1) {
        return [[[_provinceArray objectAtIndex:_provinceSelectedRow] objectForKey:@"city" ] count];
    } else {
        return [[[[[_provinceArray objectAtIndex:_provinceSelectedRow] objectForKey:@"city" ] objectAtIndex:_citySelectedRow] objectForKey:@"county" ] count];
    }
}

//每列每行对应显示的数据是什么
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSDictionary *provinceDic = [_provinceArray objectAtIndex:_provinceSelectedRow];
    NSArray *cityArray = [provinceDic objectForKey:@"city"];
    
    switch (component) {
        case 0:
            return [NSString stringWithFormat:@"%@",[_provinceArray objectAt:row][@"name"]];
            break;
        case 1:{
            return [NSString stringWithFormat:@"%@",[cityArray objectAt:row][@"name"]];
            break;
        }
        case 2:{
            NSArray *areaArr = (NSArray *)[[cityArray objectAtIndex:_citySelectedRow] objectForKey:@"county"];
            return [NSString stringWithFormat:@"%@",[[areaArr objectAt:row] objectForKey:@"name"]];
            break;
        }
        default:
            return [NSString stringWithFormat:@"%@",[[_provinceArray objectAt:row] objectForKey:@"name"]];
            break;
    }
}

#pragma mark-设置下方的数据刷新
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSLog(@"%@",[NSString stringWithFormat:@"%ld",row]);
    
    switch (component) {
        case 0:{
            _provinceSelectedRow = row;
            _citySelectedRow = 0;
            _areaSelectedRow = 0;
            [pickerView selectRow:0 inComponent:1 animated:NO];
            [pickerView selectRow:0 inComponent:2 animated:NO];
            break;
        }
        case 1:{
            _citySelectedRow = row;
            _areaSelectedRow = 0;
            [pickerView selectRow:0 inComponent:2 animated:NO];
            break;
        }
        case 2:
            _areaSelectedRow = row;
            break;
        default:
            _provinceSelectedRow = row;
            break;
    }
    [pickerView reloadAllComponents];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:SCREEN_WIDTH/26.78]];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}












#pragma mark - 城市选择
- (void)initCity{
    /** 地区XML文件解析 */
    NSString *path = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"xml"];
    NSData   *data = [[NSData alloc] initWithContentsOfFile:path];
    NSError *error = nil;
    _cityDic = [XMLReader dictionaryForXMLData:data
                                       options:XMLReaderOptionsProcessNamespaces
                                         error:&error];
    
    
    _provinceArray = (NSArray *)_cityDic[@"root"][@"province"];
    _provinceSelectedRow = 0;
    _citySelectedRow     = 0;
    _areaSelectedRow     = 0;
    
    //NSLog(@"%@",_cityDic);
    //NSLog(@"%@",_provinceArray);
}



#pragma mark - Init Ac
- (void)initAc{
    //个人是否认证
    NSString *isPersonAuth = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Person_auth]];
    if ([isPersonAuth isEqualToString:@"unauthed"]) {
        //未认证
        self.editDataView.nametextField.userInteractionEnabled = YES;
    }else if ([isPersonAuth isEqualToString:@"authed"]){
        //已认证
        self.editDataView.nametextField.userInteractionEnabled = NO;
    }else if ([isPersonAuth isEqualToString:@"unchecked"]){
        //待审核
        self.editDataView.nametextField.userInteractionEnabled = NO;
    }else if ([isPersonAuth isEqualToString:@"failed"]){
        //未通过"
        self.editDataView.nametextField.userInteractionEnabled = YES;
    }
}


#pragma mark - 业务类型
- (void)observeProjectTag{

    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    [self.HUD show:YES];
    
    NSString *urlStr   = [NSString stringWithFormat:@"%@/common/project-tag",APIDev];
    
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:nil withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"pro tag -----------------------***********************************************--- %@",object);
        
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            
            curTotal = 0;
            self.tagsArray = [NSMutableArray array];
            NSArray *tagArray = [NSArray arrayWithArray:object[@"data"]];
            for (NSDictionary *tagDic in tagArray) {
                [self.tagsArray addObject:tagDic[@"tag"]];
            }
            //NSLog(@"tagsArray ---------- %@",self.tagsArray);
            [self.editDataView.tagView addTags:self.tagsArray];
           
            
            //个人主营业务
            NSString *per_main_biz = [[NSUserDefaults standardUserDefaults] objectForKey:Person_main_biz];
            int per_main_int = [per_main_biz intValue];
            
            currentValue = per_main_int;
            for (int i=0; i<self.tagsArray.count; i++) {
                int compare = (int)pow(2, i);
                if (per_main_int&compare) {
                    [self.editDataView.tagView setTagAtIndex:i selected:YES];
                    curTotal++;
                }
            }
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

#pragma mark - TTGTextTagDelegate
- (void)textTagCollectionView:(TTGTextTagCollectionView *)textTagCollectionView
                    didTapTag:(NSString *)tagText
                      atIndex:(NSUInteger)index
                     selected:(BOOL)selected {
    
    //NSLog(@"tagText:%@   index:%ld  selected:%ld",tagText,index,selected);
    int compare = (int)pow(2, index);
    if (selected) {
        currentValue=currentValue|compare;
        curTotal++;
    }else{
        currentValue=currentValue^compare;
        curTotal--;
    }
    
    NSLog(@"currentValue --- %d    curTotal --- %d",currentValue,curTotal);
}

- (BOOL)textTagCollectionView:(TTGTextTagCollectionView *)textTagCollectionView canTapTag:(NSString *)tagText atIndex:(NSUInteger)index currentSelected:(BOOL)currentSelected{
    
    //NSLog(@"%ld",currentSelected);
    if (currentSelected) {
        return YES;
    }else{
        if (curTotal>=3) {
            [self showProgress:@"主营业务最多可选3项!"];
            return NO;
        }else{
            return YES;
        }
    }
    
    
}




- (void)rightButton{
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 80, 44)];
    [rightButton setTitle:@"保存" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor colorWithHex:@"333333"] forState:UIControlStateNormal];
    [rightButton.titleLabel setFont:[UIFont systemFontOfSize:SCREEN_WIDTH/23.43]];
    rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightButton addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

#pragma mark - Add Action
 - (void)addAction{
 
     UITapGestureRecognizer *viewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapAction:)];
     [self.view addGestureRecognizer:viewTap];
     
     
     UITapGestureRecognizer *maleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(malrTapAction:)];
     [self.editDataView.maleView addGestureRecognizer:maleTap];
     
     UITapGestureRecognizer *femaleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(femalrTapAction:)];
     [self.editDataView.femaleView addGestureRecognizer:femaleTap];
     
     self.editDataView.emailTextField.delegate = self;
     self.editDataView.emailTextField.tag      = 911;
     
     self.editDataView.companyTextField.delegate = self;
     self.editDataView.companyTextField.tag      = 912;
     
     self.editDataView.positionTextField.delegate = self;
     self.editDataView.positionTextField.tag      = 913;
     
     self.editDataView.cityTextField.delegate = self;
     self.editDataView.cityTextField.tag      = 914;
     
     self.editDataView.telTextField.delegate = self;
     self.editDataView.telTextField.tag      = 916;
 }


#pragma mark - TF Delegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (textField.tag==911) {
        [UIView animateWithDuration:0.18 animations:^{
            self.editDataView.contentOffset = CGPointMake(0, SCREEN_WIDTH/375*145);
        }];
    }else if (textField.tag==912) {
        [UIView animateWithDuration:0.28 animations:^{
            self.editDataView.contentOffset = CGPointMake(0, SCREEN_WIDTH/375*374.5);
        }];
    }else if (textField.tag==913) {
        [UIView animateWithDuration:0.28 animations:^{
            self.editDataView.contentOffset = CGPointMake(0, SCREEN_WIDTH/375*374.5);
        }];
    }else if (textField.tag==914) {
        
         //弹出选择器
        [UIView animateWithDuration:0.28 animations:^{
            self.editDataView.contentOffset = CGPointMake(0, SCREEN_WIDTH/375*374.5);
            
            [self.editDataView.infoPicker selectRow:0 inComponent:0 animated:NO];
            self.editDataView.pickerView.y = SCREEN_HEIGHT - 240;
        }];
        [self.view endEditing:YES];
        return NO;
    }
    return YES;
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.tag==916) {
        // Prevent crashing undo bug – see note below.
        if(range.length + range.location > textField.text.length){
            return NO;
        }
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return newLength <= 11;
    }
 
    return YES;
}



- (void)backAction {
    
    [self.editDataView.pickerView removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Save
- (void)rightBtnAction {
    NSMutableDictionary *parDic = [[NSMutableDictionary alloc] init];
    
    //name
    if (self.editDataView.nametextField.text.length>0) {
        [parDic setObject:self.editDataView.nametextField.text forKey:@"person_name"];
    }else{
        [parDic setObject:@"" forKey:@"person_name"];
    }
    //gender
    if (self.genderStr.length>0) {
       [parDic setObject:self.genderStr forKey:@"gender"];
    }
    //tel
    if (self.editDataView.telTextField.text.length>0) {
        [parDic setObject:self.editDataView.telTextField.text forKey:@"telphone"];
    }else{
        [parDic setObject:@"" forKey:@"telphone"];
    }
    //email
    if (self.editDataView.emailTextField.text.length>0) {
        [parDic setObject:self.editDataView.emailTextField.text forKey:@"email"];
    }else{
       [parDic setObject:@"" forKey:@"email"];
    }
    //com
    if (self.editDataView.companyTextField.text.length>0) {
        [parDic setObject:self.editDataView.companyTextField.text forKey:@"corp_name"];
    }else{
        [parDic setObject:@"" forKey:@"corp_name"];
    }
    //position
    if (self.editDataView.positionTextField.text.length>0) {
        [parDic setObject:self.editDataView.positionTextField.text forKey:@"title"];
    }else{
        [parDic setObject:@"" forKey:@"title"];
    }
    //city
    if (self.editDataView.cityTextField.text.length>0) {
        [parDic setObject:[NSString stringWithFormat:@"%@^%@^%@",_selectedProvinceTitle,_selectedCityTitle,_selectedAreaTitle] forKey:@"city"];
    }else{
        [parDic setObject:@"" forKey:@"city"];
    }
    
    
    //main_biz
    NSString *currentMianBiz = [NSString stringWithFormat:@"%d",currentValue];
    if (currentMianBiz.length>0&&![currentMianBiz isEqualToString:@"(null)"]) {
        [parDic setObject:currentMianBiz forKey:@"main_biz"];
    }else{
        [parDic setObject:@"0" forKey:@"main_biz"];
    }
    
    
    
    
    NSString *isComAuth = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Person_auth]];
    if ([isComAuth isEqualToString:@"unauthed"]||[isComAuth isEqualToString:@"failed"]) {
        //未认证
        //未通过
        if (self.editDataView.nametextField.text.length>0) {
            //tel
            if (self.editDataView.telTextField.text.length>0) {
                if ([BFRegularManage checkMobile:self.editDataView.telTextField.text]) {
                    //email
                    if (self.editDataView.emailTextField.text.length>0) {
                        if ([BFRegularManage checkEmail:self.editDataView.emailTextField.text]) {
                            NSLog(@"right");
                            [self saveBaseInfo:parDic];
                        }else{
                            [self showProgress:@"邮箱格式填写错误"];
                        }
                    }else{
                        [self saveBaseInfo:parDic];
                    }
                }else{
                    [self showProgress:@"请输入正确的手机号"];
                    [self.HUD hide:YES];
                }
            }else{
                //email
                if (self.editDataView.emailTextField.text.length>0) {
                    if ([BFRegularManage checkEmail:self.editDataView.emailTextField.text]) {
                        NSLog(@"right");
                        [self saveBaseInfo:parDic];
                    }else{
                        [self showProgress:@"邮箱格式填写错误"];
                    }
                }else{
                    [self saveBaseInfo:parDic];
                }
            }
        }else{
            [self showProgress:@"姓名不能为空!"];
        }
    }else{
        //tel
        if (self.editDataView.telTextField.text.length>0) {
            if ([BFRegularManage checkMobile:self.editDataView.telTextField.text]) {
                //email
                if (self.editDataView.emailTextField.text.length>0) {
                    if ([BFRegularManage checkEmail:self.editDataView.emailTextField.text]) {
                        NSLog(@"right");
                        [self saveBaseInfo:parDic];
                    }else{
                        [self showProgress:@"邮箱格式填写错误"];
                    }
                }else{
                    [self saveBaseInfo:parDic];
                }
            }else{
                [self showProgress:@"请输入正确的手机号"];
                [self.HUD hide:YES];
            }
        }else{
            //email
            if (self.editDataView.emailTextField.text.length>0) {
                if ([BFRegularManage checkEmail:self.editDataView.emailTextField.text]) {
                    NSLog(@"right");
                    [self saveBaseInfo:parDic];
                }else{
                    [self showProgress:@"邮箱格式填写错误"];
                }
            }else{
                [self saveBaseInfo:parDic];
            }
        }
    }

    
    
    NSLog(@"new par --- %@",parDic);
    NSLog(@"old par --- %@",self.old_parDic);
}

- (void)saveBaseInfo:(NSDictionary *)parDic{
    if (![self.old_parDic isEqualToDictionary:parDic]) {
        
        self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        [keyWindow addSubview:self.HUD];
        [self.HUD show:YES];
        //NSLog(@"%@",parDic);
        NSString *urlStr = [NSString stringWithFormat:@"%@/user/edit",APIDev];
        [AFNetManager requestWithType:HttpRequestTypePost withUrlString:urlStr withParaments:parDic withSuccessBlock:^(NSDictionary *object) {
            NSLog(@"%@",object);
            
            [self.HUD hide:YES];
            
            NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
            if ([stateStr isEqualToString:@"success"]) {
                
                //name
                if (self.editDataView.nametextField.text.length>0) {
                    [[NSUserDefaults standardUserDefaults] setObject:self.editDataView.nametextField.text  forKey:Person_name];
                }else{
                    [[NSUserDefaults standardUserDefaults] setObject:nil  forKey:Person_name];
                }
                //gender
                if (self.genderStr.length>0) {
                    [[NSUserDefaults standardUserDefaults] setObject:self.genderStr    forKey:Person_gender];
                }else{
                    [[NSUserDefaults standardUserDefaults] setObject:nil  forKey:Person_gender];
                }
                //tel
                if (self.editDataView.telTextField.text.length>0) {
                    [[NSUserDefaults standardUserDefaults] setObject:self.editDataView.telTextField.text      forKey:Person_telphone];
                }else{
                    [[NSUserDefaults standardUserDefaults] setObject:nil  forKey:Person_telphone];
                }
                //email
                if (self.editDataView.emailTextField.text.length>0) {
                    [[NSUserDefaults standardUserDefaults] setObject:self.editDataView.emailTextField.text    forKey:Person_email];
                }else{
                    [[NSUserDefaults standardUserDefaults] setObject:nil  forKey:Person_email];
                }
                //com
                if (self.editDataView.companyTextField.text.length>0) {
                    [[NSUserDefaults standardUserDefaults] setObject:self.editDataView.companyTextField.text  forKey:Person_corp_name];
                }else{
                    [[NSUserDefaults standardUserDefaults] setObject:nil  forKey:Person_corp_name];
                }
                //position
                if (self.editDataView.positionTextField.text.length>0) {
                    [[NSUserDefaults standardUserDefaults] setObject:self.editDataView.positionTextField.text forKey:Person_title];
                }else{
                    [[NSUserDefaults standardUserDefaults] setObject:nil  forKey:Person_title];
                }
                //city
                if (self.editDataView.cityTextField.text.length>0) {
                    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@^%@^%@",_selectedProvinceTitle,_selectedCityTitle,_selectedAreaTitle]    forKey:Person_city];
                }else{
                    [[NSUserDefaults standardUserDefaults] setObject:nil  forKey:Person_city];
                }
                if (currentValue>0) {
                    //main_biz
                    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",currentValue] forKey:Person_main_biz];
                }else{
                    //main_biz
                    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:Person_main_biz];
                }
                
                
                
                
                [self showProgress:object[@"data"][@"success"]];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [self showProgress:object[@"status"][@"message"]];
            }
            
        } withFailureBlock:^(NSError *error) {
            NSLog(@"%@",error);
            [self.HUD hide:YES];
        } progress:^(float progress) {
            NSLog(@"%f",progress);
        }];
    }else{
        [self showProgress:@"保存成功！"];
        [self.navigationController popViewControllerAnimated:YES];
    }
}



- (void)viewTapAction:(UITapGestureRecognizer *)sender{
    [self.view endEditing:YES];
    
    [UIView animateWithDuration:0.28 animations:^{
        self.editDataView.pickerView.y = SCREEN_HEIGHT;
    } completion:^(BOOL finished) {
        //_currentPick = 0;
        _provinceSelectedRow = 0;
        _citySelectedRow     = 0;
        _areaSelectedRow     = 0;
    }];
    
    [UIView animateWithDuration:0.18 animations:^{
        //self.editDataView.contentOffset = CGPointMake(0, 0);
    }];
}

#pragma mark - Change header Image
- (void)headerTapAction:(UITapGestureRecognizer *)sender{
    NSLog(@"tap");
}

#pragma mark - 称呼
- (void)malrTapAction:(UITapGestureRecognizer *)sender{
    //NSLog(@"male");
    self.genderStr = @"1";
    self.editDataView.maleImageView.image   = [UIImage imageNamed:@"maleSelectedImage"];
    self.editDataView.femaleImageView.image = [UIImage imageNamed:@"maleNoSelectedImage"];
}
- (void)femalrTapAction:(UITapGestureRecognizer *)sender{
    //NSLog(@"femal");
    self.genderStr = @"0";
    self.editDataView.maleImageView.image   = [UIImage imageNamed:@"maleNoSelectedImage"];
    self.editDataView.femaleImageView.image = [UIImage imageNamed:@"maleSelectedImage"];
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
