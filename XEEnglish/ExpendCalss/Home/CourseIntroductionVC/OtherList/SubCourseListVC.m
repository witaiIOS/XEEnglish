//
//  SubCourseListVC.m
//  XEEnglish
//
//  Created by houjing on 15/6/25.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "SubCourseListVC.h"
#import "SubCourseListCell.h"

#import "XeeService.h"

@interface SubCourseListVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *courseArray;

@end

@implementation SubCourseListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"子课程列表";
}

- (void)initUI{
    
    [super initUI];
    
    [self getCourseListByParentCourseId];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
    //self.courseArray = [[NSMutableArray alloc] initWithObjects:@"CP",@"CK",@"CL", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getCourseListByParentCourseId{
    //应用时将@"1124" 假数据换成 self.parentCourseId
    [[XeeService sharedInstance] getCourseListByParentCourseId:@"1124" andBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            NSLog(@"result:%@",result);
            NSNumber *isResult = result[@"result"];
            if (isResult.integerValue == 0) {
                NSDictionary *subCoursesDic = result[@"resultInfo"];
                self.courseArray = subCoursesDic[@"listCourse"];
    
                [self.tableView reloadData];
            }
        }
    }];
}

#pragma mark - UITableView DataSource
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    //NSLog(@"result:%li",self.courseArray.count);
    return self.courseArray.count;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuse = @"SubCourseListCell";
    
    SubCourseListCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    
    if (cell == nil) {
        cell = [[SubCourseListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
    cell.cellEdge = 10;
    NSDictionary *subCourseDic = self.courseArray[indexPath.section];
    cell.courseName.text = subCourseDic[@"title"];
    //NSLog(@"%@",self.selectedCourse);
    if ([self.selectedCourse isEqualToString:cell.courseName.text]) {
        cell.selectedImageView.highlighted = YES;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *subCourseDic = self.courseArray[indexPath.section];
    [self.delegate selectedCourse:subCourseDic];
    
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

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44.0f;
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
