//
//  RegisterVC.h
//  XEEnglish
//
//  Created by houjing on 15/6/9.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseVC.h"

@protocol RegisterVCDelegate <NSObject>

- (void)registerSuccessWithPhoneNumber:(NSString *)phoneNumber andPassword:(NSString *)password;

@end

@interface RegisterVC : BaseVC

@property (assign, nonatomic) id<RegisterVCDelegate>delegate;

@property (strong, nonatomic) NSString *phoneNumber;

@end
