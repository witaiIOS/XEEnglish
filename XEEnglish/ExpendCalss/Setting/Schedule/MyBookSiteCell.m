//
//  MyBookSiteCell.m
//  XEEnglish
//
//  Created by houjing on 15/6/29.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "MyBookSiteCell.h"

@implementation MyBookSiteCell

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //NSLog(@"info:%@",self.bookSiteInfoDic);
    //审核状态0待审核1审核通过-1审核不通过
    NSString *statusStr = [NSString stringWithFormat:@"%@",self.bookSiteInfoDic[@"exam_status"]];
    self.bookSiteState.text = [self getStatus:statusStr];
    self.bookSiteSchollZone.text = self.bookSiteInfoDic[@"school_name"];
    self.bookSiteStateTime.text = self.bookSiteInfoDic[@"start_time"];
    self.bookSiteEndTime.text = self.bookSiteInfoDic[@"end_time"];
    self.bookSiteProjectorImageview.image = [UIImage imageNamed: [self.bookSiteInfoDic[@"use_projector"] isEqualToString:@"1"]?@"chekbox_select.png":@"chekbox.png"];
    self.bookSiteTeacherImageView.image = [UIImage imageNamed: [self.bookSiteInfoDic[@"teacher"] isEqualToString:@"1"]?@"chekbox_select.png":@"chekbox.png"];
}
//审核状态0待审核1审核通过-1审核不通过
//状态类型转换可读性
- (NSString *)getStatus:(NSString *)statusStr{
    
    if ([statusStr intValue] == 0) {
        return @"待审核";
    }
    else if([statusStr intValue] == 1){
        self.bookSiteState.textColor = [UIColor blueColor];
        return @"审核通过";
    }
    else if([statusStr intValue] == 1){
        self.bookSiteState.textColor = [UIColor redColor];
        return @"审核不通过";
    }
    else{
        return @"";
    }
    
}

@end
