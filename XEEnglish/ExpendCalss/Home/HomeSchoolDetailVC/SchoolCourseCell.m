//
//  SchoolCourseCell.m
//  XEEnglish
//
//  Created by houjing on 15/8/11.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "SchoolCourseCell.h"

@implementation SchoolCourseCell

- (void)layoutSubviews{
    
    [super layoutSubviews];
    //获取课程图像
    [self.courseImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",XEEimageURLPrefix,[_courseInfo objectForKey:@"photo"]]] placeholderImage:[UIImage imageNamed:@"image_loading.png"]];
    //获取课程名
    self.courseNameLabel.text = [_courseInfo objectForKey:@"title"];
    //获取报名人数
    self.courseStudentNumberLabel.text = [NSString stringWithFormat:@"已报名人数：%@人",[_courseInfo objectForKey:@"order_parent_count"]];
    //获取价格
    self.coursePriceLabel.text = [NSString stringWithFormat:@"总价：%@元/套(单价：%@元/套)",[_courseInfo objectForKey:@"total_price"],[_courseInfo objectForKey:@"price"]];
}

@end
