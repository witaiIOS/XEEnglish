//
//  DepositServiceVC.m
//  XEEnglish
//
//  Created by houjing on 15/8/11.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "DepositServiceVC.h"
#import "BaseTVC.h"

#import "SetInfoVC.h"

@interface DepositServiceVC ()<UITableViewDataSource,UITableViewDelegate,SetInfoVCDelegate>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSString *parentName;//家长姓名
@property (nonatomic, strong) NSString *parentPhone;//家长电话
@property (nonatomic, strong) NSString *childrenName;//小孩姓名
@end

@implementation DepositServiceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"托管申请";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI{
    
    [super initUI];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 5;
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuse = @"BaseCell";
    
    BaseTVC *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (cell == nil) {
        cell = [[BaseTVC alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuse];
        cell.cellEdge = 10;
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.textColor = [UIColor darkGrayColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    switch (indexPath.section) {
        case 0:
        {
            cell.textLabel.text = @"家长姓名";
            cell.detailTextLabel.text = self.parentName;
            break;
        }
        case 1:
        {
            cell.textLabel.text = @"家长电话";
            cell.detailTextLabel.text = self.parentPhone;
            break;
        }
        case 2:
        {
            cell.textLabel.text = @"小孩姓名";
            cell.detailTextLabel.text = self.childrenName;
            break;
        }
        case 3:
        {
            cell.textLabel.text = @"托管类型";
            break;
        }
        case 4:
        {
            cell.textLabel.text = @"托管时间";
            break;
        }
            
        default:
            break;
    }
    
    return cell;
    
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        SetInfoVC *vc = [[SetInfoVC alloc] init];
        vc.nTitle = @"设置家长姓名";
        vc.nplaceholder = @"请输入家长姓名";
        vc.index = @"ParentName";
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.section == 1){
        SetInfoVC *vc = [[SetInfoVC alloc] init];
        vc.nTitle = @"设置家长电话";
        vc.nplaceholder = @"请输入家长电话";
        vc.index = @"ParentPhone";
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.section == 2){
        SetInfoVC *vc = [[SetInfoVC alloc] init];
        vc.nTitle = @"设置小孩姓名";
        vc.nplaceholder = @"请输入小孩姓名";
        vc.index = @"ChildrenName";
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44.0f;
}
- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 3.0f;
    }
    else{
        return 1.0f;
    }
}
- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 1.0f;
}
#pragma mark - SetInfoVCDelegate
- (void)SetInfoVCInputInfo:(id)sender index:(NSInteger)index{
    if (index == 0) {
        self.parentName = sender;
    }else if (index == 1){
        self.parentPhone = sender;
    }
    else if (index ==2){
        self.childrenName = sender;
    }
    [self.tableView reloadData];
}

@end
