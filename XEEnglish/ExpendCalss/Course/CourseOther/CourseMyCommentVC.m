//
//  CourseMyCommentVC.m
//  XEEnglish
//
//  Created by houjing on 15/7/11.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "CourseMyCommentVC.h"

#import "XeeService.h"

@interface CourseMyCommentVC ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *courseTitle;
@property (weak, nonatomic) IBOutlet UITextView *commentTV;
@property (nonatomic, assign) NSInteger starNum;

@end

@implementation CourseMyCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"发表新评论";
}

- (void)initUI{
    
    [super initUI];
    
    self.courseTitle.text = self.courseInfoDic[@"title"];
    //添加键盘上的done按钮
    [self addKeyboardDone];
}

#pragma mark - AddKeyboardDone
- (void)addKeyboardDone{
    
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    [topView setBarStyle:UIBarStyleBlack];
    
    UIBarButtonItem *btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Done"
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - starComment
//评价星星控制
- (IBAction)starButtonClicked:(id)sender{
    //获取点击button的tag，为了得到需要高亮的星星个数
    UIButton *pressBtn = (UIButton *)sender;
    self.starNum = pressBtn.tag;
    //一次循环5颗星星，小于tag的星星需要点亮，大于的需要不亮
    for (int i = 0; i<5; i++) {
        UIButton *highLightBtn = (UIButton *)[self.view viewWithTag:i+1];
        if (i<self.starNum) {
            [highLightBtn setBackgroundImage:[UIImage imageNamed:@"star_1_normal.png"] forState:UIControlStateNormal];
        }
        else{
            [highLightBtn setBackgroundImage:[UIImage imageNamed:@"star_0_pressed.png"] forState:UIControlStateNormal];
        }
        
    }
    
}

#pragma mark - Web
- (void)addSubcourseLeaveApply{
    
    if (self.starNum <= 0) {
        [UIFactory showAlert:@"您还未评价星级"];
    }
    else if (self.commentTV.text.length <= 0){
        [UIFactory showAlert:@"您还未填写评价内容"];
    }
    else{
        NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
        NSDictionary *userInfoDic = userDic[uUserInfoKey];
        [self showHudWithMsg:@"上传中"];
        [[XeeService sharedInstance] addSubcourseLeaveApplyByParentId:userInfoDic[uUserId] andRelationId:self.courseInfoDic[@"signon_id"] andRemark:self.commentTV.text andStar:[NSString stringWithFormat:@"%li",(long)self.starNum] andType:@"1" andApplyId:@"null" andCreateTime:@"null" andStatus:@"null" andTeacherId:@"null" andCheckTime:@"null" andCheckRemark:@"null" andToken:userInfoDic[uUserToken] andBlock:^(NSDictionary *result, NSError *error) {
            [self hideHud];
            if (!error) {
                NSNumber *isResult = result[@"result"];
                if (isResult.integerValue == 0) {
                    [UIFactory showAlert:result[@"resultInfo"]];
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
    //发表评论
    [self addSubcourseLeaveApply];
}


#pragma mark - UITextView Delegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    
}


@end
