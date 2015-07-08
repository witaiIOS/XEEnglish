//
//  SelectedStudentVC.m
//  XEEnglish
//
//  Created by houjing on 15/7/7.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "SelectedStudentVC.h"
#import "SchoolZoneCell.h"
#import "XeeService.h"

@interface SelectedStudentVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *studentArray;

@end

@implementation SelectedStudentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"选择小孩";
}

- (void)initUI{
    
    [super initUI];
    
    self.studentArray = [[NSMutableArray alloc] init];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
    [self getVStudentByParentId];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Web

- (void)getVStudentByParentId{
    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
    NSDictionary *userInfoDic = userDic[uUserInfoKey];
    [self showHudWithMsg:@"载入中..."];
    [[XeeService sharedInstance] getVStudentByParentId:userInfoDic[uUserId] andToken:userInfoDic[uUserToken] andBlock:^(NSDictionary *result, NSError *error){
        [self hideHud];
        if(!error){
            //NSLog(@"result:%@",result);
            NSNumber *isResult = result[@"result"];
            if(isResult.integerValue == 0){
                self.studentArray = result[@"resultInfo"];
                [self.tableView reloadData];
            }
        }
    }];
}

#pragma mark - UITableView DataSource
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [self.studentArray count];
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuse = @"SchoolZoneCell";
    
    SchoolZoneCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    
    if (cell == nil) {
        cell = [[SchoolZoneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
    cell.cellEdge = 10;
    NSDictionary *studentDic = self.studentArray[indexPath.section];
    cell.schollLabel.text = studentDic[@"name"];
    if ([self.selectedStudent isEqualToString:cell.schollLabel.text]) {
        cell.selectImageView.highlighted = YES;
    }
    
    return cell;
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *studentDic = self.studentArray[indexPath.section];
    self.selectedStudent = studentDic[@"name"];
    NSDictionary *selectedStudentDic = @{@"student_id":studentDic[@"student_id"],@"name":studentDic[@"name"]};
    [self.delegate selectedStudent:selectedStudentDic];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 5.0f;
    }
    else{
        return 1.0f;
    }
}
- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 1.0f;
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
