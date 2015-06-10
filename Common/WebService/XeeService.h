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

#pragma mark - 活动
/**
 获取当前活动信息
 @param pageSize 一次请求显示多少个活动
 @param pageIndex 当前页码
 @param block  (result 解析出来的结果, error 请求的错误信息)
 */
- (void)getActivityInfoWithPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex andBlock:(void (^)(NSDictionary *result, NSError *error))block;

#pragma mark - 我的
/**
 登录后修改密码
 @param newPassword 新密码
 @param oldPassword 旧密码
 @param parent_id 旧密码
 */
- (void)modifyPwdWithNewPassword:(NSString *)newPassword andOldPassword:(NSString *)oldPassword andId:(NSInteger )parent_id andBlock:(void (^)(NSDictionary *result, NSError *error))block;


@end
