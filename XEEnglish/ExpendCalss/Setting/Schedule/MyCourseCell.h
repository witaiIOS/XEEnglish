//
//  MyCourseCell.h
//  XEEnglish
//
//  Created by houjing on 15/7/17.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseTVC.h"

@interface MyCourseCell : BaseTVC

@property (nonatomic, strong) NSDictionary *myCourseInfoDic;//我的预约课程功能的info

@property (weak, nonatomic) IBOutlet UILabel *myCourseStatue;//状态
@property (weak, nonatomic) IBOutlet UILabel *myCourseUserName;//用户名
@property (weak, nonatomic) IBOutlet UILabel *myCourseUserPhone;//用户手机号
@property (weak, nonatomic) IBOutlet UILabel *myCourseCourseName;//课程名
@property (weak, nonatomic) IBOutlet UILabel *myCourseCreateTime;//创建时间
@property (weak, nonatomic) IBOutlet UILabel *myCourseTradeNO;//订单号


@end
