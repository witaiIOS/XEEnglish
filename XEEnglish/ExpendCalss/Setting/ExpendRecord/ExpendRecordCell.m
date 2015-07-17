//
//  ExpendRecordCell.m
//  XEEnglish
//
//  Created by houjing on 15/7/2.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "ExpendRecordCell.h"

@implementation ExpendRecordCell

- (void)layoutSubviews{
    
    self.expendRecordStatue.text = [self getStatus:self.expendRecordInfoDic[@"order_statue"]];
    self.expendRecordName.text = self.expendRecordInfoDic[@"name"];
    self.expendRecordPhone.text = self.expendRecordInfoDic[@"mobile"];
    self.expendRecordTradeNo.text = self.expendRecordInfoDic[@"out_trade_no"];
    self.expendRecordCourseName.text = self.expendRecordInfoDic[@"title"];
    
    //订单类型  type取值1选课类型2免费试听3有偿授课。
    NSString *tradeTypeStr = [NSString stringWithFormat:@"%@",self.expendRecordInfoDic[@"type"]];
    self.expendRecordTradeType.text = [self getTradeType:tradeTypeStr];
    
    self.expendRecordCreateTime.text = self.expendRecordInfoDic[@"order_datetime"];
    //NSLog(@"info:%@",self.expendRecordInfoDic);
    
    //购买详情，显示按套还是课时购买
    NSString *payTypeStr = [NSString stringWithFormat:@"%@",self.expendRecordInfoDic[@"pay_type"]];
    self.expendRecordPayType.text = [self getPayType:payTypeStr];
    
    self.expendRecordCoursePrice.text = [NSString stringWithFormat:@"%@",self.expendRecordInfoDic[@"order_price"]];
    
    //现金券
    NSMutableArray *couponsArray = self.expendRecordInfoDic[@"listCoupon"];
    self.expendRecordCoupons.text = [self getCoupons:couponsArray];
    
//    id payMode = self.expendRecordInfoDic[@"pay_mode"];
//    if (payMode == [NSNull class]) {
//        self.expendRecordPayMode.text = @"还未支付";
//    }
//    else{
//        self.expendRecordPayMode.text = [self getPayMode:(int)payMode];
//    }
    NSString *payMode = [NSString stringWithFormat:@"%@",self.expendRecordInfoDic[@"pay_mode"]];
    if ([payMode isEqual:@"<null>"]) {
        self.expendRecordPayMode.text = @"还未支付";
    }
    else{
        self.expendRecordPayMode.text = [self getPayMode:payMode.intValue];
    }
    
//    self.expendRecordPayMode.text = [NSString stringWithFormat:@"%@",self.expendRecordInfoDic[@"pay_mode"]];
    
}
//状态转换可读性
- (NSString *)getStatus:(NSNumber *)statusNum{
    
    NSString *statusStr = nil;
    
    if (statusNum.integerValue == 0) {
        statusStr = @"未审核";
    }
    else if (statusNum.integerValue == 1){
        statusStr = @"审核通过";
    }
    else if (statusNum.integerValue == -1){
        statusStr = @"审核不通过";
    }
    else{
        
    }
    return statusStr;
}

//type取值1选课类型2免费试听3有偿授课
//订单类型转换可读性
- (NSString *)getTradeType:(NSString *)tradeTypeStr{
    
    if ([tradeTypeStr intValue] == 1) {
        return @"购买课程";
    }
    else if([tradeTypeStr intValue] == 3){
        return @"有偿试听";
    }
    else{
        return @"";
    }
    
}

//pay_type 取值 1课时2整套
//购买详情转换可读性
- (NSString *)getPayType:(NSString *)payTypeStr{
    
    NSNumber *number = self.expendRecordInfoDic[@"numbers"];
    
    if ([payTypeStr intValue] == 1) {
        return [NSString stringWithFormat:@"购买%li课时",(long)number.integerValue];
    }
    else if([payTypeStr intValue] == 2){
        return @"购买整套";
    }
    else{
        return @"";
    }
    
}

//现金券转换可读性
- (NSString *)getCoupons:(NSMutableArray *)couponArray{
    
    if ([couponArray count] == 0) {
        return @"无";
    }
    else{
        NSInteger couponTotalPrice = 0;
        for (int i=0; i<couponArray.count; i++) {
            NSDictionary *couponDic = couponArray[i];
            NSNumber *price = couponDic[@"price"];
            couponTotalPrice = couponTotalPrice + price.integerValue;
        }
        return [NSString stringWithFormat:@"现金券%li张，总价值%li元",couponArray.count,couponTotalPrice];
    }
    
}

//pay_mode 取值 0免费 1 现金2 信用卡3 储蓄卡4 支付宝5 微信支付
//支付平台转换可读性
- (NSString *)getPayMode:(NSInteger)payMode{
    
    if (payMode == 1) {
        return @"现金支付";
    }
    else if(payMode == 2){
        return @"信用卡支付";
    }
    else if(payMode == 3){
        return @"储蓄卡支付";
    }
    else if(payMode == 4){
        return @"支付宝支付";
    }
    else if(payMode == 5){
        return @"微信支付";
    }
    else{
        return @"";
    }
    
}

@end
