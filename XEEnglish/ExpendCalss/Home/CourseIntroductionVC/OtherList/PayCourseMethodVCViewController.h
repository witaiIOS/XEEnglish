//
//  PayCourseMethodVCViewController.h
//  XEEnglish
//
//  Created by houjing on 15/6/25.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseVC.h"
@protocol SelectedPayCourseMethodDelegate <NSObject>

@optional
- (void)selectedPayCourseMethod:(id) sender;

@end
@interface PayCourseMethodVCViewController : BaseVC
@property (nonatomic, strong) NSString *selectedMethod;//选择购买课程方式的标记
@property (nonatomic, assign) id<SelectedPayCourseMethodDelegate>delegate;
@end
