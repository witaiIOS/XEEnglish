//
//  CourseForenoticeVC.h
//  XEEnglish
//
//  Created by houjing on 15/7/1.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseVC.h"

@interface CourseForenoticeVC : BaseVC
@property (nonatomic, strong) NSDictionary *courseLeaveInfoDic;
@property (nonatomic, strong) NSString *courseIdStr;//课程预览请求需要传递整套课程的id
@end
