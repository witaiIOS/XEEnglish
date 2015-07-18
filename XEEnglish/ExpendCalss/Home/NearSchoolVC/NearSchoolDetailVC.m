//
//  NearSchoolDetailVC.m
//  XEEnglish
//
//  Created by houjing on 15/7/16.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "NearSchoolDetailVC.h"
#import "NearSchoolDetailCell.h"

#import "XeeService.h"

@interface NearSchoolDetailVC ()<UITableViewDataSource,UITableViewDelegate>

//@property (nonatomic, strong) UIView *headView;
//@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *schoolImageArray;

@end

@implementation NearSchoolDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"校区详情";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI{
    
    [super initUI];
    //NSLog(@"info:%@",self.schoolInfoDic);
    
    //初始化
    self.schoolImageArray = [NSMutableArray array];
    
    [self getSchoolNearbyPicListWithWeb];
    
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    self.tableview.tableHeaderView = [self createHeaderView];
    
    [self.view addSubview:self.tableview];
    
    
}

- (UIView *)createHeaderView{
    //校区名
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,10, kScreenWidth-20, 20)];
    titleLabel.text = self.schoolInfoDic[@"department"];
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.textColor = [UIColor orangeColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    //历史介绍
    UILabel *historyLabel =  [[UILabel alloc]initWithFrame:CGRectMake(20, 20, kScreenWidth-40, 60)];
    historyLabel.text = self.schoolInfoDic[@"history"];
    historyLabel.numberOfLines = 0;
    historyLabel.lineBreakMode = NSLineBreakByWordWrapping;
    //NSLog(@"width:%li",(long)historyLabel.frame.size.width);
    CGSize historySize = [historyLabel sizeThatFits:CGSizeMake(historyLabel.frame.size.width, MAXFLOAT)];
    historyLabel.frame =CGRectMake(20, 20, kScreenWidth-40, historySize.height);
    historyLabel.font = [UIFont systemFontOfSize:14];
    
    //分割线
    UILabel *historyLine = [[UILabel alloc] initWithFrame:CGRectMake(10, historyLabel.frame.origin.y+historySize.height+5, kScreenWidth-20, 1)];
    historyLine.backgroundColor = [UIColor lightGrayColor];
    
    //地址
    UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, historyLabel.frame.origin.y+historySize.height+10, kScreenWidth-20, 50)];
    addressLabel.text = [NSString stringWithFormat:@"地址：%@",self.schoolInfoDic[@"addr"]];
    addressLabel.textColor = [UIColor blackColor];
    addressLabel.font = [UIFont systemFontOfSize:14];
    addressLabel.textAlignment = NSTextAlignmentLeft;
    addressLabel.numberOfLines = 0;
    addressLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    //电话
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, historyLabel.frame.origin.y+historySize.height+10 +50, kScreenWidth-20, 20)];
    phoneLabel.text = [NSString stringWithFormat:@"电话：%@",self.schoolInfoDic[@"mobile"]];
    phoneLabel.textColor = [UIColor blackColor];
    phoneLabel.font = [UIFont systemFontOfSize:14];
    phoneLabel.textAlignment = NSTextAlignmentLeft;
    
    //分割线
    UILabel *phoneLine = [[UILabel alloc] initWithFrame:CGRectMake(10, historyLabel.frame.origin.y+historySize.height+10 +50+20+5, kScreenWidth-20, 1)];
    phoneLine.backgroundColor = [UIColor lightGrayColor];
    
    //头视图
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(10, 64, kScreenWidth-20, historyLabel.frame.origin.y+historySize.height+10 +50+20+10)];
    headView.backgroundColor = [UIColor whiteColor];
    
    //label都加入headView
    [headView addSubview:titleLabel];
    [headView addSubview:historyLabel];
    [headView addSubview:historyLine];
    [headView addSubview:addressLabel];
    [headView addSubview:phoneLabel];
    [headView addSubview:phoneLine];
    
    return headView;
}

#pragma mark - Web
- (void)getSchoolNearbyPicListWithWeb{
    
    [self showHudWithMsg:@"载入中..."];
    [[XeeService sharedInstance] getSchoolNearbyPicListWithDepartmentId:self.schoolInfoDic[@"department_id"] andPlatformTypeId:@"202" andPageSize:10 andPageIndex:1 andBolck:^(NSDictionary *result, NSError *error) {
        [self hideHud];
        if (!error) {
            //NSLog(@"result:%@",result);
            NSNumber *isResult = result[@"result"];
            if (isResult.integerValue == 0) {
                self.schoolImageArray = result[@"resultInfo"];
                //NSLog(@"schoolImageArray:%@",self.schoolImageArray);
                [self.tableview reloadData];
            }
            else{
                [UIFactory showAlert:@"未知错误"];
            }
        }else{
            [UIFactory showAlert:@"网络错误"];
        }
    }];
}

#pragma mark - UITableView DataSource
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [self.schoolImageArray count];
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuse = @"NearSchoolDetailCell";
    
    NearSchoolDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    
    if (cell == nil) {
        cell = [[NearSchoolDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
    cell.cellEdge = 10;
    cell.schoolImageInfoDic = self.schoolImageArray[indexPath.section];
    
    return cell;
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 30.0f;
    }
    else{
        return 5.0f;
    }
}

- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 3.0f;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 140.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth-20, 30)];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, kScreenWidth-20, 20)];
        titleLabel.text = @"校区展示";
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont systemFontOfSize:14];
        
        [view addSubview:titleLabel];
        
        return view;
    }
    else{
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        view.backgroundColor = [UIColor clearColor];
        return view;
    }
}

@end
