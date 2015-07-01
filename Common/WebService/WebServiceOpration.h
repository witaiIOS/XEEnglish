//
//  WebServiceOpration.h
//  XEEnglish
//
//  Created by MacAir2 on 15/6/2.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppCore.h"

@interface WebServiceOpration : NSObject

//////////////////////////////////美宅宝接口
/**
 WebService基类
 @param body 不同方法body不同
 */
+ (AFHTTPRequestOperation *)XeeWebService:(NSString *)body;


/**
 获取主页服务
 */
+ (AFHTTPRequestOperation *)getHomePageServiceCategroy;



/**
 获取主页广告
 */
+ (AFHTTPRequestOperation *)getHomeAppAdConfigure;

//////////////////////////////////艾迪天才接口
#pragma mark -  XEE
/**
 XEEServiceOpration基类
 @param body 不同方法body不同
 */
+ (AFHTTPRequestOperation *)XEEWebService:(NSString *)body;

#pragma mark - 登陆相关
/**
 获取验证码的opration
 @param phoneNumber 手机号
 @param sign 1.忘记密码/2.注册/3.修改手机号
 */
+ (AFHTTPRequestOperation *)checkPhoneWithPhoneNumber:(NSString *)phoneNumber andSign:(NSString *)sign;

/**
 验证发送来的验证码
 @param phoneNumber 手机号
 @param code 验证码
 @param sign 1.忘记密码/2.注册/3.修改手机号
 */
+ (AFHTTPRequestOperation *)checkCodeWithPhoneNumber:(NSString *)phoneNumber andCode:(NSString *)code andSign:(NSString *)sign;


/**
 注册
 @param phoneNumber 手机号
 @param name  用户名
 @param password 密码
 @param invitation_code  推荐码
 */
+ (AFHTTPRequestOperation *)registerWithPhoneNumber:(NSString *)phoneNumber andName:(NSString *)name andPassword:(NSString *)password andInvitation_code:(NSString *)invitation_code;

/**
 找回密码
 @param phoneNumber 手机号
 @param password 密码
 */
+ (AFHTTPRequestOperation *)modifyPwdByMobilephoneWithPhoneNumber:(NSString *)phoneNumber andPassword:(NSString *)password;


/**
 登录
 @param phoneNumber 手机号
 @param password 密码
 */
+ (AFHTTPRequestOperation *)loginWithPhoneNumber:(NSString *)phoneNumber andPassword:(NSString *)password;

#pragma mark - 首页
/**
 获取首页课程列表
 @param {}
 */
+ (AFHTTPRequestOperation *)getCourseListAppHome;

/**
 获取课程大类和课程年龄段
 获取首页所有课程页的课程年龄列表
 @param {}
 */
+ (AFHTTPRequestOperation *)getCourseCategoryAge;

/**
 首页进入的筛选课程
 获取首页所有课程页的课程年龄列表
 @param MinAge 最小年龄
 @param MaxAge 最大年龄
 @param CourseCategoryId  课程分类id
 @param Sort      排序字段(可选)
 @param Order     desc/asc（可选）
 @param PageSize  每页最大条数
 @param PageIndex 从1开始的索引
 */
+ (AFHTTPRequestOperation *)getCourseListByFilterWithMinAge:(NSString *)min_age andMaxAge:(NSString *)max_age andCourseCategoryId:(NSString *)course_category_id andSort:(NSString *)sort andOrder:(NSString *)order andPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex;

/**
 通过课程id，查询课程详情
 @param course_id 注册id
 */
+ (AFHTTPRequestOperation *)getCourseDetailByCourseId:(NSString *)course_id;

/**
 通过课程获取详情，及子课程列表
 @param course_id 注册id
 */
+ (AFHTTPRequestOperation *)getCourseListByParentCourseId:(NSString *)course_id;


#pragma mark - 课程
/**
 通过家长id，查找学生选课关系简介列表
 @param parent_id 注册id
 */
+ (AFHTTPRequestOperation *)getVStudentCourseByParentId:(NSString *)parent_id andToken:(NSString *)token;

/**
 通过student_id学员id，获取课程计划签到信息分页(获取请假/缺课列表 共用)
 @param parent_id 注册id
 @param StudentId 学生id
 @param CourseId  选课Id
 @param Signon    标记取值 “时间已经过了： 1已上课且已签到 2 请假 3 缺课 时间没有过： 0正常 4  延迟 5 暂停”
 @param Sort      排序字段(可选)
 @param Order     desc/asc（可选）
 @param PageSize  每页最大条数
 @param PageIndex 从1开始的索引
 */
+ (AFHTTPRequestOperation *)getVStudentSourseScheduleSignWithParentId:(NSString *)parent_id andStudentId:(NSString *)student_id andCourseId:(NSString *)course_id andSignon:(NSString *)is_signon andSort:(NSString *)sort andOrder:(NSString *)order andPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex andToken:(NSString *)token;


/**
 请假/家长评论   type取值 0 请假 1评论
 @param parent_id    注册id
 @param relation_id  课表id
 @param remark       请假原因
 @param type         type取值 0 请假 1评论
 @param apply_id  NULL
 @param create_time  NULL
 @param status       NULL
 @param teacher_id   NULL
 @param check_time   NULL
 @param check_remark   NULL
 @param token
 */
+ (AFHTTPRequestOperation *)addSubcourseLeaveApplyByParentId:(NSString *)parent_id andRelationId:(NSString *)relation_id andRemark:(NSString *)remark andType:(NSString *)type andApplyId:(NSString *)apply_id andCreateTime:(NSString *)create_time andStatus:(NSString *)status andTeacherId:(NSString *)teacher_id andCheckTime:(NSString *)check_time andCheckRemark:(NSString *)check_remark andToken:(NSString *)token;

#pragma mark - 活动
/**
 获取当前活动信息
 @param pageSize 一次请求显示多少个活动
 @param pageIndex 当前页码
 */
+ (AFHTTPRequestOperation *)getActivityInfoWithPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex andParentId:(NSString *)parent_id andToken:(NSString *)token;

#pragma mark - 活动 我的预定
/**
 查询所有校区
 @param parent_id 用户Id
 @param course_id 课程Id
 */
+ (AFHTTPRequestOperation *)getSchoolWithParentId:(NSString *)parent_id andCourseId:(NSString *)course_id andToken:(NSString *)token;

/**
 预定场馆
 @param id    主键0
 @param room_id      教室id
 @param add_time     添加时间
 @param parent_id    用户id
 @param department_id   校区id
 @param start_time      开始日期时间
 @param end_time        预计结束时间
 @param personNum       sum预计人数
 @param area            面积需求多大
 @param use_projector  是否需要投影仪
 @param teacher     是否需要老师
 @param activity_content  活动内容
 @param memo              其他备注
 @param token    //
 
 */
+ (AFHTTPRequestOperation *)AddBookSiteWithKeyId:(NSString *)keyId andRoomId:(NSString *)room_id andAddTime:(NSString *)add_time andParentId:(NSString *)parent_id andSchoolId:(NSString *)school_id andStartTime:(NSString *)start_time andeEndTime:(NSString *)end_time andPersonNum:(NSString *)personNum andArea:(NSString *)area andProjector:(NSString *)projector andTeacher:(NSString *)teacher andActivityContent:(NSString *)activity_content andMemo:(NSString *)memo andToken:(NSString *)token;


#pragma mark - 我的
/**
 登录后修改密码
 @param parent_id 注册id
 @param token
 */
+ (AFHTTPRequestOperation *)getMyInfoWithParentId:(NSString *)parent_id andToken:(NSString *)token;

#pragma mark - 我的 个人信息
/**
 登录后修改密码
 @param newPassword 新密码
 @param oldPassword 旧密码
 @param parent_id 注册id
 @param token
 */
+ (AFHTTPRequestOperation *)modifyPwdWithNewPassword:(NSString *)newPassword andOldPassword:(NSString *)oldPassword andParentId:(NSString *)parent_id andToken:(NSString *)token;

#pragma mark - 我的 我的积分
/**
 我的积分交易记录
 @param pageSize 一次请求显示多少个活动
 @param pageIndex 当前页码
 @param parentId 表示当前登录人id
 */
+ (AFHTTPRequestOperation *)getPointsWithPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex andParentId: (NSString *)parent_id andToken:(NSString *)token;

/**
 查询积分策略
 */
+ (AFHTTPRequestOperation *)getPointConfig;

/**
 获取我的积分中所有的礼品
*/
+ (AFHTTPRequestOperation *)getGift;

/**
 用积分兑换礼品
 @param parentId 表示当前登录人id
 @param platform_type_Id    //Android传201,IOS传202
 @param gift_id   //礼品的id
 @param token
 */
+ (AFHTTPRequestOperation *)buyGiftWithParentId:(NSString *)parent_id andPlatformTypeId:(NSString *)platform_type_Id andGiftId: (NSString *)gift_id andToken:(NSString *)token;

#pragma mark - 我的 我的预定
/**
 获取我的预定中的活动
 @param pageSize 一次请求显示多少个活动
 @param pageIndex 当前页码
 @param parentId 表示当前登录人id
 */
+ (AFHTTPRequestOperation *)GetActivityInfoByParentIdWithPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex andParentId: (NSString *)parentId andToken:(NSString *)token;

/**
 获取我的预定中的场馆
 @param pageSize 一次请求显示多少个活动
 @param pageIndex 当前页码
 @param parentId 表示当前登录人id
 */
+ (AFHTTPRequestOperation *)getBookSiteByParent_idWithPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex andParentId: (NSString *)parentId andToken:(NSString *)token;


/**
 获取城市
 */
+ (AFHTTPRequestOperation *)getCity;

/**
 修改城市
 @param:department_id  表示城市id
 @param:parent_id      表示当前登录用户的id
 @param:token
 */
+ (AFHTTPRequestOperation *)setCityWithDepartmentId:(NSString *)department_id andParentId:(NSString *)parent_id andToken:(NSString *)token;

#pragma mark - 我的 更多设置
/**
 分享
 @param:share_content  表示内容
 @param:parent_id      表示当前登录用户的id
 @param:token
 */
+ (AFHTTPRequestOperation *)tellFriendWithShareContent:(NSString *)share_content andParentId:(NSString *)parent_id andToken:(NSString *)token;
/**
 意见反馈
 @param:bug_info       表示城市提交的意见
 @param:parent_id      表示当前登录用户的id
 @param:token
 */
+ (AFHTTPRequestOperation *)addFeedbackWithBugInfo:(NSString *)bug_info andParentId:(NSString *)parent_id andToken:(NSString *)token;

@end
