//
//  PointsRecordCell.h
//  XEEnglish
//
//  Created by houjing on 15/6/30.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseTVC.h"

@interface PointsRecordCell : BaseTVC

@property (nonatomic, strong) NSDictionary *pointRecordInfoDic;

@property (weak, nonatomic) IBOutlet UILabel *pointstate;//交易状态
@property (weak, nonatomic) IBOutlet UILabel *pointExchangeType;//交易类型
@property (weak, nonatomic) IBOutlet UILabel *pointRemainder;//剩余积分
@property (weak, nonatomic) IBOutlet UILabel *pointExchange;//交易积分
@property (weak, nonatomic) IBOutlet UILabel *pointExchangeTime;//交易时间

@end
