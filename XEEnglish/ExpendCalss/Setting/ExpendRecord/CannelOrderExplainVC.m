//
//  CannelOrderExplainVC.m
//  XEEnglish
//
//  Created by houjing on 15/7/17.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "CannelOrderExplainVC.h"

@interface CannelOrderExplainVC ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *explainTextView;

@end

@implementation CannelOrderExplainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"取消订单说明";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI{
    
    [super initUI];
    
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
    [self.explainTextView setInputAccessoryView:topView];//当文本输入框加上topView
    topView = nil;
}

-(IBAction)dismissKeyBoard
{
    [self.explainTextView resignFirstResponder];
}


- (IBAction)submitBtnClicked:(id)sender {
    
}

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    [textView resignFirstResponder];
}

@end
