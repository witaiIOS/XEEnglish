//
//  CourseLeaveApplyVC.m
//  XEEnglish
//
//  Created by houjing on 15/7/1.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "CourseLeaveApplyVC.h"
#import "BaseTVC.h"

#import "ApplyProtocolVC.h"

@interface CourseLeaveApplyVC ()<UITableViewDataSource,UITableViewDelegate,ApplyProtocolChangeSelectedBtnDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *selectedBtn;//是否同意了章程

@end

@implementation CourseLeaveApplyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.title = @"请假申请";
}

- (void)initUI{
    
    [super initUI];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
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
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, 200)];
    view.backgroundColor = [UIColor clearColor];
    
    self.selectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.selectedBtn setFrame:CGRectMake(10, 10, 20, 20)];
    [self.selectedBtn setImage:[UIImage imageNamed:@"chekbox.png"] forState:UIControlStateNormal];
    [self.selectedBtn setImage:[UIImage imageNamed:@"chekbox_select.png"] forState:UIControlStateSelected];
    [self.selectedBtn addTarget:self action:@selector(selectedBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:self.selectedBtn];
    
    UILabel *protocolLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, 70, 20)];
    protocolLabel.text = @"阅读并同意";
    protocolLabel.textColor = [UIColor blackColor];
    protocolLabel.font = [UIFont systemFontOfSize:14];
    
    [view addSubview:protocolLabel];
    
    UIButton *protocolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [protocolBtn setFrame:CGRectMake(120, 10, 60, 20)];
    [protocolBtn setTitle:@"《章程》" forState:UIControlStateNormal];
    [protocolBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [protocolBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [protocolBtn addTarget:self action:@selector(protocolBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:protocolBtn];
    
    UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [buyBtn setFrame:CGRectMake(20, 60, kScreenWidth-40, 40)];
    [buyBtn setTitle:@"立即申请" forState:UIControlStateNormal];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyBtn setBackgroundColor:[UIColor orangeColor]];
    [buyBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [buyBtn addTarget:self action:@selector(ApplyBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:buyBtn];
    
    
    return view;
    
}

- (void)selectedBtnClicked{
    if (self.selectedBtn.selected) {
        self.selectedBtn.selected = NO;
    }
    else{
        self.selectedBtn.selected = YES;
    }
}

- (void)protocolBtnClicked{
    
    ApplyProtocolVC *vc = [[ApplyProtocolVC alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)ApplyBtnClicked{
    if (self.selectedBtn.selected) {
//        PayCourseVC *vc = [[PayCourseVC alloc] init];
//        vc.payMoney = self.priceTotal;
//        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        [UIFactory showAlert:@"请阅读并同意协议"];
    }
    
}

#pragma mark - UITableView DataSource
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuse = @"MyCell";
    
    BaseTVC *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    
    if (cell == nil) {
        cell = [[BaseTVC alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuse];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    }
    cell.cellEdge = 10;
    NSString *titleStr = nil;
    NSString *detailStr = nil;
    switch (indexPath.section) {
        case 0:
        {
            titleStr = @"课程名";
            NSString *nameStr = self.courseLeaveInfoDic[@"title"];
            detailStr = nameStr;
            break;
        }
        case 1:
        {
            titleStr = @"原课程时间";
            NSString *TimeStr = self.courseLeaveInfoDic[@"create_time"];
            detailStr = TimeStr;
            break;
        }
        case 2:
        {
            titleStr = @"说明";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        }
            
        default:
            break;
    }
    
    cell.textLabel.text = titleStr;
    cell.detailTextLabel.text = detailStr;
    return cell;
}





#pragma mark - UITableView Delegate

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44.0f;
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 10.0f;
    }
    else{
        return 5.0f;
    }
}

- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 5.0f;
}

#pragma mark - ApplyProtocolChangeSelectedBtnDelegate

- (void)changeSelectedBtn:(BOOL)sender{
    self.selectedBtn.selected = sender;
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
