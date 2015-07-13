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
    
    NSLog(@"schoolInfoDic:%@",self.schoolInfoDic);
    
    self.schoolNameLabel.text = self.schoolInfoDic[@"department"];
    //NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    //NSNumber *dictence = self.schoolInfoDic[@"distance"];
    NSString *dictence = self.schoolInfoDic[@"distance"];
    self.schoolDistanceLabel.text = [NSString stringWithFormat:@"%.2fkm",[dictence floatValue]];
    [self.schoolImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",XEEimageURLPrefix,self.schoolInfoDic[@"pic_url"]]] placeholderImage:[UIImage imageNamed:@"image_loading.png"]];
    self.schoolAddresslabel.text = [NSString stringWithFormat:@"校区地址：%@",self.schoolInfoDic[@"addr"]];
    //self.schoolAddresslabel.numberOfLines = 0;
    
    
}

- (IBAction)schoolPhoneBtn:(id)sender {
    
    [self.delegate TakePhoneBtnClicked:self.schoolInfoDic[@"mobile"]];
}
@end
