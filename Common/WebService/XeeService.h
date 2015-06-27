//
//  XeeService.h
//  XEEnglish
//
//  Created by MacAir2 on 15/6/2.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServiceOpration.h"


@interface XeeService : NSObject

/////////////////////////////mrchabo

+ (XeeService *)sharedInstance;

//获取主页服务
- (void)getHomeServiceWithBlock:(void (^)(NSNumber *result, NSArray *resultInfo, NSError *error))block;

//获取主页广告
- (void)getHomeAdWithBlock:(void (^)(NSNumber *result, NSArray *resultInfo, NSError *error))block;

/////////////////////////////XEE
#pragma mark - XEE
/**
 得到请求返回的结果
 @param opration 请求的操作
 @param xmlKey  xml解析的关键字段
 @param block  (response 返回的xml, result 解析出来的结果, error 请求的错误信息)
 */
- (void)getResponseWithOpration:(AFHTTPRequestOperation *)opration andXmlKey:(NSString *)xmlKey andBlock:(void (^)(NSString *response, NSDictionary *result, NSError *error))block;

#pragma mark - 登陆相关
/**
 发送验证码的请求
 @param phoneNumber 手机号
 @param sign 1.忘记密码/2.注册/3.修改手机号
 @param block  (result 解析出来的结果, error 请求的错误信息)
 */
- (void)checkPhoneWithPhoneNumber:(NSString *)phoneNumber andSign:(NSString *)sign andBlock:(void (^)(NSDictionary *result, NSError *error))block;

/**
 验证验证码的请求
 @param phoneNumber 手机号
 @param code 验证码
 @param sign 1.忘记密码/2.注册/3.修改手机号
 @param block  (result 解析出来的结果, error 请求的错误信息)
 */
- (void)checkCodeWithPhoneNumber:(NSString *)phoneNumber andCode:(NSString *)code andSign:(NSString *)sign andBlock:(void (^)(NSDictionary *result, NSError *error))block;


/**
 注册
 @param phoneNumber 手机号
 @param name  用户名
 @param password 密码
 @param invitation_code  推荐码
 */
- (void)registerWithPhoneNumber:(NSString *)phoneNumber andName:(NSString *)name andPassword:(NSString *)password andInvitation_code:(NSString *)invitation_code andBlock:(void (^)(NSDictionary *result, NSError *error))block;

/**
 找回密码
 @param phoneNumber 手机号
 @param password 密码
 */
- (void)modifyPwdByMobilephoneWithPhoneNumber:(NSString *)phoneNumber andPassword:(NSString *)password andBlock:(void (^)(NSDictionary *result, NSError *error))block;

/**
 登录
 @param phoneNumber 手机号
 @param password 密码
 */
- (void)loginWithPhoneNumber:(NSString *)phoneNumber andPassword:(NSString *)password andBlock:(void(^)(NSDictionary *result, NSError *error))block;

#pragma mark - 首页
/**
 获取首页课程列表
 @param {}
 */
- (void)getCourseListAppHomeAndBlock:(void(^)(NSDictionary *result,NSError *error))block;


/**
 获取首页课程列表
 @param {}
 */
- (void)getCourseCategoryAgeAndBlock:(void(^)(NSDictionary *result, NSError *error))block;

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
- (void)getCourseListByFilterWithMinAge:(NSString *)min_age andMaxAge:(NSString *)max_age andCourseCategoryId:(NSString *)course_category_id andSort:(NSString *)sort andOrder:(NSString *)order andPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex andBlock:(void(^)(NSDictionary *result, NSError *error))block;

/**
 通过课程id，查询课程详情
 @param course_id 注册id
 */
- (void)getCourseDetailByCourseId:(NSString *)course_id andBlock:(void(^)(NSDictionary *result, NSError *error))block;

/**
 通过课程获取详情，及子课程列表
 @param course_id 注册id
 */
- (void)getCourseListByParentCourseId:(NSString *)course_id andBlock:(void(^)(NSDictionary *result, NSError *error))block;

#pragma mark - 课程
/**
 通过家长id，查找学生选课关系简介列表
 @param parent_id 注册id
 */
- (void)getVStudentCourseByParentId:(NSString *)parent_id andToken:(NSString *)token andBlock:(void(^)(NSDictionary *result,NSError *error))block;

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
- (void)getVStudentSourseScheduleSignWithParentId:(NSString *)parent_id andStudentId:(NSString *)student_id andCourseId:(NSString *)course_id andSignon:(NSString *)is_signon andSort:(NSString *)sort andOrder:(NSString *)order andPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex andToken:(NSString *)token andBlock:(void(^)(NSDictionary *result,NSError *error))block;


#pragma mark - 活动
/**
 获取当前活动信息
 @param pageSize 一次请求显示多少个活动
 @param pageIndex 当前页码
 @param block  (result 解析出来的结果, error 请求的错误信息)
 */
- (void)getActivityInfoWithPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex andParentId:(NSString *)parent_id andToken:(NSString *)token andBlock:(void (^)(NSDictionary *result, NSError *error))block;

/**
 查询所有校区
 @param parent_id 用户Id
 @param course_id 课程Id
 */
- (void)getSchoolWithParentId:(NSString *)parent_id andCourseId:(NSString *)course_id andToken:(NSString *)token andBlock:(void(^)(NSDictionary *result,NSError *error))block;

/**
 预定场馆
 @param jsonParam 预定场馆的相关参数组成的JSON
 */
- (void)AddBookSiteWithParameter:(NSString *)jsonParam andBlock:(void(^)(NSDictionary *result,NSError *error))block;


#pragma mark - 我的

/**
 登录后修改密码
 @param parent_id 注册id
 @param token
 */
- (void)getMyInfoWithParentId:(NSString *)parent_id andToken:(NSString *)token andBlock:(void(^)(NSDictionary *result, NSError *error))block;

#pragma mark - 我的 个人信息
/**
 登录后修改密码
 @param newPassword 新密码
 @param oldPassword 旧密码
 @param parent_id 旧密码
 */
- (void)modifyPwdWithNewPassword:(NSString *)newPassword andOldPassword:(NSString *)oldPassword andParentId:(NSString *)parent_id andToken:(NSString *)token andBlock:(void (^)(NSDictionary *result, NSError *error))block;

/**
 获取我的预定中的活动
 @param pageSize 一次请求显示多少个活动
 @param pageIndex 当前页码
 @param parentId 表示当前登录人id
 */
- (void)GetActivityInfoByParentIdWithPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex andParentId:(NSString *)parentId andToken:(NSString *)token andBlock:(void(^)(NSDictionary *result, NSError *error))block;

/**
 获取城市
 */
- (void)getCityWithBlock:(void(^)(NSDictionary *result, NSError *error))block;

@end
