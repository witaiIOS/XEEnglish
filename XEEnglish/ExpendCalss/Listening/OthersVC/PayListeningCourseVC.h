//
//  PayListeningCourseVC.h
//  XEEnglish
//
//  Created by houjing on 15/7/27.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseVC.h"
@protocol PayListeningCourseVCDelegate <NSObject>

@optional
- (void)payListeningCourseVCSelectedCourse:(id) sender;

@end

@interface PayListeningCourseVC : BaseVC

@property (nonatomic, strong) NSString *selectCourse;//选择的课程

@property (nonatomic, assign) id<PayListeningCourseVCDelegate>delegate;
@end
