//
//  CourseMyCommentVC.m
//  XEEnglish
//
//  Created by houjing on 15/7/11.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "CourseMyCommentVC.h"

@interface CourseMyCommentVC ()
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)starButtonClicked:(id)sender{
    UIButton *pressBtn = (UIButton *)sender;
    NSInteger num = pressBtn.tag;
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

@end
