//
//  BuyCourseVC.h
//  XEEnglish
//
//  Created by houjing on 15/6/24.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseVC.h"

@interface BuyCourseVC : BaseVC

@property (nonatomic, strong) NSString *courseName;//课程名
@property (nonatomic, assign) NSInteger payMethodNumber;//付款方式的判断号，pay_type取值 1按课时价 2按整套价 3两者都可。
@property (nonatomic, assign) NSInteger superPayMethodNumber;//最开始的支付状态；（初始化时，判断能否跳转，有子课程的）
@property (nonatomic, strong) NSString *priceHour;//课时单价
@property (nonatomic, assign) NSInteger priceSeries;//整套价格；

@property (nonatomic, strong) NSString *parentCourseId;//大课程Id

@property (nonatomic, strong) NSDictionary *courseInfoDic;
@end
