//
//  ExpendRecordCell.h
//  XEEnglish
//
//  Created by houjing on 15/7/2.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseTVC.h"

@protocol ExpendRecordCellDelegate <NSObject>

- (void)expendRecordCellCannelBtnPressed:(id)sender;
- (void)expendRecordCellPayBtnClicked;

@end

@interface ExpendRecordCell : BaseTVC
@property (nonatomic, strong) NSDictionary *expendRecordInfoDic;
@property (weak, nonatomic) IBOutlet UILabel *expendRecordStatue;//订单状态
@property (weak, nonatomic) IBOutlet UILabel *expendRecordName;//用户昵称
@property (weak, nonatomic) IBOutlet UILabel *expendRecordPhone;//用户账号

@property (weak, nonatomic) IBOutlet UILabel *expendRecordTradeNo;//订单号*

@property (weak, nonatomic) IBOutlet UILabel *expendRecordCourseName;//课程名

@property (weak, nonatomic) IBOutlet UILabel *expendRecordTradeType;//订单类型*

@property (weak, nonatomic) IBOutlet UILabel *expendRecordCreateTime;//订单时间

@property (weak, nonatomic) IBOutlet UILabel *expendRecordPayType;//购买详情*，是整套还是课时

@property (weak, nonatomic) IBOutlet UILabel *expendRecordCoursePrice;//费用

@property (weak, nonatomic) IBOutlet UILabel *expendRecordCoupons;//使用现金券情况***

@property (weak, nonatomic) IBOutlet UILabel *expendRecordPayMode;//支付平台***
@property (weak, nonatomic) IBOutlet UIButton *cannelBtn;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;


@property (nonatomic, assign) id<ExpendRecordCellDelegate>delegate;



@end
