//
//  ZMMySounceAnswerDetailViewController.m
//  SesameService
//
//  Created by 杜海龙 on 17/5/9.
//  Copyright © 2017年 anju. All rights reserved.
//

#import "ZMMySounceAnswerDetailViewController.h"
#import "ZMMySounceAnswerDetailView.h"

#import "ZMSounceRightTableViewCell.h"
#import "ZMSounceRightDetailTableViewCell.h"

#import "ZMMySounceAnswerAudioTableViewCell.h"
#import "ZMMySounceAnswerTextTableViewCell.h"
#import "AVRecorder.h"

@interface ZMMySounceAnswerDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) ZMMySounceAnswerDetailView *sounceDetailView;
@property (nonatomic, strong) NSArray       *answerArray;
@property (nonatomic, strong) MBProgressHUD *HUD;
@property (nonatomic, strong) NSDictionary  *sourceDic;

@property (nonatomic, strong) AVRecorder    *Recorder;
@property (nonatomic, assign) BOOL          isShowVoice; //判断是否已弹出语音输入框
@property (nonatomic, assign) BOOL          isTextAnswer;//是否文字回答
@property (nonatomic, assign) BOOL          isGetVoice;  //是否存在录音文件
@property (nonatomic, assign) BOOL          isStartRecord; //是否正在录音


/** 定时器 **/
@property (nonatomic, assign) BOOL             isPlayRecord;
@property (nonatomic, strong) NSTimer          *timer;
@property (nonatomic, assign) NSInteger        recordTime;
@property (nonatomic, assign) NSInteger        playTime;
@end

@implementation ZMMySounceAnswerDetailViewController

-(void)loadView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.sounceDetailView = [[ZMMySounceAnswerDetailView alloc] initWithFrame:SCREEN_BOUNDS];
    self.sounceDetailView.sounceDetailableView.delegate = self;
    self.sounceDetailView.sounceDetailableView.dataSource=self;
    self.sounceDetailView.msgTextField.delegate = self;
    self.view = self.sounceDetailView;
    
    [self.sounceDetailView.keyBoardImgBtn addTarget:self action:@selector(toKeyboard)    forControlEvents:UIControlEventTouchUpInside];
    [self.sounceDetailView.voiceImgBtn    addTarget:self action:@selector(toVoice)       forControlEvents:UIControlEventTouchUpInside];
    [self.sounceDetailView.voiceBtn       addTarget:self action:@selector(answerAction)  forControlEvents:UIControlEventTouchUpInside];
    [self.sounceDetailView.sendBtn        addTarget:self action:@selector(sendAnswer)    forControlEvents:UIControlEventTouchUpInside];
    
    [self.sounceDetailView.startVoiceBtn  addTarget:self action:@selector(startRecord)   forControlEvents:UIControlEventTouchUpInside];
    [self.sounceDetailView.stopVoiceBtn   addTarget:self action:@selector(stopRecord)    forControlEvents:UIControlEventTouchUpInside];
    [self.sounceDetailView.playVoiceBtn   addTarget:self action:@selector(playRecord)    forControlEvents:UIControlEventTouchUpInside];
    [self.sounceDetailView.pauseVoiceBtn  addTarget:self action:@selector(pauseRecord)   forControlEvents:UIControlEventTouchUpInside];
    [self.sounceDetailView.repeatVoiceBtn addTarget:self action:@selector(repeatRecord)  forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的打听";
    
    [self regiestNotification];
    // 创建手势关闭键盘
    UITapGestureRecognizer *downKeyBoard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(downKeyBoard:)];
    [self.view addGestureRecognizer:downKeyBoard];
    
    [self sourceData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[AudioPlayer sharedManager] stopPlayRecord:nil]; /** 停止所有播放的录音 */
}

-(void)backAction{

    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshMySounceAc" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

/** 注册通知监听 */
- (void)regiestNotification {
    
    //注册键盘弹起回收监听
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [nc addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    //注册监听语音录制与上传
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mp3UploadComplete:) name:@"mp3UploadComplete" object:nil]; //上传成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mp3UploadFail)      name:@"mp3UploadFail" object:nil];     //上传失败
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endPlay)            name:@"endPlay" object:nil];           //播放结束
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(audioTime:)         name:@"audioTime" object:nil];         //录音时间
}


#pragma mark - Load Detail
- (void)sourceData{
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    [self.HUD show:YES];
    
    
    NSDictionary *par = @{@"id":[NSString stringWithFormat:@"%@",self.answerDic[@"id"]]};
    NSString *urlStr   = [NSString stringWithFormat:@"%@/question/my-answer-detail",APIDev];
    [AFNetManager requestWithType:HttpRequestTypeGet withUrlString:urlStr withParaments:par withSuccessBlock:^(NSDictionary *object) {
        
        
        NSString *stateStr = [NSString stringWithFormat:@"%@",object[@"status"][@"state"]];
        if ([stateStr isEqualToString:@"success"]) {
            
            self.sourceDic = [NSDictionary dictionaryWithDictionary:object[@"data"]];
            
            if ([[NSString stringWithFormat:@"%@",self.sourceDic[@"is_can_answer"]] isEqualToString:@"1"]) {
                self.sounceDetailView.inputView.alpha = 1;
            } else {
                self.sounceDetailView.inputView.alpha = 0;
            }
            
            NSLog(@"my-answer-detail --- %@",self.sourceDic);
            
            self.answerArray = [NSArray arrayWithArray:object[@"data"][@"my_answer_lists"]];
            NSLog(@"my_answer_lists ---- %@",self.answerArray);
            
            NSString *is_can_answer = [NSString stringWithFormat:@"%@",object[@"data"][@"is_can_answer"]];
            [self canAnswer:[is_can_answer integerValue]];
            
            [self.sounceDetailView.sounceDetailableView reloadData];
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


#pragma mark - Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==0) {
        return 1;
    }else{
        return self.answerArray.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        NSString *note = [NSString stringWithFormat:@"%@",self.sourceDic[@"note"]];
        if (note.length>0&&![note isEqualToString:@"(null)"]) {
            CGSize   size = CGSizeMake(SCREEN_WIDTH-SCREEN_WIDTH/375*34, 0);
            CGSize   autoSize = [[UILabel new] actualSizeOfLable:[NSString stringWithFormat:@"%@",self.sourceDic[@"question"]]
                                                         andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/375*13]
                                                         andSize:size];
            
            NSArray *imgArr    = (NSArray *)self.sourceDic[@"images"];
            CGFloat imgHeight  = 0.0f;
            if (imgArr.count != 0) {
                imgHeight = SCREEN_WIDTH/6.25;
            } else {
                //没图片
                imgHeight = 0;
            }
            
            return SCREEN_WIDTH/375*154-SCREEN_WIDTH/375*36+autoSize.height+imgHeight;
        }else{
            
            
            CGSize   size = CGSizeMake(SCREEN_WIDTH-SCREEN_WIDTH/375*34, 0);
            CGSize   autoSize = [[UILabel new] actualSizeOfLable:[NSString stringWithFormat:@"%@",self.sourceDic[@"question"]]
                                                         andFont:[UIFont systemFontOfSize:SCREEN_WIDTH/375*13]
                                                         andSize:size];
            
            NSArray *imgArr    = (NSArray *)self.sourceDic[@"images"];
            CGFloat imgHeight  = 0.0f;
            if (imgArr.count != 0) {
                imgHeight = SCREEN_WIDTH/6.25;
            } else {
                //没图片
                imgHeight = 0;
            }
            return SCREEN_WIDTH/375*98+autoSize.height+imgHeight;
        }
    }else{
        
        NSDictionary *dic = self.answerArray[indexPath.row];
        NSString *answer = [NSString stringWithFormat:@"%@",dic[@"answer"]];
        //NSString *audio = [NSString stringWithFormat:@"%@",dic[@"audio"]];
        if (answer.length>0&&![answer isEqualToString:@"(null)"]) {
            return SCREEN_WIDTH/375*80;
            //文字
        }else{
            return SCREEN_WIDTH/375*85;
            //音频
        }
    }
}


/**********footer**********/
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        if (self.answerArray.count>0) {
           return SCREEN_WIDTH/375*25;
        }else{
           return SCREEN_WIDTH/375*0.1;
        }
    }else{
        return SCREEN_WIDTH/375*0.1;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section==0) {
        
        if (self.answerArray.count>0) {
            UIView *footView         = [[UIView alloc] init];
            footView.backgroundColor = [UIColor clearColor];
            UILabel *tipLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/375*19,
                                                                          SCREEN_WIDTH/375*0,
                                                                          SCREEN_WIDTH/375*100,
                                                                          SCREEN_WIDTH/375*25)];
            [ZMLabelAttributeMange setLabel:tipLable
                                       text:@"我的回答"
                                        hex:@"666666"
                              textAlignment:NSTextAlignmentLeft
                                       font:[UIFont systemFontOfSize:SCREEN_WIDTH/375*12]];
            [footView addSubview:tipLable];
            return footView;
        }else{
            UIView *footView         = [[UIView alloc] init];
            footView.backgroundColor = [UIColor clearColor];
            return footView;
        }
        
        
    }else{
        UIView *footView         = [[UIView alloc] init];
        footView.backgroundColor = [UIColor clearColor];
        return footView;
    }
    
}

/**********header**********/
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return SCREEN_WIDTH/375*0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *footView         = [[UIView alloc] init];
    footView.backgroundColor = [UIColor clearColor];
    return footView;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *topIndentifire         = @"topSelectCell";
    static NSString *topDetailIndentifire   = @"topDetailSelectCell";
    
    static NSString *audioIndentifire     = @"audioSelectCell";
    static NSString *textIndentifire      = @"textSelectCell";
    
    if (indexPath.section==0) {
        NSString *note = [NSString stringWithFormat:@"%@",self.sourceDic[@"note"]];
        if (note.length>0&&![note isEqualToString:@"(null)"]) {
            ZMSounceRightDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:topDetailIndentifire];
            if (!cell) {
                cell = [[ZMSounceRightDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:topDetailIndentifire];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            [cell setMyDetailAnswer:self.sourceDic];
            return cell;
        }else{
            ZMSounceRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:topIndentifire];
            if (!cell) {
                cell = [[ZMSounceRightTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:topIndentifire];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            [cell setMyDetailAnswer:self.sourceDic];
            return cell;
        }
    }else{
        NSDictionary *dic = self.answerArray[indexPath.row];
        NSString *answer = [NSString stringWithFormat:@"%@",dic[@"answer"]];
        //NSString *audio = [NSString stringWithFormat:@"%@",dic[@"audio"]];
        if (answer.length>0&&![answer isEqualToString:@"(null)"]) {
            
            //文字
            ZMMySounceAnswerTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:textIndentifire];
            if (!cell) {
                cell = [[ZMMySounceAnswerTextTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:textIndentifire];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            [cell setTextSounce:dic];
            return cell;
        }else{
            
            //音频
            ZMMySounceAnswerAudioTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:audioIndentifire];
            if (!cell) {
                cell = [[ZMMySounceAnswerAudioTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:audioIndentifire];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            UILabel *voiceLable = [[cell.voiceBtn subviews] objectAtIndex:3];
            voiceLable.text = @"点击播放";
            
            [cell.voiceBtn addTarget:self action:@selector(voiceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            cell.voiceBtn.tag = 9191+indexPath.row;
            [cell setAudo:dic];
            return cell;
        }
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"click");
}

#pragma mark - is_can_answer
- (void)canAnswer:(NSInteger)is_can_answer{
    if (is_can_answer==1) {
        
    }else{
        
    }
}


#pragma mark - player Audio
- (void)voiceBtnClick:(UIButton *)sender{
    NSDictionary *dic = self.answerArray[sender.tag-9191];
    NSLog(@"player");
    [[AudioPlayer sharedManager] playRecord:[NSString stringWithFormat:@"%@",dic[@"audio"]]
                                    withBtn:sender];
}


#pragma mark - inputView 弹起与收回逻辑
//收到键盘弹出通知后的响应
- (void)keyboardWillShow:(NSNotification *)info {
    
    NSDictionary *dict             = info.userInfo;
    CGRect keyboardBounds          = [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    double duration                = [dict[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardBoundsRect      = [self.view convertRect:keyboardBounds toView:nil];
    double offsetY                 = keyboardBoundsRect.size.height;
    UIViewAnimationOptions options = [dict[UIKeyboardAnimationCurveUserInfoKey] integerValue] << 16;
    
    self.sounceDetailView.voiceImgBtn.alpha    = 1;
    self.sounceDetailView.keyBoardImgBtn.alpha = 0;
    
    if (self.isShowVoice) {
        
        //切换为文字输入状态
        self.isTextAnswer = YES;
        if (_isStartRecord) {
            [self stopRecord];
        }
        
        [UIView animateWithDuration:duration delay:0 options:options animations:^{
            
            self.sounceDetailView.inputView.transform  = CGAffineTransformMakeTranslation(0, -offsetY + (self.sounceDetailView.inputView.height - self.sounceDetailView.textView.height));
        } completion:nil];
        
        
    } else {
        
        [UIView animateWithDuration:duration delay:0 options:options animations:^{
            
            self.sounceDetailView.inputView.transform  = CGAffineTransformMakeTranslation(0, -offsetY);
        } completion:nil];
        
    }
}

//隐藏键盘通知的响应
- (void)keyboardWillHide:(NSNotification *)info {
    
    NSDictionary *dict             = info.userInfo;
    double duration                = [dict[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions options = [dict[UIKeyboardAnimationCurveUserInfoKey] integerValue] << 16;
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        
        self.sounceDetailView.inputView.transform         = CGAffineTransformIdentity;
        
    } completion:nil];
}

//关闭键盘
- (void)downKeyBoard:(UITapGestureRecognizer *)sender{
    
    [self.view endEditing:YES];
    if (self.isShowVoice) {
        
        if (_isStartRecord) {
            [self stopRecord];
        }
        self.isShowVoice = NO;
        [self.view endEditing:YES];
        [UIView animateWithDuration:0.3 animations:^{
            
            self.sounceDetailView.inputView.frame = CGRectMake(0,
                                                          SCREEN_HEIGHT - SCREEN_HEIGHT/13.34,
                                                          SCREEN_WIDTH,
                                                          SCREEN_WIDTH/2.43);
        }];
    }
}

//切换成键盘输入
- (void)toKeyboard {
    
    self.isTextAnswer = YES;
    self.sounceDetailView.voiceBtn.alpha       = 0;
    self.sounceDetailView.voiceImgBtn.alpha    = 1;
    self.sounceDetailView.keyBoardImgBtn.alpha = 0;

    [self.sounceDetailView.msgTextField becomeFirstResponder];
    
}

//切换成语音输入
- (void)toVoice {
    
    self.isTextAnswer = NO;
    self.sounceDetailView.voiceImgBtn.alpha    = 0;
    self.sounceDetailView.keyBoardImgBtn.alpha = 1;
    
    
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.38 animations:^{
        
        self.sounceDetailView.inputView.frame = CGRectMake(0,
                                                      SCREEN_HEIGHT - SCREEN_WIDTH/1.36,
                                                      SCREEN_WIDTH,
                                                      SCREEN_WIDTH/1.36);
    } completion:^(BOOL finished) {
        self.isShowVoice = YES;
    }];
}

- (void)answerAction {
    
    self.isShowVoice  = YES;
    self.isTextAnswer = NO;
    [UIView animateWithDuration:0.38 animations:^{
        
        self.sounceDetailView.inputView.frame = CGRectMake(0,
                                                      SCREEN_HEIGHT - SCREEN_WIDTH/1.36,
                                                      SCREEN_WIDTH,
                                                      SCREEN_WIDTH/1.36);
    } completion:^(BOOL finished) {
        self.isShowVoice = YES;
    }];
}


#pragma mark - 语音录制
- (AVRecorder *)Recorder {
    
    if (_Recorder == nil) {
        _Recorder = [[AVRecorder alloc] init];
    }
    return _Recorder;
}

- (void)startRecord {
    [self.Recorder startRecord];
    NSLog(@"开始录制");
    _isStartRecord = YES;
    _isPlayRecord = NO;
    _isGetVoice = NO;
    _playTime = -1;
    [self.timer setFireDate:[NSDate distantPast]];
    
    [UIView animateWithDuration:0.18 animations:^{
        
        self.sounceDetailView.startVoiceBtn.alpha  = 0;
        self.sounceDetailView.stopVoiceBtn.alpha   = 1;
        self.sounceDetailView.playVoiceBtn.alpha   = 0;
        self.sounceDetailView.pauseVoiceBtn.alpha  = 0;
        self.sounceDetailView.repeatVoiceBtn.alpha = 0;
        self.sounceDetailView.gifImage.alpha = 1;
        self.sounceDetailView.timeLable.alpha = 1;
    }];
}

- (void)stopRecord {
    [self.Recorder stopRecord];
    NSLog(@"停止录制");
    _isStartRecord = NO;
    [self.timer setFireDate:[NSDate distantFuture]];
    
    [UIView animateWithDuration:0.18 animations:^{
        
        self.sounceDetailView.startVoiceBtn.alpha  = 0;
        self.sounceDetailView.stopVoiceBtn.alpha   = 0;
        self.sounceDetailView.playVoiceBtn.alpha   = 1;
        self.sounceDetailView.pauseVoiceBtn.alpha  = 0;
        self.sounceDetailView.repeatVoiceBtn.alpha = 1;
        self.sounceDetailView.gifImage.alpha = 0;
        self.sounceDetailView.timeLable.alpha = 0;
    }];
}

- (void)playRecord {
    [self.Recorder playRecord];
    NSLog(@"播放录音");
    _playTime     = _recordTime;
    _isPlayRecord = YES;
    [self.timer setFireDate:[NSDate distantPast]];
    
    [UIView animateWithDuration:0.18 animations:^{
        
        self.sounceDetailView.startVoiceBtn.alpha  = 0;
        self.sounceDetailView.stopVoiceBtn.alpha   = 0;
        self.sounceDetailView.playVoiceBtn.alpha   = 0;
        self.sounceDetailView.pauseVoiceBtn.alpha  = 1;
        self.sounceDetailView.repeatVoiceBtn.alpha = 1;
        self.sounceDetailView.gifImage.alpha = 1;
        self.sounceDetailView.timeLable.alpha = 1;
    }];
}

- (void)pauseRecord {
    [self.Recorder stopPlayRecord];
    NSLog(@"暂停播放");
    [self.timer setFireDate:[NSDate distantFuture]];
    
    [UIView animateWithDuration:0.18 animations:^{
        
        self.sounceDetailView.startVoiceBtn.alpha  = 0;
        self.sounceDetailView.stopVoiceBtn.alpha   = 0;
        self.sounceDetailView.playVoiceBtn.alpha   = 1;
        self.sounceDetailView.pauseVoiceBtn.alpha  = 0;
        self.sounceDetailView.repeatVoiceBtn.alpha = 1;
        self.sounceDetailView.gifImage.alpha = 0;
        self.sounceDetailView.timeLable.alpha = 0;
    }];
}

- (void)repeatRecord {
    
    [self.Recorder repeatRecord];
    NSLog(@"重新录制");
    _playTime   = 0;
    _recordTime = 0;
    [self pauseRecord];
    [UIView animateWithDuration:0.18 animations:^{
        
        self.sounceDetailView.startVoiceBtn.alpha  = 1;
        self.sounceDetailView.stopVoiceBtn.alpha   = 0;
        self.sounceDetailView.playVoiceBtn.alpha   = 0;
        self.sounceDetailView.pauseVoiceBtn.alpha  = 0;
        self.sounceDetailView.repeatVoiceBtn.alpha = 0;
        self.sounceDetailView.gifImage.alpha = 0;
        self.sounceDetailView.timeLable.alpha = 0;
    }];
}

//发送语音
- (void)postRecord {
    NSLog(@"发送录音");
    
    //发送回答（语音或者文字发送其中一个）
    [self.Recorder postRecord];
}

#pragma mark - 计时器
- (NSTimer *)timer {
    
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(workTime) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (void)workTime {
    
    if (_isPlayRecord) {
        if (_playTime > 0) {
            _playTime--;
        }
    } else {
        _playTime++;
    }
    NSInteger min    = (NSInteger)(_playTime % (3600)) / 60;
    NSInteger second = (NSInteger)(_playTime % 60);
    self.sounceDetailView.timeLable.text = [NSString stringWithFormat:@"%.2lu:%.2lu",(long)min,(long)second];
}

#pragma maek - 发送回答
- (void)sendAnswer {
    
    if (self.isTextAnswer) {
        
        /** 发送文字 */
        [self.view addSubview:self.HUD];
        [self.HUD show:YES];
        
        NSString     *urlStr   = [NSString stringWithFormat:@"%@/answer/create",APIDev];
        NSDictionary *param = @{@"question_id":[NSString stringWithFormat:@"%@",self.answerDic[@"id"]],
                                @"answer":self.sounceDetailView.msgTextField.text};
        
        NSLog(@"param %@",param);
        
        [AFNetManager requestWithType:HttpRequestTypePost withUrlString:urlStr withParaments:param withSuccessBlock:^(NSDictionary *object) {
            
            NSLog(@"dataSources : %@",object);
            [self.HUD removeFromSuperview];
            if ([[NSString stringWithFormat:@"%@",object[@"status"][@"state"]] isEqualToString:@"success"]) {
                
                [self sourceData];
                [toolClass showProgress:@"发送成功" toView:self.view];
                self.sounceDetailView.msgTextField.text = @"";
            } else {
                [toolClass showProgress:[NSString stringWithFormat:@"%@",object[@"status"][@"message"]] toView:self.view];
            }
            
        } withFailureBlock:^(NSError *error) {
            NSLog(@"%@",error);
            [self.HUD removeFromSuperview];
        } progress:^(float progress) {
            NSLog(@"%f",progress);
        }];
        
    } else {
        
        /** 发送语音 */
        if (_isGetVoice) {
            [self postRecord];
            [self.view addSubview:self.HUD];
            [self.HUD show:YES];
        }
    }
}

//语音上传完成
- (void)mp3UploadComplete:(NSNotification *)info {
    
    NSDictionary *dic = (NSDictionary *)info.userInfo;
    NSLog(@"输出语音地址 : %@ %@",dic[@"url"],dic[@"time"]);

    NSString     *urlStr   = [NSString stringWithFormat:@"%@/answer/create",APIDev];
    NSDictionary *param = @{@"question_id":[NSString stringWithFormat:@"%@",self.answerDic[@"id"]],
                            @"audio":[NSString stringWithFormat:@"%@",dic[@"name"]],
                            @"audio_time":[NSNumber numberWithInteger:[[NSString stringWithFormat:@"%@",dic[@"time"]] integerValue] - 1]};
    
    NSLog(@"param %@",param);
    
    [AFNetManager requestWithType:HttpRequestTypePost withUrlString:urlStr withParaments:param withSuccessBlock:^(NSDictionary *object) {
        
        NSLog(@"dataSources : %@",object);
        [self.HUD removeFromSuperview];
        if ([[NSString stringWithFormat:@"%@",object[@"status"][@"state"]] isEqualToString:@"success"]) {
            
            [self repeatRecord];
            self.isShowVoice = NO;
            [UIView animateWithDuration:0.3 animations:^{
                
                self.sounceDetailView.inputView.frame = CGRectMake(0,
                                                                   SCREEN_HEIGHT - SCREEN_HEIGHT/13.34,
                                                                   SCREEN_WIDTH,
                                                                   SCREEN_WIDTH/2.43);
            }];
            
            [self sourceData];
            [toolClass showProgress:@"发送成功" toView:self.view];
        } else {
            [toolClass showProgress:[NSString stringWithFormat:@"%@",object[@"status"][@"message"]] toView:self.view];
        }
        
    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
        [self.HUD removeFromSuperview];
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
    });
}

//语音上传失败
- (void)mp3UploadFail{
    
    [toolClass showProgress:@"发送失败" toView:self.view];
}

#pragma mark - AVRecord 录音状态通知
//语音播放结束
- (void)endPlay {
    
    [UIView animateWithDuration:0.18 animations:^{
        
        self.sounceDetailView.startVoiceBtn.alpha  = 0;
        self.sounceDetailView.stopVoiceBtn.alpha   = 0;
        self.sounceDetailView.playVoiceBtn.alpha   = 1;
        self.sounceDetailView.pauseVoiceBtn.alpha  = 0;
        self.sounceDetailView.repeatVoiceBtn.alpha = 1;
        self.sounceDetailView.gifImage.alpha = 0;
        self.sounceDetailView.timeLable.alpha = 0;
    }];
}

//获取录音时间
- (void)audioTime:(NSNotification *)info {
    
    NSLog(@"录音时长  %@",info.userInfo);
    _isGetVoice = YES;
    _recordTime = [[NSString stringWithFormat:@"%@",info.userInfo[@"time"]] integerValue];
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
