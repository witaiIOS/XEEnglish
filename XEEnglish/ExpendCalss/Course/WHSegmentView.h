//
//  WHSegmentView.h
//  XEEnglish
//
//  Created by houjing on 15/6/5.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WHSegmentView : UIView<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UIImageView *tabTFImageView;
//@property (strong, nonatomic) UIColor *tabTFColor;
//@property (strong, nonatomic) UIColor *tabTFSelectCorlor;
@property (strong, nonatomic) UIImageView *tabTFSeclectImageView;

@property (nonatomic, strong) UITextField *textFieldStudent;
@property (nonatomic, strong) UITextField *textFieldCourse;

@property (nonatomic, strong) UITableView *tableViewStudent;
@property (nonatomic, strong) UITableView *tableViewCourse;


@property (nonatomic, strong) NSArray *studentsArray;
@property (nonatomic, strong) NSArray *coursesArray;

@property (nonatomic, assign) BOOL showStudentsList;
@property (nonatomic, assign) BOOL showCoursesList;
@property (nonatomic, assign) CGFloat tableHeight;
@property (nonatomic, assign) CGFloat frameHeight;

@property (nonatomic) NSInteger currentIndex;


@end
