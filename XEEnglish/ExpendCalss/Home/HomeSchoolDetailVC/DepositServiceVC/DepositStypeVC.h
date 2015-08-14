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
- (void)DepositStypeVCSelectedDepositStype:(id) sender index:(NSString *)index;

@end
@interface DepositStypeVC : BaseVC
@property (strong, nonatomic) NSString *nTitle;
@property (strong, nonatomic) NSString *index;//公共界面，标记更改哪个cell

@property (nonatomic, strong) NSString *selectedStype;

@property (nonatomic, assign) id<DepositStypeVCDelegate>delegate;
@end
