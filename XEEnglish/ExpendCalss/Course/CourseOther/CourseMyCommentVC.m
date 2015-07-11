//
//  CourseMyCommentVC.m
//  XEEnglish
//
//  Created by houjing on 15/7/11.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "CourseMyCommentVC.h"

@interface CourseMyCommentVC ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *courseTitle;
@property (weak, nonatomic) IBOutlet UITextView *commentTV;

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




- (IBAction)starButtonClicked:(id)sender{
    //获取点击button的tag，为了得到需要高亮的星星个数
    UIButton *pressBtn = (UIButton *)sender;
    NSInteger num = pressBtn.tag;
    //一次循环5颗星星，小于tag的星星需要点亮，大于的需要不亮
    for (int i = 0; i<5; i++) {
        UIButton *highLightBtn = (UIButton *)[self.view viewWithTag:i+1];
        if (i<num) {
            [highLightBtn setBackgroundImage:[UIImage imageNamed:@"star_1_normal.png"] forState:UIControlStateNormal];
        }
        else{
            [highLightBtn setBackgroundImage:[UIImage imageNamed:@"star_0_pressed.png"] forState:UIControlStateNormal];
        }
        
    }
    
}
- (IBAction)publishCommentBtnClicked:(id)sender {
    
    
}


#pragma mark - UITextView Delegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    
}


@end
