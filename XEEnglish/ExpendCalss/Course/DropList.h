//
//  DropList.h
//  XEEnglish
//
//  Created by MacAir2 on 15/6/6.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kTFHeight 40
#define kFont 14
#define kCellHeight 35.0f

@interface DropList : UIView<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *tableList;

@property (nonatomic) BOOL showTable;

@end
