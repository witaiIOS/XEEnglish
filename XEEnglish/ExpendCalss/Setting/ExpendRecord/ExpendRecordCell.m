//
//  ExpendRecordCell.m
//  XEEnglish
//
//  Created by houjing on 15/7/2.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "ExpendRecordCell.h"

@implementation ExpendRecordCell

- (void)layoutSubviews{
    
    self.expendRecordStatue.text = [self getStatus:self.expendRecordInfoDic[@"order_statue"]];
    self.expendRecordName.text = self.expendRecordInfoDic[@"name"];
    self.expendRecordPhone.text = self.expendRecordInfoDic[@"mobile"];
    self.expendRecordCourseName.text = self.expendRecordInfoDic[@"title"];
    self.expendRecordCreateTime.text = self.expendRecordInfoDic[@"order_datetime"];
    //NSLog(@"info:%@",self.expendRecordInfoDic);
    self.expendRecordCourseHours.text = [NSString stringWithFormat:@"%@",self.expendRecordInfoDic[@"numbers"]];
    self.expendRecordCoursePrice.text = [NSString stringWithFormat:@"%@",self.expendRecordInfoDic[@"total_price"]];
    
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
