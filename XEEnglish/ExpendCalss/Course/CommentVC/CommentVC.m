//
//  CommentVC.m
//  XEEnglish
//
//  Created by houjing on 15/7/28.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "CommentVC.h"

#import "XeeService.h"

//动画时间
#define kAnimationDuration 0.2
//view高度
#define kViewHeight 56

@interface CommentVC ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;

@property (weak, nonatomic) IBOutlet UITextView *commentTV;//评论的UITextView

@property (nonatomic, assign) NSInteger starNum;//评价星级，满意度

@property (nonatomic, assign) NSInteger teacherStatusNum;//老师状态星数
@property (nonatomic, assign) NSInteger teacherAbilityNum;//老师点评星数
@property (nonatomic, assign) NSInteger studentStatusNum;//学生参与度星数

@end

@implementation CommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评论";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI{
    
    [super initUI];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.myScrollView.contentSize = CGSizeMake(kScreenWidth, 700);
    
    //初始化
    self.starNum = 0;
    self.teacherStatusNum = 0;
    self.teacherAbilityNum = 0;
    self.studentStatusNum = 0;
    
    //添加键盘上的done按钮
    [self addKeyboardDone];
}

#pragma mark - AddKeyboardDone
- (void)addKeyboardDone{
    
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    [topView setBarStyle:UIBarStyleBlack];
    
    UIBarButtonItem *btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithTitle:@"完成"
                                                                  style:UIBarButtonItemStyleDone
                                                                 target:self
                                                                 action:@selector(dismissKeyBoard)];
    
    NSArray * buttonsArray = @[btnSpace, doneButton];;
    [topView setItems:buttonsArray];
    [self.commentTV setInputAccessoryView:topView];//当文本输入框加上topView
    topView = nil;
}

-(IBAction)dismissKeyBoard
{
    [self.commentTV resignFirstResponder];
}


#pragma mark - starComment
- (IBAction)starButtonClicked:(id)sender {
    //将原先的btn的图片置灰
    if (self.starNum != 0) {
        UIButton *oldBtn = (UIButton *)[self.view viewWithTag:self.starNum];
        [oldBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"ic_review_score%li_off.png",(long)oldBtn.tag]] forState:UIControlStateNormal];
        [oldBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    //获取点击button的tag，为了得到需要高亮的星星个数
    UIButton *pressBtn = (UIButton *)sender;
    [pressBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"ic_review_score%li_on.png",(long)pressBtn.tag]] forState:UIControlStateNormal];
    [pressBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    self.starNum = pressBtn.tag;
    //一次循环5颗星星，小于tag的星星需要点亮，大于的需要不亮
    for (int i = 10; i<15; i++) {
        UIImageView *highLightImageView = (UIImageView *)[self.view viewWithTag:i+1];
        if (i<self.starNum+10) {
            [highLightImageView setImage:[UIImage imageNamed:@"star_1_normal.png"]];
            
        }
        else{
            [highLightImageView setImage:[UIImage imageNamed:@"star_0_pressed.png"]];
        }
        
    }
}

#pragma mark - faceButton

- (IBAction)faceButtonClicked:(id)sender {
    //获取点击button的tag，为了得到需要高亮的星星个数
    UIButton *faceBtn = (UIButton *)sender;
    if ((20 < faceBtn.tag)&& (faceBtn.tag< 30)) {
        //获取需要高亮的笑脸个数
        self.teacherStatusNum = faceBtn.tag - 20;
        //一次循环5颗星星，小于tag的星星需要点亮，大于的需要不亮
        for (int i = 20; i<25; i++) {
            UIButton *highLightBtn = (UIButton *)[self.view viewWithTag:i+1];
            if (i<self.teacherStatusNum+20) {
                [highLightBtn setBackgroundImage:[UIImage imageNamed:@"takeout_bg_rating_face_selected.png"] forState:UIControlStateNormal];
            }
            else{
                [highLightBtn setBackgroundImage:[UIImage imageNamed:@"takeout_bg_rating_face_normal.png"] forState:UIControlStateNormal];
            }
        }
    }
    else if ((30 < faceBtn.tag)&& (faceBtn.tag< 40)){
        //获取需要高亮的笑脸个数
        self.teacherAbilityNum = faceBtn.tag - 30;
        //一次循环5颗星星，小于tag的星星需要点亮，大于的需要不亮
        for (int i = 30; i<35; i++) {
            UIButton *highLightBtn = (UIButton *)[self.view viewWithTag:i+1];
            if (i<self.teacherAbilityNum+30) {
                [highLightBtn setBackgroundImage:[UIImage imageNamed:@"takeout_bg_rating_face_selected.png"] forState:UIControlStateNormal];
            }
            else{
                [highLightBtn setBackgroundImage:[UIImage imageNamed:@"takeout_bg_rating_face_normal.png"] forState:UIControlStateNormal];
            }
        }
        
    }
    else if ((40 < faceBtn.tag)&& (faceBtn.tag< 50)){
        //获取需要高亮的笑脸个数
        self.studentStatusNum = faceBtn.tag - 40;
        //一次循环5颗星星，小于tag的星星需要点亮，大于的需要不亮
        for (int i = 40; i<45; i++) {
            UIButton *highLightBtn = (UIButton *)[self.view viewWithTag:i+1];
            if (i<self.studentStatusNum+40) {
                [highLightBtn setBackgroundImage:[UIImage imageNamed:@"takeout_bg_rating_face_selected.png"] forState:UIControlStateNormal];
            }
            else{
                [highLightBtn setBackgroundImage:[UIImage imageNamed:@"takeout_bg_rating_face_normal.png"] forState:UIControlStateNormal];
            }
        }
    }
}

#pragma mark - Web
- (void)addTStarCommentWithWeb{
    
    if (self.starNum <= 0) {
        [UIFactory showAlert:@"您还未评价星级"];
    }
    else if (self.teacherStatusNum <= 0) {
        [UIFactory showAlert:@"您还未评价老师的状态"];
    }
    else if (self.teacherAbilityNum <= 0) {
        [UIFactory showAlert:@"您还未评价老师的点评"];
    }
    else if (self.studentStatusNum <= 0) {
        [UIFactory showAlert:@"您还未评价学生的参与度"];
    }
    else if (self.commentTV.text.length <= 0){
        [UIFactory showAlert:@"您还未填写评价内容"];
    }
    else{
        NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
        NSDictionary *userInfoDic = userDic[uUserInfoKey];
        //对汉字进行编码
        NSString *commentStr = [self.commentTV.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [self showHudWithMsg:@"上传中"];
        [[XeeService sharedInstance] addTStarCommentWithParentId:userInfoDic[uUserId] andStarCommentNumbers:self.starNum andTeacherTowardsNumbers:self.teacherStatusNum andTeacherCommentNumbers:self.teacherAbilityNum andStudentDegreeNumbers:self.studentStatusNum andRemark:commentStr andRelationId:self.courseInfoDic[@"signon_id"] andToken:userInfoDic[uUserToken] andBlock:^(NSDictionary *result, NSError *error) {
            [self hideHud];
            if (!error) {
                NSNumber *isResult = result[@"result"];
                if (isResult.integerValue == 0) {
                    [UIFactory showAlert:result[@"resultInfo"]];
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else{
                    [UIFactory showAlert:result[@"resultInfo"]];
                }
            }
            else{
                [UIFactory showAlert:@"网络错误"];
            }
        }];
    }
    
}

#pragma mark - My Action
- (IBAction)publishCommentBtnClicked:(id)sender {
    
    [self addTStarCommentWithWeb];
}



#pragma mark - UITextView Delegate
-(void) slideFrame:(BOOL)up
{
    const int movementDistance = 260; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}


- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    //[textView becomeFirstResponder];
    [self slideFrame:YES];
    if ([textView.text isEqualToString:@"请输入－－"]) {
        textView.text = @"";
    }

}

- (void)textViewDidEndEditing:(UITextView *)textView{
    [self slideFrame:NO];
    //[textView resignFirstResponder];
}
@end
