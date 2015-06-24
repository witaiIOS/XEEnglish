//
//  BuyCourseVC.m
//  XEEnglish
//
//  Created by houjing on 15/6/24.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BuyCourseVC.h"
#import "BaseTVC.h"
#import "ListeningCourseInfoCell.h"

@interface BuyCourseVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *selectedBtn;

@end

@implementation BuyCourseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"课程购买";
}

- (void)initUI{
    
    [super initUI];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
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
    [protocolBtn setTitle:@"《协议》" forState:UIControlStateNormal];
    [protocolBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [protocolBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [protocolBtn addTarget:self action:@selector(protocolBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:protocolBtn];
    
    UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [buyBtn setFrame:CGRectMake(20, 60, kScreenWidth-40, 40)];
    [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyBtn setBackgroundColor:[UIColor orangeColor]];
    [buyBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [buyBtn addTarget:self action:@selector(buyBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
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
    
}


- (void)buyBtnClicked{
    
}

#pragma mark - UITableView DataSource
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 4;
    }
    else if(section == 1){
        return 1;
    }
    else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuse1 = @"BaseCell";
    static NSString *reuse2 = @"ListeningCourseInfoCell";
    
    if (indexPath.section == 0) {
        BaseTVC *cell = [tableView dequeueReusableCellWithIdentifier:reuse1];
        
        if (cell == nil) {
            cell = [[BaseTVC alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuse1];
            //cell.textLabel.textColor = [UIColor blackColor];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
            cell.cellEdge = 10;
        }
        
        if (indexPath.row == 0) {
            cell.textLabel.text = @"课程名";
            cell.detailTextLabel.text = self.courseName;
            return cell;
        }
        else if (indexPath.row == 1){
            
            cell.textLabel.text = @"课程分类";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
        else if (indexPath.row == 2){
            
            cell.textLabel.text = @"校区选择";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
        else{
            ListeningCourseInfoCell *cell2 = [tableView dequeueReusableCellWithIdentifier:reuse2];
            if (cell2 == nil) {
                cell2 = [[ListeningCourseInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse2];
            }
            cell2.cellEdge = 10;
            cell2.myLabel.text = @"购买课时";
            
            return cell2;
            
        }
    }
    else if (indexPath.section == 1){
        
        ListeningCourseInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse2];
        if (cell == nil) {
            cell = [[ListeningCourseInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse2];
        }
        cell.cellEdge = 10;
        cell.myLabel.text = @"缴费金额";
        
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
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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



@end
