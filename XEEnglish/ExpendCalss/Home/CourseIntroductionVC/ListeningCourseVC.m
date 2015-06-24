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

@interface ListeningCourseVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ListeningCourseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"试听申请";
}

- (void)initUI{
    
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
    
}


#pragma mark - UITableView DataSource

- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 4;
    }
    else{
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuse1 = @"BaseCell";
    static NSString *reuse2 = @"ListeningCourseInfoCell";
    static NSString *reuse3 = @"ListenZoneCell";
    
    if (indexPath.section == 0) {
        
        BaseTVC *cell = [tableView dequeueReusableCellWithIdentifier:reuse1];
        
        if (cell == nil) {
            cell = [[BaseTVC alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuse1];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
            cell.cellEdge = 10;
        }
        if (indexPath.row == 0) {
            cell.textLabel.text = @"课程名";
            cell.detailTextLabel.text = self.courseName;
            return cell;
        }
        else if (indexPath.row == 1)
        {
            cell.textLabel.text = @"课程分类";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
        else if (indexPath.row == 2)
        {
            cell.textLabel.text = @"校区选择";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
        else
        {
            ListeningCourseInfoCell *cell2 = [tableView dequeueReusableCellWithIdentifier:reuse2];
            
            if (cell2 == nil) {
                cell2 = [[ListeningCourseInfoCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuse2];
                cell2.cellEdge = 10;
            }

            cell2.myLabel.text = @"购买课时";
            return cell2;
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
                //cell.selectedImageView.image = [UIImage imageNamed:@"school_selected.png"];
                break;
            }
            case 1:
            {
                cell.myLabel.text = @"有偿上门试听";
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
        
    }
    else{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
