//
//  SchoolCourseCell.h
//  XEEnglish
//
//  Created by houjing on 15/8/11.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseTVC.h"

@interface SchoolCourseCell : BaseTVC
@property (nonatomic, strong) NSDictionary *courseInfo;

@property (weak, nonatomic) IBOutlet UIImageView *courseImageView;
@property (weak, nonatomic) IBOutlet UILabel *courseNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *courseStudentNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *coursePriceLabel;


@end
