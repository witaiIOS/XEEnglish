//
//  CommentVC.m
//  XEEnglish
//
//  Created by houjing on 15/7/28.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "CommentVC.h"

@interface CommentVC ()

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
    //初始化
    self.starNum = 0;
    
}

#pragma mark - starComment
- (IBAction)starButtonClicked:(id)sender {
    //将原先的btn的图片置灰
    if (self.starNum != 0) {
        UIButton *oldBtn = (UIButton *)[self.view viewWithTag:self.starNum];
        [oldBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"ic_review_score%li_off.png",(long)oldBtn.tag]] forState:UIControlStateNormal];
    }
    //获取点击button的tag，为了得到需要高亮的星星个数
    UIButton *pressBtn = (UIButton *)sender;
    [pressBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"ic_review_score%li_on.png",(long)pressBtn.tag]] forState:UIControlStateNormal];
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

@end
