//
//  DepositTimeVC.h
//  XEEnglish
//
//  Created by houjing on 15/8/14.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseVC.h"
@protocol DepositTimeVCDelegate <NSObject>

@optional
- (void)DepositTimeVCSetTime:(id) sender index:(NSString *)index;

@end
@interface DepositTimeVC : BaseVC
@property (strong, nonatomic) NSString *nTitle;
@property (strong, nonatomic) NSString *index;//公共界面，标记更改哪个cell
@property (nonatomic, assign) id<DepositTimeVCDelegate>delegate;
@end
