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

+ (AFHTTPRequestOperation *)XEEWebService:(NSString *)body;

///获取验证码
+ (AFHTTPRequestOperation *)checkPhoneWithJson:(NSString *)phoneNumber;

//验证发送来的验证码
+ (AFHTTPRequestOperation *)checkCodeWithPhoneNumber:(NSString *)phoneNumber andCode:(NSString *)code;

@end
