//
//  PointsRecordCell.m
//  XEEnglish
//
//  Created by houjing on 15/6/30.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "PointsRecordCell.h"

@implementation PointsRecordCell

- (void)layoutSubviews{
    
    [super layoutSubviews];
    //NSLog(@"info:%@",self.pointRecordInfoDic);
    
    self.pointExchange.text = self.pointRecordInfoDic[@"audit_statue_cn"];
    self.pointExchangeType.text = self.pointRecordInfoDic[@"trade_type_cn"];
    self.pointRemainder.text = self.pointRecordInfoDic[@"remainder"];
    self.pointExchange.text = self.pointRecordInfoDic[@"number"];
    self.pointExchangeTime.text = self.pointRecordInfoDic[@"operate_time"];
    
}

@end
