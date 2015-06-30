//
//  ExchangePointsCell.h
//  XEEnglish
//
//  Created by houjing on 15/6/30.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseTVC.h"

@interface ExchangePointsCell : BaseTVC

@property (nonatomic, strong) NSDictionary *giftInfoDic;

@property (weak, nonatomic) IBOutlet UIImageView *giftImageView;
@property (weak, nonatomic) IBOutlet UILabel *giftName;
@property (weak, nonatomic) IBOutlet UILabel *giftNeedPoints;

- (IBAction)exchangePointsBtnClicked:(id)sender;


@end
