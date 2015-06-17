//
//  CourseCell.h
//  XEEnglish
//
//  Created by houjing on 15/6/16.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseTVC.h"

@interface CourseCell : BaseTVC

@property (strong, nonatomic) NSDictionary *courseInfo;

@property (weak, nonatomic) IBOutlet UILabel *courseTitle;
@property (weak, nonatomic) IBOutlet UILabel *courseTime;
@property (weak, nonatomic) IBOutlet UILabel *courseState;


- (IBAction)leaveButtonClicked:(id)sender;

@end
