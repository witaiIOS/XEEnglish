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
    [self layoutSubviews];
    
    self.courseTitle.text = self.courseInfo[@"title"];
    self.courseTime.text = self.courseInfo[@"create_time"];
    self.courseState.text = self.courseInfo[@"is_signon"];
}

- (IBAction)leaveButtonClicked:(id)sender {
}
@end
