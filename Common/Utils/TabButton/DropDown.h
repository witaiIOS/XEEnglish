//
//  DropDown.h
//  DropDown1
//
//  Created by houjing on 15/6/4.
//  Copyright (c) 2015年 aprees. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropButton.h"

@interface DropDown : UIView

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *tableArray;
//@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) DropButton *tabBtn;
@property (nonatomic, assign) BOOL showList;
@property (nonatomic, assign) CGFloat tabHeight;
@property (nonatomic, assign) CGFloat frameHeight;
@end

