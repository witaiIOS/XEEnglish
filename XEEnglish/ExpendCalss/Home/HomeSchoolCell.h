//
//  HomeSchoolCell.h
//  XEEnglish
//
//  Created by houjing on 15/8/11.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseTVC.h"

@interface HomeSchoolCell : BaseTVC

@property (nonatomic, strong) NSDictionary *schoolInfoDic;//学校信息

@property (weak, nonatomic) IBOutlet UIImageView *schoolImageView;//学校图片
@property (weak, nonatomic) IBOutlet UILabel *schoolNameLabel;//校区名字
@property (weak, nonatomic) IBOutlet UILabel *schoolPhoneLabel;//校区电话

@property (weak, nonatomic) IBOutlet UILabel *schoolAddresslabel;//校区地址
@property (weak, nonatomic) IBOutlet UILabel *schoolDetailInfoLabel;//详细信息/众筹
@property (weak, nonatomic) IBOutlet UILabel *schoolDistanceLabel;//距离


@end
