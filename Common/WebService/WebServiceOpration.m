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

#pragma mark - home
+ (AFHTTPRequestOperation *)getHomePageServiceCategroy
{
    return [WebServiceOpration XeeWebService:@"<ws:getHomePageServiceCategroy/>"];
    
}



+ (AFHTTPRequestOperation *)getHomeAppAdConfigure{
    
    return [WebServiceOpration XeeWebService:@"<ws:getHomeAppAdConfigure/>"];
}


@end
