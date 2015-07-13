//
//  NearSchoolCell.h
//  XEEnglish
//
//  Created by houjing on 15/7/13.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseTVC.h"

@protocol NearSchoolCellTakePhoneDelegate <NSObject>

@optional
- (void)TakePhoneBtnClicked:(id) sender;

@end

@interface NearSchoolCell : BaseTVC

@property (nonatomic, strong) NSDictionary *schoolInfoDic;//学校信息


@property (weak, nonatomic) IBOutlet UILabel *schoolNameLabel;//校区名
@property (weak, nonatomic) IBOutlet UILabel *schoolDistanceLabel;//学校距离
@property (weak, nonatomic) IBOutlet UIImageView *schoolImageView;//校区图片
@property (weak, nonatomic) IBOutlet UILabel *schoolAddresslabel;//学校地址

@property (nonatomic, assign) id<NearSchoolCellTakePhoneDelegate>delegate;//电话delegate


- (IBAction)schoolPhoneBtn:(id)sender;



@end
