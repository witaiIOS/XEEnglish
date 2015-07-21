//
//  ExchangePointsCell.h
//  XEEnglish
//
//  Created by houjing on 15/6/30.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseTVC.h"

@protocol ExchangePointsCellDelegate <NSObject>

- (void)ExchangePointsCellBuyGift:(id)sender;

@end

@interface ExchangePointsCell : BaseTVC

@property (nonatomic, strong) NSDictionary *giftInfoDic;

@property (weak, nonatomic) IBOutlet UIImageView *giftImageView;
@property (weak, nonatomic) IBOutlet UILabel *giftName;
@property (weak, nonatomic) IBOutlet UILabel *giftNeedPoints;
@property (weak, nonatomic) IBOutlet UILabel *giftDeadLine;//过期时间
@property (weak, nonatomic) IBOutlet UILabel *giftMemo;//补充说明

@property (nonatomic, assign) id<ExchangePointsCellDelegate>delegate;

- (IBAction)exchangePointsBtnClicked:(id)sender;


@end
