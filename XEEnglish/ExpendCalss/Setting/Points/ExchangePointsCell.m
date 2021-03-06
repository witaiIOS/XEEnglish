//
//  ExchangePointsCell.m
//  XEEnglish
//
//  Created by houjing on 15/6/30.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "ExchangePointsCell.h"
#import "XeeService.h"


@implementation ExchangePointsCell

- (void)layoutSubviews{
    [super layoutSubviews];
    //NSLog(@"giftInfoDic:%@",self.giftInfoDic);
    [self.giftImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",XEEimageURLPrefix,self.giftInfoDic[@"pic_url"]]] placeholderImage:[UIImage imageNamed:@"image_loading.png"]];
    
    self.giftName.text = self.giftInfoDic[@"name"];
    
    self.giftNeedPoints.text = [NSString stringWithFormat:@"%@积分",self.giftInfoDic[@"price"]];
    
    self.giftDeadLine.text = [NSString stringWithFormat:@"%@过期",self.giftInfoDic[@"deadline"]];
    
    self.giftMemo.text = self.giftInfoDic[@"memo"];
    
}

- (IBAction)exchangePointsBtnClicked:(id)sender {
    
    //[self buyGift];
    [self.delegate ExchangePointsCellBuyGift:self.giftInfoDic];
}

//#pragma mark - Web
//
//- (void)buyGift{
//    
//    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
//    NSDictionary *userInfoDic = userDic[uUserInfoKey];
//    
//    [[XeeService sharedInstance] buyGiftWithParentId:userInfoDic[uUserId] andPlatformTypeId:@"202" andGiftId:self.giftInfoDic[@"id"] andToken:userInfoDic[uUserToken] andBlock:^(NSDictionary *result, NSError *error) {
//        if (!error) {
//            //NSLog(@"result:%@",result);
//            NSNumber *isResult = result[@"result"];
//            if (isResult.integerValue == 0) {
//                [UIFactory showAlert:result[@"resultInfo"]];
//            }
//            else{
//                [UIFactory showAlert:result[@"resultInfo"]];
//            }
//        }
//        else{
//            [UIFactory showAlert:@"网络错误"];
//        }
//    }];
//    
//}

@end
