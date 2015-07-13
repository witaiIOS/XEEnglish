//
//  NearSchoolCell.m
//  XEEnglish
//
//  Created by houjing on 15/7/13.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "NearSchoolCell.h"

@implementation NearSchoolCell

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.schoolNameLabel.text = self.schoolInfoDic[@"department"];
    self.schoolDistanceLabel.text = [NSString stringWithFormat:@"%@km",self.schoolInfoDic[@"distance"]];
    [self.schoolImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",XEEimageURLPrefix,self.schoolInfoDic[@"pic_url"]]] placeholderImage:[UIImage imageNamed:@"image_loading.png"]];
    self.schoolAddresslabel.text = [NSString stringWithFormat:@"校区地址：%@",self.schoolInfoDic[@"addr"]];
    //self.schoolAddresslabel.numberOfLines = 0;
    
    
}

- (IBAction)schoolPhoneBtn:(id)sender {
    
    [self.delegate TakePhoneBtnClicked:self.schoolInfoDic[@"mobile"]];
}
@end
