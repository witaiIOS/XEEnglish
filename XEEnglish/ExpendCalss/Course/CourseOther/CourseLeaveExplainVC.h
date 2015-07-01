//
//  CourseLeaveExplainVC.h
//  XEEnglish
//
//  Created by houjing on 15/7/1.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseVC.h"
@protocol CourseLeaveExplainVCSetExplainDelegate <NSObject>

@optional
- (void)setExplain:(id)sender;

@end
@interface CourseLeaveExplainVC : BaseVC

@property (nonatomic, strong) id<CourseLeaveExplainVCSetExplainDelegate>delegate;

- (IBAction)submitBtnClicked:(id)sender;

@end
