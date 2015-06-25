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
        NSLog(@"result:%@",result);
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
- (void)getVStudentCourseByParentId:(NSInteger )parent_id andBlock:(void(^)(NSDictionary *result,NSError *error))block{
    AFHTTPRequestOperation *operation = [WebServiceOpration getVStudentCourseByParentId:parent_id];
    
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
- (void)getVStudentSourseScheduleSignWithParentId:(NSString *)parent_id andStudentId:(NSString *)student_id andCourseId:(NSString *)course_id andSignon:(NSString *)is_signon andSort:(NSString *)sort andOrder:(NSString *)order andPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex andBlock:(void(^)(NSDictionary *result,NSError *error))block{
    
    AFHTTPRequestOperation *operation = [WebServiceOpration getVStudentSourseScheduleSignWithParentId:parent_id andStudentId:student_id andCourseId:course_id andSignon:is_signon andSort:sort andOrder:order andPageSize:pageSize andPageIndex:pageIndex];
    
    [self getResponseWithOpration:operation andXmlKey:@"GetVStudentSourseScheduleSignResult" andBlock:^(NSString *response, NSDictionary *result, NSError *error) {
        //NSLog(@"result:%@",result);
        if (block) {
            block(result,error);
        }
    }];
}




#pragma mark - 活动
- (void)getActivityInfoWithPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex andBlock:(void (^)(NSDictionary *result, NSError *error))block {
    
    AFHTTPRequestOperation *operation = [WebServiceOpration getActivityInfoWithPageSize:pageSize andPageIndex:pageIndex];
    [self getResponseWithOpration:operation andXmlKey:@"GetActivityInfoResult" andBlock:^(NSString *response, NSDictionary *result, NSError *error) {
        
        if (block) {
            block(result, error);
        }
        
        
    }];
}

/**
 查询所有校区
 */
- (void)getSchoolWithParentId:(NSString *)parent_id andCourseId:(NSString *)course_id andBlock:(void(^)(NSDictionary *result,NSError *error))block{
    
    AFHTTPRequestOperation *operation = [WebServiceOpration getSchoolWithParentId :parent_id andCourseId:(NSString *)course_id];
    
    [self getResponseWithOpration:operation andXmlKey:@"GetSchoolResult" andBlock:^(NSString *response, NSDictionary *result, NSError *error) {
        //NSLog(@"result:%@",result);
        if (block) {
            block(result,error);
        }
    }];
}

/**
 预定场馆
 @param jsonParam 预定场馆的相关参数组成的JSON
 */
- (void)AddBookSiteWithParameter:(NSString *)jsonParam andBlock:(void(^)(NSDictionary *result,NSError *error))block{
    
    AFHTTPRequestOperation *operation = [WebServiceOpration AddBookSiteWithParameter:jsonParam];
    
    [self getResponseWithOpration:operation andXmlKey:@"AddBookSiteResult" andBlock:^(NSString *response, NSDictionary *result, NSError *error) {
        //NSLog(@"result:%@",result);
        if (block) {
            block(result,error);
        }
    }];
}

#pragma mark - 我的
/**
 登录后修改密码
 */
- (void)modifyPwdWithNewPassword:(NSString *)newPassword andOldPassword:(NSString *)oldPassword andId:(NSInteger )parent_id andBlock:(void (^)(NSDictionary *result, NSError *error))block{
    
    AFHTTPRequestOperation *operation = [WebServiceOpration modifyPwdWithNewPassword:newPassword andOldPassword:oldPassword andId:parent_id];
    
    [self getResponseWithOpration:operation andXmlKey:@"modifyPwdResult" andBlock:^(NSString *response, NSDictionary *result, NSError *error) {
        //NSLog(@"result:%@",result);
        if(block){
            block(result,error);
        }
    }];

}

/**
 获取我的预定中的活动
 */
- (void)GetActivityInfoByParentIdWithPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex andParentId: (NSInteger )parentId andBlock:(void(^)(NSDictionary *result, NSError *error))block{
    
    AFHTTPRequestOperation *operation = [WebServiceOpration GetActivityInfoByParentIdWithPageSize:pageSize andPageIndex:pageIndex andParentId:parentId];
    [self getResponseWithOpration:operation andXmlKey:@"GetActivityInfoByParentIdResult" andBlock:^(NSString *response, NSDictionary *result, NSError *error) {
        //NSLog(@"result:%@",result);
        if (block) {
            block(result,error);
        }
    }];
}

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


@end
