//
//  CoursePhotoVC.h
//  XEEnglish
//
//  Created by houjing on 15/7/31.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseVC.h"

@interface CoursePhotoVC : BaseVC
//图片de公共页面，由课程回顾页面传值过来
@property (nonatomic, strong) NSString *courseScheduleId;
@property (nonatomic, strong) NSString *signonId;

@end
