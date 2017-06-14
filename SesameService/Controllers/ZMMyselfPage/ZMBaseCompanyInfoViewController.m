//
//  ZMBaseCompanyInfoViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/4/27.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMBaseCompanyInfoViewController.h"
#import "ZMBaseCompanyInfoView.h"

@interface ZMBaseCompanyInfoViewController ()<UITextFieldDelegate,TTGTextTagCollectionViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    int currentValue;
    int curTotal;
    
    BOOL isSelectComPro;
    
    BOOL isChoiseCity;
    
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



@property(nonatomic,strong)ZMBaseCompanyInfoView *baseCompanyInfoView;
//old par
@property (nonatomic,strong)NSMutableDictionary *old_comDic;
//公司名称
@property (nonatomic,strong)NSString *com_name;
//公司城市
@property (nonatomic,strong)NSString *com_city;
//公司-联系人姓名
@property (nonatomic,strong)NSString *com_contact_name;
//公司-联系人职务
@property (nonatomic,strong)NSString *com_contact_position;
//公司-联系人电话
@property (nonatomic,strong)NSString *com_contact_tel;

//hud
@property (nonatomic , strong) MBProgressHUD *HUD;
//tags
@property(nonatomic,strong)NSMutableArray *tagsArray;

//公司性质
@property(nonatomic,strong)NSArray   *comProArray;
//公司性质
@property (nonatomic,strong)NSString *com_property;
@end

@implementation ZMBaseCompanyInfoViewController

- (void)loadView {
    //change
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.baseCompanyInfoView    = [[ZMBaseCompanyInfoView alloc] initWithFrame:SCREEN_BOUNDS];
    self.view                                 = self.baseCompanyInfoView;
    self.baseCompanyInfoView.tagView.delegate = self;
    self.baseCompanyInfoView.contentSize = CGSizeMake(SCREEN_WIDTH,
                                               CGRectGetMaxY(self.baseCompanyInfoView.tagBackView.frame)+SCREEN_WIDTH/375*23);


    
    
    self.baseCompanyInfoView.infoPicker.delegate   = self;
    self.baseCompanyInfoView.infoPicker.dataSource = self;
    [self.baseCompanyInfoView.confirmBtn addTarget:self action:@selector(pickViewConfirm) forControlEvents:UIControlEventTouchUpInside];
    [self.baseCompanyInfoView.cancelBtn addTarget:self action:@selector(pickViewCancel) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"基础信息";
    
    [self rightButton];
    
    [self addAction];
    
    self.old_comDic = [[NSMutableDictionary alloc] init];
    //个人姓名
    self.com_name = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Com_name]];
    if (self.com_name.length>0&&![self.com_name isEqualToString:@"(null)"]) {
        self.baseCompanyInfoView.nametextField.text = self.com_name;
        [self.old_comDic setObject:self.com_name forKey:@"corp_name"];
    }
    
    
    
    //公司城市
    self.com_city = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Com_city]];
    if (self.com_city.length>0&&![self.com_city isEqualToString:@"(null)"]) {
        self.baseCompanyInfoView.citytextField.text = [self.com_city stringByReplacingOccurrencesOfString:@"^" withString:@" "];
        [self.old_comDic setObject:self.com_city forKey:@"city"];
        
        
        NSArray *arrayCity = [self.com_city componentsSeparatedByString:@"^"];
        
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
    //公司-联系人姓名
    self.com_contact_name= [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Com_contact_name]];
    if (self.com_contact_name.length>0&&![self.com_contact_name isEqualToString:@"(null)"]) {
        self.baseCompanyInfoView.contactNameextField.text = self.com_contact_name;
        [self.old_comDic setObject:self.com_contact_name forKey:@"person_name"];
    }
    //公司-联系人职务
    self.com_contact_position = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Com_contact_position]];
    if (self.com_contact_position.length>0&&![self.com_contact_position isEqualToString:@"(null)"]) {
        self.baseCompanyInfoView.positionTextField.text = self.com_contact_position;
        [self.old_comDic setObject:self.com_contact_position forKey:@"title"];
    }
    //公司-联系人电话
    self.com_contact_tel = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Com_contact_tel]];
    if (self.com_contact_tel.length>0&&![self.com_contact_tel isEqualToString:@"(null)"]) {
        self.baseCompanyInfoView.telTextField.text = self.com_contact_tel;
        [self.old_comDic setObject:self.com_contact_tel forKey:@"telphone"];
    }
    
    //公司主营业务
    NSString *per_main_biz = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Com_main_biz]];
    if (per_main_biz.length>0&&![per_main_biz isEqualToString:@"(null)"]) {
        [self.old_comDic setObject:per_main_biz forKey:@"main_biz"];
    }
    
    [self observeProjectTag];
    
    
    [self initAc];
    
    [self initCity];
    
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

#pragma mark - init Ac
- (void)initAc{
    //公司是否认证
    NSString *isComAuth = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Com_auth]];
    if ([isComAuth isEqualToString:@"unauthed"]) {
        //未认证
        self.baseCompanyInfoView.nametextField.userInteractionEnabled = YES;
    }else if ([isComAuth isEqualToString:@"authed"]){
        //已认证
        self.baseCompanyInfoView.nametextField.userInteractionEnabled = NO;
    }else if ([isComAuth isEqualToString:@"unchecked"]){
        //待审核
        self.baseCompanyInfoView.nametextField.userInteractionEnabled = NO;
    }else if ([isComAuth isEqualToString:@"failed"]){
        //未通过
        self.baseCompanyInfoView.nametextField.userInteractionEnabled = YES;
    }
}


#pragma mark- pickerView代理方法
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    //列数
    if (isChoiseCity) {
        return 3;
    }else{
       return 1;
    }
    
}

//每列对应多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {

    if (isChoiseCity) {
        if (component == 0) {
            return _provinceArray.count;
        } else if (component == 1) {
            return [[[_provinceArray objectAtIndex:_provinceSelectedRow] objectForKey:@"city" ] count];
        } else {
            return [[[[[_provinceArray objectAtIndex:_provinceSelectedRow] objectForKey:@"city" ] objectAtIndex:_citySelectedRow] objectForKey:@"county" ] count];
        }
    }else{
        return self.comProArray.count;
    }
    
    
    
}

//每列每行对应显示的数据是什么
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (isChoiseCity) {
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
    }else{
        NSDictionary *dic = self.comProArray[row];
        NSString *picComPro = [NSString stringWithFormat:@"%@",dic[@"title"]];
        return picComPro;
    }
}



-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (isChoiseCity) {
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
    }else{
        isSelectComPro = YES;
        NSDictionary *dic = self.comProArray[row];
        NSString *picComPro = [NSString stringWithFormat:@"%@",dic[@"title"]];
        self.baseCompanyInfoView.companyXingzhitextField.text = picComPro;
        
        self.com_property = [NSString stringWithFormat:@"%@",dic[@"id"]];
        NSLog(@"%@",picComPro);
    }
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



/** pickView Action */
- (void)pickViewConfirm {
    
    if (isChoiseCity) {
        _selectedProvinceTitle = [self pickerView:self.baseCompanyInfoView.infoPicker titleForRow:_provinceSelectedRow forComponent:0];
        _selectedCityTitle     = [self pickerView:self.baseCompanyInfoView.infoPicker titleForRow:_citySelectedRow forComponent:1];
        _selectedAreaTitle     = [self pickerView:self.baseCompanyInfoView.infoPicker titleForRow:_areaSelectedRow forComponent:2];
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
        
        
        self.baseCompanyInfoView.citytextField.text = [NSString stringWithFormat:@"%@ %@ %@",_selectedProvinceTitle,_selectedCityTitle,_selectedAreaTitle];
        
        
        [UIView animateWithDuration:0.28 animations:^{
            self.baseCompanyInfoView.pickerView.y = SCREEN_HEIGHT;
        } completion:^(BOOL finished) {
            //_currentPick = 0;
            _provinceSelectedRow = 0;
            _citySelectedRow     = 0;
            _areaSelectedRow     = 0;
        }];
    }else{
        if (!isSelectComPro) {
            NSDictionary *dic = self.comProArray[0];
            NSString *picComPro = [NSString stringWithFormat:@"%@",dic[@"title"]];
            self.baseCompanyInfoView.companyXingzhitextField.text = picComPro;
            
            
            self.com_property = [NSString stringWithFormat:@"%@",dic[@"id"]];
        }
        NSLog(@"确认");
        self.baseCompanyInfoView.pickerView.alpha = 0;
        [UIView animateWithDuration:0.28 animations:^{
            self.baseCompanyInfoView.pickerView.y = SCREEN_HEIGHT;
        } completion:^(BOOL finished) {
            
        }];
    }
    
    
    
}

- (void)pickViewCancel {
    
    NSLog(@"取消");
    //self.baseCompanyInfoView.pickerView.alpha = 0;
    [UIView animateWithDuration:0.28 animations:^{
        self.baseCompanyInfoView.pickerView.y = SCREEN_HEIGHT;
    } completion:^(BOOL finished) {
        //_currentPick = 0;
        _provinceSelectedRow = 0;
        _citySelectedRow     = 0;
        _areaSelectedRow     = 0;
    }];
    
    
}



#pragma mark - 业务类型
- (void)observeProjectTag{
    
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    //UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
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
            [self.baseCompanyInfoView.tagView addTags:self.tagsArray];
            
            
            //公司主营业务
            NSString *per_main_biz = [[NSUserDefaults standardUserDefaults] objectForKey:Com_main_biz];
            int per_main_int = [per_main_biz intValue];
            
            currentValue = per_main_int;
            for (int i=0; i<self.tagsArray.count; i++) {
                int compare = (int)pow(2, i);
                if (per_main_int&compare) {
                    [self.baseCompanyInfoView.tagView setTagAtIndex:i selected:YES];
                    curTotal++;
                }
            }
        }else{
            [self showProgress:object[@"status"][@"message"]];
        }
        
        [self observeComPro];
    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
        [self observeComPro];
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}



#pragma mark - 公司性质
- (void)observeComPro{
    
    NSString *urlStr   = [NSString stringWithFormat:@"%@/common/info-config",APIDev];
    NSDictionary *pra = @{@"param":@"corp"};
    
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:pra withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"Com Pro -----------------------***********************************************--- %@",object);
        
        
        [self.HUD hide:YES];
        
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            self.comProArray = [NSArray arrayWithArray:object[@"data"][@"corp_property"]];
            //公司性质
            NSString *comPro = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Com_property]];
            self.com_property = comPro;
            if (comPro.length>0&&![comPro isEqualToString:@"(null)"]&&![comPro isEqualToString:@"0"]) {
                [self.old_comDic setObject:comPro forKey:@"corp_property"];
                for (NSDictionary *comProDic in self.comProArray) {
                    NSString *coPr = [NSString stringWithFormat:@"%@",comProDic[@"id"]];
                    if ([coPr integerValue]==[comPro integerValue]) {
                       self.baseCompanyInfoView.companyXingzhitextField.text = [NSString stringWithFormat:@"%@",comProDic[@"title"]];
                    }
                }
            }
        }else{
            [self showProgress:object[@"status"][@"message"]];
        }
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



- (void)addAction{
    
    UITapGestureRecognizer *viewTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapGRAction:)];
    [self.view addGestureRecognizer:viewTapGR];
    
    //企业名称
    self.baseCompanyInfoView.nametextField.delegate = self;
    self.baseCompanyInfoView.nametextField.tag      = 511;
    
    //公司性质
    self.baseCompanyInfoView.companyXingzhitextField.delegate = self;
    self.baseCompanyInfoView.companyXingzhitextField.tag      = 512;
    //所在城市
    self.baseCompanyInfoView.citytextField.delegate = self;
    self.baseCompanyInfoView.citytextField.tag      = 513;
    //联系人信息
    //name
    self.baseCompanyInfoView.contactNameextField.delegate = self;
    self.baseCompanyInfoView.contactNameextField.tag      = 514;
    //职务
    self.baseCompanyInfoView.positionTextField.delegate = self;
    self.baseCompanyInfoView.positionTextField.tag      = 515;
    //tel
    self.baseCompanyInfoView.telTextField.delegate = self;
    self.baseCompanyInfoView.telTextField.tag      = 516;
    
    
    
    
}

#pragma mark - TF Delegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    NSLog(@"%ld",textField.tag);
    
    if (textField.tag==511) {
        [UIView animateWithDuration:0.18 animations:^{
            self.baseCompanyInfoView.contentOffset = CGPointMake(0, SCREEN_WIDTH/375*0);
        }];
    }else if (textField.tag==512) {
        isChoiseCity = NO;
        //公司性质
        [UIView animateWithDuration:0.28 animations:^{
            self.baseCompanyInfoView.contentOffset = CGPointMake(0, SCREEN_WIDTH/375*0);
        }];
        /** 弹出选择器 */
        self.baseCompanyInfoView.pickerView.alpha = 1;
        [UIView animateWithDuration:0.28 animations:^{
            [self.baseCompanyInfoView.infoPicker selectRow:0 inComponent:0 animated:NO];
            self.baseCompanyInfoView.pickerView.y = SCREEN_HEIGHT - 240;
        }];
        
        [self.view endEditing:YES];
        return NO;
    }else if (textField.tag==513) {
        isChoiseCity = YES;
        //城市
        [UIView animateWithDuration:0.28 animations:^{
            self.baseCompanyInfoView.contentOffset = CGPointMake(0, SCREEN_WIDTH/375*0);
        }];
        /** 弹出选择器 */
        self.baseCompanyInfoView.pickerView.alpha = 1;
        [UIView animateWithDuration:0.28 animations:^{
            [self.baseCompanyInfoView.infoPicker selectRow:0 inComponent:0 animated:NO];
            self.baseCompanyInfoView.pickerView.y = SCREEN_HEIGHT - 240;
        }];
        
        [self.view endEditing:YES];
        return NO;
    }else if (textField.tag==514) {
        [UIView animateWithDuration:0.28 animations:^{
            self.baseCompanyInfoView.contentOffset = CGPointMake(0, SCREEN_WIDTH/375*250);
        }];
    }else if (textField.tag==515) {
        [UIView animateWithDuration:0.28 animations:^{
            self.baseCompanyInfoView.contentOffset = CGPointMake(0, SCREEN_WIDTH/375*250);
        }];
    }else if (textField.tag==516) {
        [UIView animateWithDuration:0.28 animations:^{
            self.baseCompanyInfoView.contentOffset = CGPointMake(0, SCREEN_WIDTH/375*250);
        }];
    }
    
    
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.tag==516) {
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
    
    [self.baseCompanyInfoView.pickerView removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}




#pragma mark - tap
- (void)viewTapGRAction:(UITapGestureRecognizer *)sender{
    //NSLog(@"tap");
    
    [UIView animateWithDuration:0.28 animations:^{
        self.baseCompanyInfoView.pickerView.y = SCREEN_HEIGHT;
    } completion:^(BOOL finished) {
        //_currentPick = 0;
        _provinceSelectedRow = 0;
        _citySelectedRow     = 0;
        _areaSelectedRow     = 0;
    }];
    [self.view endEditing:YES];
    
    
    
    [UIView animateWithDuration:0.28 animations:^{
        //self.baseCompanyInfoView.contentOffset = CGPointMake(0, SCREEN_WIDTH/375*0);
    }];
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

#pragma mark - 保存
- (void)rightBtnAction{

    //NSLog(@"save");
    NSMutableDictionary *parDic = [[NSMutableDictionary alloc] init];
    
    //公司名称
    if (self.baseCompanyInfoView.nametextField.text.length>0) {
        [parDic setObject:self.baseCompanyInfoView.nametextField.text forKey:@"corp_name"];
    }else{
        [parDic setObject:@"" forKey:@"corp_name"];
    }
    //公司性质
    if (self.baseCompanyInfoView.companyXingzhitextField.text.length>0) {
        [parDic setObject:self.com_property forKey:@"corp_property"];
    }else{
        [parDic setObject:@"0" forKey:@"corp_property"];
    }
    //公司城市
    if (self.self.baseCompanyInfoView.citytextField.text.length>0) {
        [parDic setObject:[NSString stringWithFormat:@"%@^%@^%@",_selectedProvinceTitle,_selectedCityTitle,_selectedAreaTitle] forKey:@"city"];
    }else{
        [parDic setObject:@"" forKey:@"city"];
    }
    
    
    
    //公司-联系人姓名
    if (self.self.baseCompanyInfoView.contactNameextField.text.length>0) {
        [parDic setObject:self.baseCompanyInfoView.contactNameextField.text forKey:@"person_name"];
    }else{
        [parDic setObject:@"" forKey:@"person_name"];
    }
    //公司-联系人职务
    if (self.baseCompanyInfoView.positionTextField.text.length>0) {
        [parDic setObject:self.baseCompanyInfoView.positionTextField.text forKey:@"title"];
    }else{
        [parDic setObject:@"" forKey:@"title"];
    }
    //公司-联系人电话
    if (self.baseCompanyInfoView.telTextField.text.length>0) {
        [parDic setObject:self.baseCompanyInfoView.telTextField.text forKey:@"telphone"];
    }else{
        [parDic setObject:@"" forKey:@"telphone"];
    }
    
    //main_biz
    NSString *currentMianBiz = [NSString stringWithFormat:@"%d",currentValue];
    if (currentMianBiz.length>0&&![currentMianBiz isEqualToString:@"(null)"]) {
        [parDic setObject:currentMianBiz forKey:@"main_biz"];
    }else{
        [parDic setObject:@"0" forKey:@"main_biz"];
    }
    
    
    
    
    
    NSString *isComAuth = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Com_auth]];
    if ([isComAuth isEqualToString:@"unauthed"]||[isComAuth isEqualToString:@"failed"]) {
        //未认证
        //未通过
        if (self.baseCompanyInfoView.nametextField.text.length>0) {
            if ([self.old_comDic isEqualToDictionary:parDic]) {
                [self showProgress:@"保存成功！"];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                
                
                
                self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
                UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
                [keyWindow addSubview:self.HUD];
                [self.HUD show:YES];
                
                NSLog(@"%@",parDic);
                
                if (self.baseCompanyInfoView.telTextField.text.length>0) {
                    if ([BFRegularManage checkMobile:self.baseCompanyInfoView.telTextField.text]) {
                        [self saveBaseComInfo:parDic];
                    }else{
                        [self showProgress:@"请输入正确的手机号"];
                        [self.HUD hide:YES];
                    }
                }else{
                    [self saveBaseComInfo:parDic];
                }
                
                
                
            }
        }else{
            [self showProgress:@"企业名称不能为空!"];
        }
    }else{
        if ([self.old_comDic isEqualToDictionary:parDic]) {
            [self showProgress:@"保存成功！"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
            self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
            UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
            [keyWindow addSubview:self.HUD];
            [self.HUD show:YES];
            NSLog(@"%@",parDic);
            if (self.baseCompanyInfoView.telTextField.text.length>0) {
                if ([BFRegularManage checkMobile:self.baseCompanyInfoView.telTextField.text]) {
                    [self saveBaseComInfo:parDic];
                }else{
                    [self showProgress:@"请输入正确的手机号"];
                    [self.HUD hide:YES];
                }
            }else{
                [self saveBaseComInfo:parDic];
            }
        }
        
    }
    

    
    NSLog(@"new par --- %@",parDic);
    NSLog(@"old par --- %@",self.old_comDic);
}


- (void)saveBaseComInfo:(NSDictionary *)parDic{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/user/edit",APIDev];
    [AFNetManager requestWithType:HttpRequestTypePost withUrlString:urlStr withParaments:parDic withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"%@",object);
        NSLog(@"%@",object[@"status"][@"message"]);
        
        [self.HUD hide:YES];
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            //NSLog(@"%@",object[@"data"][@"success"]);
            //公司名称
            if (self.baseCompanyInfoView.nametextField.text.length>0) {
                [[NSUserDefaults standardUserDefaults] setObject:self.baseCompanyInfoView.nametextField.text forKey:Com_name];
            }else{
                [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:Com_name];
            }
            //公司性质
            if (self.baseCompanyInfoView.companyXingzhitextField.text.length>0) {
                [[NSUserDefaults standardUserDefaults] setObject:self.com_property forKey:Com_property];
            }else{
                [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:Com_property];
            }
            //公司城市
            if (self.self.baseCompanyInfoView.citytextField.text.length>0) {
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@^%@^%@",_selectedProvinceTitle,_selectedCityTitle,_selectedAreaTitle] forKey:Com_city];
            }else{
                [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:Com_city];
            }
            //公司-联系人姓名
            if (self.self.baseCompanyInfoView.contactNameextField.text.length>0) {
                [[NSUserDefaults standardUserDefaults] setObject:self.baseCompanyInfoView.contactNameextField.text forKey:Com_contact_name];
            }else{
                [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:Com_contact_name];
            }
            //公司-联系人职务
            if (self.baseCompanyInfoView.positionTextField.text.length>0) {
                [[NSUserDefaults standardUserDefaults] setObject:self.baseCompanyInfoView.positionTextField.text forKey:Com_contact_position];
            }else{
                [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:Com_contact_position];
            }
            //公司-联系人电话
            if (self.baseCompanyInfoView.telTextField.text.length>0) {
                [[NSUserDefaults standardUserDefaults] setObject:self.baseCompanyInfoView.telTextField.text forKey:Com_contact_tel];
            }else{
                [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:Com_contact_tel];
            }
            
            //main_biz
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",currentValue] forKey:Com_main_biz];
            
            
            
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
}



/*
 //NSLog(@"login");
 if ([BFRegularManage checkMobile:self.loginView.telTextField.text]) {
 
 }else{
 [self showProgress:@"请输入正确的手机号"];
 [self.HUD hide:YES];
 }
 */






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
