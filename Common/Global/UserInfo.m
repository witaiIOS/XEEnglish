//
//  UserInfo.m
//  XEEnglish
//
//  Created by MacAir2 on 15/6/10.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "UserInfo.h"
#import "AppCore.h"

@implementation UserInfo

+ (UserInfo *)sharedUser{
    
    static UserInfo *sharedUserInfo = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedUserInfo = [[self alloc] init];
    });
    return sharedUserInfo;
}

- (void)firstInitUserInfoDic {//仅AppDelegate didFinishLaunchingWithOptions 中用到
    NSDictionary *userDic = [self getUserInfoDic];
    if (!userDic) {
        [self initUserInfoDic];
        NSLog(@"userDic ready");
    }

}

- (void)initUserInfoDic{
    
    NSDictionary *userDic = @{uIslogin:[NSNumber numberWithInt:1], uUserInfoKey:@{}};
    [self setUserInfoDic:userDic];
        
}


- (NSDictionary *)getUserInfoDic {
    return [[NSUserDefaults standardUserDefaults] dictionaryForKey:UserInfoGlobalKey];
}

- (void)setUserInfoDic:(NSDictionary *)userInfoDic {
    [[NSUserDefaults standardUserDefaults] setValue:userInfoDic forKey:UserInfoGlobalKey];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

- (void)setUserInfoDicWithWebServiceResult:(NSDictionary *)result {
    NSDictionary *resultInfo = result[@"resultInfo"];
    NSDictionary *userDic = @{uIslogin:result[@"result"], uUserInfoKey:@{uUserName:resultInfo[@"name"], uPhoneNumber:resultInfo[@"mobile"], uPassword:resultInfo[@"password"]}};
    [self setUserInfoDic:userDic];
}




@end