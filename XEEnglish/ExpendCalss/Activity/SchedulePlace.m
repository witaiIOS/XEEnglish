//
//  SchedulePlace.m
//  XEEnglish
//
//  Created by houjing on 15/6/2.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "SchedulePlace.h"
#import "PlaceDemandCell.h"
#import "HardwareDemandCell.h"
#import "ActivityContentCell.h"
#import "otherRequireCell.h"

@interface SchedulePlace ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SchedulePlace

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"场馆预定";
}

- (void)initUI{
    
    [super initUI];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [self tableFooterView];
    
    [self.view addSubview: self.tableView];
    
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
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"预定成功" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    [alert show];
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
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.cellEdge = 10;
        }
        cell.textLabel.text = @"校区选择";
        
        return cell;
    }
    else if (indexPath.section == 1){
        cell = [tableView dequeueReusableCellWithIdentifier:reuse1];
        if (cell == nil) {
            cell = [[BaseTVC alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuse1];
            cell.textLabel.textColor = [UIColor darkGrayColor];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.cellEdge = 10;
        }
        switch (indexPath.row) {
            case 0:{
                cell.textLabel.text = @"预定起始时间";
                break;
            }
            case 1:{
                cell.textLabel.text = @"预定结束时间";
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
                cell.peopleAndPlaceTF.text = @"";
                break;
            }
            case 1:{
                cell.tipInfoLabel.text = @"所需面积";
                cell.peopleAndPlaceTF.text = @"";
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
                break;
            }
            case 1:{
                cell.tipInfoLabel.text = @"老师陪同";
                cell.yesLabel.text = @"要";
                cell.noLabel.text = @"不要";
                break;
            }
                
            default:
                break;
        }
        return cell;
    }
    else if (indexPath.section == 4){
        ActivityContentCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse4];
        if (cell == nil) {
            cell = [[ActivityContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse3];
            cell.cellEdge = 10;
        }
        return cell;
    }
    else if (indexPath.section == 5){
        otherRequireCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse5];
        if (cell == nil) {
            cell = [[otherRequireCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse3];
            cell.cellEdge = 10;
        }
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





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
