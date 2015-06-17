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
    self.courseState.text = [NSString stringWithFormat:@"%@",self.courseInfo[@"is_signon"]];
}

- (IBAction)leaveButtonClicked:(id)sender {
}
@end
