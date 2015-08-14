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
    
    
    //NSString *requestURL = [[NSString alloc]initWithData:postbody encoding:NSUTF8StringEncoding];
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
    
    //NSLog(@"requestURL:%@",postbody);
    
    //NSString *requestURL = [[NSString alloc]initWithData:postbody encoding:NSUTF8StringEncoding];
    //NSLog(@"requestURL:%@",requestURL);
    
    AFHTTPRequestOperation *opration = [[AFHTTPRequestOperation alloc] initWithRequest:req];
    return opration;
}

/*+ (AFHTTPRequestOperation *)XEEWebService:(NSString *)body {
    
    NSURL* WebURL = [NSURL URLWithString:XEEWebURL];
    NSMutableURLRequest* req = [[NSMutableURLRequest alloc] init];
    [req setURL:WebURL];
    [req setHTTPMethod:@"POST"];
    
    unsigned long encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
    [req addValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
    NSMutableData* postbody = [[NSMutableData alloc] init];
    [postbody appendData:[[NSString stringWithFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:web=\"http://webservice.ereal.com/\"><soapenv:Header/><soapenv:Body>"] dataUsingEncoding:encode]];
    
    [postbody appendData:[[NSString stringWithFormat:@"%@",body] dataUsingEncoding:encode]];
    
    [postbody appendData:[[NSString stringWithFormat:@"</soapenv:Body></soapenv:Envelope>"] dataUsingEncoding:encode]];
    [req setHTTPBody:postbody];
    
    NSLog(@"requestURL:%@",postbody);
    
    NSString *requestURL = [[NSString alloc]initWithData:postbody encoding:encode];
    NSLog(@"requestURL:%@",requestURL);
    
    AFHTTPRequestOperation *opration = [[AFHTTPRequestOperation alloc] initWithRequest:req];
    return opration;
}*/


#pragma mark - 登陆相关

+ (AFHTTPRequestOperation *)checkPhoneWithPhoneNumber:(NSString *)phoneNumber andSign:(NSString *)sign {
    return [self XEEWebService:[NSString stringWithFormat:@"<web:checkPhone><web:json>{\"mobile\":\"%@\",\"sign\":\"%@\"}</web:json></web:checkPhone>", phoneNumber, sign]];
}

+ (AFHTTPRequestOperation *)checkCodeWithPhoneNumber:(NSString *)phoneNumber andCode:(NSString *)code andSign:(NSString *)sign {
    return [self XEEWebService:[NSString stringWithFormat:@" <web:checkCode><web:json>{\"sign\":\"%@\",\"mobile\":\"%@\",\"code\":\"%@\"}</web:json></web:checkCode>", sign, phoneNumber, code]];
}
+ (AFHTTPRequestOperation *)checkCodeWithPhoneNumber:(NSString *)phoneNumber andCode:(NSString *)code andSign:(NSString *)sign  andPassword:(NSString *)password  andInvitationCode:(NSString *)invitation_code{
    
    return [self XEEWebService:[NSString stringWithFormat:@" <web:checkCode><web:json>{\"sign\":\"%@\",\"mobile\":\"%@\",\"code\":\"%@\",\"password\":\"%@\",\"invitation_code\":\"%@\"}</web:json></web:checkCode>", sign, phoneNumber, code, password, invitation_code]];
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
 获取首页广告信息
 @param {}
 */
+ (AFHTTPRequestOperation *)getAd{
    
    return [self XEEWebService:[NSString stringWithFormat:@"<web:GetAd/>"]];
}


/**
 获取首页课程列表
 @param {}
 */
+ (AFHTTPRequestOperation *)getCourseListAppHomeWithTitle:(NSString *)title{
    return [self XEEWebService:[NSString stringWithFormat:@"<web:GetCourseListAppHome><web:json>{\"title\":\"%@\"}</web:json></web:GetCourseListAppHome>",title]];
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
 查询课程推荐评论
 @param course_id 课程id
 */
+ (AFHTTPRequestOperation *)getCourseParentCommentByCourseId:(NSString *)course_id andPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex{
    
    return [self XEEWebService:[NSString stringWithFormat:@"<web:GetCourseParentComment><web:json>{\"course_id\":\"%@\",\"pageSize\":\"%li\",\"pageIndex\":\"%li\"}</web:json></web:GetCourseParentComment>",course_id,(long)pageSize,(long)pageIndex]];
}

/**
 通过课程获取详情，及子课程列表
 @param course_id 注册id
 */
+ (AFHTTPRequestOperation *)getCourseListByParentCourseId:(NSString *)course_id{
    
    return [self XEEWebService:[NSString stringWithFormat:@"<web:GetCourseListByParentCourseId><web:json>{\"course_id\":\"%@\"}</web:json></web:GetCourseListByParentCourseId>",course_id]];
}


/**
 通过家长id，查询家长的孩子列表,购买试听用
 @param parent_id 注册id
 */
+ (AFHTTPRequestOperation *)getVStudentByParentId:(NSString *)parent_id andToken:(NSString *)token{
    
    return [self XEEWebService:[NSString stringWithFormat:@"<web:GetVStudentByParentId><web:json>{\"parent_id\":\"%@\",\"token\":\"%@\"}</web:json></web:GetVStudentByParentId>",parent_id,token]];
}

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
 */
+ (AFHTTPRequestOperation *)addStudentSubCourseByParentId:(NSInteger )parent_id andCourseId:(NSInteger )course_id andDepartmentId:(NSInteger )department_id  andStudentId:(NSInteger )student_id andType:(NSInteger )type andPayType:(NSInteger )pay_type andNumbers:(NSInteger )numbers andOrderPrice:(NSInteger )order_price andPlatformType:(NSString *)platform_type andListCoupon:(NSArray *)listCoupon andToken:(NSString *)token{
    
    return [self XEEWebService:[NSString stringWithFormat:@"<web:AddStudentSubCourse><web:json>{\"parent_id\":%li,\"course_id\":%li,\"department_id\":%li,\"student_id\":%li,\"type\":%li,\"pay_type\":%li,\"numbers\":%li,\"order_price\":%li,\"platform_type_id\":\"%@\",\"listCoupon\":%@,\"token\":\"%@\"}</web:json></web:AddStudentSubCourse>",(long)parent_id,(long)course_id,(long)department_id,(long)student_id,(long)type,(long)pay_type,(long)numbers,(long)order_price,platform_type,listCoupon,token]];
    
    }

+ (AFHTTPRequestOperation *)addStudentSubCourseWithDepartmentId:(NSString *)departmentId andStudentId:(NSString *)studentId andType:(NSString *)type andOrderPrice:(NSInteger)orderPrice andPlatFormTypeId:(NSString *)platFormTypeId andListCoupon:(NSString *)listCoupon andToken:(NSString *)token andPayType:(NSString *)payType andNumbers:(NSInteger)numbers andCourseId:(NSInteger)courseId andParentId:(NSString *)parentId andIsSelectStudent:(NSString *)is_select_student andSex:(NSString *)sex andBirthday:(NSString *)birthday andName:(NSString *)name andOutTradeNo:(NSString *)out_trade_no {
    //NSLog(@"{\"department_id\":%@,\"student_id\":%@,\"type\":%@,\"order_price\":%li,\"platform_type_id\":%@,\"listCoupon\":%@,\"token\":%@,\"pay_type\":%@,\"numbers\":%li,\"course_id\":%li,\"parent_id\":%@}",departmentId,studentId,type,(long)orderPrice,platFormTypeId,listCoupon,token,payType,(long)numbers,(long)courseId,parentId);
    //NSLog(@"{\"department_id\":%@,\"student_id\":%@,\"type\":%@,\"order_price\":%li,\"platform_type_id\":\"%@\",\"listCoupon\":%@,\"token\":\"%@\",\"pay_type\":%@,\"numbers\":%li,\"course_id\":%li,\"parent_id\":%@}",departmentId,studentId,type,(long)orderPrice,platFormTypeId,listCoupon,token,payType,(long)numbers,(long)courseId,parentId);
    /*return [self XEEWebService:[NSString stringWithFormat:@"<web:AddStudentSubCourse><web:json>{\"department_id\":%@,\"student_id\":%@,\"type\":%@,\"order_price\":%li,\"platform_type_id\":\"%@\",\"listCoupon\":%@,\"token\":\"%@\",\"pay_type\":%@,\"numbers\":%li,\"course_id\":%li,\"parent_id\":%@}</web:json></web:AddStudentSubCourse>",departmentId,studentId,type,(long)orderPrice,platFormTypeId,listCoupon,token,payType,(long)numbers,(long)courseId,parentId]];*/
    return [self XEEWebService:[NSString stringWithFormat:@"<web:AddStudentSubCourse><web:json>{\"department_id\":\"%@\",\"student_id\":\"%@\",\"type\":\"%@\",\"order_price\":%li,\"platform_type_id\":\"%@\",\"listCoupon\":%@,\"token\":\"%@\",\"pay_type\":\"%@\",\"numbers\":%li,\"course_id\":%li,\"parent_id\":\"%@\",\"is_select_student\":\"%@\",\"sex\":\"%@\",\"birthday\":\"%@\",\"name\":\"%@\",\"out_trade_no\":\"%@\"}</web:json></web:AddStudentSubCourse>",departmentId,studentId,type,(long)orderPrice,platFormTypeId,listCoupon,token,payType,(long)numbers,(long)courseId,parentId,is_select_student,sex,birthday,name,out_trade_no]];

}

/**
 获取课程详情和评论列表
 @param course_id 注册id
 */
+ (AFHTTPRequestOperation *)getCourseDetailAndTopCommentListByCourseId:(NSString *)course_id andPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex{
    
    return [self XEEWebService:[NSString stringWithFormat:@"<web:GetCourseDetailAndTopCommentListByCourseId><web:json>{\"course_id\":\"%@\",\"pageSize\":\"%li\",\"pageIndex\":\"%li\"}</web:json></web:GetCourseDetailAndTopCommentListByCourseId>",course_id,(long)pageSize,(long)pageIndex]];
}


/**
 通过课程id，获取补课课表安排
 @param parent_id 注册id
 @param course_id 课程id
 @param course_id 注册id
 @param course_id 注册id
 @param course_id 注册id
 */
+ (AFHTTPRequestOperation *)getMakeupLessionListByCourseIdWithToken:(NSString *)token andParentId:(NSString *)parent_id andCourseId:(NSString *)course_id andCreateTime:(NSString *)create_time andPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex{
    
    return [self XEEWebService:[NSString stringWithFormat:@"<web:GetMakeupLessionListByCourseId><web:json>{\"token\":\"%@\",\"parent_id\":\"%@\",\"course_id\":\"%@\",\"create_time\": \"%@\",\"pageSize\":\"%li\",\"pageIndex\":\"%li\"}</web:json></web:GetMakeupLessionListByCourseId>",token,parent_id,course_id,create_time,(long)pageSize,(long)pageIndex]];
}


/**
 托管申请
 @param student_name    学生姓名
 @param parent_name     家长姓名
 @param mobile          手机号
 @param type            type 1全托0半托
 @param start_time      托管开始时间
 @param end_time        托管结束时间
 @param is_transfer     is_transfer 1接送 0不接送
 @param receive_time    接孩子时间
 @param send_time       送孩子时间
 @param department_id   校区id
 @param parent_id       注册id
 */
+ (AFHTTPRequestOperation *)addTrustByStudentName:(NSString *)student_name andParentName:(NSString *)parent_name andMobile:(NSString *)mobile andType:(NSInteger )type andStartTime:(NSString *)start_time andEndTime:(NSString *)end_time andIsTransfer:(NSInteger )is_transfer andReceiveTime:(NSString *)receive_time andSendTime:(NSString *)send_time andDepartmentId:(NSString *)department_id andParentId:(NSString *)parent_id andToken:(NSString *)token{
    
    return [self XEEWebService:[NSString stringWithFormat:@"<web:AddTrust><web:json>{\"student_name\":\"%@\",\"parent_name\": \"%@\",\"mobile\":\"%@\",\"type\":\"%li\",\"start_time\":\"%@\",\"end_time\":\"%@\",\"is_transfer\":\"%li\",\"receive_time\":\"%@\",\"send_time\":\"%@\",\"department_id\":\"%@\",\"parent_id\":\"%@\",\"token\":\"%@\"}</web:json></web:AddTrust>",student_name,parent_name,mobile,(long)type,start_time,end_time,(long)is_transfer,receive_time,send_time,department_id,parent_id,token]];
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
 通过学号，获取选课列表
 @param parent_id    注册id
 @param student_id   学生id
 @param token
 */
+ (AFHTTPRequestOperation *)getSubcourseCourseListByStudentIdWithParentId:(NSString *)parent_id  andStudentId:(NSString *)student_id andToken:(NSString *)token{
    
    return [self XEEWebService:[NSString stringWithFormat:@"<web:GetSubcourseCourseListByStudentId><web:json>{\"parent_id\": \"%@\",\"student_id\":\"%@\",\"token\": \"%@\"}</web:json></web:GetSubcourseCourseListByStudentId>",parent_id,student_id,token]];
}

/**
 通过student_id学员id，获取课程计划签到信息分页(获取请假/缺课列表 共用)
 */
+ (AFHTTPRequestOperation *)getVStudentSourseScheduleSignWithParentId:(NSString *)parent_id andStudentId:(NSString *)student_id andCourseId:(NSString *)course_id andSignon:(NSString *)is_signon andSort:(NSString *)sort andOrder:(NSString *)order andPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex andToken:(NSString *)token{
    
    return [self XEEWebService:[NSString stringWithFormat:@"<web:GetVStudentSourseScheduleSign><web:json>{\"parent_id\":\"%@\",\"student_id\":\"%@\",\"student_subcourse_id\":\"%@\", \"is_signon\":\"%@\",\"sort\":\"%@\",\"order\":\"%@\",\"pageSize\":\"%li\",\"pageIndex\":\"%li\",\"token\":\"%@\"}</web:json></web:GetVStudentSourseScheduleSign>",parent_id,student_id,course_id,is_signon,sort,order,(long)pageSize,(long)pageIndex,token]];
}

/**
 请假/家长评论   type取值 0 请假 1评论
 */
+ (AFHTTPRequestOperation *)addSubcourseLeaveApplyByParentId:(NSString *)parent_id andRelationId:(NSString *)relation_id andRemark:(NSString *)remark andStar:(NSString *)star andType:(NSString *)type andApplyId:(NSString *)apply_id andCreateTime:(NSString *)create_time andStatus:(NSString *)status andTeacherId:(NSString *)teacher_id andCheckTime:(NSString *)check_time andCheckRemark:(NSString *)check_remark andToken:(NSString *)token{
    
    //@"{\"parent_id\":\"17\", \"relation_id\":\"11\", \"remark\":\"uuu\", \"type\":\"0\", \"apply_id\":null, \"create_time\":%@, \"status\":null, \"teacher_id\":null, \"check_time\":null, \"check_remark\":null,\"token\":\"yEqHDenWZHANQ08W1WF93J+t+ELfkokN0dz9KsI8kALd/GXU1pEykMyOJupHiHATpELTmg8I+XWN1mKJb8Vr+g==\"}"
    
    return [self XEEWebService:[NSString stringWithFormat:@"<web:AddSubcourseLeaveApply><web:json>{\"parent_id\":\"%@\", \"relation_id\":\"%@\", \"remark\":\"%@\",\"star\":\"%@\", \"type\":\"%@\", \"apply_id\":%@, \"create_time\":\"%@\", \"status\":%@, \"teacher_id\":%@, \"check_time\":%@, \"check_remark\": %@,\"token\":\"%@\"}</web:json></web:AddSubcourseLeaveApply>",parent_id,relation_id,remark,star,type,apply_id,create_time,status,teacher_id,check_time,check_remark,token]];
}

/**
 课程回顾(通过课表id(course_schedule_id)获取课表相关图片)   //其他图片
 @param parent_id    注册id
 @param owner_id   就是course_schedule_id
 @param token
 */
+ (AFHTTPRequestOperation *)getPhotoByCourseScheduleIdWithParentId:(NSString *)parent_id  andOwnerId:(NSString *)owner_id andToken:(NSString *)token{
    
    return [self XEEWebService:[NSString stringWithFormat:@"<web:GetPhotoByCourseScheduleId><web:json>{\"owner_id\":\"%@\",\"parent_id\":\"%@\",\"token\":\"%@\"}</web:json></web:GetPhotoByCourseScheduleId>",owner_id,parent_id,token]];
}

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
+ (AFHTTPRequestOperation *)getStudentSignPhotoListWithParentId:(NSString *)parent_id  andStudentId:(NSString *)student_id  andSignonId:(NSString *)signon_id andCourseScheduleId:(NSString *)course_schedule_id  andCreateTime:(NSString *)create_time andPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex andToken:(NSString *)token{
    
    return [self XEEWebService:[NSString stringWithFormat:@"<web:GetStudentSignPhotoList><web:json>{\"parent_id\":\"%@\",\"student_id\":\"%@\", \"signon_id\":\"%@\",\"course_schedule_id\":\"%@\", \"create_time\": \"%@\",\"pageSize\":\"%li\",\"pageIndex\":\"%li\",\"token\":\"%@\"}</web:json></web:GetStudentSignPhotoList>",parent_id,student_id,signon_id,course_schedule_id,create_time,(long)pageSize,(long)pageIndex,token]];
}

/**
 通过课程计划id，查询上课家长评论  每节课的评论
 @param parent_id    注册id
 @param course_schedule_id
 @param token
 */
+ (AFHTTPRequestOperation *)getCourseScheduleSignParentCommentWithParentId:(NSString *)parent_id  andCourseScheduleId:(NSString *)course_schedule_id andPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex andSignonId:(NSString *)signon_id andToken:(NSString *)token{
    return [self XEEWebService:[NSString stringWithFormat:@"<web:GetCourseScheduleSignParentComment><web:json>{\"parent_id\":\"%@\",\"course_schedule_id\":\"%@\",\"pageSize\":\"%li\",\"pageIndex\":\"%li\",\"signon_id\":\"%@\",\"token\":\"%@\"}</web:json></web:GetCourseScheduleSignParentComment>",parent_id,course_schedule_id,(long)pageSize,(long)pageIndex,signon_id,token]];
}

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
+ (AFHTTPRequestOperation *)addTStarCommentWithParentId:(NSString *)parent_id  andStarCommentNumbers:(NSInteger )star_comment_numbers andTeacherTowardsNumbers:(NSInteger )teacher_towards_numbers andTeacherCommentNumbers:(NSInteger )teacher_comment_numbers andStudentDegreeNumbers:(NSInteger )student_degree_numbers andRemark:(NSString *)remark andRelationId:(NSString *)relation_id andToken:(NSString *)token{
    
    return [self XEEWebService:[NSString stringWithFormat:@"<web:AddTStarComment><web:json>{\"parent_id\":\"%@\",\"star_comment_numbers\":\"%li\",\"teacher_towards_numbers\":\"%li\",\"teacher_comment_numbers\": \"%li\",\"student_degree_numbers\":\"%li\",\"remark\":\"%@\",\"relation_id\":\"%@\",\"token\":\"%@\"} </web:json></web:AddTStarComment>",parent_id,(long)star_comment_numbers,(long)teacher_towards_numbers,(long)teacher_comment_numbers,(long)student_degree_numbers,remark,relation_id,token]];
}


#pragma mark - 活动
+ (AFHTTPRequestOperation *)getActivityInfoWithPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex andActivityStatus:(NSInteger )activity_status andParentId:(NSString *)parent_id andToken:(NSString *)token{
    
    return [self XEEWebService:[NSString stringWithFormat:@"<web:GetActivityInfo><web:json>{\"pageSize\":\"%li\",\"pageIndex\":\"%li\",\"activity_status\":\"%li\",\"parent_id\":\"%@\",\"token\":\"%@\"}</web:json></web:GetActivityInfo>",(long)pageSize, (long)pageIndex,(long)activity_status,parent_id,token]];
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
+ (AFHTTPRequestOperation *)modifyUserWithIsPhotoEdit:(NSString *)is_photo_edit andName:(NSString *)name andSex:(NSString *)sex andBirthday:(NSString *)birthday andIdentifyId:(NSString *)identify_id andMobile:(NSString *)mobile andAddr:(NSString *)addr andQq:(NSString *)qq andEmail:(NSString *)email andMemo:(NSString *)memo andMobile2:(NSString *)mobile2 andParentId:(NSString *)parent_id andPhoto:(NSString *)photo andCommunityId:(NSString *)community_id andToken:(NSString *)token{
    
    return [self XEEWebService:[NSString stringWithFormat:@"<web:modifyUser><web:json>{\"is_photo_edit\":\"%@\",\"name\":\"%@\",\"sex\":\"%@\",\"birthday\":\"%@\",\"identify_id\":\"%@\",\"mobile\":\"%@\",\"addr\":\"%@\",\"qq\":\"%@\",\"email\":\"%@\",\"memo\":\"%@\",\"mobile2\":\"%@\",\"parent_id\":\"%@\",\"photo\":\"%@\",\"community_id\":\"%@\",\"token\":\"%@\"}</web:json></web:modifyUser>",is_photo_edit,name,sex,birthday,identify_id,mobile,addr,qq,email,memo,mobile2,parent_id,photo,community_id,token]];
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

/**
 查询小区
 参数1:pageSize表示一页行数
 参数2:pageIndex 表示页码
 参数3:parent_id表示登陆人id
 参数4:token
 参数5:search_content查询内容,可选参数
 */
+ (AFHTTPRequestOperation *)getCommunityWithParentId:(NSString *)parent_id andSearchContent:(NSString *)search_content andPageSize: (NSInteger )pageSize andPageIndex: (NSInteger )pageIndex andToken:(NSString *)token{
    
    return [self XEEWebService:[NSString stringWithFormat:@"<web:GetCommunity><web:json>{\"parent_id\":\"%@\",\"search_content\":\"%@\",\"pageSize\":\"%li\", \"pageIndex\":\"%li\",\"token\":\"%@\"}</web:json></web:GetCommunity>",parent_id,search_content,pageSize,pageIndex,token]];
}

#pragma mark - 我的 宝宝相册
/**
 用积分兑换礼品
 @param parentId 表示当前登录人id
 @param student_id    学生id
 @param pageSize
 @param pageIndex
 @param token
 */
+ (AFHTTPRequestOperation *)getPhotoGroupListByStudentIdWithParentId:(NSString *)parent_id andStudentId:(NSString *)student_id andPageSize: (NSInteger )pageSize andPageIndex: (NSInteger )pageIndex andToken:(NSString *)token{
    
    return [self XEEWebService:[NSString stringWithFormat:@"<web:GetPhotoGroupListByStudentId><web:json>{\"parent_id\":\"%@\",\"student_id\": \"%@\",\"pageSize\": \"%li\",\"pageIndex\":\"%li\",\"token\":\"%@\"}</web:json></web:GetPhotoGroupListByStudentId>",parent_id,student_id,(long)pageSize,(long)pageIndex,token]];
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
    
    return [self XEEWebService:[NSString stringWithFormat:@"<web:BuyGift><web:json>{\"parent_id\":\"%@\",\"platform_type_id\":\"%@\",\"gift_id\":\"%@\",\"token\":\"%@\"}</web:json></web:BuyGift>",parent_id,platform_type_Id,gift_id,token]];
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

#pragma mark - 我的 订单

/**
 通过会员id，查询消费订单分页列表
 @param pageSize 一次请求显示多少个活动
 @param pageIndex 当前页码
 @param parentId 表示当前登录人id
 @param sort
 @param order
 */
+ (AFHTTPRequestOperation *)getVOrderByParentIdWithParentId:(NSString *)parentId andSort:(NSString *)sort andOrder:(NSString *)order andType:(NSString *)type andPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex andToken:(NSString *)token{
    
    return [self XEEWebService:[NSString stringWithFormat:@"<web:GetVOrderByParentId><web:json>{\"parent_id\":\"%@\",\"sort\":\"%@\",\"order\":\"%@\",\"type\":\"%@\",\"pageSize\":\"%li\",\"pageIndex\":\"%li\",\"token\":\"%@\"}</web:json></web:GetVOrderByParentId>",parentId,sort,order,type,(long)pageSize,(long)pageIndex,token]];
}

/**
 通过会员id，查询消费订单分页列表
 @param relation_id   订单的order_id
 @param remark        取消原因
 @param parentId 表示当前登录人id
 @param type          type为4，取消操作
 @param token
 */
+ (AFHTTPRequestOperation *)cancelOrderWithParentId:(NSString *)parentId andRelationId:(NSString *)relation_id andRemark:(NSString *)remark andType:(NSString *)type andToken:(NSString *)token{
    
    return [self XEEWebService:[NSString stringWithFormat:@"<web:CancelOrder><web:json>{\"parent_id\":\"%@\",\"relation_id\":\"%@\", \"remark\":\"%@\", \"type\":\"%@\",\"token\":\"%@\"}</web:json></web:CancelOrder>",parentId,relation_id,remark,type,token]];
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
    
    return [self XEEWebService:[NSString stringWithFormat:@"<web:AddFeedback><web:json>{\"bugInfo\":\"%@\",\"parent_id\":\"%@\",\"token\":\"%@\"}</web:json></web:AddFeedback>",bug_info,parent_id,token]];
}

/**
 查询附近校区
 */
+ (AFHTTPRequestOperation *)getSchoolNearByWithLongitude:(CGFloat)longitude andLatitude:(CGFloat)latitude andPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex {
    return [self XEEWebService:[NSString stringWithFormat:@"<web:GetSchoolNearby><web:json>{\"longitude\":\"%f\",\"latitude\":\"%f\",\"pageSize\":\"%li\",\"pageIndex\":\"%li\"}</web:json></web:GetSchoolNearby>",longitude, latitude, (long)pageSize, (long)pageIndex]];
}

/**
 查询附近校区详情
 @param:department_id      校区id
 @param:platform_type_id   "202"ios
 */
+ (AFHTTPRequestOperation *)getSchoolNearbyPicListWithDepartmentId:(NSString *)department_id andPlatformTypeId:(NSString *)platform_type_id andPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex{
    
    return [self XEEWebService:[NSString stringWithFormat:@"<web:GetSchoolNearbyPicList><web:json>{\"department_id\":\"%@\",\"platform_type_id\":\"%@\",\"pageSize\":\"%li\",\"pageIndex\":\"%li\"}</web:json></web:GetSchoolNearbyPicList>",department_id,platform_type_id,(long)pageSize,(long)pageIndex]];
}

//#pragma mark - 微信支付修改订单
///**
// 查我的现金卷
// @param parentId 表示当前登录人id
// @param token
// @param out_trade_no 微信商户订单号
// @param platform_type_id 平台"201"为安卓，"202"为ios
// */
//+ (AFHTTPRequestOperation *)updateOrderStatueWxWithParentId:(NSString *)parent_id andOutTradeNo:(NSString *)out_trade_no andPlatformTypeId:(NSString *)platform_type_id andToken:(NSString *)token{
//    
//    return [self XEEWebService:[NSString stringWithFormat:@"<web:UpdateOrderStatueWx><web:json>{\"parent_id\":\"%@\",\"out_trade_no\":\"%@\",\"platform_type_id\":\"%@\",\"token\":\"%@\"}</web:json></web:UpdateOrderStatueWx>",parent_id,out_trade_no,platform_type_id,token]];
//}

@end
