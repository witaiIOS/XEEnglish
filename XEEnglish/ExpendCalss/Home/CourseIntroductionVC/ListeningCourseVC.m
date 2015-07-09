//
//  ListeningCourseVC.m
//  XEEnglish
//
//  Created by houjing on 15/6/23.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "ListeningCourseVC.h"

#import "BaseTVC.h"
#import "ListenZoneCell.h"
#import "ListeningCourseInfoCell.h"

#import "SubCourseListVC.h"
#import "courseSchoolZoneVC.h"
#import "SelectedStudentVC.h"

#import "payCompleteVC.h"
#import "PayCourseVC.h"

#import "XeeService.h"

@interface ListeningCourseVC ()<UITableViewDataSource,UITableViewDelegate,SelectedCourseDelegate,CourseSchoolZoneDelegate,SelectedStudentVCselectedStudentDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger courseId;//课程id
@property (nonatomic, strong) NSString *subCourseName;//子课程名
@property (nonatomic, assign) NSInteger subCourseNumeber;//子课程数量，用于做判断，没有子课程就隐藏那个cell
@property (nonatomic, assign) NSInteger subCoursePrice;//子课程价格

@property (nonatomic, strong) NSDictionary *schoolZone;//校区
@property (nonatomic, strong) NSDictionary *selectedStudent;//选择的学生及学生id

@property (nonatomic, assign) NSInteger listenPrice;//试听价格
//payMethod为2是免费到校试听，为3是有偿上门试听  type取值 1 选课 2 免费试听 3 有偿试听
@property (nonatomic, assign) NSInteger payMethod;//付款方式
//购买的完整信息
//@property (nonatomic, strong) NSMutableDictionary *payInfoDic;
@end

@implementation ListeningCourseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"试听申请";
}

- (void)initUI{
    
    [super initUI];
    
    [self getCourseListByParentCourseId];
    //默认是免费试听
    self.payMethod = 2;
    //默认情况下付款价格是父课程价格
    NSLog(@"%@",self.parentCourseInfo);
    NSNumber *price = self.parentCourseInfo[@"price"];
    self.listenPrice = price.integerValue;
    //NSLog(@"%li",self.listenPrice);
    //初始化为父课程id
    NSNumber *coursenumId =self.parentCourseInfo[@"course_id"];
    self.courseId = coursenumId.integerValue;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [self footView];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)applyBtnClicked{
    
    if (self.schoolZone[@"department"] == nil) {
        [UIFactory showAlert:@"请选择校区"];
    }
    else if (self.selectedStudent[@"name"] == nil){
        [UIFactory showAlert:@"请选择小孩"];
    }
//    else if (self.payMethod  ) {
//        [UIFactory showAlert:@"请选择试听方式"];
//    }
    else{
        if (self.payMethod == 2) {
            
            //免费试听的price为0
            self.listenPrice = 0;
            
            [self addStudentSubCourseWithWeb];
//            payCompleteVC *vc = [[payCompleteVC alloc] init];
//            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (self.payMethod == 3){
            
            //有偿付款中，如果选择了子课程，用子课程价格，没有选就还是用父课程价格
            if ([self.subCourseName length] != 0) {
                self.listenPrice = self.subCoursePrice;
            }
            //NSLog(@"price:%li",self.listenPrice);
            PayCourseVC *vc = [[PayCourseVC alloc] init];
            vc.payMoney = self.listenPrice;
            vc.courseId = self.courseId;
            vc.studentId = self.selectedStudent[@"student_id"];
            vc.schoolId = self.schoolZone[@"department_id"];
            vc.payMethod = self.payMethod;
            vc.payType = @"1";
            vc.number = 1;
            vc.listCoupon = @"[]";
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            
        }
    }
}

#pragma mark -Web
- (void)getCourseListByParentCourseId{
    //应用时将@"1124" 假数据换成 self.parentCourseId
    [[XeeService sharedInstance] getCourseListByParentCourseId:self.parentCourseId andBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            //NSLog(@"result:%@",result);
            NSNumber *isResult = result[@"result"];
            if (isResult.integerValue == 0) {
                NSDictionary *subCoursesDic = result[@"resultInfo"];
                NSMutableArray *subCourseArray = subCoursesDic[@"listCourse"];
                //子课程数量，用于做判断，没有子课程就隐藏那个cell
                self.subCourseNumeber = [subCourseArray count];
                //NSLog(@"count:%li",self.subCourseNumeber);
                //                //付款方式的判断号，pay_type取值 1按课时价 2按整套价 3两者都可。
                //                NSNumber *payMethed = subCoursesDic[@"pay_type"];
                //                self.payMethodNumber = payMethed.integerValue;
                
                //初始化上门试听价格。没有子课程，按父课程的价格，有子课程按子课程的价格
                //NSString *price = [NSString stringWithFormat:@"%@",subCoursesDic[@"price"]];
                
//                NSNumber *price = subCoursesDic[@"price"];
//                self.listenPrice = price.integerValue;
                
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

- (void)addStudentSubCourseWithWeb{
    
    /*[self getPayInfoDictionary];
    NSLog(@"info:%@",self.payInfoDic);
    
    [[XeeService sharedInstance] addStudentSubCourseByParentId:(long)self.payInfoDic[@"parent_id"] andCourseId:(long)self.payInfoDic[@"course_id"] andDepartmentId:(long)self.payInfoDic[@"department_id"] andStudentId:(long)self.payInfoDic[@"student_id"] andType:(int)self.payInfoDic[@"type"] andPayType:1 andNumbers:1 andOrderPrice:(long)self.payInfoDic[@"order_price"] andPlatformType:@"202" andListCoupon:self.payInfoDic[@"listCoupon"] andToken:self.payInfoDic[@"token"] andBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            NSNumber *isResult = result[@"result"];
            if (isResult.integerValue == 0) {
                payCompleteVC *vc = [[payCompleteVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
                //[UIFactory showAlert:result[@"resultInfo"]];
            }
            else{
                [UIFactory showAlert:result[@"resultInfo"]];
            }
        }else{
            [UIFactory showAlert:@"网络错误"];
        }
    }];*/
    
    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
    NSDictionary *userInfoDic = userDic[uUserInfoKey];
    
    [[XeeService sharedInstance] addStudentSubCourseWithDepartmentId:self.schoolZone[@"department_id"] andStudentId:self.selectedStudent[@"student_id"] andType:[NSString stringWithFormat:@"%li",self.payMethod] andOrderPrice:self.listenPrice andPlatFormTypeId:@"202" andListCoupon:@"[]" andToken:userInfoDic[uUserToken] andPayType:@"1" andNumbers:1 andCourseId:self.courseId andParentId:userInfoDic[uUserId] andBlock:^(NSDictionary *result, NSError *error) {
        
        if (!error) {
            NSNumber *isResult = result[@"result"];
            if (isResult.integerValue == 0) {
                payCompleteVC *vc = [[payCompleteVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
                //[UIFactory showAlert:result[@"resultInfo"]];
            }
            else{
                [UIFactory showAlert:result[@"resultInfo"]];
            }
        }else{
            //NSLog(@"%@",[error description]);
            
            [UIFactory showAlert:@"网络错误"];
        }

    }];
}

/*#pragma mark - payInfo
- (void)getPayInfoDictionary{
    
    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
    NSDictionary *userInfoDic = userDic[uUserInfoKey];
    
    self.payInfoDic = [[NSMutableDictionary alloc] init];
    [self.payInfoDic setObject:userInfoDic[uUserId] forKey:@"parent_id"];
    
    [self.payInfoDic setObject:userInfoDic[uUserToken] forKey:@"token"];
    
    [self.payInfoDic setObject:self.selectedStudent[@"student_id"] forKey:@"student_id"];
    
    NSNumber *courseNumId = [NSNumber numberWithInt:(int)self.courseId];
    [self.payInfoDic setObject:courseNumId forKey:@"course_id"];
    
    [self.payInfoDic setObject:self.schoolZone[@"department_id"] forKey:@"department_id"];
    
    NSNumber *price = [NSNumber numberWithInt:(int)self.listenPrice];
    [self.payInfoDic setObject:price forKey:@"order_price"];
    
    NSNumber *type = [NSNumber numberWithInt:(int)self.payMethod];
    [self.payInfoDic setObject:type forKey:@"type"];
    
    //NSMutableArray *listCoupon = [NSMutableArray array];
    [self.payInfoDic setObject:@[] forKey:@"listCoupon"];
}*/

#pragma mark - UITableView DataSource

- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        if (self.subCourseNumeber == 0) {
            return 3;
        }
        else{
            return 4;
        }   
    }
    else{
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuse1 = @"BaseCell";
    //static NSString *reuse2 = @"ListeningCourseInfoCell";
    static NSString *reuse3 = @"ListenZoneCell";
    
    if (indexPath.section == 0) {
        
        BaseTVC *cell = [tableView dequeueReusableCellWithIdentifier:reuse1];
        
        if (cell == nil) {
            cell = [[BaseTVC alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuse1];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
            cell.cellEdge = 10;
        }
        //判断有没有子课程，没有就隐藏
        if (self.subCourseNumeber == 0){
            
            if (indexPath.row == 0) {
                cell.textLabel.text = @"课程名";
                cell.detailTextLabel.text = self.courseName;
                return cell;
            }
            else if (indexPath.row == 1)
            {
                cell.textLabel.text = @"校区选择";
                cell.detailTextLabel.text = self.schoolZone[@"department"];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                return cell;
            }
            else
            {
                
                cell.textLabel.text = @"选择小孩";
                cell.detailTextLabel.text = self.selectedStudent[@"name"];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                return cell;
            }
            
        }
        else{
            
            if (indexPath.row == 0) {
                cell.textLabel.text = @"课程名";
                cell.detailTextLabel.text = self.courseName;
                return cell;
            }
            else if (indexPath.row == 1)
            {
                cell.textLabel.text = @"课程分类";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.detailTextLabel.text = self.subCourseName;
                return cell;
            }
            else if (indexPath.row == 2)
            {
                cell.textLabel.text = @"校区选择";
                cell.detailTextLabel.text = self.schoolZone[@"department"];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                return cell;
            }
            else
            {
                cell.textLabel.text = @"选择小孩";
                cell.detailTextLabel.text = self.selectedStudent[@"name"];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                return cell;
            }
            
        }
        
    }
    else if (indexPath.section == 1){
        
        ListenZoneCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse3];
        
        if (cell == nil) {
            cell = [[ListenZoneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse3];
            cell.cellEdge = 10;
        }
        switch (indexPath.row) {
            case 0:
            {
                cell.myLabel.text = @"免费到校试听";
                cell.myPriceLabel.text = @"0";
                if (self.payMethod == 2) {
                    cell.selected = YES;
                }
                //cell.selectedImageView.image = [UIImage imageNamed:@"school_selected.png"];
                break;
            }
            case 1:
            {
                cell.myLabel.text = @"有偿上门试听";
                //没有选择子课程时是父课程的price，选择了子课程是子课程的price
                if ([self.subCourseName length] == 0) {
                    cell.myPriceLabel.text = [NSString stringWithFormat:@"%li",self.listenPrice];
                }
                else{
                    cell.myPriceLabel.text = [NSString stringWithFormat:@"%li",self.subCoursePrice];
                }
                
                if (self.payMethod == 3) {
                    cell.selected = YES;
                }
               // cell.selectedImageView.image = [UIImage imageNamed:@"school_unselected.png"];
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
            cell.cellEdge = 10;
        }
        return cell;
    }
    
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
            {
                self.payMethod = 2;
                break;
            }
            case 1:
            {
                self.payMethod = 3;
                break;
            }
                
            default:
                break;
        }
        
    }
    else{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        //判断有没有子课程，没有就隐藏
        if (self.subCourseNumeber == 0){
            
            switch (indexPath.row) {
                
                case 1:
                {
                    courseSchoolZoneVC *vc = [[courseSchoolZoneVC alloc] init];
                    vc.delegate = self;
                    vc.selectedSchool = self.schoolZone[@"department"];
                    //NSLog(@"selectedSchool:%@",vc.selectedSchool);
                    //NSLog(@"parentCourseId:%@",self.parentCourseId);
                    vc.parentCourseId = self.parentCourseId;
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                case 2:
                {
                    SelectedStudentVC *vc = [[SelectedStudentVC alloc] init];
                    vc.delegate = self;
                    vc.selectedStudent = self.selectedStudent[@"name"];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    
                default:
                    break;
            }
            
        }
        else{
            
            switch (indexPath.row) {
                case 1:
                {
                    //有课程分类的就实现跳转
                    if (self.subCourseNumeber != 0) {
                        SubCourseListVC *vc = [[SubCourseListVC alloc] init];
                        vc.delegate = self;
                        vc.selectedCourse = self.subCourseName;
                        vc.parentCourseId = self.parentCourseId;//传递父课程id
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                    break;
                }
                case 2:
                {
                    courseSchoolZoneVC *vc = [[courseSchoolZoneVC alloc] init];
                    vc.delegate = self;
                    vc.selectedSchool = self.schoolZone[@"department"];
                    //NSLog(@"selectedSchool:%@",vc.selectedSchool);
                    //NSLog(@"parentCourseId:%@",self.parentCourseId);
                    vc.parentCourseId = self.parentCourseId;
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                case 3:
                {
                    SelectedStudentVC *vc = [[SelectedStudentVC alloc] init];
                    vc.delegate = self;
                    vc.selectedStudent = self.selectedStudent[@"name"];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    
                default:
                    break;
            }
            
        }
        
        
    }
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 10.0f;
    }
    else{
        return 2.0f;
    }
}

- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 3.0f;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44.0f;
}

#pragma mark - SelectedCourseDelegate

- (void)selectedCourse:(id)sender{
    
    NSDictionary *subCourseDic = sender;
    //选择子课程时更改courseId，上传要用
    NSNumber *coursenumId =subCourseDic[@"course_id"];
    self.courseId = coursenumId.integerValue;
    //NSLog(@"dic:%li",self.courseId);
    self.subCourseName = subCourseDic[@"title"];
    //NSString *price = [NSString stringWithFormat:@"%@",subCourseDic[@"price"]];
    //选择了子课程，就获取子课程的价格
    NSNumber *price = subCourseDic[@"price"];
    self.subCoursePrice = price.integerValue;
    [self.tableView reloadData];
}

#pragma mark - CourseSchoolZoneDelegate
- (void)courseSelectedSchoolZone:(id)sender{
    self.schoolZone = sender;
    [self.tableView reloadData];
}
#pragma mark -  SelectedStudentVC selectedStudentDelegate
- (void)selectedStudent:(id)sender{
    self.selectedStudent = sender;
    [self.tableView reloadData];
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
