//
//  StudentVC.h
//  XEEnglish
//
//  Created by houjing on 15/7/27.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseVC.h"

@protocol StudentVCDelegate <NSObject>

@optional
- (void)studentVCSelectedStudent:(id) sender;

@end

@interface StudentVC : BaseVC
@property (nonatomic, strong) NSString *selectedStudent;//选择的学生
@property (nonatomic, assign) id<StudentVCDelegate>delegate;
@end
