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
 @param password 密码为验证码的md5编码
 @param invitation_code 邀请码
 */
+ (AFHTTPRequestOperation *)checkCodeWithPhoneNumber:(NSString *)phoneNumber andCode:(NSString *)code andSign:(NSString *)sign;
+ (AFHTTPRequestOperation *)checkCodeWithPhoneNumber:(NSString *)phoneNumber andCode:(NSString *)code andSign:(NSString *)sign  andPassword:(NSString *)password  andInvitationCode:(NSString *)invitation_code;


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
 获取首页广告信息
 @param {}
 */
+ (AFHTTPRequestOperation *)getAd;

/**
 获取首页课程列表
 @param title  输入的搜索数据
 */
+ (AFHTTPRequestOperation *)getCourseListAppHomeWithTitle:(NSString *)title;

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
 @param course_id 课程id
 */
+ (AFHTTPRequestOperation *)getCourseDetailByCourseId:(NSString *)course_id;

/**
 查询课程推荐评论
 @param course_id 课程id
 */
+ (AFHTTPRequestOperation *)getCourseParentCommentByCourseId:(NSString *)course_id andPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex;

/**
 通过课程获取详情，及子课程列表
 @param course_id 注册id
 */
+ (AFHTTPRequestOperation *)getCourseListByParentCourseId:(NSString *)course_id;


/**
 通过家长id，查询家长的孩子列表,购买试听用
 @param parent_id 注册id
 */
+ (AFHTTPRequestOperation *)getVStudentByParentId:(NSString *)parent_id andToken:(NSString *)token;

/**
 添加预约试听/购课 
 @param parent_id 注册id
 @param course_id 课程id
 @param department_id 校区id
 @param student_id 小孩id
 @param type      type取值 1时student_id必选；2/3时，student_id为空。
 @param pay_type  pay_type 取值 1课时 2整套 3都可
 @param numbers   课时数
 @param order_price 总价格
 @param platform_type platform_type “操作平台”，取值范围：201 APP for Android   202 APP for IOS  203 微信   204 Web
 @param is_select_student  是否是选择孩子取值 1选孩子 0填写孩子
 @param sex       //性别
 @param birthday  //填写生日
 @param name     //学生姓名
 */
+ (AFHTTPRequestOperation *)addStudentSubCourseByParentId:(NSInteger )parent_id andCourseId:(NSInteger )course_id andDepartmentId:(NSInteger )department_id  andStudentId:(NSInteger )student_id andType:(NSInteger )type andPayType:(NSInteger )pay_type andNumbers:(NSInteger )numbers andOrderPrice:(NSInteger )order_price andPlatformType:(NSString *)platform_type andListCoupon:(NSArray *)listCoupon andToken:(NSString *)token;
+ (AFHTTPRequestOperation *)addStudentSubCourseWithDepartmentId:(NSString *)departmentId andStudentId:(NSString *)studentId andType:(NSString *)type andOrderPrice:(NSInteger)orderPrice andPlatFormTypeId:(NSString *)platFormTypeId andListCoupon:(NSString *)listCoupon andToken:(NSString *)token andPayType:(NSString *)payType andNumbers:(NSInteger)numbers andCourseId:(NSInteger)courseId andParentId:(NSString *)parentId andIsSelectStudent:(NSString *)is_select_student andSex:(NSString *)sex andBirthday:(NSString *)birthday andName:(NSString *)name andOutTradeNo:(NSString *)out_trade_no;

/**
 获取课程详情和评论列表
 @param course_id 注册id
 */
+ (AFHTTPRequestOperation *)getCourseDetailAndTopCommentListByCourseId:(NSString *)course_id andPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex;

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
 @param remark       请假原因||评价内容
 @param type         type取值 0 请假 1评论
 @param apply_id  NULL
 @param create_time  NULL
 @param status       NULL
 @param teacher_id   NULL
 @param check_time   NULL
 @param check_remark   NULL
 @param token
 */
+ (AFHTTPRequestOperation *)addSubcourseLeaveApplyByParentId:(NSString *)parent_id andRelationId:(NSString *)relation_id andRemark:(NSString *)remark andStar:(NSString *)star andType:(NSString *)type andApplyId:(NSString *)apply_id andCreateTime:(NSString *)create_time andStatus:(NSString *)status andTeacherId:(NSString *)teacher_id andCheckTime:(NSString *)check_time andCheckRemark:(NSString *)check_remark andToken:(NSString *)token;

/**
 课程回顾(通过课表id(course_schedule_id)获取课表相关图片)   //其他图片
 @param parent_id    注册id
 @param owner_id   就是course_schedule_id
 @param token
 */
+ (AFHTTPRequestOperation *)getPhotoByCourseScheduleIdWithParentId:(NSString *)parent_id  andOwnerId:(NSString *)owner_id andToken:(NSString *)token;

/**
 通过student_id学员id，获取相册列表分页
 @param parent_id    注册id
 @param student_id   学生id
 @param signon_id    注册id
 @param create_time  创建时间
 @param pageSize
 @param pageIndex
 @param token
 */
+ (AFHTTPRequestOperation *)getStudentSignPhotoListWithParentId:(NSString *)parent_id  andStudentId:(NSString *)student_id  andSignonId:(NSString *)signon_id andCourseScheduleId:(NSString *)course_schedule_id  andCreateTime:(NSString *)create_time andPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex andToken:(NSString *)token;


/**
 通过课程计划id，查询上课家长评论  每节课的评论
 @param parent_id    注册id
 @param course_schedule_id
 @param signon_id  该节课的id
 @param token
 */
+ (AFHTTPRequestOperation *)getCourseScheduleSignParentCommentWithParentId:(NSString *)parent_id  andCourseScheduleId:(NSString *)course_schedule_id andPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex andSignonId:(NSString *)signon_id andToken:(NSString *)token;

/**
 通过课程计划id，查询上课家长评论  每节课的评论
 @param parent_id    注册id
 @param star_comment_numbers     评论星级
 @param teacher_towards_numbers  老师状态星级
 @param teacher_comment_numbers  老师评星级
 @param student_degree_numbers   学生参与度星级
 @param remark        评论
 @param relation_id   该节课的id  relation_id 取值签到表id(signon_id)
 @param token
 */
+ (AFHTTPRequestOperation *)addTStarCommentWithParentId:(NSString *)parent_id  andStarCommentNumbers:(NSInteger )star_comment_numbers andTeacherTowardsNumbers:(NSInteger )teacher_towards_numbers andTeacherCommentNumbers:(NSInteger )teacher_comment_numbers andStudentDegreeNumbers:(NSInteger )student_degree_numbers andRemark:(NSString *)remark andRelationId:(NSString *)relation_id andToken:(NSString *)token;

#pragma mark - 活动
/**
 获取当前活动信息
 @param pageSize 一次请求显示多少个活动
 @param pageIndex 当前页码
 @param activity_status 活动de状态：activity_status的值为0当前活动,1历史
 */
+ (AFHTTPRequestOperation *)getActivityInfoWithPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex andActivityStatus:(NSInteger )activity_status andParentId:(NSString *)parent_id andToken:(NSString *)token;

/**
 预定活动
 @param parent_id 用户id
 @param activity_id 活动Id
 */
+ (AFHTTPRequestOperation *)makeActivityWithParentId:(NSString *)parent_id andActivityId:(NSString *)activity_id andToken:(NSString *)token;


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
 每日登录后签到
 @param parent_id 注册id
 @param platform_type_id  //Android传201,IOS传202
 @param token
 */
+ (AFHTTPRequestOperation *)signWithParentId:(NSString *)parent_id andPlatform_type_id:(NSString *)platform_type_id andToken:(NSString *)token;

/**
 登录后修改密码
 @param parent_id 注册id
 @param token
 */
+ (AFHTTPRequestOperation *)getMyInfoWithParentId:(NSString *)parent_id andToken:(NSString *)token;

#pragma mark - 我的 个人信息

/**
 个人信息修改
 @param is_photo_edit 是否修改了图像 is_photo_edit 取值 0未修改头像(photo传值***.png) 1修改头像(photo传值base64编码)
 @param name          名字
 @param sex           性别
 @param birthday      生日
 @param nationality   国家名
 @param identify_id   身份证
 @param mobile        手机号
 @param addr          区名
 @param qq
 @param email
 @param memo           备注
 @param regional_id    地区名
 @param mobile2
 @param parent_id      注册id
 @param photo          图片
 @param token
 */
+ (AFHTTPRequestOperation *)modifyUserWithIsPhotoEdit:(NSString *)is_photo_edit andName:(NSString *)name andSex:(NSString *)sex andBirthday:(NSString *)birthday andIdentifyId:(NSString *)identify_id andMobile:(NSString *)mobile andAddr:(NSString *)addr andQq:(NSString *)qq andEmail:(NSString *)email andMemo:(NSString *)memo andMobile2:(NSString *)mobile2 andParentId:(NSString *)parent_id andPhoto:(NSString *)photo andToken:(NSString *)token;


/**
 登录后修改密码
 @param newPassword 新密码
 @param oldPassword 旧密码
 @param parent_id 注册id
 @param token
 */
+ (AFHTTPRequestOperation *)modifyPwdWithNewPassword:(NSString *)newPassword andOldPassword:(NSString *)oldPassword andParentId:(NSString *)parent_id andToken:(NSString *)token;

/**
 查询小区
 参数1:pageSize表示一页行数
 参数2:pageIndex 表示页码
 参数3:parent_id表示登陆人id
 参数4:token
 参数5:search_content查询内容,可选参数
 */
+ (AFHTTPRequestOperation *)getCommunityWithParentId:(NSString *)parent_id andSearchContent:(NSString *)search_content andPageSize: (NSInteger )pageSize andPageIndex: (NSInteger )pageIndex andToken:(NSString *)token;

#pragma mark - 我的 宝宝相册
/**
 用积分兑换礼品
 @param parentId 表示当前登录人id
 @param student_id    学生id
 @param pageSize
 @param pageIndex
 @param token
 */
+ (AFHTTPRequestOperation *)getPhotoGroupListByStudentIdWithParentId:(NSString *)parent_id andStudentId:(NSString *)student_id andPageSize: (NSInteger )pageSize andPageIndex: (NSInteger )pageIndex andToken:(NSString *)token;


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

#pragma mark - 我的 我的现金券
/**
 查我的现金卷
 @param parentId 表示当前登录人id
 @param token
 */
+ (AFHTTPRequestOperation *)getMyCouponWithParentId: (NSString *)parent_id andToken:(NSString *)token;



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

#pragma mark - 我的 订单
/**
 通过会员id，查询消费订单分页列表
 @param pageSize 一次请求显示多少个活动
 @param pageIndex 当前页码
 @param parentId 表示当前登录人id
 @param sort
 @param order
 */
+ (AFHTTPRequestOperation *)getVOrderByParentIdWithParentId:(NSString *)parentId andSort:(NSString *)sort andOrder:(NSString *)order andType:(NSString *)type andPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex andToken:(NSString *)token;

/**
 通过会员id，查询消费订单分页列表
 @param relation_id   订单的order_id
 @param remark        取消原因
 @param parentId 表示当前登录人id
 @param type          type为4，取消操作
 @param token
 */
+ (AFHTTPRequestOperation *)cancelOrderWithParentId:(NSString *)parentId andRelationId:(NSString *)relation_id andRemark:(NSString *)remark andType:(NSString *)type andToken:(NSString *)token;

#pragma mark - 我的 城市
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
+ (AFHTTPRequestOperation *)setCityWithRegionalId:(NSString *)regional_id andParentId:(NSString *)parent_id andToken:(NSString *)token;

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

/**
 查询附近校区
 @param:longitude
 @param:latitude
 */
+ (AFHTTPRequestOperation *)getSchoolNearByWithLongitude:(CGFloat)longitude andLatitude:(CGFloat)latitude andPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex;

/**
 查询附近校区详情
 @param:department_id      校区id
 @param:platform_type_id   "202"ios
 */
+ (AFHTTPRequestOperation *)getSchoolNearbyPicListWithDepartmentId:(NSString *)department_id andPlatformTypeId:(NSString *)platform_type_id andPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex;

//#pragma mark - 微信支付修改订单
///**
// 查我的现金卷
// @param parentId 表示当前登录人id
// @param token
// @param out_trade_no 微信商户订单号
// @param platform_type_id 平台"201"为安卓，"202"为ios
// */
//+ (AFHTTPRequestOperation *)updateOrderStatueWxWithParentId:(NSString *)parent_id andOutTradeNo:(NSString *)out_trade_no andPlatformTypeId:(NSString *)platform_type_id andToken:(NSString *)token;

@end
