//
//  CouponsVC.h
//  XEEnglish
//
//  Created by houjing on 15/6/4.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseVC.h"
@protocol CouponsVCCouponsUsedDelegate <NSObject>

@optional
- (void)couponsUsed:(id) sender;

@end


@interface CouponsVC : BaseVC

@property (nonatomic, assign) id<CouponsVCCouponsUsedDelegate>delegate;
@end
