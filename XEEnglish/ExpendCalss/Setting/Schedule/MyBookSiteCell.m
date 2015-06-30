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
    
    self.bookSiteState.text = @"预约成功";
    self.bookSiteSchollZone.text = self.bookSiteInfoDic[@"school_name"];
    self.bookSiteStateTime.text = self.bookSiteInfoDic[@"start_time"];
    self.bookSiteEndTime.text = self.bookSiteInfoDic[@"end_time"];
    self.bookSiteProjectorImageview.image = [UIImage imageNamed: [self.bookSiteInfoDic[@"use_projector"] isEqualToString:@"1"]?@"chekbox_select.png":@"chekbox.png"];
    self.bookSiteTeacherImageView.image = [UIImage imageNamed: [self.bookSiteInfoDic[@"teacher"] isEqualToString:@"1"]?@"chekbox_select.png":@"chekbox.png"];
}

@end
