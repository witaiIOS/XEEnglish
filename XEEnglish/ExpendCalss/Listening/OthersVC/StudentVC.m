//
//  StudentVC.m
//  XEEnglish
//
//  Created by houjing on 15/7/27.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "StudentVC.h"
#import "StudentVCCell.h"

#import "XeeService.h"

@interface StudentVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *studentArray;//学生数组

@end

@implementation StudentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
            }else{
                [UIFactory showAlert:@"未知错误"];
            }
        }else{
            [UIFactory showAlert:@"网络错误"];
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
    
    static NSString *reuse = @"StudentVCCell";
    
    StudentVCCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    
    if (cell == nil) {
        cell = [[StudentVCCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
    cell.cellEdge = 10;
    NSDictionary *studentDic = self.studentArray[indexPath.section];
    cell.studentNameLabel.text = studentDic[@"name"];
    if ([self.selectedStudent isEqualToString:cell.studentNameLabel.text]) {
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
    [self.delegate studentVCSelectedStudent:selectedStudentDic];
    
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

@end
