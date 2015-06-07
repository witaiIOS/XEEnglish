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
        NSLog(@"%@",dic);
        
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
        NSLog(@"%@",dic);
        
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


///////////////////////////////////
- (void)checkPhoneWithPhoneNumber:(NSString *)phoneNumber andBlock:(void (^)(NSDictionary *result, NSError *error))block {
    AFHTTPRequestOperation *operation = [WebServiceOpration checkPhoneWithJson:phoneNumber];
    [operation start];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *responseStr = operation.responseString;
        //NSLog(@"responseStr:%@",responseStr);
        
        [[MyParser sharedInstance] parserWithContent:responseStr andKey:@"checkPhoneResult"];
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[[MyParser sharedInstance].results dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dic);
        
        if (block) {
            block(dic, nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (block) {
            block(nil, error);
        }

    }];
}

@end
