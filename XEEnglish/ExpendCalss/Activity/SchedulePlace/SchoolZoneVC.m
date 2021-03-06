//
//  SchoolZoneVC.m
//  XEEnglish
//
//  Created by houjing on 15/6/10.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "SchoolZoneVC.h"
#import "SchoolZoneCell.h"
#import "XeeService.h"

@interface SchoolZoneVC ()<UITableViewDataSource,UITableViewDelegate>


@end

@implementation SchoolZoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"校区选择";
}

- (void)initUI{
    
    [super initUI];
    
    [self getSchoolInfo];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - My Action

- (void)getSchoolInfo{
    //需要传真参数时再用
    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
    NSDictionary *userInfoDic = userDic[uUserInfoKey];
    //NSLog(@"token:%@",userToken);
    [self showHudWithMsg:@"载入中..."];
    [[XeeService sharedInstance] getSchoolWithParentId:userInfoDic[uUserId] andCourseId:nil andToken:userInfoDic[uUserToken] andBlock:^(NSDictionary *result, NSError *error) {
        [self hideHud];
        if (!error) {
            //NSLog(@"result:%@",result);
            NSNumber *isResult = result[@"result"];
            if (isResult.integerValue == 0) {
                self.schoolZoneArray= result[@"resultInfo"];
                [self.tableView reloadData];
            }
            else{
                [UIFactory showAlert:@"请在“我的页面“设置城市”"];
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
    
    return [self.schoolZoneArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuse = @"SchoolZoneCell";
    
    SchoolZoneCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    
    if (cell == nil) {
        cell = [[SchoolZoneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.cellEdge = 10;
    NSDictionary *singleSchoolInfo =self.schoolZoneArray[indexPath.row];
    cell.schollLabel.text = singleSchoolInfo[@"department"];
    if ([self.selectedSchool isEqualToString:cell.schollLabel.text]) {
        cell.selectImageView.highlighted = YES;
    }
    
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    //[self.delegate SelectedSchoolZone:self.schoolZoneArray[indexPath.row]];
    NSDictionary *singleSchoolInfo =self.schoolZoneArray[indexPath.row];
    self.selectedSchool = singleSchoolInfo[@"department"];
    NSDictionary *schoolDic = @{@"department_id":singleSchoolInfo[@"department_id"],@"department":singleSchoolInfo[@"department"]};
    [self.delegate SelectedSchoolZone:schoolDic];
    
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
