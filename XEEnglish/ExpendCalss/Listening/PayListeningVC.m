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

#import "PayListeningCourseVC.h"
#import "SchoolVC.h"

#import "StudentVC.h"
#import "AddStudentVC.h"
#import "addStudentBirthday.h"

#import "ListenPayCourseVC.h"

@interface PayListeningVC ()<UITableViewDataSource,UITableViewDelegate,SwicthCellDelegate,PayListeningCourseVCDelegate,SchoolVCDelegate,StudentVCDelegate,AddStudentVCDelegate,AddStudentBirthdayDelegate>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSString *is_select_student;//is_select_student 是否是选择孩子取值 1选孩子 0填写孩子
@property (nonatomic, strong) NSString *sex;//sex(0女1男)

@property (nonatomic, strong) NSDictionary *courseInfoDic;//选择的课程信息
@property (nonatomic, strong) NSString *selectedCourse;//被选择的课程
@property (nonatomic, strong) NSString *coursePrice;//试听课程单价

@property (nonatomic, strong) NSDictionary *schoolInfoDic;//校区信息
@property (nonatomic, strong) NSString *selectedSchool;//被选择的校区

@property (nonatomic, strong) NSDictionary *selectedStudentInfoDic;//选择的学生及学生id,is_select_student为1选择孩子

@property (nonatomic, strong) NSString *addStudentName;//is_select_student为0填写孩子，name(姓名不能为空)
@property (nonatomic, strong) NSString *studentId;//学生id，is_select_student取值0 填写孩子信息时 学生id置为0

@property (nonatomic, strong) NSString *addBrithday;//学生id，is_select_student取值0 填写孩子生日

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
    //is_select_student为1时，是选择现有小孩，
    //is_select_student为1时，是选择现有小孩，需要将studentName，birthday，sex置空
    if ([self.is_select_student intValue] == 1) {
        if (self.selectedCourse == nil) {
            [UIFactory showAlert:@"请选择课程"];
        }
        else if (self.schoolInfoDic[@"department"] == nil) {
            [UIFactory showAlert:@"请选择校区"];
        }
        else if (self.selectedStudentInfoDic[@"name"] == nil){
            [UIFactory showAlert:@"请选择小孩"];
        }else{
            
            ListenPayCourseVC *vc = [[ListenPayCourseVC alloc] init];
            vc.payMoney = [self.coursePrice intValue];
            vc.courseId = [self.courseInfoDic[@"course_id"] intValue];
            vc.studentId = self.selectedStudentInfoDic[@"student_id"];
            vc.schoolId = self.schoolInfoDic[@"department_id"];
            //type取值 1 选课 2 免费试听 3 有偿试听。
            //type取值 1时student_id必选；2/3时，填写小孩时student_id为0。
            vc.payMethod = 3;//有偿试听
            vc.payType = @"1";//按课时
            vc.number = 1;//一个课时
            vc.listCoupon = @"[]";//现金券
            vc.is_select_student = self.is_select_student;//是否选择小孩
            vc.name = @"";
            vc.sex = @"";
            vc.birthday = @"";
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
    }
    //is_select_student为0时，是填写小孩信息，
    else{
        if (self.selectedCourse == nil) {
            [UIFactory showAlert:@"请选择课程"];
        }
        else if (self.schoolInfoDic[@"department"] == nil) {
            [UIFactory showAlert:@"请选择校区"];
        }
        else if (self.addStudentName == nil){
            [UIFactory showAlert:@"请填写小孩名字"];
        }
        else if (self.addBrithday == nil){
            [UIFactory showAlert:@"请填写小孩生日"];
        }
        else{
            ListenPayCourseVC *vc = [[ListenPayCourseVC alloc] init];
            vc.payMoney = [self.coursePrice intValue];
            vc.courseId = [self.courseInfoDic[@"course_id"] intValue];
            //type取值 1时student_id必选；2/3时，填写小孩时student_id为0。
            vc.studentId = @"0";
            vc.schoolId = self.schoolInfoDic[@"department_id"];
            //type取值 1 选课 2 免费试听 3 有偿试听。
            //type取值 1时student_id必选；2/3时，填写小孩时student_id为0。
            vc.payMethod = 3;//有偿试听
            vc.payType = @"1";//按课时
            vc.number = 1;//一个课时
            vc.listCoupon = @"[]";//现金券
            vc.is_select_student = self.is_select_student;//是否选择小孩
            vc.name = self.addStudentName;
            vc.sex = self.sex;
            vc.birthday = self.addBrithday;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
    
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
                cell.detailTextLabel.text = self.selectedCourse;
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
                cell.detailTextLabel.text = self.selectedStudentInfoDic[@"name"];
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
                    cell = [[BaseTVC alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuse1];
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
                        cell.detailTextLabel.text = self.addStudentName;
                        break;
                    }
                    case 2:
                    {
                        cell.textLabel.text = @"小孩生日";
                        cell.detailTextLabel.text = self.addBrithday;
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
        cell.myDetailLabel.text = self.coursePrice;
        
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
                PayListeningCourseVC *vc = [[PayListeningCourseVC alloc] init];
                vc.selectCourse = self.selectedCourse;
                vc.delegate = self;
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case 1:
            {
                //校区要根据课程的id来查找，当未选择课程时，不让选择校区
                if (self.selectedCourse == nil) {
                    
                    [UIFactory showAlert:@"请选择课程"];
                }
                else{
                    SchoolVC *vc = [[SchoolVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    vc.selectedSchool = self.selectedSchool;
                    vc.delegate = self;
                    [self.navigationController pushViewController:vc animated:YES];
                }
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
                vc.selectedStudent = self.selectedStudentInfoDic[@"name"];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
        else{
            if (indexPath.row == 1) {
                AddStudentVC *vc = [[AddStudentVC alloc] init];
                vc.delegate = self;
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
            else{
                addStudentBirthday *vc = [[addStudentBirthday alloc] init];
                vc.delegate = self;
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

#pragma mark - PayListeningCourseVCDelegate
- (void)payListeningCourseVCSelectedCourse:(id)sender{
    
    self.courseInfoDic = sender;
    self.selectedCourse = self.courseInfoDic[@"title"];
    self.coursePrice = [NSString stringWithFormat:@"%@",self.courseInfoDic[@"price"]];
    [self.tableView reloadData];
}

#pragma mark - SchoolVCDelegate
- (void)schoolVCSelectedSchoolZone:(id)sender{
    
    self.schoolInfoDic = sender;
    self.selectedSchool = self.schoolInfoDic[@"department"];
    [self.tableView reloadData];
}

#pragma mark - StudentVCDelegate
- (void)studentVCSelectedStudent:(id)sender{
    
    self.selectedStudentInfoDic = sender;
    [self.tableView reloadData];
}
#pragma mark - AddStudentVC Delegate
- (void)addStudentVCGetStudentName:(id)sender{
    self.addStudentName = sender;
    [self.tableView reloadData];
}

#pragma mark - AddStudentBirthdayDelegate
- (void)addStudentBirthdayGetBirthday:(id)sender{
    
    self.addBrithday = sender;
    [self.tableView reloadData];
}


@end
