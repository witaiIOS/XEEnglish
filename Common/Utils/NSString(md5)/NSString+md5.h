//
//  NSString+md5.h
//  XEEnglish
//
//  Created by MacAir2 on 15/7/1.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import <Foundation/Foundation.h>
//密码加密
#import <CommonCrypto/CommonDigest.h>

@interface NSString (md5)

+ (NSString *)md5:(NSString *)str;

@end
