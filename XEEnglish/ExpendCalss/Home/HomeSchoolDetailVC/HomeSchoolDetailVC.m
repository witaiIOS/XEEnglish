//
//  HomeSchoolDetailVC.m
//  XEEnglish
//
//  Created by houjing on 15/8/11.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "HomeSchoolDetailVC.h"
#import "SchoolAdCell.h"
#import "XeeService.h"

@interface HomeSchoolDetailVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *schoolImageArray;
@end

@implementation HomeSchoolDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"校区介绍";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI{
    
    [super initUI];
    
    //初始化
    self.schoolImageArray = [NSMutableArray array];
    
    [self getSchoolNearbyPicListWithWeb];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
}

#pragma mark - Web
- (void)getSchoolNearbyPicListWithWeb{
    
    [self showHudWithMsg:@"载入中..."];
    [[XeeService sharedInstance] getSchoolNearbyPicListWithDepartmentId:self.schoolInfoDic[@"department_id"] andPlatformTypeId:@"202" andPageSize:10 andPageIndex:1 andBolck:^(NSDictionary *result, NSError *error) {
        [self hideHud];
        if (!error) {
            //NSLog(@"result:%@",result);
            NSNumber *isResult = result[@"result"];
            if (isResult.integerValue == 0) {
                self.schoolImageArray = result[@"resultInfo"];
                //NSLog(@"schoolImageArray:%@",self.schoolImageArray);
                [self.tableView reloadData];
            }
            else{
                [UIFactory showAlert:@"未知错误"];
            }
        }else{
            [UIFactory showAlert:@"网络错误"];
        }
    }];
}


#pragma mark - UITableViewDataSource
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuse1 = @"SchoolAdCell";
    SchoolAdCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse1];
    if (cell == nil) {
        cell = [[SchoolAdCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse1];
    }
    cell.adArray = self.schoolImageArray;
    //NSLog(@"ad:%@",cell.adArray);
    return cell;
    
}
#pragma mark - UITableViewDelegate
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 160;
}
- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 5.0f;
}
- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 3.0f;
}

@end
