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
    
    
    NSString *requestURL = [[NSString alloc]initWithData:postbody encoding:NSUTF8StringEncoding];
    NSLog(@"requestURL:%@",requestURL);
    
    AFHTTPRequestOperation *opration = [[AFHTTPRequestOperation alloc] initWithRequest:req];
    return opration;
}

#pragma mark - 登陆相关

+ (AFHTTPRequestOperation *)checkPhoneWithPhoneNumber:(NSString *)phoneNumber andSign:(NSString *)sign {
    return [self XEEWebService:[NSString stringWithFormat:@"<web:checkPhone><web:json>{\"mobile\":\"%@\",\"sign\":\"%@\"}</web:json></web:checkPhone>", phoneNumber, sign]];
}

+ (AFHTTPRequestOperation *)checkCodeWithPhoneNumber:(NSString *)phoneNumber andCode:(NSString *)code andSign:(NSString *)sign {
    return [self XEEWebService:[NSString stringWithFormat:@" <web:checkCode><web:json>{\"sign\":%@,\"mobile\":\"%@\",\"code\":\"%@\"}</web:json></web:checkCode>", sign, phoneNumber, code]];
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

#pragma mark - 活动
+ (AFHTTPRequestOperation *)getActivityInfoWithPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex {
    
    return [self XEEWebService:[NSString stringWithFormat:@"<web:GetActivityInfo><web:pageSize>%li</web:pageSize><web:pageIndex>%li</web:pageIndex></web:GetActivityInfo>", (long)pageSize, (long)pageIndex]];
}

#pragma mark - 我的
/**
 登录后修改密码
 */
+ (AFHTTPRequestOperation *)modifyPwdWithNewPassword:(NSString *)newPassword andOldPassword:(NSString *)oldPassword andId:(NSInteger )parent_id{
    
    return [self XEEWebService:[NSString stringWithFormat:@"<web:modifyPwd><web:json>{\"password\":\"%@\",\"old_password\":\"%@\",\"parent_id\":\"%li\"}</web:json></web:modifyPwd>",newPassword,oldPassword,(long)parent_id]];
}

/**
 获取我的预定中的活动
 */
+ (AFHTTPRequestOperation *)GetActivityInfoByParentIdWithPageSize:(NSInteger )pageSize andPageIndex:(NSInteger )pageIndex andParentId: (NSInteger )parentId{
    return [self XEEWebService:[NSString stringWithFormat:@"<web:GetActivityInfoByParentId><web:pageSize>%li</web:pageSize><web:pageIndex>%li</web:pageIndex><web:parentId>%li</web:parentId></web:GetActivityInfoByParentId>",pageSize,pageIndex,parentId]];
}

@end
