//
//  DepositStypeVC.h
//  XEEnglish
//
//  Created by houjing on 15/8/13.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseVC.h"
@protocol DepositStypeVCDelegate <NSObject>

@optional
- (void)DepositStypeVCSelectedDepositStype:(id) sender;

@end
@interface DepositStypeVC : BaseVC
@property (nonatomic, strong) NSString *selectedStype;

@property (nonatomic, assign) id<DepositStypeVCDelegate>delegate;
@end
