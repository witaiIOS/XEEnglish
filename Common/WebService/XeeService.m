//
//  XeeService.m
//  XEEnglish
//
//  Created by MacAir2 on 15/6/2.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "XeeService.h"
#import "MyParser.h"

@implementation XeeService

+ (XeeService *)sharedInstance{
    static XeeService *sharedXeeService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedXeeService = [[self alloc] init];
    });
    return sharedXeeService;
}

- (void)getHomeServiceWithBlock:(void (^)(NSNumber *result, NSArray *resultInfo, NSError *error))block{
    
    AFHTTPRequestOperation *opration = [WebServiceOpration getHomePageServiceCategroy];
    [opration start];
    [opration setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *responseStr = operation.responseString;
        //NSLog(@"responseStr:%@",responseStr);
        
        [[MyParser sharedInstance] parserWithContent:responseStr andKey:@"return"];
        
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[[MyParser sharedInstance].results dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        //NSLog(@"%@",dic);
        
        ////////
        NSNumber *serviceResult = [dic objectForKey:@"result"];
        //NSLog(@"serviceResult:%@",serviceResult);
        
        NSArray *serviceResultInfo = [dic objectForKey:@"resultInfo"];
        
        if (block) {
            block(serviceResult, serviceResultInfo, nil);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"%@",[error description]);
        block(nil, nil, error);
    }];
}

- (void)getHomeAdWithBlock:(void (^)(NSNumber *result, NSArray *resultInfo, NSError *error))block{
    AFHTTPRequestOperation *opration = [WebServiceOpration getHomeAppAdConfigure];
    [opration start];
    [opration setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *responseStr = operation.responseString;
        //NSLog(@"responseStr:%@",responseStr);
        
        [[MyParser sharedInstance] parserWithContent:responseStr andKey:@"return"];

        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[[MyParser sharedInstance].results dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        //NSLog(@"%@",dic);
        
        ////////
        NSNumber *serviceResult = [dic objectForKey:@"result"];
        //NSLog(@"serviceResult:%@",serviceResult);
        
        NSArray *serviceResultInfo = [dic objectForKey:@"resultInfo"];
        
        if (block) {
            block(serviceResult, serviceResultInfo, nil);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, nil, error);
    }];
}


///////////////////////////////////XEE
#pragma mark - XEE
- (void)getResponseWithOpration:(AFHTTPRequestOperation *)opration andXmlKey:(NSString *)xmlKey andBlock:(void (^)(NSString *response, NSDictionary *result, NSError *error))block {
    
    [opration start];
    [opration setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *responseStr = operation.responseString;
        //NSLog(@"responseStr:%@",responseStr);
        
        [[MyParser sharedInstance] parserWithContent:responseStr andKey:xmlKey];
        

        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[[MyParser sharedInstance].results dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        
        
        //NSLog(@"%@",dic);

        
        if (block) {
            block(responseStr, dic, nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, nil, error);
        }

    }];
}

#pragma mark - 登陆相关

- (void)checkPhoneWithPhoneNumber:(NSString *)phoneNumber andSign:(NSString *)sign andBlock:(void (^)(NSDictionary *result, NSError *error))block {
    
    AFHTTPRequestOperation *operation = [WebServiceOpration checkPhoneWithPhoneNumber:phoneNumber andSign:sign];
    
    [self getResponseWithOpration:operation andXmlKey:@"checkPhoneResult" andBlock:^(NSString *response, NSDictionary *result, NSError *error) {
        
        //NSLog(@"result:%@",result);
        
        if (block) {
            block(result, error);
        }
        
    }];
}


- (void)checkCodeWithPhoneNumber:(NSString *)phoneNumber andCode:(NSString *)code andSign:(NSString *)sign andBlock:(void (^)(NSDictionary *result, NSError *error))block {
    
    AFHTTPRequestOperation *operation = [WebServiceOpration checkCodeWithPhoneNumber:phoneNumber andCode:code andSign:sign];
    [self getResponseWithOpration:operation andXmlKey:@"checkCodeResult" andBlock:^(NSString *response, NSDictionary *result, NSError *error) {
        
        //NSLog(@"result:%@",result);
        
        if (block) {
            block(result, error);
        }
        
    }];
}


- (void)registerWithPhoneNumber:(NSString *)phoneNumber andName:(NSString *)name andPassword:(NSString *)password andInvitation_code:(NSString *)invitation_code andBlock:(void (^)(NSDictionary *result, NSError *error))block{
    
    AFHTTPRequestOperation *operation = [WebServiceOpration registerWithPhoneNumber:phoneNumber andName:name andPassword:password andInvitation_code:invitation_code];
    
    [self getResponseWithOpration:operation andXmlKey:@"registerResult" andBlock:^(NSString *response, NSDictionary *result, NSError *error) {
        //NSLog(@"result:%@",result);
        if (block) {
            block(result,error);
        }
    }];
}

/**
 找回密码
 @param phoneNumber 手机号
 @param password 密码
 */
- (void)modifyPwdByMobilephoneWithPhoneNumber:(NSString *)phoneNumber andPassword:(NSString *)password andBlock:(void (^)(NSDictionary *result, NSError *error))block{
    
    AFHTTPRequestOperation *operation = [WebServiceOpration modifyPwdByMobilephoneWithPhoneNumber:phoneNumber andPassword:password];
    
    [self getResponseWithOpration:operation andXmlKey:@"modifyPwdResult" andBlock:^(NSString *response, NSDictionary *result, NSError *error) {
        //NSLog(@"result:%@",result);
        if (block) {
            block(result,error);
        }
    }];
}

/**
 登录
 @param phoneNumber 手机号
 @param password 密码
 */
- (void)loginWithPhoneNumber:(NSString *)phoneNumber andPassword:(NSString *)password andBlock:(void(^)(NSDictionary *result, NSError *error))block{
    
    AFHTTPRequestOperation *operation = [WebServiceOpration loginWithPhoneNumber:phoneNumber andPassword:password];
    
    [self getResponseWithOpration:operation andXmlKey:@"LoginResult" andBlock:^(NSString *response, NSDictionary *result, NSError *error) {
        //NSLog(@"result:%@",result);
        if (block) {
            block(result,error);
        }
    }];
}

#pragma mark - 首页
/**
 获取首页课程列表
 @param {}
 */
- (void)getCourseListAppHomeAndBlock:(void(^)(NSDictionary *result,NSError *error))block{
    
    AFHTTPRequestOperation *operation = [WebServiceOpration getCourseListAppHome];
    
    [self getResponseWithOpration:operation andXmlKey:@"GetCourseListAppHomeResult" andBlock:^(NSString *response, NSDictionary *result, NSError *error) {
        //NSLog(@"result:%@",result);
        if (block) {
            block(result,error);
        }
    }];
}

/**
 获取首页课程列表
 @param {}
 */
- (void)getCourseCategoryAgeAndBlock:(void(^)(NSDictionary *result, NSError *error))block{
    
    AFHTTPRequestOperation *operation = [WebServiceOpration getCourseCategoryAge];
    
    [self getResponseWithOpration:operation andXmlKey:@"GetCourseCategoryAgeResult" andBlock:^(NSString *response, NSDictionary *result, NSError *error) {
        //NSLog(@"result:%@",result);
        if (block) {
            block(result,error);
        }
    }];
}

/**
 首页进入的筛选课程
 获取首页所有课程页的课程年龄列表
 */
- (void)getCourseListByFilterWithMinAge:(NSString *)min_age andMaxAge:(NSString *)max_age andCourseCategoryId:(NSString *)course_category_id andSort:(NSString *)sort andOrder:(NSString *)order andPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex andBlock:(void(^)(NSDictionary *result, NSError *error))block{
    
    AFHTTPRequestOperation *oparetion = [WebServiceOpration getCourseListByFilterWithMinAge:min_age andMaxAge:max_age andCourseCategoryId:course_category_id andSort:sort andOrder:order andPageSize:pageSize andPageIndex:pageIndex];
    
    [self getResponseWithOpration:oparetion andXmlKey:@"GetCourseListByFilterResult" andBlock:^(NSString *response, NSDictionary *result, NSError *error) {
        if (block) {
            block(result,error);
        }
    }];
}

/**
 通过课程id，查询课程详情
 @param course_id 注册id
 */
- (void)getCourseDetailByCourseId:(NSString *)course_id andBlock:(void(^)(NSDictionary *result, NSError *error))block{
    
    AFHTTPRequestOperation *operation = [WebServiceOpration getCourseDetailByCourseId:course_id];
    [self getResponseWithOpration:operation andXmlKey:@"GetCourseDetailByCourseIdResult" andBlock:^(NSString *response, NSDictionary *result, NSError *error) {
        if (block) {
            block(result,error);
        }
    }];
}

/**
 通过课程获取详情，及子课程列表
 @param course_id 注册id
 */
- (void)getCourseListByParentCourseId:(NSString *)course_id andBlock:(void(^)(NSDictionary *result, NSError *error))block{
    
    AFHTTPRequestOperation *oparetion = [WebServiceOpration getCourseListByParentCourseId:course_id];
    [self getResponseWithOpration:oparetion andXmlKey:@"GetCourseListByParentCourseIdResult" andBlock:^(NSString *response, NSDictionary *result, NSError *error) {
        if (block) {
            block(result,error);
        }
    }];
}

#pragma mark - 课程
/**
 通过家长id，查找学生选课关系简介列表
 @param parent_id 注册id
 */
- (void)getVStudentCourseByParentId:(NSString *)parent_id andToken:(NSString *)token andBlock:(void(^)(NSDictionary *result,NSError *error))block{
    AFHTTPRequestOperation *operation = [WebServiceOpration getVStudentCourseByParentId:parent_id andToken:token];
    
    [self getResponseWithOpration:operation andXmlKey:@"GetVStudentCourseByParentIdResult" andBlock:^(NSString *response, NSDictionary *result, NSError *error) {
        //NSLog(@"result:%@",result);
        if (block) {
            block(result,error);
        }
    }];
}

/**
 通过student_id学员id，获取课程计划签到信息分页(获取请假/缺课列表 共用)
 */
- (void)getVStudentSourseScheduleSignWithParentId:(NSString *)parent_id andStudentId:(NSString *)student_id andCourseId:(NSString *)course_id andSignon:(NSString *)is_signon andSort:(NSString *)sort andOrder:(NSString *)order andPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex andToken:(NSString *)token andBlock:(void(^)(NSDictionary *result,NSError *error))block{
    
    AFHTTPRequestOperation *operation = [WebServiceOpration getVStudentSourseScheduleSignWithParentId:parent_id andStudentId:student_id andCourseId:course_id andSignon:is_signon andSort:sort andOrder:order andPageSize:pageSize andPageIndex:pageIndex andToken:token];
    
    [self getResponseWithOpration:operation andXmlKey:@"GetVStudentSourseScheduleSignResult" andBlock:^(NSString *response, NSDictionary *result, NSError *error) {
        //NSLog(@"result:%@",result);
        if (block) {
            block(result,error);
        }
    }];
}

/**
 请假/家长评论   type取值 0 请假 1评论
 */
- (void)addSubcourseLeaveApplyByParentId:(NSString *)parent_id andRelationId:(NSString *)relation_id andRemark:(NSString *)remark andType:(NSString *)type andApplyId:(NSString *)apply_id andCreateTime:(NSString *)create_time andStatus:(NSString *)status andTeacherId:(NSString *)teacher_id andCheckTime:(NSString *)check_time andCheckRemark:(NSString *)check_remark andToken:(NSString *)token andBlock:(void(^)(NSDictionary *result, NSError *error))block{
    
    AFHTTPRequestOperation *operation = [WebServiceOpration addSubcourseLeaveApplyByParentId:parent_id andRelationId:relation_id andRemark:remark andType:type andApplyId:apply_id andCreateTime:create_time andStatus:status andTeacherId:teacher_id andCheckTime:check_time andCheckRemark:check_remark andToken:token];
    
    [self getResponseWithOpration:operation andXmlKey:@"AddSubcourseLeaveApplyResult" andBlock:^(NSString *response, NSDictionary *result, NSError *error) {
        if (block) {
            block(result,error);
        }
    }];
}


#pragma mark - 活动
- (void)getActivityInfoWithPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex andParentId:(NSString *)parent_id andToken:(NSString *)token andBlock:(void (^)(NSDictionary *result, NSError *error))block {
    
    AFHTTPRequestOperation *operation = [WebServiceOpration getActivityInfoWithPageSize:pageSize andPageIndex:pageIndex andParentId:parent_id andToken:token];
    [self getResponseWithOpration:operation andXmlKey:@"GetActivityInfoResult" andBlock:^(NSString *response, NSDictionary *result, NSError *error) {
        
        if (block) {
            block(result, error);
        }
        
        
    }];
}

/**
 预定活动
 @param parent_id 用户id
 @param activity_id 活动Id
 */
- (void)makeActivityWithParentId:(NSString *)parent_id andActivityId:(NSString *)activity_id andToken:(NSString *)token andBlock:(void (^)(NSDictionary *result, NSError *error))block{
    
    AFHTTPRequestOperation *operation = [WebServiceOpration makeActivityWithParentId:parent_id andActivityId:activity_id andToken:token];
    
    [self getResponseWithOpration:operation andXmlKey:@"MakeActivityResult" andBlock:^(NSString *response, NSDictionary *result, NSError *error) {
        if (block) {
            block(result,error);
        }
    }];
}

/**
 查询所有校区
 */
- (void)getSchoolWithParentId:(NSString *)parent_id andCourseId:(NSString *)course_id andToken:(NSString *)token andBlock:(void(^)(NSDictionary *result,NSError *error))block{
    
    AFHTTPRequestOperation *operation = [WebServiceOpration getSchoolWithParentId :parent_id andCourseId:(NSString *)course_id andToken:(NSString *)token];
    
    [self getResponseWithOpration:operation andXmlKey:@"GetSchoolResult" andBlock:^(NSString *response, NSDictionary *result, NSError *error) {
        //NSLog(@"result:%@",result);
        if (block) {
            block(result,error);
        }
    }];
}

/**
 预定场馆
 */
- (void)AddBookSiteWithKeyId:(NSString *)keyId andRoomId:(NSString *)room_id andAddTime:(NSString *)add_time andParentId:(NSString *)parent_id andSchoolId:(NSString *)school_id andStartTime:(NSString *)start_time andeEndTime:(NSString *)end_time andPersonNum:(NSString *)personNum andArea:(NSString *)area andProjector:(NSString *)projector andTeacher:(NSString *)teacher andActivityContent:(NSString *)activity_content andMemo:(NSString *)memo andToken:(NSString *)token andBlock:(void(^)(NSDictionary *result, NSError *error))block{
    
    AFHTTPRequestOperation *operation = [WebServiceOpration AddBookSiteWithKeyId:keyId andRoomId:room_id andAddTime:add_time andParentId:parent_id andSchoolId:school_id andStartTime:start_time andeEndTime:end_time andPersonNum:personNum andArea:area andProjector:projector andTeacher:teacher andActivityContent:activity_content andMemo:memo andToken:token];
    [self getResponseWithOpration:operation andXmlKey:@"AddBookSiteResult" andBlock:^(NSString *response, NSDictionary *result, NSError *error) {
        if (block) {
            block(result,error);
        }
    }];
}

#pragma mark - 我的

/**
 个人信息修改
 */
- (void)modifyUserWithIsPhotoEdit:(NSString *)is_photo_edit andName:(NSString *)name andSex:(NSString *)sex andBirthday:(NSString *)birthday andIdentifyId:(NSString *)identify_id andMobile:(NSString *)mobile andAddr:(NSString *)addr andQq:(NSString *)qq andEmail:(NSString *)email andMemo:(NSString *)memo andRegionalId:(NSString *)regional_id andMobile2:(NSString *)mobile2 andParentId:(NSString *)parent_id andPhoto:(NSString *)photo andToken:(NSString *)token andBlock:(void(^)(NSDictionary *result, NSError *error))block{
    
    AFHTTPRequestOperation *operation = [WebServiceOpration modifyUserWithIsPhotoEdit:is_photo_edit andName:name andSex:sex andBirthday:birthday andIdentifyId:identify_id andMobile:mobile andAddr:addr andQq:qq andEmail:email andMemo:memo andRegionalId:regional_id andMobile2:mobile2 andParentId:parent_id andPhoto:photo andToken:token];
    
    [self getResponseWithOpration:operation andXmlKey:@"modifyUserResult" andBlock:^(NSString *response, NSDictionary *result, NSError *error) {
        if (block) {
            block(result,error);
        }
    }];
}

/**
 每日登录后签到
 @param parent_id 注册id
 @param platform_type_id  //Android传201,IOS传202
 @param token
 */
- (void)signWithParentId:(NSString *)parent_id andPlatform_type_id:(NSString *)platform_type_id andToken:(NSString *)token andBlock:(void(^)(NSDictionary *result, NSError *error))block{
    
    AFHTTPRequestOperation *operation = [WebServiceOpration signWithParentId:parent_id andPlatform_type_id:platform_type_id andToken:token];
    
    [self getResponseWithOpration:operation andXmlKey:@"SignResult" andBlock:^(NSString *response, NSDictionary *result, NSError *error) {
        if (block) {
            block(result,error);
        }
    }];
    
}


/**
 登录后修改密码
 */
- (void)getMyInfoWithParentId:(NSString *)parent_id andToken:(NSString *)token andBlock:(void(^)(NSDictionary *result, NSError *error))block{
    
    AFHTTPRequestOperation *oparetion = [WebServiceOpration getMyInfoWithParentId:parent_id andToken:token];
    
    [self getResponseWithOpration:oparetion andXmlKey:@"GetMyInfoResult" andBlock:^(NSString *response, NSDictionary *result, NSError *error) {
        if (block) {
            block(result,error);
        }
    }];
}

#pragma mark - 我的 个人信息
/**
 登录后修改密码
 */
- (void)modifyPwdWithNewPassword:(NSString *)newPassword andOldPassword:(NSString *)oldPassword andParentId:(NSString *)parent_id andToken:(NSString *)token andBlock:(void (^)(NSDictionary *result, NSError *error))block{
    
    AFHTTPRequestOperation *operation = [WebServiceOpration modifyPwdWithNewPassword:newPassword andOldPassword:oldPassword andParentId:parent_id andToken:token];
    
    [self getResponseWithOpration:operation andXmlKey:@"modifyPwdResult" andBlock:^(NSString *response, NSDictionary *result, NSError *error) {
        //NSLog(@"result:%@",result);
        if(block){
            block(result,error);
        }
    }];

}
#pragma mark - 我的 我的积分
/**
 我的积分交易记录
 */
- (void)getPointsWithPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex andParentId: (NSString *)parent_id andToken:(NSString *)token andBlock:(void(^)(NSDictionary *result,NSError *error))block{
    AFHTTPRequestOperation *operation = [WebServiceOpration getPointsWithPageSize:pageSize andPageIndex:pageIndex andParentId:parent_id andToken:token];
    [self getResponseWithOpration:operation andXmlKey:@"GetPointsResult" andBlock:^(NSString *response, NSDictionary *result, NSError *error) {
        if (block) {
            block(result,error);
        }
    }];
}

/**
 查询积分策略
 */
- (void)getPointConfigAndBlock:(void(^)(NSDictionary *result,NSError *error))block{
    
    AFHTTPRequestOperation *operation = [WebServiceOpration getPointConfig];
    
    [self getResponseWithOpration:operation andXmlKey:@"GetPointConfigResult" andBlock:^(NSString *response, NSDictionary *result, NSError *error) {
        if (block) {
            block(result,error);
        }
    }];
}

/**
 获取我的积分中所有的礼品
 */
- (void)getGiftAndBlock:(void (^)(NSDictionary *result, NSError *error))block{
    
    AFHTTPRequestOperation *operation = [WebServiceOpration getGift];
    
    [self getResponseWithOpration:operation andXmlKey:@"GetGiftResult" andBlock:^(NSString *response, NSDictionary *result, NSError *error) {
        if (block) {
            block(result,error);
        }
    }];
}

/**
 用积分兑换礼品
 */
- (void)buyGiftWithParentId:(NSString *)parent_id andPlatformTypeId:(NSString *)platform_type_Id andGiftId: (NSString *)gift_id andToken:(NSString *)token andBlock:(void(^)(NSDictionary *result,NSError *error))block{
    
    AFHTTPRequestOperation *operation = [WebServiceOpration buyGiftWithParentId:parent_id andPlatformTypeId:platform_type_Id andGiftId:gift_id andToken:token];
    [self getResponseWithOpration:operation andXmlKey:@"BuyGiftResult" andBlock:^(NSString *response, NSDictionary *result, NSError *error) {
        if (block) {
            block(result,error);
        }
    }];
}

#pragma mark - 我的 我的现金券
/**
 查我的现金卷
 @param parentId 表示当前登录人id
 @param token
 */
- (void)getMyCouponWithParentId: (NSString *)parent_id andToken:(NSString *)token andBlock:(void(^)(NSDictionary *result,NSError *error))block{
    
    AFHTTPRequestOperation *operation = [WebServiceOpration getMyCouponWithParentId:parent_id andToken:token];
    
    [self getResponseWithOpration:operation andXmlKey:@"GetMyCouponResult" andBlock:^(NSString *response, NSDictionary *result, NSError *error) {
        if (block) {
            block(result,error);
        }
    }];
}

#pragma mark - 我的 我的预定

/**
 获取我的预定中的活动
 */
- (void)GetActivityInfoByParentIdWithPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex andParentId:(NSString *)parentId andToken:(NSString *)token andBlock:(void(^)(NSDictionary *result, NSError *error))block{
    
    AFHTTPRequestOperation *operation = [WebServiceOpration GetActivityInfoByParentIdWithPageSize:pageSize andPageIndex:pageIndex andParentId:parentId andToken:token];
    [self getResponseWithOpration:operation andXmlKey:@"GetActivityInfoByParentIdResult" andBlock:^(NSString *response, NSDictionary *result, NSError *error) {
        //NSLog(@"result:%@",result);
        if (block) {
            block(result,error);
        }
    }];
}


/**
 获取我的预定中的场馆
 @param pageSize 一次请求显示多少个活动
 @param pageIndex 当前页码
 @param parentId 表示当前登录人id
 */
- (void)getBookSiteByParent_idWithPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex andParentId: (NSString *)parentId andToken:(NSString *)token andBlock:(void(^)(NSDictionary *result, NSError *error))block{
    
    AFHTTPRequestOperation *operation = [WebServiceOpration getBookSiteByParent_idWithPageSize:pageSize andPageIndex:pageIndex andParentId:parentId andToken:token];
    
    [self getResponseWithOpration:operation andXmlKey:@"GetBookSiteByParentIdResult" andBlock:^(NSString *response, NSDictionary *result, NSError *error) {
        if (block) {
            block(result,error);
        }
    }];
}

#pragma mark - 我的 消费记录
/**
 通过会员id，查询消费订单分页列表
 */
- (void)getVOrderByParentIdWithParentId:(NSString *)parentId andSort:(NSString *)sort andOrder:(NSString *)order andPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex andToken:(NSString *)token andBlock:(void(^)(NSDictionary *result, NSError *error))block{
    
    AFHTTPRequestOperation *operation = [WebServiceOpration getVOrderByParentIdWithParentId:parentId andSort:sort andOrder:order andPageSize:pageSize andPageIndex:pageIndex andToken:token];
    
    [self getResponseWithOpration:operation andXmlKey:@"GetVOrderByParentIdResult" andBlock:^(NSString *response, NSDictionary *result, NSError *error) {
        if (block) {
            block(result,error);
        }
    }];
}

#pragma mark - 我的 城市

/**
 获取城市
 */
- (void)getCityWithBlock:(void(^)(NSDictionary *result, NSError *error))block{
    
    AFHTTPRequestOperation *operation = [WebServiceOpration getCity];
    [self getResponseWithOpration:operation andXmlKey:@"GetCityResult" andBlock:^(NSString *response, NSDictionary *result, NSError *error) {
        //NSLog(@"result:%@",result);
        if (block) {
            block(result,error);
        }
    }];
}


/**
 修改城市
 */
- (void)setCityWithRegionalId:(NSString *)regional_id andParentId:(NSString *)parent_id andToken:(NSString *)token andBlock:(void (^)(NSDictionary *result,NSError *error))block{
    AFHTTPRequestOperation *operation = [WebServiceOpration setCityWithRegionalId:regional_id andParentId:parent_id andToken:token];
    [self getResponseWithOpration:operation andXmlKey:@"SetCityResult" andBlock:^(NSString *response, NSDictionary *result, NSError *error) {
        if (block) {
            block(result,error);
        }
    }];
}

#pragma mark - 我的 更多设置

/**
 分享
 @param:share_content  表示内容
 @param:parent_id      表示当前登录用户的id
 @param:token
 */
- (void)tellFriendWithShareContent:(NSString *)share_content andParentId:(NSString *)parent_id andToken:(NSString *)token andBlock:(void(^)(NSDictionary *result, NSError *error))block{
    
    AFHTTPRequestOperation *operation = [WebServiceOpration tellFriendWithShareContent:share_content andParentId:parent_id andToken:token];
    [self getResponseWithOpration:operation andXmlKey:@"TellFriendResult" andBlock:^(NSString *response, NSDictionary *result, NSError *error) {
        if (block) {
            block(result,error);
        }
    }];
}

/**
 意见反馈
 */
- (void)addFeedbackWithBugInfo:(NSString *)bug_info andParentId:(NSString *)parent_id andToken:(NSString *)token andBolck:(void(^)(NSDictionary *result, NSError *error))block {
    
    AFHTTPRequestOperation *operation = [WebServiceOpration addFeedbackWithBugInfo:bug_info andParentId:parent_id andToken:token];
    [self getResponseWithOpration:operation andXmlKey:@"AddFeedbackResult" andBlock:^(NSString *response, NSDictionary *result, NSError *error) {
        if (block) {
            block(result,error);
        }
    }];
}

@end
