//
//  MyCourseCell.m
//  XEEnglish
//
//  Created by houjing on 15/7/17.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "MyCourseCell.h"

@implementation MyCourseCell

- (void)layoutSubviews{
    
    NSLog(@"info:%@",self.myCourseInfoDic);
    
    self.myCourseStatue.text = [self getStatus:self.myCourseInfoDic[@"order_statue"]];
    self.myCourseUserName.text = self.myCourseInfoDic[@"name"];
    self.myCourseUserPhone.text = self.myCourseInfoDic[@"mobile"];
    self.myCourseCourseName.text = self.myCourseInfoDic[@"title"];
    self.myCourseCreateTime.text = self.myCourseInfoDic[@"order_datetime"];
    //NSLog(@"info:%@",self.expendRecordInfoDic);
    self.myCourseTradeNO.text = [NSString stringWithFormat:@"%@",self.myCourseInfoDic[@"out_trade_no"]];  
}

- (NSString *)getStatus:(NSNumber *)statusNum{
    
    NSString *statusStr = nil;
    
    if (statusNum.integerValue == 0) {
        statusStr = @"未审核";
    }
    else if (statusNum.integerValue == 1){
        statusStr = @"审核通过";
    }
    else if (statusNum.integerValue == -1){
        statusStr = @"审核不通过";
    }
    else{
        
    }
    return statusStr;
}

@end
