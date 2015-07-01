//
//  ApplyProtocolVC.h
//  XEEnglish
//
//  Created by houjing on 15/7/1.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseVC.h"
@protocol ApplyProtocolChangeSelectedBtnDelegate <NSObject>

@optional
- (void)changeSelectedBtn:(BOOL)sender;

@end

@interface ApplyProtocolVC : BaseVC
@property (nonatomic, assign) id<ApplyProtocolChangeSelectedBtnDelegate> delegate;
@end
