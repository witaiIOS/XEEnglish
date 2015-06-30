//
//  ExchangePointsCell.m
//  XEEnglish
//
//  Created by houjing on 15/6/30.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "ExchangePointsCell.h"

@implementation ExchangePointsCell

- (void)layoutSubviews{
    [super layoutSubviews];
    NSLog(@"giftInfoDic:%@",self.giftInfoDic);
    [self.giftImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",XEEimageURLPrefix,self.giftInfoDic[@"pic_url"]]] placeholderImage:[UIImage imageNamed:@"gift-01.png"]];
    
    self.giftName.text = self.giftInfoDic[@"name"];
    
    self.giftNeedPoints.text = self.giftInfoDic[@"price"];
    
}

- (IBAction)exchangePointsBtnClicked:(id)sender {
}
@end
