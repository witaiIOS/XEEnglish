//
//  PhoneLoginVC.h
//  XEEnglish
//
//  Created by houjing on 15/5/25.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseVC.h"

@protocol PhoneLoginVCDelegate <NSObject>

- (void)phoneLoginRegisterSuccessWithPhoneNumber:(NSString *)phoneNumber andPassword:(NSString *)password;

@end

@interface PhoneLoginVC : BaseVC

@property (assign, nonatomic) id<PhoneLoginVCDelegate>delegate;

@end
