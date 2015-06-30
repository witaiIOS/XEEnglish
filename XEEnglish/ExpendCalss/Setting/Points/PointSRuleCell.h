//
//  PointSRuleCell.h
//  XEEnglish
//
//  Created by houjing on 15/6/30.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseTVC.h"

@interface PointSRuleCell : BaseTVC
@property (nonatomic, strong) NSDictionary *ruleInfoDic;
//@property (nonatomic, strong) UILabel *ruleConfigIdLabel;
//@property (nonatomic, strong) UILabel *ruleTitlelabel;
@property (weak, nonatomic) IBOutlet UILabel *ruleConfigIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *ruleTitlelabel;

@end
