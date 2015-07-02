//
//  courseSchoolZoneVC.h
//  XEEnglish
//
//  Created by houjing on 15/7/2.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseVC.h"
@protocol CourseSchoolZoneDelegate <NSObject>

@optional
- (void)courseSelectedSchoolZone:(id) sender;

@end

@interface courseSchoolZoneVC : BaseVC

@property (nonatomic, strong) NSString *parentCourseId;

@property (nonatomic, strong) NSString *selectedSchool;

@property (nonatomic, assign) id<CourseSchoolZoneDelegate> delegate;

@end
