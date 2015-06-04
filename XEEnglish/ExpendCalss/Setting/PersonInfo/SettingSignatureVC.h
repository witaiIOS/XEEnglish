//
//  SettingSignatureVC.h
//  XEEnglish
//
//  Created by houjing on 15/5/29.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseVC.h"

@protocol SettingSignatureDelegate <NSObject>

@optional
- (void)changeSignature:(id)sender;

@end

@interface SettingSignatureVC : BaseVC

@property (nonatomic, strong) id<SettingSignatureDelegate> delegate;

@end
