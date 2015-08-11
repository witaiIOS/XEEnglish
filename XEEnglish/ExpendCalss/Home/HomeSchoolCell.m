//
//  HomeSchoolCell.m
//  XEEnglish
//
//  Created by houjing on 15/8/11.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "HomeSchoolCell.h"

@implementation HomeSchoolCell

- (void)layoutSubviews{
    
    [super layoutSubviews];
    //获取校区图片
    [self.schoolImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",XEEimageURLPrefix,self.schoolInfoDic[@"pic_url"]]] placeholderImage:[UIImage imageNamed:@"image_loading.png"]];
    //获取校区名字
    self.schoolNameLabel.text = self.schoolInfoDic[@"department"];
    //获取校区电话
    self.schoolPhoneLabel.text = [NSString stringWithFormat:@"校区电话：%@",self.schoolInfoDic[@"mobile"]];
    //获取校区地址
    self.schoolAddresslabel.text = self.schoolInfoDic[@"addr"];
    //获取校区距离
    NSString *dictence = self.schoolInfoDic[@"distance"];
    self.schoolDistanceLabel.text = [NSString stringWithFormat:@"%.2fkm",[dictence floatValue]];
}

@end
