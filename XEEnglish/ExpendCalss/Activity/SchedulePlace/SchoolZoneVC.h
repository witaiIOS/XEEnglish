//
//  SchoolZoneVC.h
//  XEEnglish
//
//  Created by houjing on 15/6/10.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseVC.h"
@protocol SchoolZoneDelegate <NSObject>

@optional
- (void)SelectedSchoolZone:(id) sender;

@end

@interface SchoolZoneVC : BaseVC

@property (nonatomic, strong) UITableView *tableView;//校区列表
@property (nonatomic, strong) NSArray *schoolZoneArray;//校区数组

@property (nonatomic, strong) id<SchoolZoneDelegate> delegate;

@end
