//
//  PayListeningVC.m
//  XEEnglish
//
//  Created by houjing on 15/7/24.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "PayListeningVC.h"

#import "BaseTVC.h"
#import "SwicthCell.h"
#import "PriceCell.h"


#import "SchoolVC.h"

#import "StudentVC.h"

@interface PayListeningVC ()<UITableViewDataSource,UITableViewDelegate,SwicthCellDelegate,SchoolVCDelegate,StudentVCDelegate>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSString *is_select_student;//is_select_student 是否是选择孩子取值 1选孩子 0填写孩子
@property (nonatomic, strong) NSString *sex;//sex(0女1男)

@property (nonatomic, strong) NSDictionary *schoolInfoDic;//校区信息
@property (nonatomic, strong) NSString *selectedSchool;//被选择的校区

@property (nonatomic, strong) NSDictionary *studentInfoDic;//选择的学生信息
@property (nonatomic, strong) NSString *selectedStudent;//选择学生信息

@end

@implementation PayListeningVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"上门送课";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI{
    
    [super initUI];
    
    //默认情况下is_select_student为1，选择小孩，0为填写小孩
    self.is_select_student = @"1";
    //sex(0女1男)
    self.sex = @"1";
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [self footView];
    
    [self.view addSubview:self.tableView];
}

- (UIView *)footView{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    view.backgroundColor = [UIColor clearColor];
    
    UIButton *applyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [applyBtn setFrame:CGRectMake(20, 20, kScreenWidth-40, 40)];
    [applyBtn setTitle:@"立即申请" forState:UIControlStateNormal];
    [applyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [applyBtn setBackgroundColor:[UIColor orangeColor]];
    [applyBtn addTarget:self action:@selector(applyBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:applyBtn];
    
    return view;
    
}
#pragma mark -申请试听
- (void)applyBtnClicked{
    
}

#pragma mark - UITableView DataSource
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 2;
    }else if (section == 1){
        if ([self.is_select_student isEqual:@"1"]) {
            return 2;
        }
        else{
            return 4;
        }
    }
    else if(section == 2){
        return 1;
    }
    else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuse1 = @"BaseTVC";
    static NSString *reuse2 = @"SwicthCell";
    static NSString *reuse3 = @"PriceCell";
    
    if (indexPath.section == 0) {
        BaseTVC *cell = [tableView dequeueReusableCellWithIdentifier:reuse1];
        if (cell == nil) {
            cell = [[BaseTVC alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuse1];
            cell.textLabel.textColor = [UIColor blackColor];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.cellEdge = 10;
        
        switch (indexPath.row) {
            case 0:
            {
                cell.textLabel.text = @"课程";
                break;
            }
            case 1:
            {
                cell.textLabel.text = @"校区选择";
                cell.detailTextLabel.text = self.schoolInfoDic[@"department"];
                break;
            }
                
            default:
                break;
        }
        return cell;
    }
    else if (indexPath.section == 1){
        if ([self.is_select_student isEqual:@"1"]) {
            
            if (indexPath.row == 0) {
                [tableView registerNib:[UINib nibWithNibName:@"SwicthCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuse2];
                
                SwicthCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse2];
                cell.cellEdge = 10;
                cell.rowOfCell = 0;
                cell.delegate = self;
                cell.myTipLabel.text = @"选择或输入小孩";
                cell.myDetailLabel.text = @"选择";
                
                return cell;
                
            }
            else{
                BaseTVC *cell = [tableView dequeueReusableCellWithIdentifier:reuse1];
                if (cell == nil) {
                    cell = [[BaseTVC alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuse1];
                    cell.textLabel.textColor = [UIColor blackColor];
                    cell.textLabel.font = [UIFont systemFontOfSize:14];
                    cell.detailTextLabel.textColor = [UIColor grayColor];
                    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }
                cell.cellEdge = 10;
                cell.textLabel.text = @"选择小孩";
                cell.detailTextLabel.text = self.studentInfoDic[@"name"];
                return cell;
            }
            
        }
        else{
            
            if ((indexPath.row == 0)||(indexPath.row == 3)) {
                [tableView registerNib:[UINib nibWithNibName:@"SwicthCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuse2];
                
                SwicthCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse2];
                cell.cellEdge = 10;
                
                switch (indexPath.row) {
                    case 0:
                    {
                        cell.rowOfCell = 0;
                        cell.delegate = self;
                        cell.myTipLabel.text = @"选择或输入小孩";
                        cell.myDetailLabel.text = @"输入";
                        break;
                    }
                    case 3:
                    {
                        cell.rowOfCell = 3;
                        cell.delegate = self;
                        cell.myTipLabel.text = @"选择或输入小孩";
                        cell.mySwitchBtn.on = [self.sex intValue];
                        if ([self.sex isEqualToString: @"1"]) {
                            cell.myDetailLabel.text = @"男";
                        }
                        else{
                            cell.myDetailLabel.text = @"女";
                        }
                        break;
                    }
                    default:
                        break;
                }
                
                
                return cell;
                
            }
            else{
                BaseTVC *cell = [tableView dequeueReusableCellWithIdentifier:reuse1];
                if (cell == nil) {
                    cell = [[BaseTVC alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse1];
                    cell.textLabel.textColor = [UIColor blackColor];
                    cell.textLabel.font = [UIFont systemFontOfSize:14];
                    cell.detailTextLabel.textColor = [UIColor grayColor];
                    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }
                cell.cellEdge = 10;
                switch (indexPath.row) {
                    case 1:
                    {
                        cell.textLabel.text = @"小孩姓名";
                        break;
                    }
                    case 2:
                    {
                        cell.textLabel.text = @"小孩生日";
                        break;
                    } 
                    default:
                        break;
                }
                
                return cell;
            }
        }
        
        
    }else if (indexPath.section == 2){
        [tableView registerNib:[UINib nibWithNibName:@"PriceCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuse3];
        
        PriceCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse3];
        cell.cellEdge = 10;
        
        cell.myTipLabel.text = @"缴费金额";
        cell.myDetailLabel.text = @"";
        
        return cell;
    }else{
        
        BaseTVC *cell = [tableView dequeueReusableCellWithIdentifier:reuse1];
        if (cell == nil) {
            cell = [[BaseTVC alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse1];
        }
        cell.cellEdge = 10;
        return cell;
        
    }
    
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                break;
            }
            case 1:
            {
                SchoolVC *vc = [[SchoolVC alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                vc.selectedSchool = self.selectedSchool;
                vc.delegate = self;
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
                
            default:
                break;
        }
    }
    else if (indexPath.section == 1){
        if ([self.is_select_student isEqual:@"1"]){
            if (indexPath.row == 1) {
                StudentVC *vc = [[StudentVC alloc] init];
                vc.delegate = self;
                vc.selectedStudent = self.selectedStudent;
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    }
}
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0f;
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 5.0f;
    }else{
        return 1.0f;
    }
}

- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 5.0f;
}

#pragma mark - SwicthCellDelegate
- (void)SwicthCellSwitchBtnValueChange:(id)sender andRowOfCell:(NSInteger)rowOfCell{
    
    if (rowOfCell == 0) {
        self.is_select_student = sender;
        NSLog(@"is_select_student:%@",self.is_select_student);
        [self.tableView reloadData];
    }
    if (rowOfCell == 3) {
        //self.sex = [NSString stringWithFormat:@"%li",(long)![sender integerValue]];
        self.sex = sender;
        NSLog(@"sex:%@",self.sex);
        [self.tableView reloadData];
    }
}

#pragma mark - SchoolVCDelegate
- (void)schoolVCSelectedSchoolZone:(id)sender{
    
    self.schoolInfoDic = sender;
    self.selectedSchool = self.schoolInfoDic[@"department"];
    [self.tableView reloadData];
}

#pragma mark - StudentVCDelegate
- (void)studentVCSelectedStudent:(id)sender{
    
    self.studentInfoDic = sender;
    self.selectedStudent = self.studentInfoDic[@"name"];
    [self.tableView reloadData];
}

@end
