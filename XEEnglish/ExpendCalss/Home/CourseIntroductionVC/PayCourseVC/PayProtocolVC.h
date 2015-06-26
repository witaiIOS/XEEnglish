//
//  PayProtocolVC.h
//  XEEnglish
//
//  Created by houjing on 15/6/24.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseVC.h"
@protocol changeSelectedBtnDelegate <NSObject>

@optional
- (void)changeSelectedBtn:(BOOL)sender;

@end


@interface PayProtocolVC : BaseVC

@property (nonatomic, assign) id<changeSelectedBtnDelegate> delegate;

@end
