//
//  SettingBirthdayVC.h
//  XEEnglish
//
//  Created by houjing on 15/5/28.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseVC.h"

@protocol SettingBirthdayDelegate <NSObject>

@optional
- (void)ChangeBirthday: (id) sender;

@end

@interface SettingBirthdayVC : BaseVC

@property (nonatomic,assign) id<SettingBirthdayDelegate> delegate;

@end
