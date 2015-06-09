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
/**
 得到请求返回的结果
 @param opration 请求的操作
 @param xmlKey  xml解析的关键字段
 @param block  (response 返回的xml, result 解析出来的结果, error 请求的错误信息)
 */
- (void)getResponseWithOpration:(AFHTTPRequestOperation *)opration andXmlKey:(NSString *)xmlKey andBlock:(void (^)(NSString *response, NSDictionary *result, NSError *error))block;

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

@end
