//
//  CouponsVC.h
//  XEEnglish
//
//  Created by houjing on 15/6/4.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#define SuperViewIsBuyView  1
#define SuperViewIsSettingVC 0


#import "BaseVC.h"
@protocol CouponsVCCouponsUsedDelegate <NSObject>

@optional
- (void)couponsUsed:(id) sender andCouponsArray:(NSMutableArray *)couponsArray;

@end


@interface CouponsVC : BaseVC
@property (nonatomic, assign) NSInteger superView;

@property (nonatomic, assign) NSInteger coursePrice;
@property (nonatomic, assign) id<CouponsVCCouponsUsedDelegate>delegate;
@end
