//
//  UserInfo.h
//  XEEnglish
//
//  Created by MacAir2 on 15/6/10.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UserInfo : NSObject

+ (UserInfo *)sharedUser;

- (BOOL)isLogin;

- (void)firstInitUserInfoDic;

- (void)initUserInfoDic;

- (NSDictionary *)getUserInfoDic;

- (void)setUserInfoDic:(NSDictionary *)userInfoDic;

- (void)setUserInfoDicWithWebServiceResult:(NSDictionary *)result;

///过滤NULL
- (NSDictionary *)filterNullForDictionary:(NSDictionary *)dic;

@end
