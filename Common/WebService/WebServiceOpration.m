//
//  WebServiceOpration.m
//  XEEnglish
//
//  Created by MacAir2 on 15/6/2.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "WebServiceOpration.h"

@implementation WebServiceOpration

#pragma mark - MZBWebService
+ (AFHTTPRequestOperation *)XeeWebService:(NSString *)body{
    
    NSURL* WebURL = [NSURL URLWithString:MZBWebURL];
    NSMutableURLRequest* req = [[NSMutableURLRequest alloc] init];
    [req setURL:WebURL];
    [req setHTTPMethod:@"POST"];
    
    [req addValue:@"application/soap+xml" forHTTPHeaderField:@"Content-Type"];
    NSMutableData* postbody = [[NSMutableData alloc] init];
    [postbody appendData:[[NSString stringWithFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ws=\"http://ws.houseWs.ereal.com/\"><soapenv:Header/><soapenv:Body>"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postbody appendData:[[NSString stringWithFormat:@"%@",body] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postbody appendData:[[NSString stringWithFormat:@"</soapenv:Body></soapenv:Envelope>"] dataUsingEncoding:NSUTF8StringEncoding]];
    [req setHTTPBody:postbody];
    
    
   // NSString *requestURL = [[NSString alloc]initWithData:postbody encoding:NSUTF8StringEncoding];
    //NSLog(@"requestURL:%@",requestURL);
    
    AFHTTPRequestOperation *opration = [[AFHTTPRequestOperation alloc] initWithRequest:req];
    return opration;
    
}

+ (AFHTTPRequestOperation *)getHomePageServiceCategroy
{
    return [WebServiceOpration XeeWebService:@"<ws:getHomePageServiceCategroy/>"];
    
}



+ (AFHTTPRequestOperation *)getHomeAppAdConfigure{
    
    return [WebServiceOpration XeeWebService:@"<ws:getHomeAppAdConfigure/>"];
}

#pragma mark - XEE

+ (AFHTTPRequestOperation *)XEEWebService:(NSString *)body {
    
    NSURL* WebURL = [NSURL URLWithString:XEEWebURL];
    NSMutableURLRequest* req = [[NSMutableURLRequest alloc] init];
    [req setURL:WebURL];
    [req setHTTPMethod:@"POST"];
    
    [req addValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
    NSMutableData* postbody = [[NSMutableData alloc] init];
    [postbody appendData:[[NSString stringWithFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:web=\"http://webservice.ereal.com/\"><soapenv:Header/><soapenv:Body>"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postbody appendData:[[NSString stringWithFormat:@"%@",body] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postbody appendData:[[NSString stringWithFormat:@"</soapenv:Body></soapenv:Envelope>"] dataUsingEncoding:NSUTF8StringEncoding]];
    [req setHTTPBody:postbody];
    
    
    //NSString *requestURL = [[NSString alloc]initWithData:postbody encoding:NSUTF8StringEncoding];
    //NSLog(@"requestURL:%@",requestURL);
    
    AFHTTPRequestOperation *opration = [[AFHTTPRequestOperation alloc] initWithRequest:req];
    return opration;
}

#pragma mark - 登陆相关

+ (AFHTTPRequestOperation *)checkPhoneWithPhoneNumber:(NSString *)phoneNumber andSign:(NSString *)sign {
    return [self XEEWebService:[NSString stringWithFormat:@"<web:checkPhone><web:json>{\"mobile\":\"%@\",\"sign\":\"%@\"}</web:json></web:checkPhone>", phoneNumber, sign]];
}

+ (AFHTTPRequestOperation *)checkCodeWithPhoneNumber:(NSString *)phoneNumber andCode:(NSString *)code andSign:(NSString *)sign {
    return [self XEEWebService:[NSString stringWithFormat:@" <web:checkCode><web:json>{\"sign\":\"%@\",\"mobile\":\"%@\",\"code\":\"%@\"}</web:json></web:checkCode>", sign, phoneNumber, code]];
}


+ (AFHTTPRequestOperation *)registerWithPhoneNumber:(NSString *)phoneNumber andName:(NSString *)name andPassword:(NSString *)password andInvitation_code:(NSString *)invitation_code{
    return [self XEEWebService:[NSString stringWithFormat:@"<web:register><web:json>{\"mobile\":\"%@\",\"name\":\"%@\",\"password\":\"%@\",\"invitation_code\":\"%@\"}</web:json></web:register>",phoneNumber,name,password,invitation_code]];
}

+ (AFHTTPRequestOperation *)modifyPwdByMobilephoneWithPhoneNumber:(NSString *)phoneNumber andPassword:(NSString *)password{
    return [self XEEWebService:[NSString stringWithFormat:@"<web:modifyPwdByMobilephone><web:json>{\"mobile\":\"%@\",\"password\":\"%@\"}</web:json></web:modifyPwdByMobilephone>",phoneNumber,password]];
}

+ (AFHTTPRequestOperation *)loginWithPhoneNumber:(NSString *)phoneNumber andPassword:(NSString *)password{
    return [self XEEWebService:[NSString stringWithFormat:@"<web:Login><web:json>{\"mobile\":\"%@\",\"password\":\"%@\"}</web:json></web:Login>",phoneNumber,password]];
}

#pragma mark - 首页
/**
 获取首页课程列表
 @param {}
 */
+ (AFHTTPRequestOperation *)getCourseListAppHome{
    return [self XEEWebService:[NSString stringWithFormat:@"<web:GetCourseListAppHome><web:json>{}</web:json></web:GetCourseListAppHome>"]];
}


/**
 获取首页课程列表
 @param {}
 */
+ (AFHTTPRequestOperation *)getCourseCategoryAge{
    
    return [self XEEWebService:[NSString stringWithFormat:@" <web:GetCourseCategoryAge><web:json>{}</web:json></web:GetCourseCategoryAge>"]];
}

/**
 首页进入的筛选课程
 获取首页所有课程页的课程年龄列表
 */
+ (AFHTTPRequestOperation *)getCourseListByFilterWithMinAge:(NSString *)min_age andMaxAge:(NSString *)max_age andCourseCategoryId:(NSString *)course_category_id andSort:(NSString *)sort andOrder:(NSString *)order andPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex{
    
    return [self XEEWebService:[NSString stringWithFormat:@"<web:GetCourseListByFilter><web:json>{\"min_age\":\"%@\",\"max_age\":\"%@\",\"course_category_id\":\"%@\",\"sort\":\"%@\",\"order\":\"%@\",\"pageSize\":\"%li\",\"pageIndex\":\"%li\"}</web:json></web:GetCourseListByFilter>",min_age,max_age,course_category_id,sort,order,(long)pageSize,(long)pageIndex]];
}

/**
 通过课程id，查询课程详情
 @param course_id 注册id
 */
+ (AFHTTPRequestOperation *)getCourseDetailByCourseId:(NSString *)course_id{
    return [self XEEWebService:[NSString stringWithFormat:@"<web:GetCourseDetailByCourseId><web:json>{\"course_id\":\"%@\"}</web:json></web:GetCourseDetailByCourseId>",course_id]];
}

/**
 通过课程获取详情，及子课程列表
 @param course_id 注册id
 */
+ (AFHTTPRequestOperation *)getCourseListByParentCourseId:(NSString *)course_id{
    
    return [self XEEWebService:[NSString stringWithFormat:@"<web:GetCourseListByParentCourseId><web:json>{\"course_id\":\"%@\"}</web:json></web:GetCourseListByParentCourseId>",course_id]];
}

#pragma mark - 课程
/**
 通过家长id，查找学生选课关系简介列表
 @param parent_id 注册id
 */
+ (AFHTTPRequestOperation *)getVStudentCourseByParentId:(NSString *)parent_id andToken:(NSString *)token{
    return [self XEEWebService:[NSString stringWithFormat:@"<web:GetVStudentCourseByParentId><web:json>{\"parent_id\":\"%@\",\"token\":\"%@\"}</web:json></web:GetVStudentCourseByParentId>",parent_id,token]];
}

/**
 通过student_id学员id，获取课程计划签到信息分页(获取请假/缺课列表 共用)
 */
+ (AFHTTPRequestOperation *)getVStudentSourseScheduleSignWithParentId:(NSString *)parent_id andStudentId:(NSString *)student_id andCourseId:(NSString *)course_id andSignon:(NSString *)is_signon andSort:(NSString *)sort andOrder:(NSString *)order andPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex andToken:(NSString *)token{
    
    return [self XEEWebService:[NSString stringWithFormat:@"<web:GetVStudentSourseScheduleSign><web:json>{\"parent_id\":\"%@\",\"student_id\":\"%@\",\"course_id\":\"%@\", \"is_signon\":\"%@\",\"sort\":\"%@\",\"order\":\"%@\",\"pageSize\":\"%li\",\"pageIndex\":\"%li\",\"token\":\"%@\"}</web:json></web:GetVStudentSourseScheduleSign>",parent_id,student_id,course_id,is_signon,sort,order,(long)pageSize,(long)pageIndex,token]];
}

/**
 请假/家长评论   type取值 0 请假 1评论
 */
+ (AFHTTPRequestOperation *)addSubcourseLeaveApplyByParentId:(NSString *)parent_id andRelationId:(NSString *)relation_id andRemark:(NSString *)remark andType:(NSString *)type andApplyId:(NSString *)apply_id andCreateTime:(NSString *)create_time andStatus:(NSString *)status andTeacherId:(NSString *)teacher_id andCheckTime:(NSString *)check_time andCheckRemark:(NSString *)check_remark andToken:(NSString *)token{
    
    //@"{\"parent_id\":\"17\", \"relation_id\":\"11\", \"remark\":\"uuu\", \"type\":\"0\", \"apply_id\":null, \"create_time\":%@, \"status\":null, \"teacher_id\":null, \"check_time\":null, \"check_remark\":null,\"token\":\"yEqHDenWZHANQ08W1WF93J+t+ELfkokN0dz9KsI8kALd/GXU1pEykMyOJupHiHATpELTmg8I+XWN1mKJb8Vr+g==\"}"
    
    return [self XEEWebService:[NSString stringWithFormat:@"<web:AddSubcourseLeaveApply><web:json>{\"parent_id\":\"%@\", \"relation_id\":\"%@\", \"remark\":\"%@\", \"type\":\"%@\", \"apply_id\":%@, \"create_time\":%@, \"status\":%@, \"teacher_id\":%@, \"check_time\":%@, \"check_remark\": %@,\"token\":\"%@\"}</web:json></web:AddSubcourseLeaveApply>",parent_id,relation_id,remark,type,apply_id,create_time,status,teacher_id,check_time,check_remark,token]];
}

#pragma mark - 活动
+ (AFHTTPRequestOperation *)getActivityInfoWithPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex andParentId:(NSString *)parent_id andToken:(NSString *)token{
    
    return [self XEEWebService:[NSString stringWithFormat:@"<web:GetActivityInfo><web:json>{\"pageSize\":\"%li\",\"pageIndex\":\"%li\",\"parent_id\":\"%@\",\"token\":\"%@\"}</web:json></web:GetActivityInfo>",(long)pageSize, (long)pageIndex,parent_id,token]];
}

/**
 预定活动
 @param parent_id 用户id
 @param activity_id 活动Id
 */
+ (AFHTTPRequestOperation *)makeActivityWithParentId:(NSString *)parent_id andActivityId:(NSString *)activity_id andToken:(NSString *)token{
    
    return [self XEEWebService:[NSString stringWithFormat:@"<web:MakeActivity><web:json>{\"parent_id\":\"%@\",\"activity_id\":\"%@\",\"token\":\"%@\"}</web:json></web:MakeActivity>",parent_id,activity_id,token]];
}

#pragma mark - 活动 我的预定
/**
 查询所有校区
 */
+ (AFHTTPRequestOperation *)getSchoolWithParentId:(NSString *)parent_id andCourseId:(NSString *)course_id andToken:(NSString *)token{
    if (course_id == nil) {
        return [self XEEWebService:[NSString stringWithFormat:@"<web:GetSchool><web:json>{\"parent_id\":\"%@\",\"token\":\"%@\"}</web:json></web:GetSchool>",parent_id,token]];
    }
    else{
        return [self XEEWebService:[NSString stringWithFormat:@"<web:GetSchool><web:json>{\"parent_id\":\"%@\",\"course_id\":\"%@\",\"token\":\"%@\"}</web:json></web:GetSchool>",parent_id,course_id,token]];
    }
    
}

/**
 预定场馆
 @param jsonParam 预定场馆的相关参数组成的JSON
 */
+ (AFHTTPRequestOperation *)AddBookSiteWithKeyId:(NSString *)keyId andRoomId:(NSString *)room_id andAddTime:(NSString *)add_time andParentId:(NSString *)parent_id andSchoolId:(NSString *)school_id andStartTime:(NSString *)start_time andeEndTime:(NSString *)end_time andPersonNum:(NSString *)personNum andArea:(NSString *)area andProjector:(NSString *)projector andTeacher:(NSString *)teacher andActivityContent:(NSString *)activity_content andMemo:(NSString *)memo andToken:(NSString *)token{
    
    return [self XEEWebService:[NSString stringWithFormat:@" <web:AddBookSite><web:json>{\"id\":\"%@\",\"room_id\":\"%@\",\"add_time\":\"%@\",\"parent_id\":\"%@\",\"department_id\":\"%@\",\"start_time\":\"%@\",\"end_time\":\"%@\",\"sum\":\"%@\",\"area\":\"%@\",\"use_projector\":\"%@\",\"teacher\":\"%@\",\"activity_content\":\"%@\",\"memo\":\"%@\",\"token\":\"%@\"}</web:json></web:AddBookSite>",keyId,room_id,add_time,parent_id,school_id,start_time,end_time,personNum,area,projector,teacher,activity_content,memo,token]];
}

#pragma mark - 我的

/**
 个人信息修改
*/
+ (AFHTTPRequestOperation *)modifyUserWithIsPhotoEdit:(NSString *)is_photo_edit andName:(NSString *)name andSex:(NSString *)sex andBirthday:(NSString *)birthday andIdentifyId:(NSString *)identify_id andMobile:(NSString *)mobile andAddr:(NSString *)addr andQq:(NSString *)qq andEmail:(NSString *)email andMemo:(NSString *)memo andMobile2:(NSString *)mobile2 andParentId:(NSString *)parent_id andPhoto:(NSString *)photo andToken:(NSString *)token{
    
    return [self XEEWebService:[NSString stringWithFormat:@"<web:modifyUser><web:json>{\"is_photo_edit\":\"%@\",\"name\":\"%@\",\"sex\":\"%@\",\"birthday\":\"%@\",\"identify_id\":\"%@\",\"mobile\":\"%@\",\"addr\":\"%@\",\"qq\":\"%@\",\"email\":\"%@\",\"memo\":\"%@\",\"mobile2\":\"%@\",\"parent_id\":\"%@\",\"photo\":\"%@\",\"token\":\"%@\"}</web:json></web:modifyUser>",is_photo_edit,name,sex,birthday,identify_id,mobile,addr,qq,email,memo,mobile2,parent_id,photo,token]];
}

/**
 每日登录后签到
 @param parent_id 注册id
 @param platform_type_id  //Android传201,IOS传202
 @param token
 */
+ (AFHTTPRequestOperation *)signWithParentId:(NSString *)parent_id andPlatform_type_id:(NSString *)platform_type_id andToken:(NSString *)token{
    
    return [self XEEWebService:[NSString stringWithFormat:@"<web:Sign><web:json>{\"parent_id\":\"%@\",\"platform_type_id\":\"%@\",\"token\":\"%@\"}</web:json></web:Sign>",parent_id,platform_type_id,token]];
}

/**
 登录后修改密码
 @param parent_id 注册id
 @param token
 */
+ (AFHTTPRequestOperation *)getMyInfoWithParentId:(NSString *)parent_id andToken:(NSString *)token{
    
    return [self XEEWebService:[NSString stringWithFormat:@"<web:GetMyInfo><web:json>{\"parent_id\":\"%@\",\"token\":\"%@\"}</web:json></web:GetMyInfo>",parent_id,token]];
}

#pragma mark - 我的 个人信息
/**
 登录后修改密码
 */
+ (AFHTTPRequestOperation *)modifyPwdWithNewPassword:(NSString *)newPassword andOldPassword:(NSString *)oldPassword andParentId:(NSString *)parent_id andToken:(NSString *)token{
    
    return [self XEEWebService:[NSString stringWithFormat:@"<web:modifyPwd><web:json>{\"password\":\"%@\",\"old_password\":\"%@\",\"parent_id\":\"%@\",\"token\":\"%@\"}</web:json></web:modifyPwd>",newPassword,oldPassword,parent_id,token]];
}

#pragma mark - 我的 我的积分
/**
 我的积分交易记录
 */
+ (AFHTTPRequestOperation *)getPointsWithPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex andParentId: (NSString *)parent_id andToken:(NSString *)token{
    
    return [self XEEWebService:[NSString stringWithFormat:@"<web:GetPoints><web:json>{\"parent_id\":\"%@\", \"pageSize\":\"%li\", \"pageIndex\":\"%li\", \"token\":\"%@\"}</web:json></web:GetPoints>",parent_id,(long)pageSize,(long)pageIndex,token]];
}

/**
 查询积分策略
 */
+ (AFHTTPRequestOperation *)getPointConfig{
    
    return [self XEEWebService:[NSString stringWithFormat:@"<web:GetPointConfig/>"]];
}

/**
 获取我的积分中所有的礼品
 */
+ (AFHTTPRequestOperation *)getGift{
    
    return [self XEEWebService:[NSString stringWithFormat:@"<web:GetGift/>"]];
}

/**
 用积分兑换礼品
 */
+ (AFHTTPRequestOperation *)buyGiftWithParentId:(NSString *)parent_id andPlatformTypeId:(NSString *)platform_type_Id andGiftId: (NSString *)gift_id andToken:(NSString *)token{
    
    return [self XEEWebService:[NSString stringWithFormat:@"<web:BuyGift><web:json>{\"parent_id\":\"%@\",\"trade_type\":\"%@\",\"gift_id\":\"%@\",\"token\":\"%@\"}</web:json></web:BuyGift>",parent_id,platform_type_Id,gift_id,token]];
}

#pragma mark - 我的 我的现金券
/**
 查我的现金卷
 @param parentId 表示当前登录人id
 @param token
 */
+ (AFHTTPRequestOperation *)getMyCouponWithParentId: (NSString *)parent_id andToken:(NSString *)token{
    
    return [self XEEWebService:[NSString stringWithFormat:@"<web:GetMyCoupon><web:json>{\"parent_id\":\"%@\",\"token\":\"%@\"}</web:json></web:GetMyCoupon>",parent_id,token]];
}



#pragma mark - 我的 我的预定
/**
 获取我的预定中的活动
 */
+ (AFHTTPRequestOperation *)GetActivityInfoByParentIdWithPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex andParentId: (NSString *)parentId andToken:(NSString *)token{
    return [self XEEWebService:[NSString stringWithFormat:@"<web:GetActivityInfoByParentId><web:json>{\"pageSize\":\"%li\",\"pageIndex\":\"%li\",\"parent_id\":\"%@\",\"token\":\"%@\"}</web:json></web:GetActivityInfoByParentId>",(long)pageSize,(long)pageIndex,parentId,token]];
}

/**
 获取我的预定中的场馆
 @param pageSize 一次请求显示多少个活动
 @param pageIndex 当前页码
 @param parentId 表示当前登录人id
 @param token
 */
+ (AFHTTPRequestOperation *)getBookSiteByParent_idWithPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex andParentId: (NSString *)parentId andToken:(NSString *)token{
    
    return [self XEEWebService:[NSString stringWithFormat:@"<web:GetBookSiteByParentId><web:json>{\"pageSize\":\"%li\",\"pageIndex\":\"%li\",\"parent_id\":\"%@\",\"token\":\"%@\"}</web:json></web:GetBookSiteByParentId>",(long)pageSize,(long)pageIndex,parentId,token]];
}

/**
 通过会员id，查询消费订单分页列表
 @param pageSize 一次请求显示多少个活动
 @param pageIndex 当前页码
 @param parentId 表示当前登录人id
 @param sort
 @param order
 */
+ (AFHTTPRequestOperation *)getVOrderByParentIdWithParentId:(NSString *)parentId andSort:(NSString *)sort andOrder:(NSString *)order andPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex andToken:(NSString *)token{
    
    return [self XEEWebService:[NSString stringWithFormat:@"<web:GetVOrderByParentId><web:json>{\"parent_id\":\"%@\",\"sort\":\"%@\",\"order\":\"%@\",\"pageSize\":\"%li\",\"pageIndex\":\"%li\",\"token\":\"%@\"}</web:json></web:GetVOrderByParentId>",parentId,sort,order,(long)pageSize,(long)pageIndex,token]];
}


/**
 获取城市
 */
+ (AFHTTPRequestOperation *)getCity{
    return [self XEEWebService:[NSString stringWithFormat:@"<web:GetCity/>"]];
}
#pragma mark - 我的 城市
/**
 修改城市
 */
+ (AFHTTPRequestOperation *)setCityWithRegionalId:(NSString *)regional_id andParentId:(NSString *)parent_id andToken:(NSString *)token{
    
    return [self XEEWebService:[NSString stringWithFormat:@"<web:SetCity><web:json>{\"regional_id\":\"%@\",\"parent_id\":\"%@\",\"token\":\"%@\"}</web:json></web:SetCity>",regional_id,parent_id,token]];
}

#pragma mark - 我的 更多设置
/**
 分享
 */
+ (AFHTTPRequestOperation *)tellFriendWithShareContent:(NSString *)share_content andParentId:(NSString *)parent_id andToken:(NSString *)token{
    
    return [self XEEWebService:[NSString stringWithFormat:@"<web:TellFriend><web:json>{\"share_content\":\"%@\",\"parent_id\":\"%@\",\"token\":\"%@\"}</web:json></web:TellFriend>",share_content,parent_id,token]];
}

/**
 意见反馈
 */
+ (AFHTTPRequestOperation *)addFeedbackWithBugInfo:(NSString *)bug_info andParentId:(NSString *)parent_id andToken:(NSString *)token{
    
    return [self XEEWebService:[NSString stringWithFormat:@"<web:AddFeedback><web:json>{\"bug_info\":\"%@\",\"parent_id\":\"%@\",\"token\":\"%@\"}</web:json></web:AddFeedback>",bug_info,parent_id,token]];
}

@end
