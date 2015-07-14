//
//  ExpendRecordCell.h
//  XEEnglish
//
//  Created by houjing on 15/7/2.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseTVC.h"

@interface ExpendRecordCell : BaseTVC
@property (nonatomic, strong) NSDictionary *expendRecordInfoDic;
@property (weak, nonatomic) IBOutlet UILabel *expendRecordStatue;
@property (weak, nonatomic) IBOutlet UILabel *expendRecordName;
@property (weak, nonatomic) IBOutlet UILabel *expendRecordPhone;
@property (weak, nonatomic) IBOutlet UILabel *expendRecordCourseName;
@property (weak, nonatomic) IBOutlet UILabel *expendRecordCreateTime;
@property (weak, nonatomic) IBOutlet UILabel *expendRecordCourseHours;
@property (weak, nonatomic) IBOutlet UILabel *expendRecordCoursePrice;




@end
