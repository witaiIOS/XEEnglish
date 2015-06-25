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
- (void)SelectedCourse:(id) sender;

@end
@interface SubCourseListVC : BaseVC<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *courseArray;
//@property (nonatomic, strong) NSString *selectedCourse;

@property (nonatomic, strong) id<SelectedCourseDelegate>delegate;
@end
