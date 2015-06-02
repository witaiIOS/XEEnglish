//
//  SchedulePlace.m
//  XEEnglish
//
//  Created by houjing on 15/6/2.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "SchedulePlace.h"

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
    
    return 4;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 2) {
        return 2;
    }else
        return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuse = @"SchedulePlaceCell";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuse];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    
    cell.detailTextLabel.textColor = [UIColor grayColor];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    
    NSString *scheduleString = nil;
    NSString *detailScheduleString = nil;
    
    if (indexPath.section == 0) {
        
        scheduleString = @"校区选择";
        detailScheduleString = @"武昌区";
    }else if (indexPath.section == 1){
        
        scheduleString = @"预定时间";
        detailScheduleString = @"09:00 - 12:00";
    }else if (indexPath.section == 2){
        
        switch (indexPath.row) {
                            case 0:
            {
                scheduleString = @"投影仪";
                detailScheduleString = @"有";
                break;
            }
            case 1:
            {
                scheduleString = @"老师陪同";
                detailScheduleString = @"要";
                break;
            }
            default:
                break;
        }
    }else{
        
        scheduleString = @"其他";
        detailScheduleString = @"";
    }
    
    cell.textLabel.text = scheduleString;
    cell.detailTextLabel.text = detailScheduleString;
    
    return cell;
    
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44.0;
}
- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 20.0;
    }else{
        
        return 5.0;
    }
}

- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == 3) {
        return 30.0;
    }else
        return 5.0;
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
