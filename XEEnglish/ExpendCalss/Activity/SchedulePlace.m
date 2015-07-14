//
//  SchedulePlace.m
//  XEEnglish
//
//  Created by houjing on 15/6/2.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "SchedulePlace.h"

#import "DatePickerCell.h"
#import "PlaceDemandCell.h"
#import "HardwareDemandCell.h"
#import "ActivityContentCell.h"
#import "otherRequireCell.h"
#import "SchoolZoneVC.h"

#import "XeeService.h"

@interface SchedulePlace ()<UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate,SchoolZoneDelegate,DatePickerCellChangeDateMarkDelegate,PlaceDemandCellSetPersonNumAndAreaDelegate,HardwareDemandCellSetNeedProjectorAndTeacherDelegate>
@property (nonatomic, strong) UITableView *tableView;
//@property (nonatomic, strong) NSString *dateStart;
//@property (nonatomic, strong) NSMutableArray *schoolArray;

@property (nonatomic, strong) NSDictionary *schoolZone;//校区

//改变预定场馆界面的开始时间和结束时间的标记和代理，changeDateMark为0改变开始时间，为1改变结束时间
//@property (nonatomic, assign) NSInteger changeDateMark;
@property (nonatomic, strong) NSString *stateTime;  //开始时间
@property (nonatomic, strong) NSString *endTime;    //结束时间

//设置代理方法的标记，setNumberMark为0设置人数，为1设置面积
//@property (nonatomic, assign) NSInteger setNumberMark;
@property (nonatomic, strong) NSString *personNum;  //活动人数
@property (nonatomic, strong) NSString *area;    //活动所需场馆面积

//设置代理方法的标记，setNeedMark为0设置是否需要投影仪，为1是否需要老师
//@property (nonatomic, assign) NSInteger setNeedMark;
@property (nonatomic, strong) NSString *needProjector;  //是否需要投影仪
@property (nonatomic, strong) NSString *needTeacher;    //是否需要老师


@property (nonatomic, strong) NSString *activityContent;//活动内容
@property (nonatomic, strong) NSString *otherMemo;//其他备注
@end

@implementation SchedulePlace
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    //[self.tableView reloadData];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"场馆预定";
}

- (void)initUI{
    
    [super initUI];
    
//    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"青山校区",@"关谷校区",@"汉口校区",@"创业街校区",@"江夏校区",nil];
//    self.schoolArray = array;
    
    //self.schoolZone = @"武昌校区";
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [self tableFooterView];
    
    
    [self.view addSubview: self.tableView];
    //设置是否需要投影仪和老师，默认情况时需要
    self.needProjector = @"1";
    self.needTeacher = @"1";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Set UITableFootView
- (UIView *)tableFooterView{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    view.backgroundColor = [UIColor clearColor];
    
    UIButton *scheduleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [scheduleBtn setFrame:CGRectMake(20, 20, kScreenWidth-40, 40)];
    [scheduleBtn setTitle:@"立即预定" forState:UIControlStateNormal];
    [scheduleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [scheduleBtn setBackgroundColor:[UIColor orangeColor]];
    [scheduleBtn addTarget:self action:@selector(ScheduleBtnAction) forControlEvents:UIControlEventTouchUpInside];
    scheduleBtn.layer.cornerRadius = 4.0;
    
    [view addSubview:scheduleBtn];
    
    return view;
}

- (void)ScheduleBtnAction{
    
    if (self.schoolZone[@"department"] == nil) {
        [UIFactory showAlert:@"请选择校区"];
    }
    else if (self.stateTime == nil) {
        [UIFactory showAlert:@"请选择开始时间"];
    }
    else if (self.endTime == nil) {
        [UIFactory showAlert:@"请选择结束时间"];
    }
    else if (self.personNum == nil) {
        [UIFactory showAlert:@"请输入预计人数"];
    }
    else if (self.area == nil) {
        [UIFactory showAlert:@"请输入预定场馆面积"];
    }
    else if (self.needProjector == nil) {
        [UIFactory showAlert:@"请选择是否需要投影仪"];
    }
    else if (self.needTeacher == nil) {
        [UIFactory showAlert:@"请选择是否需要老师"];
    }
    else if (self.activityContent == nil) {
        [UIFactory showAlert:@"请输入活动内容"];
    }
    else{
        [self addBookSite];
    }
}

#pragma mark - Web
- (void)addBookSite{
    
    NSDictionary *userDic = [[UserInfo sharedUser] getUserInfoDic];
    NSDictionary *userInfoDic = userDic[uUserInfoKey];
    //NSLog(@"content:%@",self.activityContent);
    [self showHudWithMsg:@"上传中..."];
    [[XeeService sharedInstance] AddBookSiteWithKeyId:@"0" andRoomId:@"0" andAddTime:nil andParentId:userInfoDic[uUserId] andSchoolId:self.schoolZone[@"department_id"] andStartTime:self.stateTime andeEndTime:self.endTime andPersonNum:self.personNum andArea:self.area andProjector:self.needProjector andTeacher:self.needTeacher andActivityContent:self.activityContent andMemo:self.otherMemo andToken:userInfoDic[uUserToken] andBlock:^(NSDictionary *result, NSError *error) {
        [self hideHud];
        if (!error) {
            NSNumber *isResult = result[@"result"];
            if (isResult.integerValue == 0) {
                [UIFactory showAlert:result[@"resultInfo"]];
            }
            else{
                [UIFactory showAlert:result[@"resultInfo"]];
            }
        }else{
            [UIFactory showAlert:@"网络错误"];
        }
    }];
}


#pragma mark - UITableView DataSource
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 6;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }
    else if (section == 1){
        return 2;
    }
    else if (section == 2){
        return 2;
    }
    else if (section == 3){
        return 2;
    }
    else if (section == 4){
        return 1;
    }
    else if (section == 5){
        return 1;
    }
    else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuse1 = @"SchedulePlaceCell";
    static NSString *reuse2 = @"PlaceDemandCell";
    static NSString *reuse3 = @"HardwareDemandCell";
    static NSString *reuse4 = @"ActivityContentCell";
    static NSString *reuse5 = @"otherRequireCell";
    
    BaseTVC *cell = nil;

    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:reuse1];
        if (cell == nil) {
            cell = [[BaseTVC alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuse1];
            cell.textLabel.textColor = [UIColor darkGrayColor];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            
            cell.detailTextLabel.textColor = [UIColor darkGrayColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.cellEdge = 10;
        }
        cell.textLabel.text = @"校区选择";
        cell.detailTextLabel.text = self.schoolZone[@"department"];
        
        return cell;
    }
    else if (indexPath.section == 1){
        DatePickerCell*cell = [tableView dequeueReusableCellWithIdentifier:reuse1];
        if (cell == nil) {
            cell = [[DatePickerCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuse1];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.cellEdge = 10;
        }
        switch (indexPath.row) {
            case 0:{
                cell.dateLabel.text = @"预定起始时间";
                cell.rowOfCell = 0;
                cell.delegate = self;
                break;
            }
            case 1:{
                cell.dateLabel.text = @"预定结束时间";
                cell.rowOfCell = 1;
                cell.delegate = self;
                break;
            }
                
            default:
                break;
        }
        return cell;
    }
    else if (indexPath.section == 2){
        PlaceDemandCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse2];
        if (cell == nil) {
            cell = [[PlaceDemandCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse2];
            cell.cellEdge = 10;
        }
        switch (indexPath.row) {
            case 0:{
                cell.tipInfoLabel.text = @"预计人数";
                //NSLog(@"num:%@",self.personNum);
                cell.peopleAndPlaceTF.text =self.personNum;
                cell.rowOfCell = 0;
                cell.delegate = self;
                
                break;
            }
            case 1:{
                cell.tipInfoLabel.text = @"所需面积";
                cell.peopleAndPlaceTF.text = self.area;
                cell.rowOfCell = 1;
                cell.delegate = self;
                
                break;
            }
  
            default:
                break;
        }
        return cell;
    }
    else if (indexPath.section == 3){
        HardwareDemandCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse3];
        if (cell == nil) {
            cell = [[HardwareDemandCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse3];
            cell.cellEdge = 10;
        }
        switch (indexPath.row) {
            case 0:{
                cell.tipInfoLabel.text = @"投影仪";
                cell.yesLabel.text = @"有";
                cell.noLabel.text = @"没有";
                //cell.boxNeed.text = @"有";
                //cell.boxUnNeed.text = @"没有";
                cell.rowOfCell = 0;
                cell.delegate = self;
                
                break;
            }
            case 1:{
                cell.tipInfoLabel.text = @"老师陪同";
                cell.yesLabel.text = @"要";
                cell.noLabel.text = @"不要";
                //cell.boxNeed.text = @"要";
                //cell.boxUnNeed.text = @"不要";
                cell.rowOfCell = 1;
                cell.delegate = self;
                
                break;
            }
                
            default:
                break;
        }
        //NSLog(@"revertValue:%@",cell.valueStr);
        return cell;
    }
    else if (indexPath.section == 4){
        ActivityContentCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse4];
        if (cell == nil) {
            cell = [[ActivityContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse4];
            cell.cellEdge = 10;
        }
        cell.activityContent.delegate = self;//设置cell中UITextView的代理。
        return cell;
    }
    else if (indexPath.section == 5){
        otherRequireCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse5];
        if (cell == nil) {
            cell = [[otherRequireCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse5];
            cell.cellEdge = 10;
        }
        cell.otherRequire.delegate = self;//设置cell中UITextField的delegate。
        return cell;
    }
    else{
        cell = [tableView dequeueReusableCellWithIdentifier:reuse1];
        if (cell == nil) {
            cell = [[BaseTVC alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuse1];
        }
        return cell;
    }

}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        SchoolZoneVC *vc = [[SchoolZoneVC alloc] init];
        vc.selectedSchool = self.schoolZone[@"department"];
        //vc.schoolZoneArray =self.schoolArray;
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
//    else if (indexPath.section == 1){
//        switch (indexPath.row) {
//            case 0:
//            {
//                //设置修改标记 为0设置开始时间
//                self.changeDateMark = 0;
//                break;
//            }
//            case 1:
//            {
//                //设置修改标记 为1设置结束时间
//                self.changeDateMark = 1;
//                break;
//            }
//    
//            default:
//                break;
//        }
//    }
//    else if (indexPath.section == 2){
//        switch (indexPath.row) {
//            case 0:
//            {
//                //设置修改标记 为0设置人数
//                self.setNumberMark = 0;
//                break;
//            }
//            case 1:
//            {
//                //设置修改标记 为1设置所需面积
//                self.setNumberMark = 1;
//                break;
//            }
//                
//            default:
//                break;
//        }
//    }
//    else if (indexPath.section == 2){
//        switch (indexPath.row) {
//            case 0:
//            {
//                //设置修改标记 为0设置是否需要投影仪
//                self.setNeedMark = 0;
//                break;
//            }
//            case 1:
//            {
//                //设置修改标记 为1设置是否需要老师
//                self.setNeedMark = 1;
//                break;
//            }
//                
//            default:
//                break;
//        }
//    }
//    else{
//        
//    }
}


- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 4) {
        return 90.0;
    }
    return 44.0;
}
- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 20.0;
    }
    else if (section == 4 || section == 5){
        return 15.0;
    }
    else{
        
        return 5.0;
    }
}

- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == 5) {
        return 30.0;
    }
    else if (section == 3 ||section == 4){
        return 10.0;
    }
    else
        return 5.0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    NSString *title = nil;
    if (section == 4) {
         title = @"活动内容";
    }
    else if (section == 5){
        title = @"其他";
    }
    
    return title;
}

#pragma mark - SchoolZone Delegate
- (void)SelectedSchoolZone:(id)sender{
    self.schoolZone = sender;
    [self.tableView reloadData];
}
#pragma mark - DatePickerCellChangeDateMarkDelegate
- (void)changeDateMark:(id)sender andRowOfCell:(NSInteger)row{
    if (row == 0) {
        self.stateTime = sender;
        //NSLog(@"stateTime:%@",self.stateTime);
    }
    else{
        self.endTime = sender;
        //NSLog(@"endtime:%@",self.endTime);
    }
}

#pragma mark - PlaceDemandCellSetPersonNumAndAreaDelegate
- (void)setPersonNumAndArea:(id)sender andRowOfCell:(NSInteger)row{
    if (row == 0) {
        self.personNum = sender;
    }
    else{
        self.area = sender;
        //NSLog(@"area:%@",self.area);
    }
}

#pragma mark - HardwareDemandCellSetNeedProjectorAndTeacherDelegate
- (void)setNeedProjectorAndTeacher:(id)sender andRowOfCell:(NSInteger)row{
    if (row == 0) {
        self.needProjector = sender;
        //NSLog(@"needProjector:%@",self.needProjector);
    }
    else{
        self.needTeacher = sender;
        //NSLog(@"needTeacher:%@",self.needTeacher);
    }
}

//增加“其他”输入框的代理，使在cell中的UITextView在键盘出现时，上移。
#pragma mark - UITextView Delegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    [textView becomeFirstResponder];
    
    if ([textView.text isEqualToString:@"请输入－－"]) {
        textView.text = @"";
    }
    CGFloat keyboardHeight = 216.0f;
    UITableViewCell *cell = (UITableViewCell *)[textView superview];
    
    if (self.tableView.frame.size.height - keyboardHeight <= cell.frame.origin.y + cell.frame.size.height) {
        CGFloat y = cell.frame.origin.y - (self.tableView.frame.size.height - keyboardHeight - cell.frame.size.height-40);
        
        [UIView beginAnimations:@"tableView" context:nil];
        
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        
        [UIView setAnimationDuration:0.275f];
        
        self.tableView.contentInset = UIEdgeInsetsMake(-y, 0, -y, 0);
        
        [UIView commitAnimations];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) {
        //获取活动内容的textView的值
        self.activityContent = textView.text;
        //NSLog(@"content:%@",self.activityContent);
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    [UIView beginAnimations:@"tableView" context:nil];
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    [UIView setAnimationDuration:0.275f];
    
    self.tableView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
    
    [UIView commitAnimations];
}





//增加“其他”输入框的代理，使在cell中的UITextField在键盘出现时，上移。
#pragma mark - UITextField Delegate
//该方法为点击输入文本框要开始输入是调用的代理方法：就是把view上移到能看见文本框的地方
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [textField becomeFirstResponder];
    if ([textField.text isEqualToString:@"请输入－－"]) {
        textField.text = @"";
    }
    
    CGFloat keyboardHeight = 216.0f;

//    UITableViewCell *cell = (UITableViewCell *)[textField superview];
//    NSLog(@"cell:%.2f",cell.frame.origin.y);
//    if (self.view.frame.size.height - keyboardHeight <= (cell.frame.origin.y + 44.0)) {
//        CGFloat y = cell.frame.origin.y - (self.view.frame.size.height - keyboardHeight - textField.frame.size.height - 5);
//        NSLog(@"cell:%.2f",cell.frame.origin.y);
//        NSLog(@"y:%.2f",y);
//
//        [UIView beginAnimations:@"srcollView" context:nil];
//
//        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//
//        [UIView setAnimationDuration:0.275f];
//
//        self.view.frame = CGRectMake(self.view.frame.origin.x, -y, self.view.frame.size.width, self.view.frame.size.height);
//
//        [UIView commitAnimations];
    UITableViewCell *cell = (UITableViewCell *)[textField superview];
    //[self.view convertPoint:cell.frame.origin fromView:self.tableView];
    //NSLog(@"cell:%.2f",cell.frame.origin.y);
    if (self.tableView.frame.size.height - keyboardHeight <= (cell.frame.origin.y + 44.0)) {
        CGFloat y = cell.frame.origin.y - (self.tableView.frame.size.height - keyboardHeight - cell.frame.size.height - 40);
        //NSLog(@"cell:%.2f",cell.frame.origin.y);
        //NSLog(@"y:%.2f",y);
        
        [UIView beginAnimations:@"tableView" context:nil];
        
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        
        [UIView setAnimationDuration:0.275f];
        
        self.tableView.contentInset = UIEdgeInsetsMake(-y, 0, - y, 0);
        
        [UIView commitAnimations];

    
    }

}

//该方法为点击虚拟键盘Return，要调用的代理方法：隐藏虚拟键盘

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    //获取备注信息
    self.otherMemo = textField.text;
    //NSLog(@"Memo:%@",self.otherMemo);

    [textField resignFirstResponder];

    return YES;

}

//该方法为完成输入后要调用的代理方法：虚拟键盘隐藏后，要恢复到之前的文本框地方

- (void)textFieldDidEndEditing:(UITextField *)textField{

    [UIView beginAnimations:@"tableView" context:nil];

    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];

    [UIView setAnimationDuration:0.275f];

    self.tableView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);

    [UIView commitAnimations];

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
