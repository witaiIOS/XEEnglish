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
 验证发送来的验证码
 @param phoneNumber 手机号
 @param name  用户名
 @param password 密码
 @param invitation_code  推荐码
 */
+ (AFHTTPRequestOperation *)registerWithPhoneNumber:(NSString *)phoneNumber andName:(NSString *)name andPassword:(NSString *)password andInvitation_code:(NSString *)invitation_code;

#pragma mark - 活动
/**
 获取当前活动信息
 @param pageSize 一次请求显示多少个活动
 @param pageIndex 当前页码
 */
+ (AFHTTPRequestOperation *)getActivityInfoWithPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex;


@end
