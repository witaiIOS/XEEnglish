//
//  PayCourseVC.h
//  XEEnglish
//
//  Created by houjing on 15/6/24.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseVC.h"

@interface PayCourseVC : BaseVC

@property (nonatomic, assign) NSInteger payMoney;//订单最终金额(减去现金券金额等)
@property (nonatomic, assign) NSInteger courseId;//课程id
@property (nonatomic, strong) NSString *schoolId;//校区id
@property (nonatomic, strong) NSString *studentId;//学生id
@property (nonatomic, assign) NSInteger payMethod;//type取值 1时student_id必选；2/3时，student_id为空。
@property (nonatomic, strong) NSString *payType;//pay_type 取值 1课时 2整套 3都可
@property (nonatomic, strong) NSString *listCoupon;//listCoupon为现金券List，主要存放现金券id。
@property (nonatomic, assign) NSInteger number;//为课时
@end
