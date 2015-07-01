//
//  CourseCell.m
//  XEEnglish
//
//  Created by houjing on 15/6/16.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "CourseCell.h"


@implementation CourseCell

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //NSLog(@"self.courseInfo:%@",self.courseInfo);
    
    self.courseTitle.text = self.courseInfo[@"title"];
    self.courseTime.text = self.courseInfo[@"create_time"];
    NSString *signonStr =[NSString stringWithFormat:@"%@",self.courseInfo[@"is_signon"]];
    
    signonStr = [self judgeState:signonStr];
    
    self.courseState.text = signonStr;
    //self.courseState.text = [NSString stringWithFormat:@"%@",self.courseInfo[@"is_signon"]];
}

- (NSString *)judgeState:(NSString *)signonStr{
    
    NSString *judgeState;
    if ([signonStr isEqualToString:@"0"]) {
        judgeState = @"等待上课";
        [self.courseButton setTitle:@"请假" forState:UIControlStateNormal];
        [self.courseButton setBackgroundColor:[UIColor orangeColor]];
    }
    else if ([signonStr isEqualToString:@"1"]){
        judgeState = @"已上课";
        [self.courseButton setTitle:@"评论" forState:UIControlStateNormal];
        [self.courseButton setBackgroundColor:[UIColor grayColor]];
    }
    else if ([signonStr isEqualToString:@"2"]){
        judgeState = @"请假";
        [self.courseButton setTitle:@"补课" forState:UIControlStateNormal];
        [self.courseButton setBackgroundColor:[UIColor orangeColor]];
    }
    else if ([signonStr isEqualToString:@"3"]){
        judgeState = @"缺课";
    }
    else if ([signonStr isEqualToString:@"4"]){
        judgeState = @"延迟";
    }
    else if ([signonStr isEqualToString:@"5"]){
        judgeState = @"暂停";
    }
    else{
        judgeState = @"";
    }
    
    return judgeState;

}

- (IBAction)leaveButtonClicked:(id)sender {
    
//    NSString *signonStr =[NSString stringWithFormat:@"%@",self.courseInfo[@"is_signon"]];
//    
//    if ([signonStr isEqualToString:@"0"]) {
//        CourseLeaveApplyVC *vc = [[CourseLeaveApplyVC alloc] init];
//        vc.title = @"请假申请";
//        
//    }
//    else if ([signonStr isEqualToString:@"1"]){
//        
//    }
//    else if ([signonStr isEqualToString:@"2"]){
//        
//    }
//    else{
//        
//    }
    
    NSString *signonStr =[NSString stringWithFormat:@"%@",self.courseInfo[@"is_signon"]];
    
    [self.delegate courseButtonPressed:signonStr andCourseInfo:self.courseInfo];
}
@end
