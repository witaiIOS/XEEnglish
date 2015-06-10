//
//  LoginVC.h
//  XEEnglish
//
//  Created by MacAir2 on 15/5/23.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseVC.h"

@protocol LoginVCDelegate <NSObject>

- (void)loginVCloginSuccess;

@end

@interface LoginVC : BaseVC

@property (assign, nonatomic) id<LoginVCDelegate>delegate;

@end
