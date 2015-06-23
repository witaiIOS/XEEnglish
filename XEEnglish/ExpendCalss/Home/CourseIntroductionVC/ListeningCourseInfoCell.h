//
//  ListeningCourseInfoCell.h
//  XEEnglish
//
//  Created by houjing on 15/6/23.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseTVC.h"

@interface ListeningCourseInfoCell : BaseTVC<UITextFieldDelegate>
@property (nonatomic, strong) UILabel *myLabel;
@property (nonatomic, strong) UITextField *myPriceTF;

@property (nonatomic, strong) UILabel *myLineLabel;
@end
