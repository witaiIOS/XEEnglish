//
//  SchoolVC.h
//  XEEnglish
//
//  Created by houjing on 15/7/24.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseVC.h"
@protocol SchoolVCDelegate <NSObject>

@optional
- (void)schoolVCSelectedSchoolZone:(id) sender;

@end

@interface SchoolVC : BaseVC

@property (nonatomic, strong) NSString *courseId;//选择课程的id
@property (nonatomic, strong) NSString *selectedSchool;//选择的校区

@property (nonatomic, assign) id<SchoolVCDelegate> delegate;
@end
