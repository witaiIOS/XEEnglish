//
//  CouponsCell.h
//  XEEnglish
//
//  Created by houjing on 15/6/4.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseTVC.h"

@interface CouponsCell : BaseTVC
@property (weak, nonatomic) IBOutlet UIButton *iconButton;
@property (nonatomic, strong) NSDictionary *couponsInfoDic;
@property (weak, nonatomic) IBOutlet UILabel *couponsStatus;
@property (weak, nonatomic) IBOutlet UILabel *couponsDescription;
@property (weak, nonatomic) IBOutlet UILabel *couponsEndTime;

@end
