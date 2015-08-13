//
//  DepositTimeVC.h
//  XEEnglish
//
//  Created by houjing on 15/8/13.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseVC.h"
@protocol DepositTimeVCDelegate <NSObject>

@optional
- (void)DepositTimeVCSetTime:(id) sender;

@end
@interface DepositTimeVC : BaseVC
@property (nonatomic, assign) id<DepositTimeVCDelegate>delegate;
@end
