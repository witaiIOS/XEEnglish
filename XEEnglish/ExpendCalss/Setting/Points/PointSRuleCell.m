//
//  PointSRuleCell.m
//  XEEnglish
//
//  Created by houjing on 15/6/30.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "PointSRuleCell.h"

@implementation PointSRuleCell

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.ruleConfigIdLabel.text = self.ruleInfoDic[@"config_id"];
    self.ruleTitlelabel.text = self.ruleInfoDic[@"title"];
}

@end
