//
//  SelectedStudentVC.h
//  XEEnglish
//
//  Created by houjing on 15/7/7.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseVC.h"
@protocol SelectedStudentVCselectedStudentDelegate <NSObject>

@optional
- (void)selectedStudent:(id) sender;

@end

@interface SelectedStudentVC : BaseVC

@property (nonatomic, strong) NSString *selectedStudent;
@property (nonatomic, strong) id<SelectedStudentVCselectedStudentDelegate>delegate;
@end
