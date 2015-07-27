//
//  SchoolVC.m
//  XEEnglish
//
//  Created by houjing on 15/7/24.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "SchoolVC.h"
#import "SchoolVCCell.h"

#import "XeeService.h"

@interface SchoolVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *schoolArray;//校区数组


@end

@implementation SchoolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"校区选择";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI{
    
    [super initUI];
    //初始化数字
    self.schoolArray = [NSMutableArray array];
    
    [self getSchoolInfo];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
}

- (void)getSchoolInfo{
    //需要传真参数时再用
    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
    NSDictionary *userInfoDic = userDic[uUserInfoKey];
    //NSLog(@"token:%@",userToken);
    //NSLog(@"parentCourseId:%@",self.parentCourseId);
    
    [[XeeService sharedInstance] getSchoolWithParentId:userInfoDic[uUserId] andCourseId:self.courseId andToken:userInfoDic[uUserToken] andBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            //NSLog(@"result:%@",result);
            NSNumber *isResult = result[@"result"];
            if (isResult.integerValue == 0) {
                self.schoolArray= result[@"resultInfo"];
                [self.tableView reloadData];
            }
            else{
                [UIFactory showAlert:@"请在“我的页面”设置城市"];
            }
        }
        else{
            [UIFactory showAlert:@"网络错误"];
        }
    }];
}



#pragma mark - UITableView DataSource
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.schoolArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuse = @"SchoolVCCell";
    
    SchoolVCCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    
    if (cell == nil) {
        cell = [[SchoolVCCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.cellEdge = 10;
    NSDictionary *singleSchoolInfo =self.schoolArray[indexPath.row];
    cell.schoolNameLabel.text = singleSchoolInfo[@"department"];
    if ([self.selectedSchool isEqualToString:cell.schoolNameLabel.text]) {
        cell.selectImageView.highlighted = YES;
    }
    
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    //[self.delegate SelectedSchoolZone:self.schoolZoneArray[indexPath.row]];
    NSDictionary *schoolInfo =self.schoolArray[indexPath.row];
    self.selectedSchool = schoolInfo[@"department"];
    NSDictionary *schoolDic = @{@"department_id":schoolInfo[@"department_id"],@"department":schoolInfo[@"department"]};
    [self.delegate schoolVCSelectedSchoolZone:schoolDic];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44.0;
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10.0;
}

- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 400.0;
}



@end
