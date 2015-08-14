//
//  DepositServiceVC.m
//  XEEnglish
//
//  Created by houjing on 15/8/11.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//
#define IsTransfer   @"IsTransfer"  //是否接送
#define DepositStype @"DepositStype"  //托管类型

#define TransferReceiveTime  @"TransferReceiveTime"
#define TransferSendTime     @"TransferSendTime"
#define DepositStartTime     @"DepositStartTime"
#define DepositEndTime       @"DepositEndTime"

#import "DepositServiceVC.h"
#import "BaseTVC.h"

#import "SetInfoVC.h"
#import "DepositStypeVC.h"
#import "DepositTimeVC.h"

@interface DepositServiceVC ()<UITableViewDataSource,UITableViewDelegate,SetInfoVCDelegate,DepositStypeVCDelegate,DepositTimeVCDelegate>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSString *parentName;//家长姓名
@property (nonatomic, strong) NSString *parentPhone;//家长电话
@property (nonatomic, strong) NSString *childrenName;//小孩姓名
@property (nonatomic, strong) NSString *isTransfer;//是否接送
@property (nonatomic, strong) NSString *transferReceiveTime;//接宝宝时间
@property (nonatomic, strong) NSString *transferSendTime;//送宝宝时间
@property (nonatomic, strong) NSString *depositStype;//托管方式
@property (nonatomic, strong) NSString *depositStartTime;//托管开始时间
@property (nonatomic, strong) NSString *depositEndTime;//托管结束时间
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
    self.tableView.tableFooterView = [self tableFooterView];
    
    [self.view addSubview:self.tableView];
}

#pragma mark - Set UITableFootView
- (UIView *)tableFooterView{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    view.backgroundColor = [UIColor clearColor];
    
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [commitBtn setFrame:CGRectMake(20, 20, kScreenWidth-40, 40)];
    [commitBtn setTitle:@"立即申请" forState:UIControlStateNormal];
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commitBtn setBackgroundColor:[UIColor orangeColor]];
    [commitBtn addTarget:self action:@selector(commitBtnAction) forControlEvents:UIControlEventTouchUpInside];
    commitBtn.layer.cornerRadius = 4.0;
    
    [view addSubview:commitBtn];
    
    return view;
}

- (void)commitBtnAction{
    
}

#pragma mark - UITableViewDataSource
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 9;
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
    switch (indexPath.row) {
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
            cell.textLabel.text = @"是否接送";
            cell.detailTextLabel.text = self.isTransfer;
            break;
        }
        case 4:
        {
            cell.textLabel.text = @"接宝宝时间";
            cell.detailTextLabel.text = self.transferReceiveTime;
            break;
        }
        case 5:
        {
            cell.textLabel.text = @"送宝宝时间";
            cell.detailTextLabel.text = self.transferSendTime;
            break;
        }
        case 6:
        {
            cell.textLabel.text = @"托管类型";
            cell.detailTextLabel.text = self.depositStype;
            break;
        }
        case 7:
        {
            cell.textLabel.text = @"托管开始时间";
            cell.detailTextLabel.text = self.depositStartTime;
            break;
        }
        case 8:
        {
            cell.textLabel.text = @"托管结束时间";
            cell.detailTextLabel.text = self.depositEndTime;
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
    
    if (indexPath.row == 0) {
        SetInfoVC *vc = [[SetInfoVC alloc] init];
        vc.nTitle = @"设置家长姓名";
        vc.nplaceholder = @"请输入家长姓名";
        vc.index = @"ParentName";
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 1){
        SetInfoVC *vc = [[SetInfoVC alloc] init];
        vc.nTitle = @"设置家长电话";
        vc.nplaceholder = @"请输入家长电话";
        vc.index = @"ParentPhone";
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 2){
        SetInfoVC *vc = [[SetInfoVC alloc] init];
        vc.nTitle = @"设置小孩姓名";
        vc.nplaceholder = @"请输入小孩姓名";
        vc.index = @"ChildrenName";
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 3){
        DepositStypeVC *vc = [[DepositStypeVC alloc] init];
        vc.nTitle = @"是否接送";
        vc.index = IsTransfer;
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 4){
        DepositTimeVC *vc = [[DepositTimeVC alloc] init];
        vc.nTitle = @"接宝宝时间";
        vc.index = TransferReceiveTime;
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 5){
        DepositTimeVC *vc = [[DepositTimeVC alloc] init];
        vc.nTitle = @"送宝宝时间";
        vc.index = TransferSendTime;
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 6){
        DepositStypeVC *vc = [[DepositStypeVC alloc] init];
        vc.nTitle = @"托管类型";
        vc.index = DepositStype;
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 7){
        DepositTimeVC *vc = [[DepositTimeVC alloc] init];
        vc.nTitle = @"托管开始时间";
        vc.index = DepositStartTime;
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 8){
        DepositTimeVC *vc = [[DepositTimeVC alloc] init];
        vc.nTitle = @"托管结束时间";
        vc.index = DepositEndTime;
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
        return 0.1f;
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

#pragma mark - DepositStypeVCDelegate
- (void)DepositStypeVCSelectedDepositStype:(id)sender index:(NSString *)index{
    if ([index isEqualToString:IsTransfer]) {
        self.isTransfer = sender;
    }
    else if ([index isEqualToString:DepositStype]){
        self.depositStype = sender;
    }
    [self.tableView reloadData];
}

#pragma mark - DepositTimeVCDelegate
- (void)DepositTimeVCSetTime:(id)sender index:(NSString *)index{
    if ([index isEqualToString:TransferReceiveTime]) {
        self.transferReceiveTime = sender;
    }
    else if ([index isEqualToString:TransferSendTime]){
        self.transferSendTime = sender;
    }
    else if ([index isEqualToString:DepositStartTime]){
        self.depositStartTime = sender;
    }
    else if ([index isEqualToString:DepositEndTime]){
        self.depositEndTime = sender;
    }
    
    [self.tableView reloadData];
    
}

@end
