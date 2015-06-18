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
    
    NSLog(@"self.courseInfo:%@",self.courseInfo);
    
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
    }
    else if ([signonStr isEqualToString:@"1"]){
        judgeState = @"已上课";
    }
    else if ([signonStr isEqualToString:@"2"]){
        judgeState = @"请假";
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
}
@end
