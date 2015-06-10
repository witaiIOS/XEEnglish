//
//  CitiesVC.h
//  XEEnglish
//
//  Created by houjing on 15/6/10.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseVC.h"
@protocol SelectedCityDelegate <NSObject>

@optional
- (void)SelectedCity:(id) sender;

@end

@interface CitiesVC : BaseVC<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;//城市列表
@property (nonatomic, strong) NSArray *citiesArray;//城市数组

@property (nonatomic, strong) id<SelectedCityDelegate> delegate;

@end
