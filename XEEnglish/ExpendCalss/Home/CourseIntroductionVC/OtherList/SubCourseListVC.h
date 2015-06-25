//
//  SubCourseListVC.h
//  XEEnglish
//
//  Created by houjing on 15/6/25.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseVC.h"
@protocol SelectedCourseDelegate <NSObject>

@optional
- (void)selectedCourse:(id) sender;

@end

@interface SubCourseListVC : BaseVC

@property (nonatomic, strong) NSString *parentCourseId;//父课程id
@property (nonatomic, strong) NSString *selectedCourse;//选择的子课程

@property (nonatomic, strong) id<SelectedCourseDelegate>delegate;
@end
